<!-- 
	@File Name: stdPrdBndChg
	@File 설명 : 표준제품 일괄 변경
	@UI ID : UI-PSTD-0202
	@작성일 : 2022.01.25
	@작성자 : 박예솔
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<style>
/* 커스컴 disable 스타일*/
.mycustom-disable-color {
	color : #cccccc;
}
</style>
<script type="text/javascript">
var mGrid;
$(document).ready(function(){
	$("#alertTitle").html("표준제품 일괄 변경");
	$("#alertBtn2").hide();
	createAUIGrid();
	resizeGrid();

	/* 제품 검색 - 분류 SelectBox 설정 */
	$(".prdCls").change(function(){
		var target = $(this).data("clsTarget");
		setMultiCombo(target);
	});

	/* 버튼 바인드 */
	$("#srcStdPrdBndBtn").on("click",searchList);
	
	
	$("#saveStdPrdChg").on("click", function(){
		var day = $("input[name='applDt']").val();
		var popupParam = [];
		popupParam.data = {
			title : "표준제품 일괄 변경",
			message : "<spring:message code='alert.saveprdBndChg' arguments='"+day+"'/>",
			btn1Func : saveStdPrdBndChg
		};
		layerAlert(popupParam);
	});
	
	/* 그리드 클릭 시 표준 제품 팝업 바인딩 */
	AUIGrid.bind(mGrid, "cellClick", function(event) {
		if(event.dataField == "prdSapCd" && event.item.applYn != "Y"){
			$.ajaxDialog({
				id: "agenStdPrdSearchPop",
				ajax: {
					url: "/std/agenStdPrdSearchPop.do",
				},
				dialog: {
					width:840,
					height:640,
					modal: true,
					draggable: false
				},
				success: function(data) {
					var col = AUIGrid.getSelectedIndex(mGrid);
					var row = AUIGrid.getSelectedRows(mGrid);
					if(row[0].chgPrdSapCd == data.prdSapCd){
						var popupParam = [];
						popupParam.data = {
							title : "남양 제품 조회",
					 	 	message : "<spring:message code='alert.equalPrdSelect' arguments="${'변경 후 제품'}"/>",
					 	 	showBtn2 : 'N'
						}
						layerAlert(popupParam);
						return;
					}
					if( AUIGrid.getDataFieldByColumnIndex(mGrid,col[1]) == "prdSapCd"){
						AUIGrid.updateRow(mGrid, data, col[0]);
					}
					
				}
			});
		}
		if(event.dataField == "chgPrdSapCd" && event.item.applYn != "Y"){
			$.ajaxDialog({
				id: "stdPrdSearchPop",
				ajax: {
					url: "/std/stdPrdSearchPop.do",
				},
				dialog: {
					width:1640,
					height:800,
					modal: true,
					draggable: false
				},
				success: function(data) {
					var col = AUIGrid.getSelectedIndex(mGrid);
					var row = AUIGrid.getSelectedRows(mGrid);
					if(row[0].prdSapCd == data.prdSapCd){
						var popupParam = [];
						popupParam.data = {
							title : "남양 제품 조회",
					 	 	message : "<spring:message code='alert.equalPrdSelect' arguments="${'변경 전 제품'}"/>",
					 	 	showBtn2 : 'N'
						}
						layerAlert(popupParam);
						return;
					}
					if( AUIGrid.getDataFieldByColumnIndex(mGrid,col[1]) == "chgPrdSapCd"){
						var item = { 
							"chgPrdSapCd" : data.prdSapCd , 
							"chgPrdNm" : data.prdNm,
							"chgPrdDtlSeq" : data.prdDtlSeq,
							"chgPrdSeq" : data.prdSeq,
						};
						AUIGrid.updateRow(mGrid, item, col[0]);
					}
				}
			});
		}
	});

	/* 그리드 전체 선택 시 체크 조건 설정 */
	AUIGrid.bind(mGrid, "rowAllChkClick", function( event ) {
		if(event.checked) {
			AUIGrid.setCheckedRowsByValue(mGrid, "applYn", "N");
		}else{
			AUIGrid.setCheckedRowsByValue(mGrid, "applYn", []);
		}
	});

	searchList();
});

//AUIGrid 를 생성합니다.
function createAUIGrid() {
	mGrid	= AUIGrid.create("#grid_wrap", 	columnLayout,	gridPros);
}
var gridPros = {
	headerHeight : 29,
	rowHeight : 29,
	// 편집 가능 여부 (기본값 : false)
	editable : false,
	showStateColumn : true,
	autoGridHeight : true,
	showRowCheckColumn : true, // 체크박스 사용
	showStateColumn : false,
	editingOnKeyDown : false, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
	showEditedCellMarker: false,
	// 셀 선택모드 (기본값: singleCell)
	selectionMode : "singleCell",
	noDataMessage : "출력할 데이터가 없습니다.",

	independentAllCheckBox : true,
	rowCheckableFunction : function(rowIndex, isChecked, item) {
		console.log(item)
		if(item.applYn != 'Y') {
			return true;
		}
		return false;
	},
	rowCheckDisabledFunction : function(rowIndex, isChecked, item) {
		if(item.applYn != 'Y') {
			return true;
		}
		return false;
	}
}


var columnLayout = [
	{
		dataField : "beforePr",
		headerText : "변경 전 제품",
		dataField : "myGroupField",
		children : [{
				dataField : "prdSapCd",
				headerText : "제품코드",
				width : "12%",
				wordWrap : true,
				renderer : {
					type : "TemplateRenderer"
				},
				labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
					if(item.applYn == "Y"){
						var template = item.prdSapCd;
					}else{
						var template = '<div class="searchWrap">';
						template += '<span class="my_div_text_box">'+value+'<a href="javascript:void(0);" class="serach popBtn" data-id="" data-prd-type="prdSapCd"></a></span>';
						template += '</div>';
					}
					return template;
				}
			}, {
				dataField : "prdNm",
				headerText : "표준제품명",
				width : "20%",
				style:"auiLeft"
			}, {
				dataField : "prdDtlSeq",
				headerText : "코드",
				visible:false
			}, {
				dataField : "prdSeq",
				headerText : "코드",
				visible:false
			}, {
				dataField : "puchSeq",
				headerText : "코드",
				visible:false
			},				
		],
	},{
		dataField : "afterPr",
		headerText : "변경 후 제품",
		dataField : "myGroupField",
		children : [{
				dataField : "chgPrdSapCd",
				headerText : "제품코드",
				width : "12%",
				wordwrap : true,
				renderer : {
					type : "TemplateRenderer"
				},
				labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
					if(item.applYn == "Y"){
						var template = item.chgPrdSapCd;
					}else{
						var template = '<div class="searchWrap">';
						template += '<span class="my_div_text_box">'+value+'<a href="javascript:void(0);" class="serach popBtn" data-prd-type="chgPrdSapCd"></a></span>';
						template += '</div>';
					}
					return template;
				}
			}, {
				dataField : "chgPrdNm",
				headerText : "표준제품명",
				width : "20%",
				style:"auiLeft"
			}, {
				dataField : "chgPrdDtlSeq",
				headerText : "코드",
				visible:false
			}, {
				dataField : "chgPrdSeq",
				headerText : "코드",
				visible:false
			},
		],
	},{
		dataField : "applDt",
		headerText : "적용일",
		width : "12%",
	},{
		dataField : "regDtm",
		headerText : "요청일시",
		dataType : "date",
		formatString : "yyyy-mm-dd HH:MM",
		width : "15%",		
	},{
		dataField : "regNm",
		headerText : "요청자",
	}, {
		dataField : "applYn",
		headerText : "적용여부",
		visible:false
	},
];

/* 표준 제품 - 리스트 조회 */
function searchList(){
	
	if($("input[name='applDt']").val() < fnGetToDay()){
		$(".editArea").hide();
	}else{
		$(".editArea").show();
	}
	
	$.ajax({
		url : "/std/selectStdPrdBndChgList.do", 
		type : 'POST', 
		data : $("#frm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(mGrid, data);
			$("#dtlCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}


/* 제품 저장 */
function saveStdPrdBndChg(){
	var popupParam = {};
	if( fnIsEmpty(fnGetGridListCRUD(mGrid))){
		popupParam.data = {
			title : "표준 제품 일괄 변경",
	 	 	message : "<spring:message code='alert.noPrdSelect' />",
	 	 	showBtn2 : 'N'
		}
 		layerAlert(popupParam);
		openPopup('modalAlert');
		return;
	}
	if(!validateGridData()){
		closePopup('modalAlert');
		return;
	}
	
	$.ajax({
		url : "/std/saveStdPrdBndChgList.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(fnGetGridListCRUD(mGrid)),
		success : function(data) {
			popupParam.data = {
				title : "표준 제품 일괄 변경",
		 	 	message : data,
		 	 	showBtn2 : 'N'
			}
			layerAlert(popupParam);
			searchList();
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

/* 행 추가 */
function addRow() {
	var item = {};
	item.applDt = $("#datepicker").val();
	item.applYn = "N";
	AUIGrid.addRow(mGrid, item, 'first');
}

/* 남양제품 조회 팝업 - 리스트 조회 *
/* 그리스 사이즈 조정 */
function resizeGrid(){
	AUIGrid.resize(mGrid, $("#grid_wrap").width());
}

/* 행 삭제 */
function removeRow(){
	var rows = AUIGrid.getCheckedRowItems(mGrid);
	var popupParam = {};
	if( fnIsEmpty(rows)){
		var popupParam = [];
		popupParam.data = {
			title : "표준 제품 일괄 변경",
	 	 	message : "<spring:message code='alert.noPrdSelect'/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	AUIGrid.removeCheckedRows(mGrid);
}

//필수로 설정해야 하는 필드들의 값이 모두 입력되었는지 검사
function validateGridData() {
	var check = AUIGrid.validateGridData(mGrid, ["prdSapCd","prdNm","chgPrdSapCd","chgPrdNm"], "<spring:message code='alert.noPrdSelect'/>");
	return check;
};

</script>

<div class="content">
	<div class="titTopArea">
		<h2 class="tit01">표준제품 일괄 변경</h2>
		<div class="location">
			<ul>
				<li><i class="home"></i></li>
				<li>기준정보관리</li>
				<li>기준정보 관리</li>
				<li>표준제품 조회</li>
			</ul>
		</div>
	</div>

	<!-- 조회 -->
	<form id="frm" method="post">
		<div class="inquiryBox">
			<dl>
				<dt>적용일</dt>
				<dd>
					<div class="formWrap">			
						<div class="dateWrap">
							<input type="text" name="applDt" value="10/24/1984" class="inp datepicker" id="datepicker" readonly="">
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
						</div>

						<button type="button" name="" class="comBtn" id="srcStdPrdBndBtn">선택</button>
					</div>
				</dd>
			</dl>

			<div class="btnGroup right editArea">
				<button type="button" name="" class="inquBtn" id="saveStdPrdChg" data-id="modalConfirm">저장</button>
			</div>
		</div>
	</form>
	<!-- 조회 -->

	<div class="titleArea arTxt">
		<div class="btnGroup editArea">
			<button type="button" name="" class="comBtn small" onclick="addRow()">행추가</button>
			<button type="button" name="" class="comBtn small" onclick="removeRow()">행삭제</button>
		</div>
	</div>
	<!-- grid -->
	<div class="girdBox">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->
</div>

<!-- 표준제품 등록 -->
<div class="modal_bg"></div> <!-- modal 배경 -->


<!--// 표준제품 등록 -->
<script id="codeTmpl" type="text/x-jquery-tmpl">
{{each(i, e) codeList }}
	<option value='\${e.code}'>\${e.name}</option>
{{/each}}
</script>