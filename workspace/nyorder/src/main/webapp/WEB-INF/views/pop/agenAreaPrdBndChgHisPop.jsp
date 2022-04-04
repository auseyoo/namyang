<!-- 
	@File Name: agenAreaPrdBndChgHisPop.jsp
	@File 설명 : 애음자관리 - 제품 일괄 변경 이력 조회
	@UI ID : UI-PCLI-1601
	@작성일 : 2022. 3. 7.
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
   
   $(document).ready(function(){
        createAUIGrid();
         
        popInit();
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
        if(AUIGrid.isCreated(popGridID)) {
            AUIGrid.destroy(popGridID);
        }
        // 그리드 속성 설정
        var gridPros = {
			headerHeights : [29, 50],
			rowHeight : 29,
			editable : true,
			enterKeyColumnBase : true,
			selectionMode : "singleRow",
			useContextMenu : true,
			enableFilter : true,
			useGroupingPanel : false,
			showRowCheckColumn : false,
			displayTreeOpen : true,
			noDataMessage : "출력할 데이터가 없습니다.",
			groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
			showRowNumColumn : true,
        };

        // 실제로 #grid_wrap 에 그리드 생성
        popGridID = AUIGrid.create("#grid_wrap2", columnLayout, gridPros);
    }

        var columnLayout = [{
            headerText : "지역정보",        
            children : [{
                    dataField : "areaSeq",
                    headerText : "코드",
                    width:"5%",
                }, {
                    dataField : "areaNm",
                    headerText : "지역",
                    headerStyle : "auiRightBorR",
                    style: "auiLeft",
                }]
            },{
            dataField : "beforeCh", 
            headerText : "변경 전",
            children : [{
                    dataField : "befPrdSapCd",
                    headerText : "제품코드",
                    width:"4%",
                    cellMerge : true,
                }, {
                    dataField : "befPrdNm",
                    headerText : "제품명",
                    width:"9%",
                    style: "auiLeft",
                    cellMerge : true
                }, {
                    dataField : "befEmplUntpc",
                    headerText : "지역별<br/>판매원 단가",
                    dataType : "numeric",
                    formatString : "#,##0",
                    style: "auiRight",
                    width:"7%",
            }, {
                    dataField : "befCstUntpc",
                    headerText : "지역별<br/>애음자(소비자) 단가",
                    headerStyle : "auiRightBorR",
                    dataType : "numeric",
                    formatString : "#,##0",
                    style: "auiRight",
                    width:"9%",
                }]
            },{
            headerText : "변경 후",      
            children : [{
                        dataField : "aftPrdSapCd",
                        headerText : "제품코드",
                        width:"5%",
                        cellMerge : true
                    }, {
                        dataField : "aftPrdNm",
                        headerText : "제품명",
                        width:"11%",
                        style: "auiLeft",
                        cellMerge : true
                    }, {
                        dataField : "aftEmplUntpc",
                        headerText : "지역별<br/>판매원 단가",
                        dataType : "numeric",
                        formatString : "#,##0",
                        style: "auiRight",
                        width:"7%",
                    }, {
                        dataField : "aftCstUntpc",
                        headerText : "지역별<br/>애음자(소비자) 단가",
                        dataType : "numeric",
                        formatString : "#,##0",
                        style: "auiRight",
                        width:"9%",
                }]
            },{
                dataField : "applDt", 
                headerText : "적용일자",
                width:"7%",
            },{
                dataField : "applYn", 
                headerText : "적용여부",
                width:"4%",
            },{
                dataField : "emplNm", 
                headerText : "작업자",
                width:"5%",
            },{
                dataField : "regDtm", 
                headerText : "작업시간",
            }
        ];

    // methods

    function popInit() {
        $(".popdatepicker").daterangepicker({
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

    function closePop() {
        $.closeDialog("<c:out value='${param.id}'/>");
    }

	// api
	
	function searchPrdBndHisList() {
        var data = {
            startDt: $("#datepicker1").val(),
            endDt: $("#datepicker2").val()
        };

        if(data.startDt < data.endDt) {
            alert('기간을 확인해주세요.');
            return;
        }

		$.ajax({
			url : "/cst/selectAgenAreaPrdBndChgHis.do",
			type : 'POST',
			data : data,
			success : function(data) {
                AUIGrid.setGridData(popGridID, data);
                $("#tab1Cnt").html(data.length);
			},
			error : function(){},
		})
	}


</script>
<div class="popArea">
	<div class="popWrap large modal_wrap h640" data-popup="modalAgencyViews">
        <header>
            <h3>제품 일괄 변경 이력</h3>
            <%-- <button type="button" name="" class="closeBtn" id="modalCloseBtn"></button> --%>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3 class="pb10">제품 일괄 변경 이력</h3>
    
                <div class="popBtnArea">
                    <button type="button" name="" class="comBtn" id="modalCloseBtn" onclick = 'closePop()'>닫기</button>
                </div>
            </div>

            <!-- 조회 -->
            <div class="inquiryBox">
                <dl>
                    <dt>적용일자</dt>
                    <dd>
                        <div class="formWrap">
                            <div class="dateWrap">
                                <input type="text" name="date" value="" class="inp datepicker popdatepicker" id="datepicker" readonly="">
                                <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
                            </div>
                            <span class="divi02">~</span>
                            <div class="dateWrap">
                                <input type="text" name="date" value="" class="inp datepicker popdatepicker" id="datepicker2" readonly="">
                                <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker2"></button>
                            </div>
                            <button type="button" name="" class="comBtn" id="inp_name01" onclick = 'searchPrdBndHisList()'>조회</button>
                        </div>
                    </dd>
                </dl>
            </div>
            <!--// 조회 -->

            <div class="titleArea right">
                <p class="numState">
                    <em>총 <span class="pColor01 fb" id="tab1Cnt">0</span></em> 건 이 조회되었습니다.
                </p>
            </div>
            
            <!-- grid -->
            <div class="girdBox rowspan3">                    
                <div id="grid_wrap2"></div>
            </div>
            <!-- grid -->
            
        </div>
        <!-- popCon -->
    </div>
</div>