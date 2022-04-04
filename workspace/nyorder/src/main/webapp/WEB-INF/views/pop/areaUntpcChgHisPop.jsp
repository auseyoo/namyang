<!-- 
	@File Name: areaUntpcChgHisPop
	@File 설명 : 지역 단가 변경 이력 팝업
	@UI ID : UI-PCLI-1501P1
	@작성일 : 2022. 2. 28.
	@작성자 : JIHUN
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
var popGridID;

$(document).ready(function() {
    createAUIGrid();
    
    init();
})

// method
function createAUIGrid() {
    if(AUIGrid.isCreated(popGridID)) {
        AUIGrid.destroy(popGridID);
    }
    
    var popColumnLayout = [
        {
            dataField : "untpcChgType",
            headerText : "단가구분",
            width : "8%",
            renderer: { // HTML 템플릿 렌더러 사용
				type: "TemplateRenderer"
			},
			labelFunction: function (rowIndex, columnIndex, value, headerText, item) {
				return item.untpcChgType + ' 단가';
			}
        },{
        headerText : "지역 정보",
            children : [{
                dataField : "areaSeq",
                headerText : "코드",                    
                width : "7%",
            }, {
                dataField : "areaNm",
                headerText : "지역명",
                headerStyle : "auiRightBorR",
                style : "auiLeft",
            }]
        },{
            headerText : "변경 전",
            children : [{
                dataField : "prdDtlCd",
                headerText : "제품코드",                    
                width : "8%",
            }, {
                dataField : "prdNm",
                headerText : "제품명",
                width : "10%",
                style : "auiLeft",
            }, {
                dataField : "befUntpc",
                headerText : "단가",
                headerStyle : "auiRightBorR",
                style : "auiRight",
                width : "7%",
            },{
                dataField : "befMrgnCt",
                headerText : "마진",
                width : "7%",
                style : "auiLeft",
            },{
                dataField : "befMrgnRate",
                headerText : "마진율(%)",
                headerStyle : "auiRightBorR",
                width : "7%",
                style : "auiLeft",
            }]
        },{
            headerText : "변경 후",
            children : [{
                dataField : "prdDtlCd",
                headerText : "제품코드",                    
                width : "8%",
            }, {
                dataField : "prdNm",
                headerText : "제품명",
                style : "auiLeft",
                width : "10%",
            }, {
                dataField : "aftUntpc",
                headerText : "단가",
                width : "7%",
                style : "auiRight",
            },{
                dataField : "aftMrgnCt",
                headerText : "마진",
                width : "7%",
                style : "auiLeft",
            },{
                dataField : "aftMrgnRate",
                headerText : "마진율(%)",
                width : "7%",
                style : "auiLeft",
            }]	
        },{
            dataField : "applDt",
            headerText : "적용일자",
            width : "9%",
        },{
            dataField : "applYn",
            headerText : "적용여부",
            width : "4%",
            renderer: { // HTML 템플릿 렌더러 사용
				type: "TemplateRenderer"
			},
			labelFunction: function (rowIndex, columnIndex, value, headerText, item) {
				return item.applYn === 'Y' ? '완료' : '대기';
			}
        },{
            dataField : "emplNm",
            headerText : "작업자",
            width : "6%",
        },{
            dataField : "regDtm",
            headerText : "작업시간",
            width : "10%",
        }
    ];

    var popGridPros = {
        headerHeight : 29,	
        rowHeight : 29,
        showStateColumn : false,
        autoGridHeight : true,
        showRowCheckColumn : false, // 체크박스 사용
    }

    popGridID = AUIGrid.create("#grid_wrap6", popColumnLayout, popGridPros);
}

function closePop() {
    $.closeDialog("<c:out value='${param.id}'/>");
}

function init() {
    $(".datepicker").daterangepicker({
        singleDatePicker: true,
        // maxDate : new Date(),
        showDropdowns: true,
        changeMonth: true,
        showMonthAfterYear: true,
        locale: {
            format: "YYYY-MM-DD",
            separator: " - ",
            applyLabel: "Apply",
            cancelLabel: "Cancel",
            fromLabel: "From",
            toLabel: "To",
            customRangeLabel: "Custom",
            weekLabel: "W",
            applyLabel: "확인",
            cancelLabel: "취소",
            daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
            monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월",],
            firstDay: 1,
        },
    });
}

// api

function searchUntpcHis() {
    var startDt = $("#datepicker").val().replace(/-/g, '');
    var endDt = $("#datepicker2").val().replace(/-/g, '');
    var areaNm = $("#areaNm2").val();
    var prdDtlCd = $("#prdSapCd2").val();
    var prdNm = $("#prdNm2").val();

    var data = { startDt, endDt, areaNm, prdDtlCd, prdNm };

    $.ajax({
        url : "/cst/selectUntpcHisPopList.do",
        type : 'POST',
        data : data,
        success : function (data) {
            AUIGrid.setGridData(popGridID, data);
            $("#layerHisCnt").html(data.length);
        },
        error : function () {

        }
    })
}
</script>

<div class="popArea">
    <div class="popWrap inGrid large modal_wrap h640" data-popup="modalAgencyViews04">
        <header>
            <h3>단가변경 이력</h3>
            <%-- <button type="button" name="" class="closeBtn" id="modalCloseBtn" onclick = 'closePop()'></button> --%>
        </header>  

        <div class="popCon">
            <div class="popTitArea">
                <h3>단가변경 이력</h3>

                <div class="popBtnArea">
                    <!--<button type="button" name="" class="inquBtn">저장</button>-->
                    <button type="button" name="" class="comBtn modalCloseBtn" id="modalCloseBtn" onclick = 'closePop()'>닫기</button>                   
                </div>
            </div>

            <!-- 조회 -->
            <div class="inquiryBox">
                <dl>
                    <dt>적용일자</dt>
                    <dd>
                        <div class="formWrap">
                            <div class="dateWrap">
                                <input type="text" name="date" value="" class="inp datepicker" id="datepicker" readonly="">                                        
                                <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>                                        
                            </div> 

                            <span class="divi02">-</span>
                            
                            <div class="dateWrap">
                                <input type="text" name="date" value="" class="inp datepicker" id="datepicker2" readonly="">
                                <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker2"></button>                                        
                            </div>
                        </div>
                    </dd>
                    <dt><label for="areaNm">지역명</label></dt>
                    <dd>
                        <input type="text" id="areaNm2" class="inp w160 mr10" value="" name="areaNm">
                    </dd>
                    <dt>제품</dt>
                    <dd>
                        <div class="formWrap">
                            <input type="text" id="prdSapCd2" class="inp w120 mr10" value="" name="" placeholder="제품코드">
                            <input type="text" id="prdNm2" class="inp w160 mr20" value="" name="" placeholder="제품명">
                        </div>
                    </dd>
                </dl>
                <button type="button" name="" class="comBtn" onclick = 'searchUntpcHis()'>조회</button>
            </div>
            <!-- 조회 -->

            <div class="titleArea">
                <p class="numState">
                    <em>총 <span class="pColor01 fb" id="layerHisCnt">0</span></em> 건 이 조회되었습니다.
                </p>
            </div>

            <!-- grid -->
            <div class="girdBox">
                <div id="grid_wrap6"></div>
            </div>
            <!-- grid -->

        </div>
    </div>
</div>