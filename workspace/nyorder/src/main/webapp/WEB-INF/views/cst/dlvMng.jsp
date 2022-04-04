<!--
	@File Name: dlvMng
	@File 설명 : 배달 관리
	@UI ID : UI-PCLI-0301
	@작성일 : 2022.01.28
	@작성자 : 박예솔
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<code:getCommCode commGrpCd="CST_DLV_NTC_TYPE" var="cstDlvNtcType" />
<script type="text/javascript">
var myGridID1;
var myGridID2;
var myGridID3;
var myGridID4;
var myGridID5;
var myGridID6;

$(document).ready(function(){
	//tabs
	$(".content .tabContent").hide();
	$(".content .tabContent:first").show();

	$(".content .tabsWrap ul.tabs li").click(function (){
		$(".content .tabsWrap ul.tabs li").removeClass("active");
		$(this).addClass("active");
		$(".content .tabsWrap .tabContent").hide();
		var activeTab = $(this).attr("rel");
		$("#" + activeTab).fadeIn(100); 
		if( typeof resizeGrid == 'function' ){
			resizeGrid();
		}
	});

	$(".lnbTabsWrap > .tabContent").hide();
	$(".lnbTabsWrap > .tabContent:first").show();

	$(".lnbTabsWrap > ul.tabs li").click(function (){
		$(".lnbTabsWrap > ul.tabs li").removeClass("active");
		$(this).addClass("active");
		$(".lnbTabsWrap > .tabContent").hide();
		var activeTab = $(this).attr("rel");
		$("#" + activeTab).fadeIn(100); 
	});
	
	createAUIGrid();
	resizeGrid();

	// 출고증(탭) 리스트 조회
	$("#srcBtn").on("click", searchList);
	// 일일배달명단 리스트 조회
	$("#srcBtn2").on("click", searchList2);

	// 출고증(탭) 리스트 - 전달 사항 저장
	$("#saveBtn").on("click", addCstDlvNtc);
	// 일일배달명단 리스트 - 전달 사항 저장
	$("#saveBtn2").on("click", addCstDlvNtc2);

	// 지역 순서 변경
	$("#areaSaveBtn").on("click", saveAreaOrdr);

	// 고객 배송 정보 변경
	$("#saveDlvCstDtlBtn").on("click",saveDlvCstDtl);
	
	// 출고증(탭) 리스트 - 전달 사항 저장
	$("#rmvBtn").on(
		"click",
		{
			title : "배달 관리",
			message : "<spring:message code='alert.msgDlvMng4'/>",
			btn1Func : rmvCstDlvNtc
		},
		layerAlert
	 );
	// 일일배달명단 리스트 - 전달 사항 저장
	$("#rmvBtn2").on("click",
		{
			title : "배달 관리",
			message : "<spring:message code='alert.msgDlvMng4'/>",
			btn1Func : rmvCstDlvNtc2
		},
		layerAlert
	);

	// 전달사항 구분 이벤트
	$("#ntcType").change(function(){
		chgNtcTarget(this,'ntcTrgt');
	});
	// 전달사항 구분 이벤트
	$("#ntcType2").change(function(){
		chgNtcTarget(this,'ntcTrgt2');
	});

	// 일일배달명단 > 인쇄 버튼 이벤트
	$("#dailyDlvPrintBtn").click(function(){
		dailyDlvPrintPop();
	});
	// 출고증 > 인쇄 버튼 이벤트
	$("#receiptPrintBtn").click(function(){
		receiptPrintPop();
	});
	
	/* 그리드 이벤트 바인드 */
	AUIGrid.bind(myGridID1, "cellClick", function( event ) {
		chgNtcTarget($("#ntcType")[0],'ntcTrgt');
		var params = event.item;
		params.srcDate = $("#datepicker02").val();
		$("#frm #areaSeq").val(params.areaSeq);
		$("#popFrm #areaSeq").val(params.areaSeq);
		$("#popFrm #areaNm").val(params.areaNm);
		$("#popFrm #emplNm").val(params.emplNm);
		$("#popFrm #srcDate").val($("#datepicker02").val());
		
		$.ajax({
			url : "/cst/selectDailDlvDetailList.do", 
			type : "POST", 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(params),
			success : function(data) {
				AUIGrid.setGridData(myGridID2, data);
				$("#frm #prdlistCnt").html(data.length);
				searchNtcList();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	});
	AUIGrid.bind(myGridID4, "cellClick", function( event ) {
		chgNtcTarget($("#ntcType2")[0],'ntcTrgt2');
		var params = event.item;
		params.srcDate = $("#datepicker03").val();

		$("#popFrm #areaSeq").val(params.areaSeq);
		$("#popFrm #areaNm").val(params.areaNm);
		$("#popFrm #emplNm").val(params.emplNm);
		$("#popFrm #srcDate").val($("#datepicker03").val());
		
		$.ajax({
			url : "/cst/selectDailDlvCstDetailList.do", 
			type : "POST", 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(params),
			success : function(data) {
				AUIGrid.setGridData(myGridID5, data);
				$("#frm2 #prdlistCnt").html(data.length);
				searchNtcList2();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	});
	AUIGrid.bind(myGridID5, "cellEditEnd", function( event ) {
		if(event.dataField == "dlvOrdr"){
			var preVal = AUIGrid.getRowIndexesByValue(myGridID5, "dlvOrdr", event.value);
			var cstSeq = event.item.cstSeq;
			if(preVal.length > 1){
				AUIGrid.setCellValue(myGridID5, event.rowIndex, event.columnIndex, event.oldValue);
				var popupParam = [];
				popupParam.data = {
					title : "배달 관리",
			 	 	message : "<spring:message code='alert.msgDlvMng11'/>",
			 	 	showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;	
			}
			var rows = AUIGrid.getRowIndexesByValue(myGridID5, "dlvOrdr", event.oldValue);
			$.each(rows,function(i){
				var tRow = AUIGrid.getItemByRowIndex(myGridID5, i);
				if(tRow.cstSeq == cstSeq){
					AUIGrid.setCellValue(myGridID5, i, "dlvOrdr", event.value);
				}
			});
		}
	});

});
var columnLayout = [
{
	dataField : "areaOrdr",
	headerText : "순서",
	width : "15%",
	
},{
	dataField : "agenAreaCd",
	headerText : "코드",
	width : "20%",
	
},{
	dataField : "areaNm",
	headerText : "지역",
	width : "25%",
},{
	dataField : "emplCd",
	headerText : "코드",
	width : "20%",
},{
	dataField : "emplNm",
	headerText : "직원",
	width : "20%",
}];

var columnLayout2 = [{
	dataField : "prdNm",
	headerText : "제품명",
	style : "auiLeft"
},{
	dataField : "abrvNm",
	headerText : "약어",
	width : "15%",
},{
	dataField : "prdQty",
	headerText : "수량",
	width : "15%",
	style : "auiRight"
},{
	dataField : "boxQty",
	headerText : "BOX",
	width : "15%",
	style : "auiRight"
},{
	dataField : "unitQty",
	headerText : "낱개",
	width : "15%",
	style : "auiRight"
}
];

var columnLayout3 = [
{
	dataField : "dlvNtcSeq",
	headerText : "seq",
	visible:false
},{
	dataField : "ntcType",
	headerText : "구분",
	width : "18%",
},{
	dataField : "ntcTrgt",
	headerText : "상세",
	width : "15%",
},{
	dataField : "cntt",
	headerText : "내용",
	style : "auiLeft"
},{
	dataField : "regNm",
	headerText : "작업자",
	width : "15%",
},{
	dataField : "regDtm",
	headerText : "작성시간",
	width : "20%",
	dataType : "date",		formatString: "yyyy-mm-dd HH:MM" 
}
];

var columnLayout4 = [{
	dataField : "areaOrdr",
	headerText : "순서",
	width : "12%",
	editable: true,
	renderer : {
		type : "TemplateRenderer"
	},
	labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
		var template = '<div class="my_div">';
		template += '<span class="my_div_text_box center">' + item.areaOrdr + '</span>';
		template += '</div>';
		return template;
	},
},{
	dataField : "agenAreaCd",
	headerText : "코드",
	width : "17%",
	editable : false
	
},{
	dataField : "areaNm",
	headerText : "지역",
	editable : false
},{
	dataField : "emplCd",
	headerText : "코드",
	width : "13%",
	editable : false
},{
	dataField : "emplNm",
	headerText : "직원",
	width : "15%",
	editable : false
},{
	dataField : "map",
	headerText : "",
	style : "mapBtn",
	width : "10%",
	renderer : {
		type : "ButtonRenderer",
		onClick : function(event) {
			console.log(event.item);
			$.ajaxDialog({
				id: "dlvMapPop",
				ajax: {
					url: "/cst/dlvMapPop.do",
					data:{
						areaSeq : event.item.areaSeq,
						areaNm : event.item.areaNm,
						srcDate : $("#datepicker03").val() 
					}
				},
				dialog: {
					width:1280,
					height:800,
					modal: true,
					draggable: false
				},
				
				success: function(data) {
					
				}
			});
		},
	}
}
];

var columnLayout5 = [{
	dataField : "dlvOrdr",
	headerText : "배송순서",
	width : "6%",
	editable: "true",
	renderer : {
		type : "TemplateRenderer"
	},
	labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
		var template = '<div class="my_div">';
		template += '<span class="my_div_text_box center">' + (fnIsEmpty(item.dlvOrdr)?"":item.dlvOrdr)+ '</span>';
		template += '</div>';
		return template;
	},
},{
	dataField : "cstAgenCd",
	headerText : "코드",
	width : "8%",
	editable : false
},{
	dataField : "cstNm",
	headerText : "성명",
	width : "8%",
	editable : false
},{
	dataField : "dlvAddr",
	headerText : "배달주소",
	width : "14%",
	style : "auiLeft",
	editable : false
},{
	dataField : "inPosi",
	headerText : "투입위치",
	width : "10%",
},{
	dataField : "prdNm",
	headerText : "품명",
	style : "auiLeft",
	editable : false
},{
	dataField : "abrvNm",
	headerText : "약어",
	width : "10%",
	editable : false
},{
	dataField : "dlvyQty",
	headerText : "수량",
	width : "6%",
	style : "auiRight",
	editable : false
},{
	dataField : "pttn",
	headerText : "주문패턴",
	width : "13%",
	editable : false
},{
	dataField : "undlvYn",
	headerText : "미배송",
	width : "5%",
	renderer : {
		type : "CheckBoxEditRenderer",
		editable : true,
		imgHeight : 15,
		checkValue : "Y",
		unCheckValue: "N",
		imgTableRef : {
			"true" : "../images/check_on.png",
			"false" : "../images/check_default.png",
			"default" : "../images/check_on.png"
		}
	}
},{
	dataField : "mapLatu",
	headerText : "mapLatu",
	visible:false,
	style:"auiRight"	
},{
	dataField : "mapLotu",
	headerText : "mapLotu",
	visible:false,
	style:"auiRight"
},{
	dataField : "laloYn",
	headerText : "laloYn",
	visible:false,
	style:"auiRight"
}
];

var columnLayout6 = [
{
	dataField : "dlvNtcSeq",
	headerText : "seq",
	visible:false
},{
	dataField : "ntcType",
	headerText : "구분",
	width : "18%",
},{
	dataField : "ntcTrgt",
	headerText : "상세",
	width : "15%",
},{
	dataField : "cntt",
	headerText : "내용",
	style : "auiLeft"
},{
	dataField : "regNm",
	headerText : "작업자",
	width : "15%",
},{
	dataField : "regDtm",
	headerText : "작성시간",
	width : "20%",
	dataType : "date",		
	formatString: "yyyy-mm-dd HH:MM" 
}
];

var columnLayout7 = [
{
	dataField : "dlvOrdr",
	headerText : "배송<br/>순서",
	width : "10%",
	styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
		if(item.laloYn == "N") {
			return "pColor02";
		}
		return null;
	}
},{
	dataField : "cstNm",
	headerText : "성명",
	width : "17%",
	styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
		if(item.laloYn == "N") {
			return "pColor02";
		}
		return null;
	}
},{
	dataField : "dlvAddr",
	headerText : "배달주소",
	style:"auiLeft",
	styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
		if(item.laloYn == "N") {
			return "pColor02";
		}
		return null;
	}
},{
	dataField : "abrvNm",
	headerText : "약어",
	width : "15%",
	styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
		if(item.laloYn == "N") {
			return "pColor02";
		}
		return null;
	}
},{
	dataField : "dlvyQty",
	headerText : "수량",
	width : "15%",
	style:"auiRight",
	styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
		if(item.laloYn == "N") {
			return "pColor02";
		}
		return null;
	}
},{
	dataField : "mapLatu",
	headerText : "mapLatu",
	visible:false,
	style:"auiRight"	
},{
	dataField : "mapLotu",
	headerText : "mapLotu",
	visible:false,
	style:"auiRight"
},{
	dataField : "laloYn",
	headerText : "laloYn",
	visible:false,
	style:"auiRight"
}
];

var gridPros = {
		headerHeight : 29,
		rowHeight : 29,
		// 편집 가능 여부 (기본값 : false)

		enableCellMerge : true,  // 셀 병합 실행
		showStateColumn : false,
		showRowCheckColumn : true, // 체크박스 사용 	
		wrapSelectionMove : true,
		editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
		//rowNumColumnWidth : 60,
		editable : false,
		// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
		enterKeyColumnBase : true,
		// 셀 선택모드 (기본값: singleCell)
		selectionMode : "multipleCells",
		showFooter : false,
		noDataMessage : "출력할 데이터가 없습니다.",
		//independentAllCheckBox : true,
};

var gridPros2 = {
	showRowCheckColumn : false,
	showFooter : false,
	editable : false
}
var gridPros3 = {
	showRowCheckColumn : true, // 체크박스 사용
	showFooter : false,
	showRowNumColumn : false,
	editable : false
}

var gridPros4 = {
	showFooter : false,
	editable : true, 
	editingOnKeyDown : true, 
	showRowCheckColumn : true, 
	enterKeyColumnBase : true,
	showRowNumColumn : false,
}

var gridPros5 = {
	showFooter : false,
	editable : true, 
	editingOnKeyDown : true, 
	showRowCheckColumn : false, 
	editable :true,
	enterKeyColumnBase : true,
	showRowNumColumn : false,
}

var gridPros6 = {
	showFooter : false,
	showRowCheckColumn : true, 
	showRowNumColumn : false,
	editable : false
}

var gridPros7 = {
		headerHeight : 58,
		rowHeight : 29,
		// 편집 가능 여부 (기본값 : false)
		showRowNumColumn : false, 
		editable : false,
		enterKeyColumnBase : true,
		// 셀 선택모드 (기본값: singleCell)
		selectionMode : "singleRow",
};

//AUIGrid 를 생성합니다.
function createAUIGrid() {
	// 실제로 #grid_wrap 에 그리드 생성
	myGridID1 = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
	myGridID3 = AUIGrid.create("#grid_wrap3", columnLayout3, gridPros3);
	myGridID4 = AUIGrid.create("#grid_wrap4", columnLayout4, gridPros4);
	myGridID5 = AUIGrid.create("#grid_wrap5", columnLayout5, gridPros5);
	myGridID6 = AUIGrid.create("#grid_wrap6", columnLayout6, gridPros6);
}


function searchList(){
	$.ajax({
		url : "/cst/selectDailDlvAreaList.do",
		type : 'POST',
		data : $("#frm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(myGridID1, data);
			$("#listCnt").html(data.length);
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}
function searchNtcList(){
	$.ajax({
		url : "/cst/selectCstDlvNtcList.do",
		type : 'POST',
		data : $("#frm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(myGridID3, data);
			$("#frm #ntcListCnt").html(data.length);
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function addCstDlvNtc(){
	var popupParam = [];
	if( fnIsEmpty( $("#frm #cntt").val())){
		popupParam.data = {
			title : "배달 관리",
			message : "<spring:message code='alert.msgDlvMng3'/>",
	 	 	showBtn2 : 'N'
		}
		$("#frm #cntt").focus();
		layerAlert(popupParam);
		return;
	}
	$.ajax({
		url : "/cst/addCstDlvNtc.do",
		type : 'POST',
		data : $("#frm").serialize(),
		success : function(data) {
			var popupParam = [];
			popupParam.data = {
				title : "배달 관리",
				message : "<spring:message code='alert.msgDlvMng10'/>",
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			searchNtcList();
		},
		error : function(xhr, status) {
			if ( CommUtil.IsJsonString(xhr.responseText) )
			{
				var message = JSON.parse(xhr.responseText).message;
				popupParam.data = {
					title : "공지사항 관리",
					message : message,
					showBtn2 : 'N'
 				}
 				layerAlert(popupParam);
			}
			else{
				alert("처리중 오류가 발생 하였습니다.");
			}
		}
	});
}

function rmvCstDlvNtc(){
	var rows = AUIGrid.getCheckedRowItems(myGridID3);
	var popupParam = {};
	if( fnIsEmpty(rows)){
		var popupParam = [];
		popupParam.data = {
			title : "배달 관리",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'삭제하실 항목'}" />",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	AUIGrid.removeCheckedRows(myGridID3);
	
	$.ajax({
		url : "/cst/rmvCstDlvNtc.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(fnGetGridListCRUD(myGridID3)),
		success : function(data) {
			popupParam.data = {
				title : "배달 관리",
				message : "<spring:message code='alert.msgDlvMng10'/>",
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			searchNtcList();
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function searchList2(){
	$.ajax({
		url : "/cst/selectDailDlvAreaList.do",
		type : 'POST',
		data : $("#frm2").serialize(),
		success : function(data) {
			AUIGrid.setGridData(myGridID4, data);
			$("#frm2 #listCnt").html(data.length);
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}
function searchNtcList2(){
	$.ajax({
		url : "/cst/selectCstDlvNtcList.do",
		type : 'POST',
		data : $("#frm2").serialize(),
		success : function(data) {
			AUIGrid.setGridData(myGridID6, data);
			$("#frm2 #ntcListCnt").html(data.length);
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function addCstDlvNtc2(){
	var popupParam = [];
	if( fnIsEmpty( $("#frm2 #cntt").val() ) ){
		popupParam.data = {
			title : "배달 관리",
			message : "<spring:message code='alert.msgDlvMng3'/>",
	 	 	showBtn2 : 'N'
		}
		$("#frm2 #cntt").focus();
		layerAlert(popupParam);
		return;
	}
	$.ajax({
		url : "/cst/addCstDlvNtc.do",
		type : 'POST',
		data : $("#frm2").serialize(),
		success : function(data) {
			var popupParam = [];
			popupParam.data = {
				title : "배달 관리",
				message : "<spring:message code='alert.msgDlvMng10'/>",
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			searchNtcList2();
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function rmvCstDlvNtc2(){
	var rows = AUIGrid.getCheckedRowItems(myGridID6);
	var popupParam = {};
	if( fnIsEmpty(rows)){
		var popupParam = [];
		popupParam.data = {
			title : "배달 관리",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'삭제하실 항목'}" />",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	AUIGrid.removeCheckedRows(myGridID6);
	
	$.ajax({
		url : "/cst/rmvCstDlvNtc.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(fnGetGridListCRUD(myGridID6)),
		success : function(data) {
			popupParam.data = {
				title : "배달 관리",
				message : "<spring:message code='alert.msgDlvMng10'/>",
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			searchNtcList2();
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

//엑셀 내보내기(Export);
function exportTo() {
	AUIGrid.exportToXlsx(mGrid, {
		// 스타일 상태 유지 여부(기본값:true)
		exportWithStyle : true,
		fileName : "거래처 리스트"
	});
};

function resizeGrid(){
	AUIGrid.resize(myGridID1, $("#content").width());
	AUIGrid.resize(myGridID2, $("#content").width());
	AUIGrid.resize(myGridID3, $("#content").width());
	AUIGrid.resize(myGridID4, $("#content").width());
	AUIGrid.resize(myGridID5, $("#content").width());
	AUIGrid.resize(myGridID6, $("#content").width());
}

function chgNtcTarget(e,target){
	var gridIdx = $(".tabsWrap ul").find(".active").data("idx");
	var row = AUIGrid.getSelectedRows(eval("myGridID"+gridIdx))[0];
	if(fnIsEmpty(row)){
		$(e).val("").attr("selected","selected");
		$("#"+target+ " option").remove();
		$("#"+target).append("<option value=''>전체</option>");
		return;
	}
	$("#"+target+ " option").remove();
	$("#"+target).append("<option value=''>전체</option>");
	if(e.value=="AREA"){
		$("#"+target).append("<option value='"+row.areaSeq+"'>"+row.areaNm+"</option>");
	}else if(e.value=="CST"){
		var frm = $(e).parents("form");
		row.srcDate = frm.find("input[name='srcDate']").val();
		$.ajax({
			url : "/cst/selectDlvCstList.do",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(row),
			type : "POST",
			success : function(data) {
				$.each(data, function(i,v){
					$("#"+target).append("<option value='"+v.cstSeq+"'>"+v.cstNm+"</option>");
				});
			}, // success
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
}

function saveAreaOrdr (){
	var popupParam = {};
	var rows = fnGetGridListCRUD(myGridID4);
	if(fnIsEmpty(rows)){
		popupParam.data = {
			title : "배달 관리",
			message : "<spring:message code='alert.msgDlvMng14'/>",
			showBtn2 : "N"
		}
		layerAlert(popupParam);
		return;
	}
	$.ajax({
		url : "/cst/saveAreaDlvOrdr.do",
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(rows),
		type : "POST",
		success : function(data) {
			popupParam.data = {
				title : "배달 관리",
				message : "<spring:message code='alert.msgDlvMng10'/>",
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			searchList2();
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function dailyDlvPrintPop(){
	var popFrm = $("#popFrm");
	$("#incNtcYn").val("N");
	$("#blankYn").val("N");
	if($("input:checkbox[id='incNtcChk']").is(":checked")){ $("#incNtcYn").val("Y"); }
	if($("input:checkbox[id='blankChk']").is(":checked")) {	$("#blankYn").val("Y"); }
	
	var url = '${request.contextPath}/cst/dailyDlvPrintPop.pop';
	var popup = window.open("","dailyDlvPrintPop", 'width=1280px,height=800px,scrollbars=yes');
	popFrm.attr("target","dailyDlvPrintPop");
	popFrm.attr("action", url);
	popFrm.attr("method","post");
	popFrm.submit();
}

function receiptPrintPop(){
	var popFrm = $("#popFrm");
	$("#incNtcYn").val("N");
	$("#blankYn").val("N");
	if($("input:checkbox[id='incNtcChk']").is(":checked")){ $("#incNtcYn").val("Y"); }
	if($("input:checkbox[id='blankChk']").is(":checked")) {	$("#blankYn").val("Y"); }
	
	
	var url = '${request.contextPath}/cst/receiptPrintPop.pop';
	var popup = window.open("","receiptPrintPop", 'width=1280px,height=800px,scrollbars=yes');
	popFrm.attr("target","receiptPrintPop");
	popFrm.attr("action", url);
	popFrm.attr("method","post");
	popFrm.submit();
}

function saveDlvCstDtl(){
	var popupParam = {};
	var rows = fnGetGridListCRUD(myGridID5);
	if(fnIsEmpty(rows)){
		popupParam.data = {
			title : "배달 관리",
			message : "<spring:message code='alert.msgDlvMng14'/>",
			showBtn2 : "N"
		}
		layerAlert(popupParam);
		return;
	}
	$.ajax({
		url : "/cst/saveDlvCstDtl.do",
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(rows),
		type : "POST",
		success : function(data) {
			popupParam.data = {
				title : "배달 관리",
				message : "<spring:message code='alert.msgDlvMng10'/>",
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			searchList2();
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});	
}
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- tabs -->
	<div class="tabsWrap">
		<ul class="tabs">
			<li class="active" 	rel="tab01" data-idx="1">출고증</li>
			<li class="" 		rel="tab02" data-idx="4">일일 배달명단</li>
		</ul>
		<div id="tab01" class="tabContent">
		<!-- tabContent 출고증 -->
			<form id="popFrm">
				<input type="hidden" name="areaSeq" id="areaSeq"/>
				<input type="hidden" name="areaNm" id="areaNm"/>
				<input type="hidden" name="emplNm" id="emplNm"/>
				<input type="hidden" name="srcDate" id="srcDate"/>
				<input type="hidden" id="incNtcYn"	name="incNtcYn" class="type01">
				<input type="hidden" id="blankYn"	name="blankYn" class="type01">
			</form>
			<!-- 조회 -->
			<form id="frm" onsubmit="return false;">
				<input type="hidden" name="areaSeq" id="areaSeq"/>
				<div class="inquiryBox type02">
					<dl>
						<dt>배달일자</dt>
						<dd>
							<div class="formWrap">				
								<div class="dateWrap">
									<input type="text" name="srcDate" value="10/24/1984" class="inp datepicker" id="datepicker02" readonly> 
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker02"></button>
								</div>								
																
								<button type="button" class="comBtn" id="srcBtn" >조회</button>
							</div>
						</dd>
					</dl>
			
					<div class="btnGroup right">									
						<input type="checkbox" id="incNtcChk" class="type01" value="Y"><label for="incNtcChk"><span>전달사항포함</span></label>
						<input type="checkbox" id="blankChk" class="type01" value="Y"><label for="blankChk"><span>빈양식</span></label>
						
						<button type="button" class="comBtn" id="receiptPrintBtn">인쇄</button>
					</div>
				</div>
				<!-- 조회 -->
			
				<!-- grid -->
				<div class="girdBoxGroup">
					<div class="w28per">
						<div class="titleArea">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
							</p>
						</div>
						<div class="girdBox type03">
							<div id="grid_wrap"></div>
						</div>
					</div>
			
					<div class="w71per">
						<div class="titleArea">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="prdlistCnt">0</span></em> 건 이 조회되었습니다.
							</p>
						</div>
			
						<div class="girdBox type03">								
							<div id="grid_wrap2"></div>
						</div>
					</div>
				</div>
				<!-- grid -->
			
				<div class="titleArea">
					<h3 class="tit01">전달사항</h3>
				</div>
			
				<!-- 조회 -->
				<div class="inquiryBox type05">
					<dl>
						<dt>구분</dt>
						<dd>
							<select name="ntcType" class="sel" id="ntcType">
								<option value="">전체</option>
								<c:forEach items="${cstDlvNtcType}" var="i" >
									<option value="${i.commCd}">${i.commNm}</option>
								</c:forEach>
							</select>
						</dd>
						<dt>상세</dt>
						<dd>
							<select name="ntcTrgt" class="sel" id="ntcTrgt">
								<option value="">전체</option>
							</select>
						</dd>
						<dt>내용</dt>
						<dd>
							<input type="text" id="cntt" class="inp w400"  name="cntt">
						</dd>
					</dl>
			
					<div class="btnGroup right">									
						<button type="button" class="inquBtn full small" id="saveBtn">저장</button>
						<button type="button" class="cancelBtn full small" id="rmvBtn">삭제</button>
					</div>
				</div>
				<!-- 조회 -->
		
				<div class="titleArea">
					<p class="numState">
						<em>총 <span class="pColor01 fb" id="ntcListCnt">0</span></em> 건 이 조회되었습니다.
					</p>
				</div>
		
				<!-- gird -->
				<div class="girdBox type04">
					<div id="grid_wrap3"></div>
				</div>
				<!-- gird -->
			</form>	
		</div>
		<!-- //tabContent 출고증 -->

		<!-- tabContent 일일 배달명단 -->
		<div id="tab02" class="tabContent">
			<!-- 조회 -->
			<form id="frm2" onsubmit="return false;">
				<div class="inquiryBox type02">
					<dl>
						<dt>배달일자</dt>
						<dd>
							<div class="formWrap">				
								<div class="dateWrap">
									<input type="text" name="srcDate" value="10/24/1984" class="inp datepicker" id="datepicker03" readonly> 
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker03"></button>
								</div>								
							</div>
						</dd>
						<dt>제품명</dt>
						<dd>
							<div class="formWrap">
								<input type="text" id="srcKeyword" class="inp w160" name="srcKeyword">
																		
								<button type="button" class="comBtn" id="srcBtn2">조회</button>
							</div>
						</dd>
					</dl>
					<div class="btnGroup right">									
						<input type="checkbox" id="chType03" class="type01"><label for="chType03"><span>전달사항포함</span></label>									
						<button type="button" class="comBtn" id="dailyDlvPrintBtn">인쇄</button>
					</div>
				</div>
				<!-- 조회 -->
		
				<!-- grid -->
				<div class="girdBoxGroup">
					<div class="w28per">
						<div class="titleArea right">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
							</p>
							<div class="btnGroup">
								<button type="button" name="" class="inquBtn full small" id="areaSaveBtn">저장</button>
							</div>
						</div>
						<div class="girdBox type03">
							<div id="grid_wrap4"></div>
						</div>
					</div>
		
					<div class="w71per">
						<div class="titleArea right">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="prdlistCnt">0</span></em> 건 이 조회되었습니다.
							</p>
							<div class="btnGroup">
								<button type="button" name="" class="inquBtn full small" id="saveDlvCstDtlBtn" >저장</button>
							</div>
						</div>
		
						<div class="girdBox type03">								
							<div id="grid_wrap5"></div>
						</div>
					</div>
				</div>
				<!-- grid -->
		
				<div class="titleArea">
					<h3 class="tit01">전달사항</h3>
				</div>
		
				<!-- 조회 -->
				<div class="inquiryBox type05">
					<dl>
						<dt>구분</dt>
						<dd>
							<select name="ntcType" class="sel" id="ntcType2">
								<option value="">전체</option>
								<c:forEach items="${cstDlvNtcType}" var="i" >
									<option value="${i.commCd}">${i.commNm}</option>
								</c:forEach>
							</select>
						</dd>
						<dt>상세</dt>
						<dd>
							<select name="ntcTrgt" class="sel" id="ntcTrgt2">
								<option value="">전체</option>
							</select>
						</dd>
						<dt>내용</dt>
						<dd>
							<input type="text" id="cntt" class="inp w400" name="cntt">
						</dd>
					</dl>
		
					<div class="btnGroup right">									
						<button type="button" class="inquBtn full small" id="saveBtn2">저장</button>
						<button type="button" class="cancelBtn full small" id="rmvBtn2">삭제</button>
					</div>
				</div>
				<!-- 조회 -->
		
				<div class="titleArea">
					<p class="numState">
						<em>총 <span class="pColor01 fb" id="ntcListCnt">0</span></em> 건 이 조회되었습니다.
					</p>
				</div>
		
				<!-- gird -->
				<div class="girdBox type04">
					<div id="grid_wrap6"></div>
				</div>
				<!-- gird -->
			</form>
		</div>
	<!-- //tabContent 일일 배달명단 -->
	</div>
</div>
<div class="modal_bg" id="modal_bg"></div> <!-- modal 배경 -->