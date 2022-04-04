<!--
	@File Name: bcncBilctMng.jsp
	@File 설명 : 거래처 수금관리
	@UI ID :
	@작성일 : 2022. 1. 17.
	@작성자 : YESOL
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
    AUIGrid.setFooter(mGrid, footerLayout);
    AUIGrid.bind(mGrid, "cellEditBegin", function(event) {
   	 //console.log(event);
       if(event.item.editableYn =='N'){

          return false;
       }
   });

    searchBaBillTotList();
});
var gridPros = {
    headerHeight: 29,
    rowHeight: 29,
    editable: true,
    autoGridHeight: true,
    showStateColumn: true,
    wrapSelectionMove: true,
    editingOnKeyDown: true,
    selectionMode: "multipleCells",
    showFooter: true,
    useContextMenu: true,
    enableFilter: true,
    useGroupingPanel: false,
    displayTreeOpen: true,
    rowIdField: "vendBillSeq",
    noDataMessage: "출력할 데이터가 없습니다.",
    groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};

function createAUIGrid(columnLayout) {
    mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
}

var columnLayout = [{
    dataField: "vendBillSeq",
    visible: false,
    editable: false
},{
    dataField: "vendSeq",
    visible: false,
    editable: false
},{
    dataField: "vendCd",
    headerText: "거래처코드",
    width: "8%",
    editable: false,
    renderer: { // HTML 템플릿 렌더러 사용
        type: "TemplateRenderer"
    },
    labelFunction: function(rowIndex, columnIndex, value, headerText, item, dataField, cItem) {
        console.log(item.vendCd);
        if(item.vendCd){
            var template = item.vendCd
        }else{
            var template = '<div class="searchWrap">';
            template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchBcncPop(); \'></a></span>';
            template += '</div>';
        }
        return template;
    }
}, {
    dataField: "vendNm",
    headerText: "거래처명",
    width: "12%",
    style: "auiLeft",
    editable: false,
  	renderer: { // HTML 템플릿 렌더러 사용
  	        type: "TemplateRenderer"
    },
    labelFunction: function(rowIndex, columnIndex, value, headerText, item, dataField, cItem) {
        if(item.vendNm){
            var template = item.vendNm
        }else{
            var template = '<div class="searchWrap">';
            template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchBcncPop(); \'></a></span>';
            template += '</div>';
        }
        return template;
    }
}, {
    dataField: "emplNm",
    headerText: "담당자",
    width: "7%",
},{
    dataField: "billDt",
    headerText: "수금일자",
    width: "14%",
    dataType: "date",
    dateInputFormat: "yyyymmdd", // 실제 데이터의 형식 지정
    formatString: "yyyy - mm - dd", // 실제 데이터 형식을 어떻게 표시할지 지정
    renderer: {
        type: "IconRenderer",
        iconWidth: 24, // icon 사이즈, 지정하지 않으면 rowHeight에 맞게 기본값 적용됨
        iconHeight: 24,
        iconPosition: "aisleRight",
        iconTableRef: { // icon 값 참조할 테이블 레퍼런스
            "default": "../images/AUIGrid/calendar-icon.png" // default
        },
        onClick: function(event) {
            // 달력 아이콘 클릭하면 실제로 달력을 띄움.
            // 즉, 수정으로 진입함.
            console.log(event);
            AUIGrid.openInputer(event.pid);
        }
    },
    editRenderer: {
        type: "CalendarRenderer",
        defaultFormat: "yyyymmdd", // 달력 선택 시 데이터에 적용되는 날짜 형식
        showEditorBtn: false,
        showEditorBtnOver: false, // 마우스 오버 시 에디터버턴 출력 여부
        showPlaceholder:true,
        onlyCalendar: true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
        showExtraDays: true // 지난 달, 다음 달 여분의 날짜(days) 출력
    }
}, {
    dataField: "delgAtmptCt",
    editable: false,
    headerText: "전일미수금",
    dataType: "numeric",
    formatString: "#,##0",
    width: "8%",
    style: "auiRight"
}, {
    dataField: "rlSaleCt",
    editable: false,
    headerText: "순매출금액",
    dataType: "numeric",
    formatString: "#,##0",
    width: "8%",
    style: "auiRight"
}, {
    dataField: "cashBilct",
    headerText: "현금수금액",
    dataType: "numeric",
    formatString: "#,##0",
    width: "8%",
    style: "auiRight"
}, {
    dataField: "cashExcpBilct",
    headerText: "현금외수금액",
    dataType: "numeric",
    formatString: "#,##0",
    width: "8%",
    style: "auiRight"
}, {
    dataField: "atmptCt",
    editable: false,
    headerText: "총미수금액",
    dataType: "numeric",
    formatString: "#,##0",
    width: "8%",
    style: "auiRight"
}, {
    dataField: "pAdjust",
    editable: false,
    headerText: "미수금조정",
    dataType: "numeric",
    formatString: "#,##0",
    width: "8%",
    style: "auiRight"
}, {
    dataField: "etc",
    headerText: "비고",
    width: "15%",
    style: "auiLeft"
}, {
    dataField: "regDtm",
    editable: false,
    headerText: "저장일시",
    width: "10%"
}];

// 푸터 설정
var footerLayout = [{
    labelText: "∑",
    positionField: "#base"
}, {
    dataField: "code",
    positionField: "code",
    operation: "SUM",
    colSpan: 2, // 자신을 포함하여 4개의 푸터를 가로 병합함.
    labelFunction: function(value, columnValues, footerValues) {
        // return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
        return "합계 : "
    }
}, {
    dataField: "preDayPrice",
    positionField: "preDayPrice",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "netSales",
    positionField: "netSales",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "amountCash",
    positionField: "amountCash",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "cashSales",
    positionField: "cashSales",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "etc",
    positionField: "etc",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}];

function addRow() {
	var item = new Object();
	var addedRowItems = AUIGrid.getAddedRowItems(mGrid);
	if (addedRowItems.length > 0) {

		alert('먼저 추가된 행을 저장 하세요.');
		return;
	}
	AUIGrid.addRow(mGrid, item, 'first');
}


function saveBaBillTot(){
	var addedRowItems = AUIGrid.getAddedRowItems(mGrid);
	var editedRowItems = AUIGrid.getEditedRowItems(mGrid);
	var removedRowItems = AUIGrid.getRemovedItems(mGrid);
	var saveData = new Array();
	var newArr = [...addedRowItems,...editedRowItems];
	var vendBillSeq;
	var cashBilct;
	var cashExcpBilct;
	$.each(newArr, function(idx,item){
		if(!isNaN(item.vendBillSeq)){
			vendBillSeq = item.vendBillSeq;
		}
		cashBilct = item.cashBilct || 0;
		cashExcpBilct = item.cashExcpBilct || 0;
		saveData.push({
			"rlSaleCt" :0,
			"vendBillSeq" : vendBillSeq,
			"vendSeq":item.vendSeq,
			"cashBilct":cashBilct,
			"cashExcpBilct":cashExcpBilct,
			"billDt":item.billDt
		});
	});

    $.ajax({
        url: "/sale/saveBaBillTot.do",
        type: 'POST',
        contentType : "application/json; charset=utf-8",
        data:JSON.stringify (saveData),
        success: function(data) {
        	alert("저장되었습니다.");
        	searchBaBillTotList();
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}
function searchBaBillTotList(){
	$.ajax({
        url: "/sale/selectBaBillTotList.do",
        type: 'POST',
        data:{
      	  "schStatBillDt"  :$("#datepicker").val(),
      	  "schEndBillDt"  :$("#datepicker2").val()
        },
        success: function(data) {
            console.log(data);
            AUIGrid.setGridData(mGrid, data);
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}

function openSearchBcncPop(){
	$.ajaxDialog({
		id: "searchBcncPop",
		ajax: {
			url: "/sale/searchBcncPop.do",
		},
		dialog: {
			width:860,
			height:560
		},
		success: function(data) {
		}
	});
}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- 조회 -->
	<div class="inquiryBox dtShort">
		<dl>
			<dt>수금일자</dt>
			<dd>
				<div class="formWrap">
					<div class="dateWrap">
						<input type="text" name="schStatBillDt" value="" class="datepicker" id="datepicker" readonly="">
						<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
					</div>

					<span class="divi02">-</span>

					<div class="dateWrap">
						<input type="text" name="schEndBillDt" value="" class="datepicker" id="datepicker2" readonly="">
						<button type="button" class="datepickerBtn2" title="날짜입력" data-target-id="datepicker2"></button>
					</div>
				</div>
			</dd>
			<dt>담당직원</dt>
			<dd>
				<select name="targetEmplSeq" class="sel">
					<option value="">전체</option>
					<c:forEach var="empl" items="${emplList}" varStatus="status">
						<option value="<c:out value="${empl.emplSeq}" />" ><c:out value="${empl.emplNm}" /></option>
					</c:forEach>
				</select>
			</dd>
			<dt>거래처명</dt>
			<dd>
				<div class="formWrap">
					<input type="text" id="inp_product01" class="inp w120" value="" name="vendNm" id ="vendNm" placeholder="거래처명">
					<button type="button" name="" class="comBtn" id="inp_name01" onclick ="searchBaBillTotList();">조회</button>
				</div>
			</dd>
		</dl>

		<div class="btnGroup right">
			<button type="button" name="" class="comBtn">엑셀다운</button>
			<button type="button" name="" class="inquBtn" onclick ="saveBaBillTot();">저장</button>
		</div>
	</div>
	<!-- 조회 -->

	<div class="titleArea">
		<h3 class="tit01">수금일자 정보</h3>
	</div>

	<div class="titleArea right">
		<p class="numState">
			<em>총 <span class="pColor01 fb">0</span></em> 건 이 조회되었습니다.
		</p>
		<button type="button" name="" class="comBtn small"  onclick="addRow()">행추가</button>
	</div>

	<!-- grid -->
	<div class="girdBox">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->
</div>