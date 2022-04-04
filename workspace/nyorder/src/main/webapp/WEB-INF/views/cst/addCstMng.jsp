<!-- 
	@File Name: 애음자 신규 등록
	@File 설명 : 
	@UI ID : UI-PCLI-0102
	@작성일 : 2022. 2. 24.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="code"  uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<code:makeSelect commGrpCd="BILCT_MTH" 		var="bilctMth"		name="bilctMth" 	classNm="sel w160"/>
<code:makeSelect commGrpCd="SBSCRB_COS_CD"	var="sbscrbCosCd"	name="sbscrbCosCd" 	classNm="sel w160" all="false"/>

<script type="text/javascript">
var mGrid;
var mGrid2;
var mGrid3;
var mGrid4;
var prmtPymInfoData;

var pttnGridData = [
    {"divi":"1주","cstSecCd":"1","monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":"0"},
	{"divi":"2주","cstSecCd":"1","monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":"0"},
	{"divi":"3주","cstSecCd":"1","monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":"0"},
	{"divi":"4주","cstSecCd":"1","monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":"0"},
	{"divi":"5주","cstSecCd":"1","monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":"0"},
    {"divi":"6주","cstSecCd":"1","monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":"0"}
];

var columnLayout = [{
		dataField : "divi",
		headerText : "구분",
		width : "9%",
		style: "auiCenter",
	},{
		dataField : "cstSecCd",
		headerText : "수량",
		width : "9.5%",
		style: "auiRight",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
	},{
		dataField : "monQty",
		headerText : "월",
		width : "9.5%",
		style: "auiRight",
		headerStyle : "auiCenter",
		dataType : "numeric",
		formatString : "#,##0",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
		headerRenderer : {
			type : "CheckBoxHeaderRenderer",
			dependentMode : true, 			
			position : "left",
			onClick : checkClickEvent
		},
		renderer : {
				type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		}
	},{
		dataField : "tueQty",
		headerText : "화",
		width : "9.5%",
		style: "auiRight",
		headerStyle : "auiCenter",
		dataType : "numeric",
		formatString : "#,##0",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
		headerRenderer : {
			type : "CheckBoxHeaderRenderer",
			dependentMode : true, 			
			position : "left",
			onClick : checkClickEvent
		},
		renderer : {
				type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		}
	},{
		dataField : "wedQty",
		headerText : "수",
		width : "9.5%",
		style: "auiRight",
		headerStyle : "auiCenter",
		dataType : "numeric",
		formatString : "#,##0",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
		headerRenderer : {
			type : "CheckBoxHeaderRenderer",
			dependentMode : true, 			
			position : "left",
			onClick : checkClickEvent
		},
		renderer : {
				type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		}
	},{
		dataField : "thuQty",
		headerText : "목",
		width : "9.5%",
		style: "auiRight",
		headerStyle : "auiCenter",
		dataType : "numeric",
		formatString : "#,##0",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
		headerRenderer : {
			type : "CheckBoxHeaderRenderer",
			dependentMode : true, 			
			position : "left",
			onClick : checkClickEvent
		},
		renderer : {
				type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		}
	},{
		dataField : "friQty",
		headerText : "금",
		width : "9.5%",
		style: "auiRight",
		headerStyle : "auiCenter",
		dataType : "numeric",
		formatString : "#,##0",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
		headerRenderer : {
			type : "CheckBoxHeaderRenderer",
			dependentMode : true, 			
			position : "left",
			onClick : checkClickEvent
		},
		renderer : {
				type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		}
	},{
		dataField : "satQty",
		headerText : "토",
		width : "9.5%",
		style: "auiRight",
		dataType : "numeric",
		formatString : "#,##0",
		headerStyle : "auiCenter, hColor01",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
		headerRenderer : {
			type : "CheckBoxHeaderRenderer",
			dependentMode : true, 			
			position : "left",
			onClick : checkClickEvent
		},
		renderer : {
				type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		}
	},{
		dataField : "sunQty",
		headerText : "일",
		width : "9.5%",
		style: "auiRight",
		headerStyle : "auiCenter hColor02",
		dataType : "numeric",
		formatString : "#,##0",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
		headerRenderer : {
			type : "CheckBoxHeaderRenderer",
			dependentMode : true, 			
			position : "left",
			onClick : checkClickEvent
		},
		renderer : {
				type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		}
	},{
		dataField : "totQty",
		headerText : "총수량",
		style: "auiRight",
		headerStyle : "auiCenter",
		dataType : "numeric",
		formatString : "#,##0",
		expFunction : function(  rowIndex, columnIndex, item, dataField ) {
			return Number(item.monQty) + Number(item.tueQty) + Number(item.wedQty) + Number(item.thuQty) + Number(item.friQty) + Number(item.satQty) + Number(item.sunQty); 
		}
	}
];

var columnLayout2 = [{
		dataField : "prdSapCd",
		headerText : "제품코드",
	    width : "15%",
	    style: "auiCenter",
	    headerStyle : "auiCenter"
	},{
		dataField : "prdNm",
		headerText : "제품명",
	    style: "auiLeft",
	    headerStyle : "auiCenter"
	},{
		dataField : "prdSeq",
		headerText : "제품Seq",
		visible: false
	},{
		dataField : "prmtPrdSeq",
		headerText : "제품Seq",
		visible: false
	}
];

var columnLayout3 = [{
		dataField : "prmtSecNm",
		headerText : "구분",
	    width : "8%",
	    style: "auiCenter",
	    headerStyle : "auiCenter"
	},{
		dataField : "prmtDetail",
		headerText : "상세",
	    style: "auiLeft",
	    headerStyle : "auiCenter"
	},{
		dataField : "applUntpc",
		headerText : "단가",
	    dataType : "numeric",
	    width : "14%",
	    style: "auiRight",
	},{
		dataField : "applDt",
		headerText : "적용시작일",
	    width : "14%",
	    style: "auiCenter",
	},{
		dataField : "endDt",
		headerText : "적용종료일",
	    width : "14%",
	    style: "auiCenter",        
	},{
		dataField : "prmtCstCt",
		headerText : "소비자부담금",
	    dataType : "numeric",
	    width : "15%",
	    headerStyle : "auiCenter",
	    style: "auiRight",
	    renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box center">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
	},{
		dataField : "prmtCt",
		headerText : "판촉사원부담금",
	    dataType : "numeric",
	    width : "15%",
	    style: "auiRight",
	    renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			var template = '<div class="my_div">';
			template += '<span class="my_div_text_box right">' + value + '</span>';
			template += '</div>';
			return template;
		},
		editable: "true",
	},{
		dataField : "prmtSeq",
		headerText : "제품Seq",
		visible: false
	},{
		dataField : "prmtSecCd",
		headerText : "구분",
		visible: false
    }
];

var columnLayout4 = [{
	    dataField : "modify",
		headerText : "",	
	    style : "moBtn auiRight",
	    width : "5%",		
	    renderer : {
	        type : "ButtonRenderer",
	        onClick : function(event) {
	        	
	            console.log("( " + event.rowIndex + ", " + event.columnIndex + " ) " + event.item.modify + " 수정 클릭");
	            modifyReviewPrd(event);
	        },
	    }
	},{
		dataField : "del",
		headerText : "",	
	    width : "5%",
	    style : "delBtn auiLeft",
	    renderer : {
	        type : "ButtonRenderer",
	        onClick : function(event) {
	            alert("( " + event.rowIndex + ", " + event.columnIndex + " ) " + event.item.del + "삭제 클릭");
	        },
	    }
	},{
		dataField : "prdNm",
		headerText : "제품명",
	    style : "auiLeft",
	    width : "14%"
	},{
		dataField : "sbscrbDt",
		headerText : "가입일",
		
	},{
		dataField : "inptDt",
		headerText : "투입일",
		width : "6%"
	},{
		dataField : "unptc",
		headerText : "단가",
	    dataType : "numeric",
		width : "6%",
	    style : "auiRight"
	},{
		dataField : "dfltQty",
		headerText : "수량",
	    width : "4%",
	    style : "auiRight"
	},{
		dataField : "pttn",
		headerText : "패턴",
		width : "7%"
	},{
		dataField : "monQty",
		headerText : "월",
		width : "3%"
	},{
		dataField : "tueQty",
		headerText : "화",
		width : "3%"
	},{
		dataField : "wedQty",
		headerText : "수",
		width : "3%"
	},{
		dataField : "thuQty",
		headerText : "목",
		width : "3%"
	},{
		dataField : "friQty",
		headerText : "금",
	    width : "3%"
	},{
		dataField : "satQty",
		headerText : "토",
	    headerStyle : "hColor01",
	    width : "3%"
	},{
		dataField : "sunQty",
		headerText : "일",
	    headerStyle : "hColor02",
	    width : "3%"
	},{
		dataField : "allQty",
		headerText : "총수량",
	    width : "5%",
	    style : "auiRight"
	},{
		dataField : "endDt",
		headerText : "계약종료일",
	    width : "6%",
	},{
		dataField : "sbscrbCosNm",
		headerText : "가입경로",
	    width : "6%",
	},{
		dataField : "prmtPymNm",
		headerText : "판촉사원",
	    width : "6%",
	},{
		dataField : "cntrMonth",
		headerText : "계약기간(월)",
	    width : "6%",
	},{
		dataField : "prmtView",
		headerText : "판촉물 지급 정보",
		width : "6%",
	    style : "moBtn",		
	    renderer : {
	        type : "ButtonRenderer",
	        onClick : function(event) {
	        	openPrmtPymInfoPop(event);	            
	        },
	    }
	},{
		dataField : "pttnInfo",
		headerText : "패턴정보",
		visible: false
	},{
		dataField : "prmtInfo",
		headerText : "판촉정보",
		visible: false
	},{
		dataField : "sbscrbCosSeq",
		headerText : "판촉정보",
		visible: false
	},{
		dataField : "prmtPymSeq",
		headerText : "판촉정보",
		visible: false
	},{
		dataField : "prdDtlSeq",
		headerText : "판촉정보",
		visible: false
	},{
		dataField : "prdSeq",
		headerText : "판촉정보",
		visible: false
	}
];

function createAddCstAUIGrid() {
	
	var gridPros = {
		headerHeight : 29,
		rowHeight : 29,
		// 편집 가능 여부 (기본값 : false)
		editable : true,
		autoGridHeight : true,				
		// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
		enterKeyColumnBase : true,
		showRowNumColumn : false,
		showRowCheckColumn : false, // 체크박스 사용 	
		// 셀 선택모드 (기본값: singleCell)
		selectionMode : "singleRow",
		showFooter : false,
		// 컨텍스트 메뉴 사용 여부 (기본값 : false)
	}
	
    var gridPros2 = {
		headerHeight : 29,
        rowHeight : 29,
        showRowCheckColumn: true,
        showRowNumColumn : false, 
        selectionMode : "singleRow",
        rowCheckToRadio : true,
	}
	
	var gridPros3 = {
		headerHeight : 29,
           rowHeight : 29,
           selectionMode : "singleRow",
	}
	console.log("createAUIGrid======");
	
	if(AUIGrid.isCreated(mGrid)){
    	AUIGrid.destroy(mGrid);        	
    }
    if(AUIGrid.isCreated(mGrid2)){
    	AUIGrid.destroy(mGrid2);        	
    }
    if(AUIGrid.isCreated(mGrid3)){
    	AUIGrid.destroy(mGrid3);        	
    }
    
    console.log("createAUIGrid22222======");
	
	mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	
	mGrid2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
	mGrid3 = AUIGrid.create("#grid_wrap3", columnLayout3, gridPros3);
		
	AUIGrid.bind(mGrid, "cellEditEnd", function( event ) {
		if(event.dataField == "cstSecCd"){
			$.each(AUIGrid.getColumnLayout(mGrid), function(i, v){
				if(!fnIsEmpty (v.headerRenderer) && v.headerRenderer.checked){
					AUIGrid.setCellValue(mGrid, event.rowIndex, v.dataField, event.value);
				}
			});
		}
	});
}

function createAddCstAUIGrid2() {
	
    var gridPros4 = {
		headerHeight : 29,
        rowHeight : 29,
        showRowNumColumn : false, 
        selectionMode : "singleRow",
	}
	
    if(AUIGrid.isCreated(mGrid4)){
    	AUIGrid.destroy(mGrid4);        	
    }
    
	mGrid4 = AUIGrid.create("#grid_wrap4", columnLayout4, gridPros4);	

}


$(document).ready(function() {

	createAddCstAUIGrid();
	createAddCstAUIGrid2();
	AUIGrid.setGridData(mGrid, pttnGridData);
		
	$(".postBtn").click(function(){
		var target = $(this).data("target");
		if ( target == "dlv") {
			fnSetPostcode('#dlvZipCd', '#dlvAddr1');
		}
		if ( target == "rept" ){
			fnSetPostcode('#reptZipCd', '#reptAddr1');
		}
	});

	$("#addSameAddr").click(function(){
		if( $(this).is(":checked") ){
			$("#reptZipCd").val($("#dlvZipCd").val());
			$("#reptAddr1").val($("#dlvAddr1").val());
			$("#reptAddr2").val($("#dlvAddr2").val());
		}else{
			$("#reptZipCd").val("");
			$("#reptAddr1").val("");
			$("#reptAddr2").val("");
		}
	});


	$("#btnPrdSrch").click(function(){
		$.ajaxDialog({
			id: "prdRegPop",
			ajax: {
				url: "/cst/prdRegPop.do",
			},
			dialog: {
				width:640,
				height:660,
				modal: true,
				draggable: false
			},
			success: function(data) {
				$("#prdNm").val(data.prdNm);
				$("#prdSeq").val(data.prdSeq);
				$("#prdDtlSeq").val(data.prdDtlSeq);
				
			}
		});
	});
	$("#btnAreaSrch").click(function(){
		openAreaPop();
	});
	

	$("#sbscrbCosCd").change(function(){
		if(this.value == "PRMT"){
			$("#prmtEmplSeq").show();
			$("#prmtEmplSeq").val("");
		}else{
			$("#prmtEmplSeq").hide();
			$("#prmtEmplSeq").val("");
		}
	});
	$("#sbscrbCosCd").change();
	
	$("#btnOverlapCheck").click(function(){
		overlapCheck();
	});
	
	$("#selCntrMonth").on("change", function(){
		
		if(this.value != "sel"){
			
			let date = new Date($("#datepicker10").val());
			console.log('기준일자 : ' + date + '<br>');

			date.setDate(date.getDate() + Number(this.value) *30);
			
			$('#datepicker11').data('daterangepicker').setStartDate(date);
			    				
		}
	});
	
  	$("#noCntr").on("change", function(){
  		if($("#noCntr").is(":checked")){
  			$("#datepicker11").val("2999-12-31");
  			$("#datepicker11").attr("readonly",true);     
  			
  			var datepicker = $('#datepicker11').data('daterangepicker');
  			//debugger;
  			//datepicker.hide();
  			datepicker.remove();
  		}else{
  			$("#datepicker11").removeAttr("readonly");  	
  			setTargetDaterangepicker('#datepicker11');
  		}
  	});
  	
  	
  	$("#btnFreeDsctPop, #getPrmtPrd, #btnAddPrmt").click(function(){  
  		if(fnIsEmpty($("#prdDtlSeq").val())){
  			layerAlert1('<spring:message code="alert.noSelect" arguments="${\'제품\'}" />');   			
  			return false;		
  		}
  		if(this.id == "btnFreeDsctPop"){
  			openFreeDsctPop();	
  		}else if(this.id == "getPrmtPrd"){
  			getPrmtList();	
  		}else if(this.id == "btnAddPrmt"){
  			setPrmtList();	
  		}
  	});
  	
  	$("#btnTempAddPrd").click(function(){
  		tempAddPrd()
  	});  	
	
  	$("#inptDt").on("change", function(){  			
  		$("#datepicker10").val(this.value);
  	});
  	$("#datepicker10").val($("#inptDt").val());
  	
});

function modifyReviewPrd(data){
	
	var rowItem = data.item;
	
	$("#prdDtlSeq").val(rowItem.prdDtlSeq);
	$("#prdSeq").val(rowItem.prdSeq);
	$("#prdNm").val(rowItem.prdNm);
	$("#datepicker10").val(rowItem.statDt);
	$("#datepicker11").val(rowItem.endDt);
	$("#sbsCrbDt").val(fnGetToDay());
	
	
}

function openPrmtPymInfoPop(info){
	
	prmtPymInfoData = info.item.prmtInfo;
	
	$.each(prmtPymInfoData, function(index, item){
    	item.prmtPymDt = fnGetToDay();
    });	
	
	$.ajaxDialog({
		id: "prmtPymInfo",
		visibility: "visible", 
		ajax: {
			url: "/cst/prmtPymInfoPop.do",
		},
		dialog: {
			width:1500,
			height:620,
			modal: true,
			draggable: false
		},
		success: function(data) {				
		}
	});
}

function prdInit(){
	
	$("#prdDtlSeq").val("");
	$("#prdSeq").val("");
	$("#prdNm").val("");
	$("#datepicker10").val(fnGetToDay());
	$("#datepicker11").val(fnGetToDay());
	$("#sbsCrbDt").val(fnGetToDay());
	
	createAddCstAUIGrid();
	
	let colList = AUIGrid.getColumnInfoList(mGrid);
	
	console.log("colList  ::  =============================" + JSON.stringify(colList));
	
	for(var i=0 ; colList.length > i ; i++){
		AUIGrid.setHeaderRendererProp(mGrid, i, {"checked" : false} );	
	}
	
	AUIGrid.setGridData(mGrid, pttnGridData);
	
}

function tempAddPrd(){
	
	let today = new Date();
	let statDt = $("#datepicker10").val();
	let endDt = $("#datepicker11").val();
	
	if(fnIsEmpty($("#prdDtlSeq").val())){
		layerAlert1('<spring:message code="alert.noSelect" arguments="${\'제품\'}" />');   			
		return false;		
	}		
	if($("#inptDt").val() < fnGetToDay()){
		layerAlert1('<spring:message code="alert.cstMng3" arguments="${\'투입일자\'}" />');   			
		return false;		
	}	
	if(new Date(statDt) > new Date(endDt)){
		layerAlert1('<spring:message code="alert.cstMng10" arguments="${\'계약일자\'}" />');   			
		return false;		
	}
	
	var sbsCrbDay = new Date(today.setDate(today.getDate() -7));
	
	console.log("sbsCrbDt  :: " + $("#sbsCrbDt").val() + ",  :: " + sbsCrbDay + ", :: " + fnConvertDate(sbsCrbDay));
	
	if($("#sbsCrbDt").val() < sbsCrbDay){
		layerAlert1('<spring:message code="alert.cstMng3" arguments="${\'투입일자\'}" />');   			
		return false;		
	}
		
	var pttnData = AUIGrid.getGridData(mGrid);
	var prmtData = AUIGrid.getGridData(mGrid3);
	var allQty = 0;
	var pttn = "";
	var pttnRow;
	$.each(pttnData, function(index, item){
		
		allQty = allQty + Number(item.totQty);
		if(item.totQty > 0 && pttn == ""){
			if(item.monQty > 0){
				pttn = "월";
			}
			if(item.tueQty > 0){
				pttn = pttn + "화";
			}
			if(item.wedQty > 0){
				pttn = pttn + "수";
			}
			if(item.thuQty > 0){
				pttn = pttn + "목";
			}
			if(item.friQty > 0){
				pttn = pttn + "금";
			}
			if(item.satQty > 0){
				pttn = pttn + "토";
			}
			if(item.sunQty > 0){
				pttn = pttn + "일";
			}
			pttnRow = item;
		}
	});
	
	if(allQty == 0){		
		layerAlert1('<spring:message code="alert.cstMng10" arguments="${\'투입패턴\'}" />');   			
		return false;		
	}
	
	let cntrMonth = (new Date(endDt).getTime() - new Date(statDt).getTime()) / (1000 * 3600 * 24 * 30) ;
	
	var obj = {"modify" : "수정", "del" : "삭제","prdNm" : $("#prdNm").val(), "sbscrbDt" : $("#datepicker10").val(), "inptDt" : $("#inptDt").val(), "unptc" : ""
			, "dfltQty" : allQty, "pttn" : pttn, "monQty" : pttnRow.monQty, "tueQty" : pttnRow.tueQty, "wedQty" : pttnRow.wedQty
			, "thuQty" : pttnRow.thuQty, "wedQty" : pttnRow.wedQty, "thuQty" : pttnRow.thuQty, "friQty" : pttnRow.friQty
			, "satQty" : pttnRow.satQty, "sunQty" : pttnRow.sunQty, "allQty" : allQty, "endDt" : $("#datepicker11").val()
			, "sbscrbCosNm" : $("#sbscrbCosCd  option:checked").text(), "prmtPymNm" : $("#prmtEmplSeq  option:checked").text()
			, "cntrMonth" : cntrMonth, "prmtView" : "상세보기", "pttnInfo" : pttnData, "prmtInfo" : prmtData
			, "sbscrbCosSeq" : $("#sbscrbCosCd  option:checked").val(), "prmtPymSeq" : $("#prmtEmplSeq  option:checked").val() };
	
	AUIGrid.addRow(mGrid4, obj, "last");
	
	prdInit();
	
}

function setPrmtList(){
		
	let checkedItems = AUIGrid.getCheckedRowItems(mGrid2);
	
	if(checkedItems.length != 1){
		
		layerAlert1('<spring:message code="alert.noSelect" arguments="${\'판촉물\'}" />');   			
		return false;
	}
	var prmtData = AUIGrid.getGridData(mGrid3);
	if(prmtData.length > 4){
		layerAlert1('<spring:message code="alert.cstMng11" arguments="${\'5\'}" />');   			
		return false;			
	}
	
	let param;
	
	for(var i=0, len = checkedItems.length; i<len; i++) {
		var item = checkedItems[i].item;
		param = {"prmtSecNm" : "상품", "prmtDetail" : item.prdNm , "applUntpc" : "", "applDt" : "", "endDt" : "", "prmtCstCt" : "", "prmtCt" : "", "prmtSeq" : item.prmtPrdSeq  }	;
	}
	
	AUIGrid.addRow(mGrid3, param, "last");
}


function getPrmtList(){

	let param = {"prmtSrhValue" : $("#prmtSrhValue").val()}
	
	$.ajax({
		url : "/cst/selectPrmtPrdList.do", 
		type : 'POST', 
		data : param,
		success : function(data) {
			
			console.log("data", data);		
			AUIGrid.setGridData(mGrid2, data);
			
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function openFreeDsctPop(){
	
	var data = [{ "prdNm" : $("#prdNm").val() , "statDt" : $("#inptDt").val() , "untpc" : $("#untpc").val() , "applUntpc" : "" 
		, "applDt" : "", "endDt" : "", "prmtSecCd" : $("#prmtSecCd").val(), "prmtMonth" : "", "prmtRate" : ""}];

	$.ajaxDialog({
		id: "freeDsctPop",
		visibility: "visible", 
		ajax: {
			url: "/cst/freeDsctPop.do",
			data : {"parentWinNm":"addCstMng", "freeDsctData": JSON.stringify(data)}
		},
		dialog: {
			width:1600,
			height:870,
			modal: true,
			draggable: false
		},
		success: function(data) {			
		}
	});
	
}

function setAreaCd(paramObj){
	
	//paramObj = {"areaSeq" : areaSeq, "agenAreaCd" : agenAreaCd, "areaNm": areaNm};
	console.log("setAreaCd ::");		
	
	$("#areaSeq").val(paramObj.areaSeq);
	$("#areaNm").val(paramObj.areaNm);	
	
}

function overlapCheck(){
	
	if(fnIsEmpty($("#cstNm").val())){		
		layerAlert1('<spring:message code="alert.noSelect" arguments="${\'이름\'}" />');
		return false;
	}
	if(fnIsEmpty($("#mob2").val()) || fnIsEmpty($("#mob3").val())){		
		layerAlert1('<spring:message code="alert.noSelect" arguments="${\'휴대폰 번호\'}" />');
		return false;
	}
	if(fnIsEmpty($("#dlvZipCd").val())){		
		layerAlert1('<spring:message code="alert.noSelect" arguments="${\'우편번호\'}" />');
		return false;
	}
	
	let param = $("#frm").serialize();
	console.log("param ::", JSON.stringify(param));
	
	var mobNo = $("#mob1").val() + $("#mob2").val() + $("#mob3").val();
	
	param = param  + "&mobNo=" + mobNo;
	
	$.ajax({
		url : "/cst/selectOverlapCheck.do", 
		type : 'POST', 
		data : param,
		success : function(data) {
			
			console.log("data", data);			
			
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}



function openAreaPop(){
	/* getComPop("/cst/areaChoicePop.do", "modalAgencyViews03"); */
	$.ajaxDialog({
		id: "areaChoicePop",
		ajax: {
			url: "/cst/areaChoicePop.do",
		},
		dialog: {
			width:680,
			height:550,
			modal: true,
			draggable: false
		},
		success: function(data) {
			//alert("여기로 리턴됨 ㅇㅇ >> "+ data.prdNm);
			
		}
	});
}


function checkClickEvent(event) {
	//alert("columnIndex : " + event.columnIndex + ", checked : " + event.checked);
	if(event.checked){
		for(var i=0; i<AUIGrid.getRowCount(mGrid); i++){
			AUIGrid.setCellValue(mGrid, i, event.columnIndex, AUIGrid.getCellValue(mGrid, i, "cstSecCd"));
			AUIGrid.setCellValue(mGrid, i, event.columnIndex, AUIGrid.getCellValue(mGrid, i, "cstSecCd"));
		}
	}else{
		for(var i=0; i<AUIGrid.getRowCount(mGrid); i++){
			AUIGrid.setCellValue(mGrid, i, event.columnIndex, 0);
		}
	}
}

</script>
<div class="content">
	<div class="titTopArea">
		<h2 class="tit01">애음자 현황 <a href="#" class="favor" title="즐겨찾기"></a></h2>
		<div class="location">
			<ul>
				<li><i class="home"></i></li>
				<li>애음자 관리</li>
				<li>애음자 관리</li>
				<li>애음자 신규 등록</li>
			</ul>
		</div>
	</div>

	<div class="btnGroup ar">
		<button type="button" name="" class="comBtn">취소</button>
		<button type="button" name="" class="inquBtn" id="inp_inquiry">저장</button>
	</div>
	
	<form id="frm">
	
		<!-- 애음자 기본정보 -->
		<div class="titleArea right">
			<h3 class="tit01">기본정보</h3>
	
			<p class="txt01 pColor02">* 필수 입력 항목입니다.</p>
		</div>
	
		<div class="tblWrap">
			<table class="tbl">
				<caption>애음자 기본정보</caption>
				<colgroup>
					<col style="width:170px;">
					<col>
					<col style="width:170px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">
							애음자 코드
						</th>
						<td>
							00001212
						</td>
						<th scope="row">
							<label for="areaNm" class="required" title="필수입력">지역 / 배달순서</label>
						</th>
						<td>
							<div class="formWrap w330">
								<div class="searchWrap">
									<input type="text" id="areaNm" name="areaNm" class="inp w160"/>
									<input type="hidden" id="areaSeq" name="areaSeq" />
									<button type="button" id="btnAreaSrch" class="postBtn" title="지역 찾기" ></button>
								</div>
								<span class="divi"> / </span>
	
								<input type="text" id="ordr" name="ordr" class="inp" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="inp_name01" class="required" title="필수입력">성명 / 신청인</label>
						</th>
						<td>
							<div class="formWrap w330">
								<input type="text" id="cstNm" name="cstNm" class="inp">
	
								<span class="divi">/</span>
	
								<input type="text" id="appctNm" name="appctNm" class="inp">
							</div>
						</td>
						<th scope="row">
							<label for="sel_regiPath01" class="required" title="필수입력">가입경로</label>
						</th>
						<td>
							<div class="formWrap type02">
								${sbscrbCosCd}
	
								<select name="prmtEmplSeq" class="sel w160" id="prmtEmplSeq" style="display: none;">
									<option value="">선택</option>
									<c:forEach var="empl" items="${emplList}" varStatus="status">
										<option value="${empl.emplSeq}">${empl.emplNm}</option>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="sel_handPhone01" class="required" title="필수입력">휴대폰 번호</label>
						</th>
						<td>
							<div class="formWrap">
								<select name="mob1" class="sel" id="mob1" name="mob1">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="012">012</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>											
								<span class="dash"></span>
								<input type="text" id="mob2" class="inp" value="" name="mob2" maxlength="4">
								<span class="dash"></span>
								<input type="text" id="mob3" class="inp" value="" name="mob3" maxlength="4">
							</div>
						</td>
						<th scope="row">
							<label for="inp_phone01">전화 번호</label>
						</th>
						<td>
							<div class="formWrap">
								<input type="text" id="telno1" class="inp" value="" name="telno1" maxlength="3">										   
								<span class="dash"></span>
								<input type="text" id="telno2" class="inp" value="" name="telno2" maxlength="4">
								<span class="dash"></span>
								<input type="text" id="telno3" class="inp" value="" name="telno3" maxlength="4">
							</div>  
						</td>
					</tr>
					<tr>
						<th scope="row" rowspan="2">
							<label for="dlvZipCd" class="required" title="필수입력">배달주소</label>
						</th>
						<td colspan="3">
							<div class="formWrap type02">
								<div class="postWrap w200 mr20">
									<input type="text" id="dlvZipCd" class="inp">
									<button type="button" class="postBtn" title="우편번호 찾기" data-target="dlv" ></button>
								</div>
	
								<button type="button" name="" class="comBtn small" id="btnOverlapCheck" >중복조회</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" id="dlvAddr1" name="dlvAddr1" class="inp">
						</td>
						<th scope="row">
							<label for="inp_address_add01">상세주소</label>
						</th>
						<td>
							<input type="text" id="dlvAddr2" name="dlvAddr2" class="inp">
						</td>
					</tr>
					<tr>
						<th scope="row" rowspan="2">
							<label for="inp_post_num02">우편주소</label>
						</th>
						<td colspan="3">
							<div class="formWrap type02">
								<div class="postWrap w200 mr20">
									<input type="text" id="reptZipCd" class="inp">
									<button type="button" class="postBtn" title="우편번호 찾기" data-target="rept"></button>
								</div>
								<input type="checkbox" id="addSameAddr" class="type01"><label for="addSameAddr"><span>배달주소와 동일</span></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" id="reptAddr1" name="reptAddr1" class="inp">
						</td>
						<th scope="row">
							<label for="inp_address_add02">상세주소</label>
						</th>
						<td>
							<input type="text" id="reptAddr2" name="reptAddr2" class="inp">
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="inp_post_posi">투입위치</label>
						</th>
						<td colspan="3">
							<input type="text" id="inp_post_posi" class="inp">
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="inp_memo">메모</label>
						</th>
						<td colspan="3">
							<textarea name="" id="inp_memo" class="h110"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 대리점 상세 정보 -->
	
		<div class="titleArea right">
			<h3 class="tit01">결제정보</h3>
		</div>
	
		<div class="tblWrap">
			<table class="tbl">
				<caption>결제정보</caption>
				<colgroup>
					<col style="width:170px;">
					<col>
					<col style="width:170px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">
							<label for="sel_collMethod" title="필수입력" class="required">수금방법</label>
						</th>
						<td colspan="3">
							<div class="formWrap">
								${bilctMth}
							</div>
						</td>
					</tr> 
				</tbody>
			</table>
		</div>
	
		<!-- 계약정보 -->
		<div class="titleArea right">
			<h3 class="tit01">계약정보</h3>
			
			<button type="button" id="btnTempAddPrd" class="comBtn small">제품추가</button>
		</div>
		
		<div class="tblWrap">
			<table class="tbl">
				<caption>계약정보</caption>
				<colgroup>
					<col style="width:170px;">
					<col>
					<col style="width:170px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">
							<label for="inp_prdNm" class="required" title="필수입력">제품명</label>
						</th>
						<td>
							<div class="formWrap type02">
								<div class="searchWrap w200 mr20">
									<input type="text" 		id="prdNm"	name="prdNm"	class="inp">
									<input type="hidden" 	id="prdSeq"	name="prdSeq"	class="inp">
									<input type="hidden" 	id="prdDtlSeq"	name="prdDtlSeq"	class="inp">
									<button type="button" id="btnPrdSrch" class="postBtn" title="제품명 찾기"></button>
								</div>
							</div>
						</td>
						<th scope="row">
							<label for="inp_price02" class="required" title="필수입력">지역 애음자단가</label>
						</th>
						<td>
							<div class="formWrap w180">
								<input type="text" id="untpc" name="untpc" class="inp ar" disabled>
								<span class="divi">원</span>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="inptDt" class="required" title="필수입력">투입일</label>
						</th>
						<td colspan="3">
							<div class="dateWrap">
								<input type="text" name="inptDt" class="inp datepicker" id="inptDt">
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="inptDt"></button>
							</div> 
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="datepicker10" class="required" title="필수입력">계약기간</label>
						</th>
						<td colspan="3">
							<div class="formWrap type02">
								<div class="dateWrap">
									<input type="text" name="statDt" value="" class="inp " id="datepicker10" readonly>										
									<button type="button" class="" title="날짜입력" data-target-id="datepicker10"></button>										
								</div> 

								<span class="divi02">-</span>
								
								<div class="dateWrap mr20">
									<input type="text" name="endDt" value="10/24/1984" class="inp datepicker" id="datepicker11" readonly>
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker11"></button>										
								</div>

								<select name="selCntrMonth" class="sel w160 mr20" id="selCntrMonth">
									<option value="">종료일 선택</option>
									<option value="1">1개월</option>
									<option value="2">2개월</option>
									<option value="3">3개월</option>
									<option value="4">4개월</option>
									<option value="5">5개월</option>
									<option value="6">6개월</option>
									<option value="7">7개월</option>
									<option value="8">8개월</option>
									<option value="9">9개월</option>
									<option value="10">10개월</option>
									<option value="11">11개월</option>
									<option value="12">12개월</option>
									<option value="13">13개월</option>
									<option value="14">14개월</option>
									<option value="15">15개월</option>
									<option value="16">16개월</option>
									<option value="17">17개월</option>
									<option value="18">18개월</option>
									<option value="19">19개월</option>
									<option value="20">20개월</option>
									<option value="21">21개월</option>
									<option value="22">22개월</option>
									<option value="23">23개월</option>
									<option value="24">24개월</option>
									<option value="36">36개월</option>
									<option value="48">48개월</option>
								</select>

								<input type="checkbox" id="noCntr" class="type01" ><label for="noCntr"><span>무계약</span></label>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="inp_inPattern" class="required" title="필수입력">투입패턴</label>
						</th>
						<td colspan="3">
							<div class="inGirdBox w49per">
								<p class="ar">* 1주는 1일~7일을, 2주는 8일~14일을 나타냅니다.</p>

								<!-- grid -->
								<div class="girdBox h207">
									<div id="grid_wrap"></div>
								</div>
								<!-- grid -->
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="sel_prmtSeller">판촉사원</label>
						</th>
						<td>
							<select name="prmtEmplSeq" class="sel w160" id="prmtEmplSeq">
								<c:forEach var="empl" items="${emplList}" varStatus="status">
									<option value="${empl.emplSeq}">${empl.emplNm}</option>
								</c:forEach>
							</select>
						</td>
						<th scope="row">
							<label for="datepicker05">가입일</label>
						</th>
						<td>
							<div class="dateWrap">
								<input type="text" name="sbsCrbDt" class="inp datepicker" id="sbsCrbDt">
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="sbsCrbDt"></button>
							</div> 
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="selFreeDsct">무료/할인</label>
						</th>
						<td>
							<div class="formWrap type02">
								<select name="prmtSecCd" class="sel w160 mr10" id="prmtSecCd">
									<option value="free">무료</option>
									<option value="dsct">할인</option>
									
								</select>

								<button type="button" name="" class="comBtn small" id="btnFreeDsctPop">추가</button>
							</div>
						</td>
						<th scope="row" class="txtLong mulLine">
							<label for="inp_appPrice">적용단가 <br/> (애음자 개별단가)</label>
						</th>
						<td>
							<div class="formrap">
								<input type="text" id="inp_appPrice" class="inp w160 pColor01 mr10 ar" value="" name="" disabled>
								<span>원</span>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="sel_prmtPrd01">판촉물</label>
						</th>
						<td colspan="3">
							<div class="tdGridWrap">
								<div class="formWrap type02">   
									<div class="searchWrap w200 mr20">
										<input type="text" id="prmtSrhValue" class="inp">
										<button type="button" class="postBtn" title="상품 찾기" id="getPrmtPrd">
									</div>

									<button type="button" name="" class="comBtn small" id="btnAddPrmt">추가</button>
								</div>

								<div class="girdBoxGroup h180">
									<!-- grid -->
									<div class="girdBox w28per">
										<div id="grid_wrap2"></div>
									</div>
									<!-- grid -->

									<!-- grid -->
									<div class="girdBox w77per">
										<div id="grid_wrap3"></div>
									</div>
									<!-- grid -->
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 계약정보 -->
	
		<!-- grid -->
		<div class="girdBox type07">
			<div id="grid_wrap4"></div>
		</div>
		<!-- grid -->
		
	</form>
</div>


