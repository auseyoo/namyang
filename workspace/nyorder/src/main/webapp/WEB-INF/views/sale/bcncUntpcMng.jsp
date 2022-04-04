<!--
	@File Name: bcncUntpcDtl
	@File 설명 : 거래처별 단가 관리
	@UI ID : UI-PSAL-0201.html
	@작성일 : 2022.01.18
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
var mGrid;
var mGrid2;
var arrChildren = [];

var targetNotGrid = false;
var untpcPage =true;
var prdBndChg = false;
$(document).ready(function() {

    createAUIGrid();
    AUIGrid.setFooter(mGrid2);
    searchBcncList();
    getPuchList();
    AUIGrid.bind(mGrid2, "cellEditBegin", function(event) {
        if(fnIsEmpty(event.item.chgSaleUntpc) && event.dataField =="chgApplDt"){
           return false;
        }
    });
    AUIGrid.bind(mGrid, "selectionChange", function(event) {
    	var primeCell = event.primeCell;
		var rowItem = primeCell.item;
    	var vendSeq = rowItem.vendSeq;
    	searchUntpcList(vendSeq);
    });

});
var columnLayout = [{
    dataField: "vendSeq",
    visible: false,
    editable: false,
    width: "10%"
},{
    dataField: "vendCd",
    headerText: "거래처코드",
}, {
    dataField: "vendNm",
    headerText: "거래처명",
    width: "22%",
}, {
    dataField: "vendPrst",
    headerText: "대표자명",
    width: "22%"
}, {
    dataField: "emplNm",
    headerText: "담당자명",
    width: "22%"

}];
var columnLayout2 = [{
    dataField: "vendUntpcSeq",
    visible: false,
    editable: false
},{
    dataField: "prdDtlSeq",
    visible: false,
    editable: false
},{
    dataField: "puchCd",
    headerText: "매입처코드",
//     visible: false,
    editable: false
},{
    dataField: "puchNm",
    headerText: "매입처명",
//     visible: false,
    editable: false
},{
    dataField: "prdDtlCd",
    headerText: "제품코드",
    editable: false,
    width: "10%",
    renderer: { // HTML 템플릿 렌더러 사용
        type: "TemplateRenderer"
    },
    labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
        if(item.prdDtlCd){
            var template = item.prdDtlCd
        }else{
            var template = '<div class="searchWrap">';
            template += '<span class="my_div_text_box"><a href="#" class="serach" onclick =\'openSearchPrdPop(); \'></a></span>';
            template += '</div>';
        }
        return template;
    }
}, {
    dataField: "prdNm",
    headerText: "제품명",
    style: "auiLeft",
    editable: false,
    renderer: { // HTML 템플릿 렌더러 사용
        type: "TemplateRenderer"
    },
    labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
        if(item.prdNm){
            var template = item.prdNm
        }else{
            var template = '<div class="searchWrap">';
            template += '<span class="my_div_text_box"><a href="#" class="serach" onclick =\'openSearchPrdPop(); \'></a></span>';
            template += '</div>';
        }
        return template;
    }
}, {
    dataField: "iddyPchaCt",
    headerText: "매입단가",
    editable: false,
    width: "9%"
}, {
    dataField: "saleUntpcTr",
    headerText: "판매단가",
    children: [{
        dataField: "saleUntpcCt",
        headerText: "금액",
        editable: false,
        width: "5%",
        style: "auiRight"
    }, {
        dataField: "saleUntpcVat",
        headerText: "VAT",
        editable: false,
        width: "5%",
        style: "auiRight"
    }, {
        dataField: "saleUntpc",
        headerText: "計",
        editable: false,
        width: "5%",
        style: "auiRight"
    }]
}, {
    dataField: "mrgn",
    headerText: "마진",
    editable: false,
    width: "8%",
    style: "auiRight"
}, {
    dataField: "mrgnRate",
    headerText: "마진율",
    editable: false,
    width: "8%",
    style: "auiRight"
}, {
    dataField: "chgSaleUntpc",
    headerText: "변경단가",
    editable: true,
    dataType: "numeric",
    formatString: "#,##0",
    width: "8%",
    editable: true,
    renderer: { // HTML 템플릿 렌더러 사용
        type: "TemplateRenderer"
    },
    // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
    labelFunction: function(rowIndex, columnIndex, value, headerText, item) { // HTML 템플릿 작성
        var width = (item.width - 12); // 좌우 여백 생각하여 12 빼줌.
        var template = '<input type="text" class="auiInput01 right"';
        template += ' style="width:90%;"'; // 칼럼 전체 크기를 변경했을 때 작성한 input 도 같이 변경시키기 위함.
        template += ' value="' + value + '" onblur="javascript:untpcInput(' + rowIndex + ', this.value, event,\'chgSaleUntpc\');"'
        template += ' onkeydown="if(event.keyCode == 9) event.preventDefault();"' //탭 키를 누르면 브라우저에서 자동으로 다음 input 을 찾는데 이를 방지.
        template += '>';
        return template;
    }
}, {
    dataField: "chgMrgn",
    headerText: "변경<br>마진",
    editable: false,
    width: "8%",
    style: "auiRight"
}, {
    dataField: "chgMrgnRate",
    headerText: "변경<br>마진율",
    editable: false,
    width: "8%",
    style: "auiRight"
}, {
    dataField: "chgApplDt",
    headerText: "적용일자",
    editable: true,
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
}];

var auiGridProps = {
    headerHeight: 29,
    rowHeight: 29,
    // 편집 가능 여부 (기본값 : false)
    editable: true,
    rowNumColumnWidth: 40,
    // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
    enterKeyColumnBase: true,
    rowIdField: "vendSeq",
    showStateColumn: true,
    showRowCheckColumn: false, // 체크박스 사용
    wrapSelectionMove: true,
    editingOnKeyDown: true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
    // 셀 선택모드 (기본값: singleCell)
    selectionMode: "multipleRows",
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
var auiGridProps2 = {
    headerHeight: 29,
    autoGridHeight: false ,
    rowHeight: 29,
    rowNumColumnWidth: 40,
    enableHScrollByWheel: false,
    editable: true,
    enterKeyColumnBase: true,
    editingOnKeyDown: true,
    rowIdField: "vendUntpcSeq",
    showStateColumn: true,
    wrapSelectionMove: true,
    selectionMode: "multipleCells",
    showFooter: false,
    useContextMenu: true,
    enableFilter: true,
    useGroupingPanel: false,
    displayTreeOpen: true,
    noDataMessage: "출력할 데이터가 없습니다.",
    groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
    showRowCheckColumn: true, // 체크박스 사용
}

function createAUIGrid() {
    mGrid = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps);
    mGrid2 = AUIGrid.create("#grid_wrap2", columnLayout2, auiGridProps2);
}


// AUIGrid 칼럼 설정
// 데이터 형태는 다음과 같은 형태임,
//[{"id":"#Cust0","date":"2014-09-03","name":"Han","country":"USA","product":"Apple","color":"Red","price":746400}, { .....} ];

// AUIGrid 를 생성합니다.


function auiCellEditingHandler(event) {
    if (event.type == "cellEditBegin") {
        document.getElementById("editBeginDesc").innerHTML = "에디팅 시작(cellEditBegin) : ( " +
            event.rowIndex +
            ", " +
            event.columnIndex +
            " ) " +
            event.headerText + ", value : " + event.value;
    } else if (event.type == "cellEditEnd") {
        document.getElementById("editBeginEnd").innerHTML = "에디팅 종료(cellEditEnd) : ( " +
            event.rowIndex +
            ", " +
            event.columnIndex +
            " ) " +
            event.headerText + ", value : " + event.value;
    } else if (event.type == "cellEditCancel") {
        document.getElementById("editBeginEnd").innerHTML = "에디팅 취소(cellEditCancel) : ( " +
            event.rowIndex +
            ", " +
            event.columnIndex +
            " ) " +
            event.headerText + ", value : " + event.value;
    }
};


//행추가
var countries = ["vendUntpcSeq","prdDtlCd", "prdNm", "iddyPchaCt", "saleUntpcCt", "saleUntpcVat", "saleUntpc", "mrgn", "mrgnRate", "chgSaleUntpc", "chgMrgn", "chgMrgnRate", "chgApplDt"];


function addRow(rowPos) {
    var item = new Object();
    var selectedItems = AUIGrid.getSelectedItems(mGrid);
    if(selectedItems.length ==0){
    	alert('단가를 추가할 거래처를 선택하세요.');
		return;
    }
    var addedRowItems = AUIGrid.getAddedRowItems(mGrid2);
    if (addedRowItems.length > 0) {
    	alert('먼저 추가된 행을 저장 하세요.');
		return;
    }
    AUIGrid.addRow(mGrid2, item, rowPos);
}

// 행 삭제
function removeRow() {
	var checkedItems = AUIGrid.getCheckedRowItems(mGrid2);
    if (!checkedItems.length) {
        alert("삭제할 내역을 선택하세요.");
    }
    checkedItems.forEach(function(item){
//          if(AUIGrid.getCellValue(mGrid2, item.rowIndex,'saleYn')=='Y'){
//         	 alert("제품코드 "+AUIGrid.getCellValue(mGrid2,item.rowIndex,'prdDtlCd')+"은(는) 판매 등록이 되어있어 삭제가 불가능합니다.");
//          }else if(AUIGrid.getCellValue(mGrid2, item.rowIndex,'bndYn')=='Y'){
//         	 alert("제품코드 "+AUIGrid.getCellValue(mGrid2,item.rowIndex,'prdDtlCd')+"은(는) 제품일괄변경이 예정 되어있어 삭제가 불가능합니다.");

//          }else{
        	 AUIGrid.removeRow(mGrid2, item.rowIndex);
//          }
    });
    AUIGrid.setAllCheckedRows(mGrid2,false);
}

// 윈도우 리사이징 이벤트
window.onresize = function() {
    // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출
    if (typeof mGrid !== "undefined") {
        AUIGrid.resize(mGrid);
    }
    if (typeof mGrid2 !== "undefined") {
        AUIGrid.resize(mGrid2);
    }
};
/* 판매단가 직접입력시 함수 */
function untpcInput(rowIndex, selectedValue, event, datafieldName) {
    if (selectedValue == 0) return;
    var tmpIddyPchaCt;
    var tmpSaleUntpc;
    var tmpMrgnRate;
    var modifyItem;

    modifyItem = {
        [datafieldName]: Number(selectedValue)
    };
    AUIGrid.updateRow(mGrid2, modifyItem, rowIndex);
    tmpIddyPchaCt = AUIGrid.getCellValue(mGrid2, rowIndex, "iddyPchaCt");
    tmpSaleUntpc = AUIGrid.getCellValue(mGrid2, rowIndex, "chgSaleUntpc");
    AUIGrid.updateRow(mGrid2, {
        "chgMrgnRate": mrgnRateCal(tmpIddyPchaCt, tmpSaleUntpc)
    }, rowIndex);
    tmpMrgnRate = AUIGrid.getCellValue(mGrid2, rowIndex, "chgMrgnRate");
    AUIGrid.updateRow(mGrid2, {
        'chgMrgn': mrgnCal(tmpSaleUntpc, tmpMrgnRate)
    }, rowIndex);
}

/* 마진율 일괄 적용 함수 */
function mrgnBatchApply() {
    var tmpMrgnRate = $("#batchMrgnRate").val();
    var tmpIddyPchaCt;
    var tmpSaleUntpc;
    var rowIndex = 0;
    AUIGrid.updateRow(mGrid2, {
        'chgMrgnRate': tmpMrgnRate
    }, rowIndex);
    tmpIddyPchaCt = AUIGrid.getCellValue(mGrid2, rowIndex, "iddyPchaCt");
    AUIGrid.updateRow(mGrid2, {
        'chgSaleUntpc': saleUntpcCal(tmpIddyPchaCt, tmpMrgnRate)
    }, rowIndex);
    tmpSaleUntpc = AUIGrid.getCellValue(mGrid2, rowIndex, "chgSaleUntpc");
    AUIGrid.updateRow(mGrid2, {
        'chgMrgn': mrgnCal(tmpSaleUntpc, tmpMrgnRate)
    }, rowIndex);
}

/* cost : 원가, price : 판매가 */
/* 판매 단가 계산 */
function saleUntpcCal(cost, mrgnRate) {
    return parseInt(cost / (1 - (mrgnRate / 100)));
}
/* 마진율 계산 */
function mrgnRateCal(cost, price) {
    return ((1 - (cost / price)) * 100).toFixed(2);
}
/* 마진 계산 */
function mrgnCal(price, mrgnRate) {
    return (price * (mrgnRate / 100)).toFixed(0);
}

function searchBcncList() {
    $.ajax({
        url: "/sale/selectBcncMngList.do",
        type: 'POST',
        success: function(data) {
            console.log(data);
        	AUIGrid.setGridData(mGrid, data);
			$("#listCnt").html(data.length);
			$.each(data, function(idx,item){
				var option = $("<option value ='"+item.vendSeq+"'>"+item.vendNm+"</option>");
				$('#stdrVendSeq').append(option);
			});
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}
function searchUntpcList(vendSeq) {
    $.ajax({
        url: "/sale/selectUntpcMngList.do",
        type: 'POST',
        data:{
        	  "vendSeq" :vendSeq
        },
        success: function(data) {
        	AUIGrid.setGridData(mGrid2, data);
			$("#listCnt2").html(data.length);
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}
function saveAgenVendUntpc(){
	var saveData = new Array();
    var addedRowItems = AUIGrid.getAddedRowItems(mGrid2);
    var editedRowItems = AUIGrid.getEditedRowItems(mGrid2);
    var removedRowItems = AUIGrid.getRemovedItems(mGrid2);
    var newArr = [...addedRowItems,...editedRowItems];
    var t_vendSeq =AUIGrid.getSelectedItems(mGrid)[0].item.vendSeq;
	$.each(newArr, function(idx,item){
		saveData.push({
			"chgType" : "NORM",
			"agenSeq":AUIGrid.getSelectedItems(mGrid)[0].item.agenSeq,
			"vendSeq":t_vendSeq,
			"prdDtlSeq":item.prdDtlSeq,
			"aftPrdDtlSeq":item.prdDtlSeq,
			"befPrdDtlSeq":item.prdDtlSeq,
			"vendUntpcSeq" : item.vendUntpcSeq,
			"chgUntpcSeq" : item.chgUntpcSeq,
			"chgSaleUntpc" : item.chgSaleUntpc,
			"chgApplDt" : item.chgApplDt,
			"puchSeq" : item.puchSeq,
			"removeYn" : "N"
		});
	});
	$.each(removedRowItems, function(idx,item){
		saveData.push({
			"chgType" : "NORM",
			"agenSeq":AUIGrid.getSelectedItems(mGrid)[0].item.agenSeq,
			"vendSeq":t_vendSeq,
			"prdDtlSeq":item.prdDtlSeq,
			"aftPrdDtlSeq":item.prdDtlSeq,
			"removeYn" : "Y"
		});
	});
	if(saveData.length ==0){
		alert("수정 데이터가 없습니다.");
		return;
	}
    $.ajax({
        url: "/sale/saveAgenVendUntpc.do",
        type: 'POST',
        contentType : "application/json; charset=utf-8",
        data:JSON.stringify (saveData),
        success: function(data) {
            searchUntpcList(t_vendSeq);
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });


}


//엑셀 내보내기(Export);
function exportTo() {
	AUIGrid.exportToXlsx(mGrid2, {
		// 스타일 상태 유지 여부(기본값:true)
		exportWithStyle : true,
		fileName : "거래처 단가 정보"
	});
};

function openSearchPrdPop(){
	$.ajaxDialog({
		id: "searchBcncPrdPop",
		ajax: {
			url: "/sale/searchBcncPrdPop.do",
		},
		dialog: {
			width:860,
			height:560
		},
		success: function(data) {
		}
	});
}

function copyBcncUntpc(){
	var vendSeq =AUIGrid.getSelectedItems(mGrid)[0].item.vendSeq;
	var agenSeq =AUIGrid.getSelectedItems(mGrid)[0].item.agenSeq;
    $.ajax({
        url: "/sale/selectStdrPrdList.do",
        contentType: 'application/json',
        type: 'POST',
        data:JSON.stringify({
              "agenSeq" : agenSeq,
              "vendSeq" : vendSeq,
        	  "stdrVendSeq" :$("#stdrVendSeq").val()
        }),
        success: function(data) {
            $.each(data, function(idx,item){
				var setVal ={
					vendUntpcSeq: item.vendUntpcSeq,
					chgSaleUntpc : item.stdrSaleUntpc,
				};
				console.log(setVal);
            	AUIGrid.updateRowsById(mGrid2, setVal);
			});

        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });

}

//매입처 리스트
function getPuchList(){

	$.ajax({
		url : "/cst/selectPuchList.do",
		type : 'POST',
		data : {},
		success : function(data) {

			console.log("data", data);
			let selHtml = "";

			$.each(data, function(index, item){
				selHtml = selHtml  + "<option value='"+item.puchSeq+"'>"+item.puchNm+"</option>";
			});

			$("#puchSeq").html(selHtml);

		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}
</script>
<form name="frm" id="frm">
	<input type="hidden" name="targetEmplSeq" value="${emplSeq}" />
</form>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />

	<!-- 조회 -->
	<div class="inquiryBox type02">
		<dl>
			<dt>거래처명</dt>
			<dd>
				<input type ="text" name ="schVendNm" id = "schVendNm" />
			</dd>
			<dt>매입처</dt>
			<dd>
				<div class="formWrap">
					<select name="puchSeq" class="sel" id="puchSeq">

					</select>
				</div>
			</dd>
			<dt>제품</dt>
			<dd>
				<div class="formWrap">
					<input type="text" id="inp_name01" class="inp w120 mr10" value=""
						title="제품 입력" placeholder="제품코드"> <input type="text"
						id="inp_name01" class="inp w160" value="" title="제품 입력"
						placeholder="제품명">
					<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
				</div>
			</dd>
		</dl>
		<div class="btnGroup right">
			<button type="button" name="" class="comBtn"
				onclick="addRow('first')">행추가</button>
			<button type="button" name="" class="comBtn"onclick="removeRow();">행삭제</button>
			<button type="button" name="" class="comBtn" onclick ="exportTo();">엑셀다운</button>
			<button type="button" name="" class="inquBtn" onclick ='saveAgenVendUntpc();'>저장</button>
		</div>


	</div>
	<!-- 조회 -->

	<!-- grid -->
	<div class="girdBoxGroup">
		<div class="girdBox w43per">
			<div class="titleArea">
				<h3 class="tit01">거래처 정보</h3>
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>
			<div id="grid_wrap" style="height: 660px"></div>
		</div>

		<div class="girdBox girdBox2">
			<div class="titleArea">
				<h3 class="tit01">거래처별 단가 정보</h3>
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="listCnt2">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>
			<div id="grid_wrap2" style="height: 670px"></div>
			<div class="conBox" style="position:relative;">
				<div class="inquiryBox type04 dtShort">
					<dl>
						<dt>기준거래처</dt>
						<dd>
							<select name="stdrBcncSeq" class="sel w100" id ="stdrVendSeq"></select>
							<button type="button" name="" class="comBtn small" onclick ="copyBcncUntpc();">단가복사</button>
						</dd>
						<dt class="line">
							<label for="inp_name01">마진율(%)</label>
						</dt>
						<dd>
							<input type="text" id="inp_name01" class="inp" value=""
								title="성명 입력">
						</dd>
						<dt>
							<label for="sel_unit">단가절삭방식</label>
						</dt>
						<dd>
							<select name="" class="sel w100" id="sel_unit">
								<option>원단위</option>
								<option>십원단위</option>
								<option>백원단위</option>
								<option>천원단위</option>
							</select>
						</dd>
					</dl>
					<div class="btnGroup right">
						<button type="button" name="" class="comBtn small">적용</button>
					</div>
				</div>

				<!-- table -->
				<!-- <table class="tbl">
                                        <caption>출고증 인쇄시 사용항목 정보</caption>
                                        <colgroup>
                                            <col style="width:132px;">
                                            <col>
                                            <col style="width:132px;">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">
                                                    <label for="inp_bankNum">약어(8 Byte)</label>
                                                </th>
                                                <td>
                                                    <input type="text" id="inp_bankNum" class="inp" value="" name="">
                                                </td>
                                                <th scope="row">
                                                    <label for="inp_repPrdNm">대표제품명</label>
                                                </th>
                                                <td>
                                                    <input type="text" id="inp_repPrdNm" class="inp" value="" name="">
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table> -->
				<!--// table -->
			</div>
		</div>

	</div>
	<!-- grid -->
</div>
