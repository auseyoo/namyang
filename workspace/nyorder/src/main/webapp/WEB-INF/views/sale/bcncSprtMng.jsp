<!--
	@File Name: bcncSprtMng
	@File 설명 : 거래처지원내역관리
	@UI ID : UI-PSAL-0701.html
	@작성일 : 2022.02.15
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
var mGrid;

$(document).ready(function() {
    createAUIGrid(columnLayout);
    getSprtList();
});
var gridPros = {
    headerHeight: 29,
    rowHeight: 29,
    // 편집 가능 여부 (기본값 : false)
    editable: false,
    autoGridHeight: false,
    // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
    enterKeyColumnBase: true,
    // 셀 선택모드 (기본값: singleCell)
    selectionMode: "singleRow",
    showFooter: false,
    // 컨텍스트 메뉴 사용 여부 (기본값 : false)
    useContextMenu: true,
    // 필터 사용 여부 (기본값 : false)
    enableFilter: true,
    // 그룹핑 패널 사용
    useGroupingPanel: false,
    // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
    displayTreeOpen: true,
    noDataMessage: "출력할 데이터가 없습니다.",
    groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};


// AUIGrid 를 생성합니다.
function createAUIGrid(columnLayout) {
    // 실제로 #grid_wrap 에 그리드 생성
    mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
}

var columnLayout = [{
    dataField: "updbtn",
    headerText: "수정",
    width: "5%",
    renderer: {
        type: "ButtonRenderer",
        onClick: function(event) {
        	var gData =AUIGrid.getItemByRowIndex(mGrid,event.rowIndex);
        	var vendSeq = gData.vendSeq;
        	var vendSprtSeq = gData.vendSprtSeq;
            location.href ="/sale/bcncMngDtl.do?sprtEditSeq="+vendSprtSeq+"&vendSeq="+vendSeq;
        },
    }
}, {
    dataField: "vendCd",
    headerText: "거래처코드",
    width: "5%"
}, {
    dataField: "vendNm",
    headerText: "거래처명",
    width: "8%",
    style: "auiLeft"
}, {
    dataField: "emplNm",
    headerText: "담당직원",
    width: "5%"
}, {
    dataField: "useYn",
    headerText: "적용여부",
    width: "4%"
}, {
    dataField: "grant",
    headerText: "지원금",
    children: [{
        dataField: "hoffAlotm",
        headerText: "회사부담금",
        width: "7%",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight"
    }, {
        dataField: "agenAlotm",
        headerText: "대리점부담금",
        width: "7%",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight"
    }, {
        dataField: "ctStatDt",
        headerText: "지급일",
        width: "8%",
    }, {
        dataField: "ctMemo",
        headerText: "메모",
        headerStyle: "auiRightBorR",
        width: "12%",
        style: "auiLeft"
    }]
}, {
    dataField: "subsidy",
    headerText: "장려금",
    children: [{
        dataField: "subsidRate",
        headerText: "지급율",
        width: "4%",
    }, {
        dataField: "subsidCt",
        headerText: "금액",
        width: "6%",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight"
    }, {
        dataField: "subsidStatDt",
        headerText: "기간 시작일",
        width: "6%",
    }, {
        dataField: "subsidClsDt",
        headerText: "기간 종료일",
        headerStyle: "auiRightBorR",
        width: "6%",
    }]
}, {
    dataField: "quanSupport",
    headerText: "물량지원",
    children: [{
        dataField: "sprtPrdCd",
        headerText: "제품코드",
        width: "6%",
    }, {
        dataField: "sprtPrdNm",
        headerText: "제품명",
        width: "12%",
        style: "auiLeft"
    }, {
        dataField: "prdQty",
        headerText: "수량",
        width: "4%",
        style: "auiRight"
    }, {
        dataField: "prdCt",
        headerText: "금액",
        width: "6%",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight"
    }, {
        dataField: "prdStatDt",
        headerText: "지급일",
        width: "6%",
        headerStyle: "auiRightBorR",
    }]
}, {
    dataField: "equiSupport",
    headerText: "장비지원",
    children: [{
        dataField: "sprtEqpmnNm",
        headerText: "장비명",
        width: "6%",
    }, {
        dataField: "eqpmnQty",
        headerText: "수량",
        width: "4%",
        style: "auiRight"
    }, {
        dataField: "eqpmnCt",
        headerText: "금액",
        width: "6%",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight"
    }, {
        dataField: "eqpmnStatDt",
        headerText: "지급일",
        width: "6%",
    }, {
        dataField: "eqpmnClsDt",
        headerText: "회수일",
        headerStyle: "auiRightBorR",
        width: "6%",
    }]
}, {
    dataField: "etc",
    headerText: "기타",
    children: [{
        dataField: "etcCt",
        headerText: "금액",
        width: "6%",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight"
    }, {
        dataField: "etcStatDt",
        headerText: "지급일",
        width: "6%",
    }, {
        dataField: "etcMemo",
        headerText: "메모",
        width: "10%",
        style: "auiLeft"

    }]
}, {
    dataField: "regNm",
    headerText: "등록자",
    width: "4%"
}, {
    dataField: "regDtm",
    headerText: "등록일시",
    width: "6%"
}, {
    dataField: "updNm",
    headerText: "수정자",
    width: "4%"
}, {
    dataField: "updDtm",
    headerText: "수정일시",
    width: "6%"
}];

function getSprtList(){
	$.ajax({
		url : "/sale/selectBcncSprtList.do",
		type : 'POST',
        data:{
        	  "schStatDt"  :$("#datepicker").val(),
        	  "schEndDt"   :$("#datepicker2").val(),
        	  "schEmplSeq" :$("#schEmplSeq").val(),
        	  "schUseYn"   :$("#schUseYn").val(),
        	  "schTxt"  :$("#schVendNm").val()
          },
		success : function(data) {
			console.log(data);
			$("#listCnt").html(data.bcncSprtList.length);
			AUIGrid.setGridData(mGrid, data.bcncSprtList);
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- 조회 -->
	<div class="inquiryBox type03 formBtnRepon">
	    <div class="dlBoxWrap">
	        <div class="dlBox">
	            <dl>
	                <dt>적용일자</dt>
	                <dd>
	                    <div class="formWrap">
	                        <div class="dateWrap">
	                            <input type="text" name="date" value="10/24/1984" class="datepicker" id="datepicker" readonly="">
	                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
	                        </div>

	                        <span class="divi02">-</span>

	                        <div class="dateWrap">
	                            <input type="text" name="date" value="10/24/1984" class="datepicker" id="datepicker2" readonly="">
	                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker2"></button>
	                        </div>
	                    </div>
	                </dd>
	                <dt>담당직원</dt>
	                <dd>
	                    <select name="schEmplSeq" class="sel" id="schEmplSeq">
							<option value="">전체</option>
							<c:forEach var="empl" items="${emplList}" varStatus="status">
								<option value="<c:out value="${empl.emplSeq}" />" ><c:out value="${empl.emplNm}" /></option>
							</c:forEach>
	                    </select>
	                </dd>
	                <dt>적용여부</dt>
	                <dd>
	                    <select name="schUseYn" class="sel W10" id ="schUseYn">
	                        <option value ="">전체</option>
	                        <option value ="Y">Y</option>
	                        <option value ="N">N</option>
	                    </select>
	                </dd>
	                <dt>거래처명</dt>
	                <dd>
	                    <input type="text" id="schVendNm" class="inp w160" name="schVendNm" value="" title="거래처명">
	                </dd>
	            </dl>
	        </div>

	        <div class="btnRepon">
	            <button type="button" name="" class="comBtn" id="inp_name01" onclick ="getSprtList();">조회</button>
	        </div>
	    </div>
	</div>
	<!-- 조회 -->

	<div class="titleArea right">
	    <h3 class="tit01">지원 내역 관리</h3>
	</div>

	<div class="titleArea right">
	    <p class="numState">
	        <em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
	    </p>
	</div>

	<!-- grid -->
	<div class="girdBox">
	    <div id="grid_wrap"></div>
	</div>
	<!-- grid -->
	</div>
