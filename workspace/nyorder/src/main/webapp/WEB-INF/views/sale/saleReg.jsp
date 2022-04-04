<!--
	@File Name: saleReg
	@File 설명 : 판매등록
	@UI ID : UI-PSAL-0301.html
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
var targetNotGrid = false;
var untpcPage =false;
var prdBndChg = false;

$(document).ready(function() {
    // AUIGrid 생성 후 반환 ID
    createAUIGrid();
    searchBcncList();
    // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
    AUIGrid.bind(mGrid, "selectionChange", function(event) {
    	searchSaleList();
    });
    $("#datepicker").change(function(){searchSaleList()});
    AUIGrid.setFooter(mGrid2, footerLayout);

    AUIGrid.bind(mGrid2, "cellEditBegin", function(event) {
    	 //console.log(event);
        if((event.item.speclUntpcYn ==null || event.item.speclUntpcYn == false ) && event.dataField =="saleUntpc"){

           return false;
        }
    });
});
var columnLayout = [{
    dataField: "vendSeq",
    visible: false,
    editable: false
}, {
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
	    dataField: "vendSaleDtlSeq",
	    visible: false,
	    editable: false
	},{
	    dataField: "prdDtlSeq",
	    visible: false,
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
	    width: "18%",
	    editable: false,
	    renderer: { // HTML 템플릿 렌더러 사용
	        type: "TemplateRenderer"
	    },
	    labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
	        if(item.prdNm){
	            var template = item.prdNm
	        }else{
	            var template = '<div class="searchWrap">';
	            template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop(); \'></a></span>';
	            template += '</div>';
	        }
	        return template;
	    }
	},
    {
        dataField: "faltQty",
        editable: false,
        headerText: "입수량",
        width: "5%",
    },
    {
        dataField: "saleQty",
        headerText: "판매수량",
        width: "7%",
        editable: true,
        renderer: { // HTML 템플릿 렌더러 사용
            type: "TemplateRenderer"
        },
        // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
        labelFunction: function(rowIndex, columnIndex, value,
            headerText, item) { // HTML 템플릿 작성
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value +
                '</span>';
            template += '</div>';
            return template;
        }
    },
    {
        dataField: "rtgdQty",
        headerText: "반품수량",
        width: "7%",
        editable: true,
        renderer: { // HTML 템플릿 렌더러 사용
            type: "TemplateRenderer"
        },
        // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
        labelFunction: function(rowIndex, columnIndex, value,
            headerText, item) { // HTML 템플릿 작성
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value +
                '</span>';
            template += '</div>';
            return template;
        }
    },
    {
        dataField: "prsntQty",
        headerText: "증정수량",
        width: "7%",
        editable: true,
        renderer: { // HTML 템플릿 렌더러 사용
            type: "TemplateRenderer"
        },
        // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
        labelFunction: function(rowIndex, columnIndex, value,
            headerText, item) { // HTML 템플릿 작성
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value +
                '</span>';
            template += '</div>';
            return template;
        }
    },
    {
        dataField: "exchgQty",
        headerText: "교환수량",
        width: "7%",
        editable: true,
        renderer: { // HTML 템플릿 렌더러 사용
            type: "TemplateRenderer"
        },
        // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
        labelFunction: function(rowIndex, columnIndex, value, headerText, item) { // HTML 템플릿 작성
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value +
                '</span>';
            template += '</div>';
            return template;
        }
    }, {
        dataField: "iddyPchaCt",
        headerText: "매입단가",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight",
        editable: false
    }, {
        dataField: "saleUntpc",
        headerText: "납품단가",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight"
    }, {
        dataField: "amountPrice",
        headerText: "매출금액",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight",
        editable: false,
        expFunction : function(rowIndex, columnIndex, item, dataField) {
            return Number( item.saleUntpc *(item.saleQty - item.rtgdQty) );
   	   }
    }, {
        dataField: "speclUntpcYn",
        headerText: "특별단가",
        width: "8%",
        renderer: {
            type: "CheckBoxEditRenderer",
            editable: true,
            checkValue :'Y',
            imgHeight: 15,
            imgTableRef: {
                "true": "../images/check_on.png",
                "false": "../images/check_default.png",
                "default": "../images/check_on.png"
            }
        }
    }
];


// 그리드 속성 설정
var gridPros = {
    headerHeight: 58,
    rowHeight: 29,
    rowIdField: "vendSeq",
    enterKeyColumnBase: true,
    // 셀 선택모드 (기본값: singleCell)
    selectionMode: "multipleRows",
    //showFooter : true,
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

var gridPros2 = {
    headerHeight: 29,
    rowHeight: 29,
    rowIdField: "vendSaleDtlSeq",
    editable: true, // 편집 가능 여부 (기본값 : false)
    editingOnKeyDown: true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
    useGroupingPanel: false,
    showFooter: true,
    showRowCheckColumn: true, // 체크박스 사용
    enterKeyColumnBase: true, // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
    noDataMessage: "출력할 데이터가 없습니다.",
    softRemoveRowMode: false
}
// AUIGrid 를 생성합니다.
function createAUIGrid() {
    // 실제로 #grid_wrap 에 그리드 생성
    mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
    mGrid2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
}
// 푸터 설정
var footerLayout = [{
    labelText: "∑",
    positionField: "#base"
}, {
    dataField: "prdDtlCd",
    positionField: "prdDtlCd",
    operation: "SUM",
    colSpan: 3, // 자신을 포함하여 3개의 푸터를 가로 병합함.
    labelFunction: function(value, columnValues, footerValues) {
        //return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
        return "합계 : "
    }
}, {
    dataField: "saleQty",
    positionField: "saleQty",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "rtgdQty",
    positionField: "rtgdQty",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "prsntQty",
    positionField: "prsntQty",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "exchgQty",
    positionField: "exchgQty",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "iddyPchaCt",
    positionField: "iddyPchaCt",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "saleUntpc",
    positionField: "saleUntpc",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "amountPrice",
    positionField: "amountPrice",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}];


var countries = ["prdDtlCd", "prdNm", "intake", "salesQn", "returnQn",
    "giftQn", "changeQn", "purchasePrice", "deliPrice", "amountPrice",
    "state"
];
// 행 추가, 삽입
function addRow() {
    var item = new Object();
    var selectedItems = AUIGrid.getSelectedItems(mGrid);
    if(selectedItems.length ==0){
    	alert('추가할 거래처를 선택하세요.');
		return;
    }
    var addedRowItems = AUIGrid.getAddedRowItems(mGrid2);
    if (addedRowItems.length > 0) {
    	alert('먼저 추가된 행을 저장 하세요.');
		return;
    }
    AUIGrid.addRow(mGrid2, item, 'first');
}

// 행 삭제
function removeRow() {
	var checkedItems = AUIGrid.getCheckedRowItems(mGrid2);
    if (!checkedItems.length) {
        alert("삭제할 내역을 선택하세요.");
    }
    checkedItems.forEach(function(item){
    	 AUIGrid.removeRow(mGrid2, item.rowIndex);
    });
}

function searchBcncList() {
    $.ajax({
        url: "/sale/selectBcncMngList.do",
        type: 'POST',
        data: {"vendNm" : $("#vendNm").val()},
        success: function(data) {
            //console.log(data);
        	AUIGrid.setGridData(mGrid, data);

			$("#listCnt").html(data.length);
			AUIGrid.setGridData(mGrid2, []);
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}
function searchSaleList(){
	var vendSeq = AUIGrid.getSelectedItems(mGrid)[0].item.vendSeq;
	if(vendSeq ==null || vendSeq ==""){
		AUIGrid.setGridData(mGrid2, []);
	}else{
	    $.ajax({
	        url: "/sale/selectSaleRegList.do",
	        type: 'POST',
	        data:{
	        	  "vendSeq" :vendSeq,
	        	  "saleDt"  :$("#datepicker").val()
	             },
	        success: function(data) {
	        	AUIGrid.setGridData(mGrid2, data);
				$("#listCnt2").html(data.length);
				getBaBillTot();
	        }, // success
	        error: function(xhr, status) {
	            alert(xhr + " : " + status);
	        }
	    });
	}

}

function saveSaleReg(){
	var saveData ;
	var saleData = new Array();
    var addedRowItems = AUIGrid.getAddedRowItems(mGrid2);
    var editedRowItems = AUIGrid.getEditedRowItems(mGrid2);
    var removedRowItems = AUIGrid.getRemovedItems(mGrid2);
    var newArr = [...addedRowItems,...editedRowItems];
    var t_vendSeq =AUIGrid.getSelectedItems(mGrid)[0].item.vendSeq;
    var vendSaleDtlSeq;
	$.each(newArr, function(idx,item){
		var speclUntpcYn =item.speclUntpcYn;
		if(speclUntpcYn == null || speclUntpcYn ==""){
			speclUntpcYn ='N';
		}
		if(!isNaN(item.vendSaleDtlSeq)){
			vendSaleDtlSeq = item.vendSaleDtlSeq;
		}

		saleData.push({
			"agenSeq":AUIGrid.getSelectedItems(mGrid)[0].item.agenSeq,
			"vendSeq":t_vendSeq,
			"prdDtlSeq":item.prdDtlSeq,
			"puchSeq":item.puchSeq,
			"vendSaleSeq":item.vendSaleSeq,
			"vendSaleDtlSeq":vendSaleDtlSeq,
			"faltQty":item.faltQty,
			"iddyPchaCt":item.iddyPchaCt,
			"saleQty":item.saleQty,
			"saleUntpc":item.saleUntpc,
			"rtgdQty":item.rtgdQty,
			"rtgdCt":item.rtgdQty*item.saleUntpc,
			"prsntQty":item.prsntQty,
			"exchgQty":item.exchgQty,
			"speclUntpcYn":speclUntpcYn,
			"saleDt":$("#datepicker").val(),
			"removeYn" :'N'
		});
	});
	$.each(removedRowItems, function(idx,item){
		saleData.push({
			"agenSeq":AUIGrid.getSelectedItems(mGrid)[0].item.agenSeq,
			"vendSeq":t_vendSeq,
			"vendSaleSeq":item.vendSaleSeq,
			"vendSaleDtlSeq":item.vendSaleDtlSeq,
			"saleDt":$("#datepicker").val(),
			"removeYn" :'Y'
		});
	});

	var t_gridData = AUIGrid.getGridData(mGrid2);
	var saleCt = 0;
	var rtgdCt = 0;
	var sumCt =0;
	var rlSaleCt =0;
	var cashBilct =$("#cashBilct").val() || 0;
	var cashExcpBilct =$("#cashExcpBilct").val() || 0;
	var insPrdDcCt = $("#insPrdDcCt").val() || 0;
	$.each(t_gridData, function(idx,item){
		saleCt += item.saleQty * item.saleUntpc;
		rtgdCt += item.rtgdQty * item.saleUntpc;
	});
	sumCt = saleCt  ;
	rlSaleCt = sumCt - insPrdDcCt;
	saveData = {
		"saleData" :saleData,
		"billData" :{
			"vendBillSeq"    : $("#vendBillSeq").val(),
    		"agenSeq"        : AUIGrid.getSelectedItems(mGrid)[0].item.agenSeq,
    		"vendSeq"	     : AUIGrid.getSelectedItems(mGrid)[0].item.vendSeq,
    		"saleDt"		 : $("#datepicker").val(),
    		"billDt"		 : $("#datepicker").val(),
    		"saleCt" 		 : saleCt,
    		"rtgdCt" 		 : rtgdCt,
    		"sumCt"  		 : sumCt,
    		"totPchaCt"      : 0,
    		"rlSaleCt"		 : rlSaleCt,
    		"cashBilct"      : cashBilct,
    		"cashExcpBilct"  : cashExcpBilct,
    		"prdDcRate"      : $("#insPrdDcRate").val(),
    		"prdDcCt"		 : $("#insPrdDcCt").val()
    	}
	};
	if(saveData.length ==0){
		alert("수정 데이터가 없습니다.");
		return;
	}
    $.ajax({
        url: "/sale/saveSaleReg.do",
        type: 'POST',
        contentType : "application/json; charset=utf-8",
        data:JSON.stringify (saveData),
        success: function(data) {
        	alert("저장되었습니다.");
            searchSaleList();
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });

}
function getBaBillTot(){
	var vendSeq = AUIGrid.getSelectedItems(mGrid)[0].item.vendSeq;
	$.ajax({
        url: "/sale/selectBaBillTot.do",
        type: 'POST',
        data:{
      	  "vendSeq" :vendSeq,
      	  "saleDt"  :$("#datepicker").val()
        },
        success: function(data) {
            var tdAtmptCt = (data.rlSaleCt||0)  - (data.cashBilct||0) - (data.cashExcpBilct||0);
           	$("#vendBillSeq").val(data.vendBillSeq);
           	$("#sumCt").val(data.sumCt);
            $("#rlSaleCt").val(data.rlSaleCt);
            $("#prdDcRate").val(data.prdDcRate);
            $("#prdDcCt").val(data.prdDcCt);
            $("#prdDcRate").val(data.prdDcRate);
            $("#insPrdDcCt").val(data.prdDcCt);
            $("#insPrdDcRate").val(data.prdDcRate);
            $("#cashBilct").val(data.cashBilct);
            $("#cashExcpBilct").val(data.cashExcpBilct);
            $("#atmptCt").val(data.atmptCt);
            $("#tdAtmptCt").val(tdAtmptCt);
            $("#delgAtmptCt").val(data.delgAtmptCt)
            console.log(data);
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}
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
</script>
<div class="content">
<tiles:insertAttribute name="body.breadcrumb" />
<input type="hidden" name ="vendBillSeq" id = "vendBillSeq"  value ="" />
	<!-- 조회 -->
	<div class="inquiryBox">
		<dl>
			<dt>판매일자</dt>
			<dd>
				<div class="formWrap">
					<div class="dateWrap">
						<input type="text" name="date" value="10/24/1984" class="datepicker" id="datepicker" readonly="" >
						<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
					</div>
				</div>
			</dd>
			<dt>거래처</dt>
			<dd>
				<div class="formWrap">
					<input type="text" id="vendNm" class="inp w160" value="" name="vendNm" placeholder="">

					<button type="button" name="" class="comBtn" id="inp_name01" onclick ="searchBcncList();">조회</button>
				</div>
			</dd>
		</dl>

		<div class="btnGroup right">
			<button type="button" name="" class="comBtn"
				onclick="addRow('first')">행추가</button>
			<button type="button" name="" class="comBtn"
				onclick="removeRow()">행삭제</button>
			<button type="button" name="" class="comBtn">양식 다운로드</button>
			<button type="button" name="" class="comBtn">PDA 업로드</button>
			<button type="button" name="" class="comBtn">거래명세표 출력</button>
			<button type="button" name="" class="inquBtn" onclick ="saveSaleReg();">저장</button>
		</div>
	</div>
	<!-- 조회 -->

	<!-- grid -->
	<div class="girdBoxGroup type02">
		<div class="girdBox w33per">
			<div class="titleArea">
				<h3 class="tit01">거래처 정보</h3>
			</div>

			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<div id="grid_wrap"></div>
		</div>

		<div class="conBox w65per">
			<div class="titleArea right">
				<h3 class="tit01">거래처 판매 등록 정보</h3>
			</div>

			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb"  id="listCnt2">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<div id="grid_wrap2"></div>
		</div>
	</div>
	<!-- grid -->

	<div class="tblWrap">
		<table class="tbl">
			<caption>거래처 정보</caption>
			<colgroup>
				<col style="width: 8%">
				<col>
				<col style="width: 8%">
				<col>
				<col style="width: 8%">
				<col>
				<col style="width: 8%">
				<col style="width: 18%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="sumCt">총매출</label></th>
					<td><input type="text" id="sumCt" class="inp ar" value="" name="sumCt" disabled></td>
					<th scope="row"><label for="cashBilct">현금수금</label></th>
					<td><input type="text" id="cashBilct" class="inp ar" value="" name="cashBilct"></td>
					<th scope="row"><label for="delgAtmptCt">전일미수액</label></th>
					<td><input type="text" id="delgAtmptCt" class="inp ar" value="" name="delgAtmptCt" disabled></td>
					<th scope="row" rowspan="3">메모</th>
					<td rowspan="3">
						<ul class="memo">
							<li>
								<div class="formWrap">
									<div class="checkGroup">
										<input type="radio" name="memo" id="memo01" class="type01" checked=""><label for="memo01"><span>전체</span></label>
										<input type="radio" name="memo" id="memo02" class="type01"><label for="memo02"><span>개별</span></label>
									</div>

									<button type="button" name="" class="inquBtn">메모 저장</button>
								</div>
							</li>
							<li><textarea id="" name="" rows="15" class="h70 mt5"></textarea>
							</li>
						</ul>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="prdDcRate">제품 DC</label></th>
					<td>
						<div class="formWrap">
							<input type="text" id="prdDcRate" class="inp" value="" name="prdDcRate" disabled> <span class="unit">%</span>
							<input type="text" id="prdDcCt" class="inp" value="" name="prdDcCt" disabled>
						</div>
					</td>
					<th scope="row"><label for="cashExcpBilct">현금외수금</label></th>
					<td><input type="text" id="cashExcpBilct" class="inp ar" value="" name="cashExcpBilct"></td>
					<th scope="row"><label for="tdAtmptCt">금일미수액</label></th>
					<td><input type="text" id="tdAtmptCt" class="inp ar" value="" name="tdAtmptCt" disabled></td>
				</tr>
				<tr>
					<th scope="row"><label for="rlSaleCt">순매출금액</label></th>
					<td><input type="text" id="rlSaleCt" class="inp ar" value="" name="rlSaleCt" disabled></td>
					<th scope="row"><label for="insPrdDcRate">수금액조정</label></th>
					<td>
						<div class="formWrap">
							<input type="text" id="insPrdDcRate" class="inp" value="" name="insPrdDcRate">
							<span class="unit">%</span>
							<input type="text" id="insPrdDcCt" class="inp" value="" name="insPrdDcCt">
						</div>
					</td>
					<th scope="row"><label for="atmptCt">미수잔액</label></th>
					<td><input type="text" id="atmptCt" class="inp ar" value="" name="atmptCt" disabled></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

