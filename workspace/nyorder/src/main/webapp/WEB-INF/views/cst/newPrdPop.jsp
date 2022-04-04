<!-- 
	@File Name: 
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 2. 22.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    var myPopGridID1;
    var myPopGridID2;
    var myPopGridID3;
    var myPopGridID4;
    
    var popupId = '${param.id}';
    
    var columnLayoutPop1 = [{
		dataField : "prdDtlCd",
		headerText : "제품코드",
        width : "30%",
        style: "auiCenter",
        headerStyle : "auiCenter"
    },{
		dataField : "shtnNm",
		headerText : "제품명",
        style: "auiLeft",
        headerStyle : "auiCenter"
    },{
		dataField : "untpc",
		headerText : "지역 애음자단가",
        width : "25%",
        dataType : "numeric",
		formatString : "#,##0",
        style: "auiRight",
        headerStyle : "auiCenter"        
    },{
		dataField : "prdSeq",
		headerText : "제품Seq", 
		visible: false
	},{
		dataField : "prdDtlSeq",
		headerText : "제품Seq",
		visible: false
	},{
		dataField : "puchSeq",
		headerText : "제품Seq",
		visible: false
	}
];
var columnLayoutPop2 = [{
    dataField : "cstSecCd",
    headerText : "구분",
    width : "10.5%",
    style: "auiCenter",
    headerStyle : "auiCenter",
    editable: "false"

    },{
        dataField : "qty",
        headerText : "수량",
        width : "9%",
        style: "auiCenter",
        headerStyle : "auiCenter",
        editable: "true",
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
        dataField : "monQty",
        headerText : "월",
        width : "9%",
        style: "auiCenter",
        headerStyle : "auiCenter",
        editable: "true",
        headerRenderer : {
            type : "CheckBoxHeaderRenderer",
            dependentMode : true, 			
            position : "left", // 기본값 "bottom",     
            onClick : myHeaderCheckClick // 클릭 핸들러
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
        width : "9%",
        style: "auiCenter",
        headerStyle : "auiCenter",
        headerRenderer : {
            type : "CheckBoxHeaderRenderer",
            dependentMode : true, 			
            position : "left", // 기본값 "bottom",
            onClick : myHeaderCheckClick // 클릭 핸들러
        },
        renderer : {
                type : "TemplateRenderer"
        },
        labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value + '</span>';
            template += '</div>';
            return template;
        },
    },{
        dataField : "wedQty",
        headerText : "수",
        width : "9%",
        style: "auiCenter",
        headerStyle : "auiCenter",
        headerRenderer : {
            type : "CheckBoxHeaderRenderer",
            dependentMode : true, 			
            position : "left", // 기본값 "bottom",   
            onClick : myHeaderCheckClick // 클릭 핸들러
        },
        renderer : {
                type : "TemplateRenderer"
        },
        labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value + '</span>';
            template += '</div>';
            return template;
        },
    },{
        dataField : "thuQty",
        headerText : "목",
        width : "9%",
        style: "auiCenter",
        headerStyle : "auiCenter",
        headerRenderer : {
            type : "CheckBoxHeaderRenderer",
            dependentMode : true, 			
            position : "left", // 기본값 "bottom",
            onClick : myHeaderCheckClick // 클릭 핸들러
        },
        renderer : {
                type : "TemplateRenderer"
        },
        labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value + '</span>';
            template += '</div>';
            return template;
        },
    },{
        dataField : "friQty",
        headerText : "금",
        width : "9%",
        style: "auiCenter",
        editable : true, 
        headerStyle : "auiCenter",
        headerRenderer : {
            type : "CheckBoxHeaderRenderer",
            dependentMode : true, 			
            position : "left", // 기본값 "bottom",      
            onClick : myHeaderCheckClick // 클릭 핸들러
        },
        renderer : {
                type : "TemplateRenderer"
        },
        labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value + '</span>';
            template += '</div>';
            return template;
        },
    },{
        dataField : "satQty",
        headerText : "토",
        width : "9%",
        style: "auiCenter",
        headerStyle : "auiCenter, hColor01",
        headerRenderer : {
            type : "CheckBoxHeaderRenderer",
            dependentMode : true, 			
            position : "left", // 기본값 "bottom",
            onClick : myHeaderCheckClick // 클릭 핸들러
        },
        renderer : {
                type : "TemplateRenderer"
        },
        labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value + '</span>';
            template += '</div>';
            return template;
        },
    },{
        dataField : "sunQty",
        headerText : "일",
        width : "9%",
        style: "auiCenter",
        headerStyle : "auiCenter hColor02",
        headerRenderer : {
            type : "CheckBoxHeaderRenderer",
            dependentMode : true, 			
            position : "left", // 기본값 "bottom",
            onClick : myHeaderCheckClick // 클릭 핸들러
        },
        renderer : {
                type : "TemplateRenderer"
        },
        labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value + '</span>';
            template += '</div>';
            return template;
        },
    },{
        dataField : "totQty",
        headerText : "총수량",
        style: "auiCenter",
        headerStyle : "auiCenter",
        editable: false,
        expFunction : function(  rowIndex, columnIndex, item, dataField ) { // 여기서 실제로 출력할 값을 계산해서 리턴시킴.			
			return ( Number(item.monQty) + Number(item.tueQty) + Number(item.wedQty) + Number(item.thuQty) + Number(item.friQty) + Number(item.satQty) + Number(item.sunQty) ); 
		},
    },{
        dataField : "weeks",
        headerText : "주차",
        visible: false
    }
];

var gridDataPop2 = [
    {"id":"#Cust01","weeks" : "1","cstSecCd":"1주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
	{"id":"#Cust02","weeks" : "2","cstSecCd":"2주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
	{"id":"#Cust03","weeks" : "3","cstSecCd":"3주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
	{"id":"#Cust04","weeks" : "4","cstSecCd":"4주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
	{"id":"#Cust05","weeks" : "5","cstSecCd":"5주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
	{"id":"#Cust06","weeks" : "6","cstSecCd":"6주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""}
	];

var columnLayoutPop3 = [{
		dataField : "prdSapCd",
		headerText : "제품코드",
        width : "40%",
        style: "auiCenter",
        headerStyle : "auiCenter"
    },{
		dataField : "prdNm",
		headerText : "제품명",
        style: "auiLeft",
        headerStyle : "auiCenter"
    },{
		dataField : "prdSeq",
		headerText : "구분",
		visible: false
    },{
		dataField : "prmtPrdSeq",
		headerText : "구분",
		visible: false
    }
];
var columnLayoutPop4 = [{
		dataField : "prmtSecNm",
		headerText : "구분",
        width : "15%",
        style: "auiCenter",
        headerStyle : "auiCenter",
        editable: false,
    },{
        dataField : "prmtDetail",
		headerText : "상세",
        style: "auiLeft",
        headerStyle : "auiCenter",
        editable: false,
    },{
    	dataField : "applUntpc",
		headerText : "단가",
        width : "15%",
        style: "auiRight",
        headerStyle : "auiCenter",
        editable: false,
    },{
    	dataField : "applDt",
		headerText : "적용시작일",
        style: "auiCenter",
        headerStyle : "auiCenter",
        width : "15%",
        editable: false,
    },{
    	dataField : "endDt",
		headerText : "적용종료일",
        style: "auiCenter",
        headerStyle : "auiCenter",
        width : "15%",
        editable: false,
    },{
		dataField : "prmtCstCt",
		headerText : "소비자부담금",
        headerStyle : "auiCenter",
        style: "auiCenter",
        width : "15%",
        editable: true,
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
		dataField : "prmtCt",
		headerText : "판촉사원부담금",
        headerStyle : "auiCenter",
        style: "auiCenter",
        width : "15%",
        editable: true,
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
		dataField : "prmtSeq",
		headerText : "제품Seq",
		visible: false
	},{
		dataField : "prmtSecCd",
		headerText : "구분",
		visible: false
    }
];

   
   $(document).ready(function(){
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();
        
      	setDaterangepicker();
      	
		$("#newModalCloseBtn").on("click", function(){        	
        	//debugger;
        	//$.closeDialog("newPrdPop");        	
        	console.log("closeDialog  : " + popupId);        		
        	$.closeDialog("<c:out value='${param.id}'/>");
        	
        });
      	
      	
      	$("#prmtEmplSeq").hide();
      	
      	$("#cstCosCd").on("change", function(){
      		if(this.value == "PRTM"){
      			setPrtmEmplSeq();
      		}else{      			
      			$("#prmtEmplSeq").hide();
      			$("#prmtEmplSeq").val("");
      		}
      	});
      	
      	$("#endDt").val(fnGetToDay());
      	
      	$("#popdatepicker02").on("change", function(){
      		$("#statDt").val(this.value);
      	});
      	
      	$("#cntrMonth").on("change", function(){      		
      		var cntrStartDate = new Date($("#statDt").val());      		
      		cntrStartDate.setDate(cntrStartDate.getDate() + Number(this.value) *30);
      		$("#endDt").val(fnConvertDate(cntrStartDate));
      	});
      	
      	$("#noCntr").on("change", function(){
      		if($("#noCntr").is(":checked")){
      			$("#endDt").val("9999-99-99");
      			$("#endDt").attr("readonly",true);      			
      		}else{
      			$("#endDt").removeAttr("readonly");
      		}
      	});
      	
      	$("#btnSearchPrd").on("click", function(){
      		getSearchPrdList();
      	});
      	
      	$("#btnFreeDsctPop2").click(function(){      		
      		openFreeDsctPop();      		
      	});
      	$("#btnNewPrdSave").click(function(){      		
      		newPrdSave();      		
      	});
      	
      	$("#btnPrmtSrh").click(function(){
      		getPrmtList();
      	});
      	$("#btnSetPrmtPrd").click(function(){
      		setPrmtList();
      	});
      	
      	
	});
	
   function setPrmtList(){
		
		let checkedItems = AUIGrid.getCheckedRowItems(myPopGridID3);
		
		if(checkedItems.length != 1){
			
			layerAlert1('<spring:message code="alert.noSelect" arguments="${\'판촉물\'}" />');   			
			return false;
		}
		
		var prmtData = AUIGrid.getGridData(myPopGridID4);
		if(prmtData.length > 4){
			layerAlert1('<spring:message code="alert.cstMng11" arguments="${\'5\'}" />');   			
			return false;			
		}
		
		let param;
		
		for(var i=0, len = checkedItems.length; i<len; i++) {
			var item = checkedItems[i].item;
			param = {"prmtSecNm" : "상품", "prmtDetail" : item.prdNm , "applUntpc" : "", "applDt" : ""
					, "endDt" : "", "prmtCstCt" : "", "prmtCt" : "", "prmtSeq" : item.prmtPrdSeq, "prmtSecCd" : "PRD"  };
		}
		
		AUIGrid.addRow(myPopGridID4, param, "last");
	}
   
	function getPrmtList(){

		let param = {"prmtSrhValue" : $("#prmtSrhValue").val()}
		
		$.ajax({
			url : "/cst/selectPrmtPrdList.do", 
			type : 'POST', 
			data : param,
			success : function(data) {
				
				console.log("data", data);		
				AUIGrid.setGridData(myPopGridID3, data);
				
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
   
   	function newPrdSave(){
   		
   		var today = new Date();   		
		var prmtDay = new Date(today.setDate(today.getDate() -8));
		var statDt = $("#statDt").val().replace(/(-)/g, "");
		var endDt =  $("#endDt").val().replace(/(-)/g, "");
		var prmtDt = $("#prmtDt").val().replace(/(-)/g, "");
		var inptDt =  $("#inptDt").val().replace(/(-)/g, "");
   		
   		console.log("prmtDt  :: " + $("#prmtDt").val() + ",  :: " + prmtDay + ", :: " + fnConvertDate(prmtDay));
   		
   		if($("#prmtDt").val() < prmtDay){
   			layerAlert1('<spring:message code="alert.cstMng3" arguments="${\'가입일자\'}" />');   			
   			return false;		
   		}
   		
   		if($("#inptDt").val() < fnGetToDay()){
   			layerAlert1('<spring:message code="alert.cstMng3" arguments="${\'투입일자\'}" />');   			
   			return false;		
   		}
   		if(new Date($("#statDt").val()) > new Date($("#endDt").val()) ){
   			layerAlert1('<spring:message code="alert.cstMng10" arguments="${\'계약기간\'}" />');   			
   			return false;		
   		}
   		
    	if(fnIsEmpty($("#prdDtlCd").val())){    		
	        layerAlert1('<spring:message code="alert.noSelect" arguments="${\'제품\'}" />');	        
    		return false;    		
    	}
    	
    	var prmtData = AUIGrid.getGridData(myPopGridID4);
    	var pttnData = AUIGrid.getGridData(myPopGridID2);
    	var allQty = 0;
    	
    	console.log("pttnData  :: " + JSON.stringify(pttnData));
    	console.log("prmtData  :: " + JSON.stringify(prmtData));
    	
    	$.each(pttnData, function(index, item){    		
    		allQty = allQty + Number(item.totQty);    	
    	});
    	
    	if(allQty == 0){		
    		layerAlert1('<spring:message code="alert.cstMng10" arguments="${\'투입패턴\'}" />');   			
    		return false;		
    	}
    	
    	$.each(prmtData, function(index, item){    		
    		if(fnIsEmpty(item.prmtCt)){
    			item.prmtCt=0;
    		}
    		if(fnIsEmpty(item.prmtCstCt)){
    			item.prmtCstCt=0;
    		}
    	});
    	
    	var formData = $("#prdFrm").serializeObject();
    	let cntrMonth = (new Date($("#endDt").val()).getTime() - new Date($("#statDt").val()).getTime()) / (1000 * 3600 * 24 * 30) ;
    	let untpc = $("#cstApplUnptc").val();
    		
    	if(fnIsEmpty(untpc)){    		
    		untpc = $("#areaCstUntpc").val();;
    	}
    	
    	formData.prmtData = prmtData;
    	formData.pttnData = pttnData;
    	formData.cntrMonth = cntrMonth;
    	formData.untpc = untpc
    	formData.cntrSecCd = 'NEW';
    	formData.stdrQty = allQty;
    	formData.dfltQty = allQty;
    	formData.statDt = statDt;
    	formData.endDt = endDt;
    	formData.prmtDt = prmtDt;
    	formData.inptDt = inptDt;
    	
    	//var params = {"formData" : $("#prdFrm").serializeObject(), "pttnData" : pttnData};
    	
    	//params = params + "&pttnData=" + pttnData;
    	
    	console.log("formData  :: " + JSON.stringify(formData));
    	
    	$.ajax({
		   	contentType: 'application/json',
			url : "/cst/saveNewPrd.do", 
			type : 'POST', 
			data : JSON.stringify(formData),
			//dataType:"json",
			success : function(data) {
				console.log('save : ' + data );
				if(!fnIsEmpty(data.success) && data.success){					
					layerAlert1('<spring:message code="alert.save" />');	
				}else{
					layerAlert1('<spring:message code="alert.admin" />');
					
				}
				   	
				
				$.closeDialog("<c:out value='${param.id}'/>");
				
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
				$.closeDialog("<c:out value='${param.id}'/>");
			}
		});
   	}
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
    	
        // 그리드 속성 설정
        var gridProsPop1 = {
                headerHeight : 30,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : false,                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "singleRow",
                //showFooter : true,                
                // 컨텍스트 메뉴 사용 여부 (기본값 : false)
                useContextMenu : true,                
                // 필터 사용 여부 (기본값 : false)
                enableFilter : true,            
                // 그룹핑 패널 사용
                useGroupingPanel : false,
                // 체크박스 사용 
	            showRowCheckColumn : true,
                // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
                displayTreeOpen : true,
                noDataMessage : "출력할 데이터가 없습니다.",                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
                showRowNumColumn : false,
                width: '100%',
                rowCheckToRadio : true,             
        };
        var gridProsPop2 = {
        	headerHeight : 29,
    		rowHeight : 29,            
    		rowCheckToRadio : true,
            rowCheckColumnWidth : 30,
            enterKeyColumnBase : true,
            headerRowCheck: true,
            editingOnKeyDown : true,
            editable : true,
            selectionMode : "singleRow",
		}
        var gridProsPop3 = {
            headerHeight : 30,
			rowHeight : 30,
			showRowCheckColumn : true, // 체크박스 사용
            showRowNumColumn : false,
            rowCheckToRadio : true,
            rowCheckColumnWidth : 30,
            enterKeyColumnBase : true,
            editingOnKeyDown : true,
            selectionMode : "singleRow",
		}
        var gridProsPop4 = {
            headerHeight : 30,
			rowHeight : 30,
            showRowNumColumn : true,
            rowNumColumnWidth : 40,
            enterKeyColumnBase : true,
            editingOnKeyDown : true,
            editable : true,
            selectionMode : "singleRow",
		} 
        
        //debugger;
        
        
        if(AUIGrid.isCreated(myPopGridID1)){
        	AUIGrid.destroy(myPopGridID1);        	
        }
        if(AUIGrid.isCreated(myPopGridID2)){
        	AUIGrid.destroy(myPopGridID2);        	
        }
        if(AUIGrid.isCreated(myPopGridID3)){
        	AUIGrid.destroy(myPopGridID3);        	
        }
        if(AUIGrid.isCreated(myPopGridID4)){
        	AUIGrid.destroy(myPopGridID4);        	
        }
        
        // 실제로 #grid_wrap 에 그리드 생성
        myPopGridID1 = AUIGrid.create("#grid_wrap1_pop", columnLayoutPop1, gridProsPop1);
        
		AUIGrid.bind(myPopGridID1, "rowCheckClick", function( event ) {        	
        	var untpc	= event.item.untpc;        	
        	$("#areaCstUntpc").val(untpc);    	
        	$("#prdDtlCd").val(event.item.prdDtlCd);
        	$("#prdSeq").val(event.item.prdSeq);
        	$("#prdDtlSeq").val(event.item.prdDtlSeq);
        	$("#puchSeq").val(event.item.puchSeq);
        	
    		//alert("rowIndex : " + event.rowIndex + ", id : " + event.item.id + ", name : " + event.item.name + ", checked : " + event.checked);
    	});
		
        myPopGridID2 = AUIGrid.create("#grid_wrap2_pop", columnLayoutPop2, gridProsPop2);
        
        AUIGrid.setGridData(myPopGridID2, gridDataPop2);
        
        myPopGridID3 = AUIGrid.create("#grid_wrap3_pop", columnLayoutPop3, gridProsPop3);
        myPopGridID4 = AUIGrid.create("#grid_wrap4_pop", columnLayoutPop4, gridProsPop4);
        
    }
    
    function openFreeDsctPop(){
    	console.log("btnFreeDsctPop  : " );
    	
    	if(fnIsEmpty($("#prdDtlCd").val())){
    		let data = {};	        
			data.title = "";
			data.message = '<spring:message code="alert.noSelect" arguments="${\'제품\'}" />';	   
			data.showBtn2 = 'N';
	        let popupObj = {"data" : data}
	        layerAlert(popupObj);
	        
    		return false;    		
    	}
    	data = [];
    	    	
    	$.each(AUIGrid.getCheckedRowItemsAll(myPopGridID1), function(index, item){
    		var obj = { "prdNm" : item.shtnNm , "statDt" : $("#inptDt").val() , "untpc" : item.untpc , "applUntpc" : "" 
    			, "applDt" : "", "endDt" : "", "prmtSecCd" : "", "prmtMonth" : "", "prmtRate" : "", "prmtSecCd" : "PRD"}
    		
    		data.push(obj);
    		
    	});
    	
    	console.log(" newPrd  freeDsctData ::" + JSON.stringify(data))
    	
		$.ajaxDialog({
			id: "freeDsctPop",
			visibility: "visible", 
			openComplete: function(data) {	
				console.log(" newPrd  freeDsctData openComplete ::" + JSON.stringify(data))
				
			},
			success: function(data) {
				console.log(" newPrd  freeDsctData success ::" + JSON.stringify(data));
				
				var rows = AUIGrid.getRowIndexesByValue(myPopGridID4, "prmtSecCd", ["DSCT", "FREE"]);
				
				console.log(" newPrd  rows success ::" + JSON.stringify(rows));
				$.each(rows, function(index, item){					
											
					AUIGrid.removeRow(myPopGridID4, item);					
										
				});
				
				AUIGrid.removeSoftRows(myPopGridID4);
				
				AUIGrid.addRow(myPopGridID4, data, "last");
				$("#cstApplUnptc").val(data.applUntpc);	   			
	   			
			},
			ajax: {
				url: "/cst/freeDsctPop.do",
				method: "get",
				async: false,
				data : {"parentWinNm":"newPrdPop", "freeDsctData": JSON.stringify(data)}
			},
			dialog: {
				modal: true,
				width:1600,
				height:870
			}
		});
    	
    	
    }

   
    // 전체 체크 설정/ 해제
    function checkAll(checked) {
        var rowCount = AUIGrid.getRowCount(myGridID);
        if(checked) {
            // 전체 데이터를 대상으로 isActive 필드를 "Active" 값으로 변경
            AUIGrid.updateRowBlockToValue(myGridID, 0, rowCount-1, "isActive", "Active");
        } else {
            // 전체 데이터를 대상으로 isActive 필드를 "Inactive" 값으로 변경
            AUIGrid.updateRowBlockToValue(myGridID, 0, rowCount-1, "isActive", "Inactive");
        }
    };

    // 헤더렌더러 체크박스 클릭 핸들러
    function myHeaderCheckClick(event) {
        console.log("columnIndex : " + event.columnIndex + ", checked : " + event.checked);
        
        var quantity = 0;	
       	var rowCount = AUIGrid.getRowCount(myPopGridID2);
       	
       	for(var i=0; i < rowCount; i++){
       		
       		if(event.checked){
       		
       			quantity = AUIGrid.getCellValue(myPopGridID2, i, 1);
       		}       		
       		AUIGrid.setCellValue(myPopGridID2, i, event.columnIndex, quantity);
       	}
        
    };
    
    
    function setPrtmEmplSeq(){
    	
   		$.ajax({
   			url : "/cst/getPrtmEmplSeq.do", 
   			type : 'POST', 
   			data : {},
   			success : function(data) {
   				
   				let selHtml = "";
   				$.each(data, function(index, item){
					selHtml = selHtml  + "<option value='"+item.prmtEmplSeq+"'>"+item.prmtEmplNm+"</option>";
				});
   				
   				$("#prmtEmplSeq").html(selHtml);   				
   				$("#prmtEmplSeq").show();
   				
   			}, // success 
   			error : function(xhr, status) {
   				console.log(xhr + " : " + status);
   			}
   		});
    }
    
    function getSearchPrdList(){
    	
   		$.ajax({
   			url : "/cst/selectPopPrdSearchList.do", 
   			type : 'POST', 
   			data : {"prdSearchValue" : $("#prdSearchValue").val(), "cstSeq" : $("#targetCstSeq").val()},
   			success : function(data) {
   				
   				console.log("selectPopPrdSearchList data : " + JSON.stringify(data));
   				
   				AUIGrid.setGridData(myPopGridID1, data);
   				   				
   			}, // success 
   			error : function(xhr, status) {
   				console.log(xhr + " : " + status);
   			}
   		});
    }
    
    
    
</script>

<body>
<!-- 신규 제품추가 -->
    <div class="modal_bg" ></div> <!-- modal 배경 -->
    <div class="popWrap largeLong modal_wrap h870" data-popup="modalAgencyViews" id="bodyTile" >
        <header>
            <h3>신규 제품추가</h3>            
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3 class="pb10">신규 제품추가</h3>
    
                <div class="popBtnArea">
                    <button type="button" name="" class="comBtn modalCloseBtn" id="newModalCloseBtn">닫기</button>
                    <button type="button" name="" class="inquBtn" id="btnNewPrdSave">저장</button>
                </div>
            </div>
            <div class="conBox mt5">
            <form name="prdFrm" id="prdFrm">	
            	<input type="hidden" name="prdDtlCd" value="" id="prdDtlCd" />
            	<input type="hidden" name="prdSeq" value="" id="prdSeq" />
            	<input type="hidden" name="prdDtlSeq" value="" id="prdDtlSeq" />
            	<input type="hidden" name="shtnNm" value="" id="shtnNm" />
            	<input type="hidden" name="untpc" value="" id="untpc" />
            	<input type="hidden" name="cstSeq" value="" id="cstSeq" />
            	<input type="hidden" name="puchSeq" value="" id="puchSeq" />
            	<input type="hidden" name="areaSeq" value="" id="areaSeq" />
                <!-- 계약 정보 -->
                <div class="tblWrap">
                    <div class="titleArea right">
                        <h3 class="tit01">계약 정보</h3>
                        <p class="txt01"><i class="icoRequir"></i>필수 입력 항목입니다.</p>
                    </div>
                    
                    <table class="tbl">
                        <caption>계약 정보</caption>
                        <colgroup>
                            <col style="width:164px;">
                            <col>
                            <col style="width:164px;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">
                                    <label for="datepicker" class="required" title="필수입력">가입경로</label>
                                </th>
                                <td colspan="3">                                    
                                    <div class="formWrap jStart">
                                    	<code:makeSelect commGrpCd="CST_COS_CD" var="cstCosCdList" name="cstCosCd" all="false" classNm="sel w160 mr7" />	                            
		                        			${cstCosCdList}
                                        
                                        <select name="prmtEmplSeq" class="sel w160" id="prmtEmplSeq" value="">                                            
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="datepicker" class="required" title="필수입력">판촉일자</label>
                                </th>
                                <td>
                                    <div class="formWrap">
                                        <div class="dateWrap">
                                            <input type="text" name="prmtDt" value="10/24/1984" class="inp w160 datepicker" id="prmtDt" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="prmtDt"></button>
                                        </div>
                                    </div>
                                </td>
                                <th>
                                     <label for="datepicker" class="required" title="필수입력">투입일자</label>
                                </th>
                                <td>
                                    <div class="formWrap jStart alignCenter">
                                        <div class="dateWrap">
                                            <input type="text" name="inptDt" value="10/24/1984" class="inp w160 datepicker" id="inptDt" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="inptDt"></button>
                                        </div>
                                        <!-- <div class="checkGroup ml20">
                                            <input type="checkbox" id="stdPrdNm01" class="type01"><label for="stdPrdNm01"><span>출고증 인쇄 안함</span></label>
                                        </div> -->
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                     <label for="datepicker" class="required" title="필수입력">계약기간</label>
                                </th>
                                <td colspan="3">
                                    <div class="formWrap" style="justify-content: flex-start; align-items: center;">
                                        <div class="dateWrap">
                                            <input type="text" name="statDt" value="10/24/1984" class="inp w160 datepicker" id="statDt" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="statDt"></button>
                                        </div>
                                        <span class="divi02">~</span>                                        
                                        <div class="dateWrap">
                                            <input type="text" name="endDt" value="10/24/1984" class="inp w160 " id="endDt" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="endDt"></button>
                                        </div>
                                        <div class="ml30">
                                            <select name="cntrMonth" class="sel w160" id="cntrMonth" value="">
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
                                            </select>
                                            <span class="ml5 vaMd">개월(무료 0개월)</span>
                                        </div>                                        
                                        <div class="checkGroup ml20">
                                            <input type="checkbox" id="noCntr" class="type01"><label for="noCntr"><span>무계약</span></label>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="inp_prNm02" class="required" title="필수입력">제품명</label>
                                </th>
                                <td>
                                    <div class="formWrap jStart alignCenter">
                                        <div class="postWrap w160">
                                            <input type="text" id="prdSearchValue" class="inp">
                                            <button type="button" class="postBtn" id="btnSearchPrd" title="찾기"></button>
                                        </div>
                                    </div>
                                    
                                    <!-- grid -->
                                    <div class="girdBox mt14 mb20">
                                        <div id="grid_wrap1_pop" style="width: 100%; height: 180px;"></div>
                                    </div>
                                    <!-- grid -->
                                </td>
                                <th scope="row" rowspan="2">
                                    <label for="memo01" class="required" title="필수입력">투입패턴</label>
                                </th>
                                <td rowspan="2">
                                    <!-- grid -->
                                    <div class="girdBox">
                                        <div id="grid_wrap2_pop" style="width: 100%; height: 206px;"></div>
                                    </div>
                                    <!-- grid -->
                                </td>                                
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="inp_prNm">지역 애음자단가</label>
                                </th>
                                <td colspan="3">
                                    <div class="formWrap jStart alignCenter">
                                        <input type="text" id="areaCstUntpc" class="inp w160 bg_gray ar pColor01" value="" name="areaCstUntpc" readonly>
                                        <span class="ml5 vaMd">원</span>
                                    </div>
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <!--// 계약 정보 -->

                <!-- 판촉정보 -->
                <div class="tblWrap">
                    <div class="titleArea right">
                        <h3 class="tit01">판촉정보</h3>
                        <p class="txt01"><i class="icoRequir"></i>필수 입력 항목입니다.</p>
                    </div>
                    <table class="tbl">
                        <caption>판촉정보</caption>
                        <colgroup>
                            <col style="width:164px;">
                            <col>
                            <col style="width:164px;">
                            <col>
                        </colgroup>
                        <tbody>
                             <tr>
                                <th scope="row">
                                    <label class="required" title="필수입력">무료/할인</label>
                                </th>
                                <td>
                                    <!-- 판촉일 경우 -->
                                    <div class="formWrap jStart alignCenter">
                                        <select name="prmtSecCd" class="sel w160 mr20" id="prmtSecCd" value="">
                                        	<option value="dsct" selected>할인</option>
                                            <option value="free">무료</option>                                            
                                        </select>
                                        <button type="button" name="" class="comBtn small" id="btnFreeDsctPop2">추가</button>
                                    </div>
                                    <!--// 판촉일 경우 -->
                                </td>
                                <th>
                                    <label for="datepicker" class="datepicker">적용단가<br/>(애음자 개별단가)</label>
                                </th>
                                <td>
                                    <div class="formWrap jStart alignCenter">
                                        <input type="text" id="cstApplUnptc" class="inp w160 bg_gray ar pColor01" value="" name="cstApplUnptc" readonly>
                                        <span class="ml5 vaMd">원</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="inp_prNm02" class="required" title="필수입력">판촉물</label>
                                </th>
                                <td colspan="3">
                                    <div class="formWrap jStart alignCenter mb14">
                                        <div class="postWrap w160 mr20">
                                            <input type="text" id="prmtSrhValue" class="inp" name="prmtSrhValue" >
                                            <button type="button" class="postBtn" title="찾기" id="btnPrmtSrh"></button>
                                        </div>
                                        <button type="button" name="" class="comBtn small" id="btnSetPrmtPrd" >추가</button>
                                    </div>
                                    <!-- 무료 -->
                                    <!-- <div class="formWrap jStart alignCenter mb14">
                                        <select name="" class="sel w160 mr7" id="inp_prDt" value="제품">
                                            <option selected="">무료</option>
                                            <option>투입패턴</option>
                                            <option>수량</option>
                                            <option>단가</option>
                                        </select>
                                        <div class="postWrap w160 mr10">
                                            <input type="text" id="inp_prNm02" class="inp">
                                        </div>
                                        <span class="vaMd mr7">개월</span>
                                        <div class="dateWrap ml5">
                                            <input type="text" name="date" value="10/24/1984" class="datepicker inp w160" id="datepicker05" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker05"></button>
                                        </div>
                                    </div> -->
                                    <!--// 무료 -->

                                    <!-- 할인 -->
                                    <!-- <div class="formWrap jStart alignCenter mb14">
                                        <select name="" class="sel w160 mr7" id="inp_prDt" value="제품">
                                            <option selected="">할인</option>
                                            <option>투입패턴</option>
                                            <option>수량</option>
                                            <option>단가</option>
                                        </select>
                                        <div class="postWrap w160 mr10">
                                            <input type="text" id="inp_prNm02" class="inp">
                                        </div>
                                        <span class="vaMd mr7">%</span>
                                    </div> -->
                                    <!--// 할인 -->

                                    <!-- 상품 -->
                                    <!-- <div class="formWrap jStart alignCenter mb14">
                                        <div class="postWrap w160">
                                            <input type="text" id="inp_prNm02" class="inp">
                                            <button type="button" class="postBtn" title="찾기"></button>
                                        </div>
                                        <button type="button" name="" class="comBtn ml20" id="inp_name01">추가</button>
                                    </div> -->
                                    <!-- 상품 -->

                                    <!-- grid -->
                                    <div class="formWrap mb20 jBetween">
                                        <div class="girdBox w50per mr20">
                                            <div id="grid_wrap3_pop" style="width: 100%; height:185px;"></div>
                                        </div>
                                        <div class="girdBox w50per">
                                            <div id="grid_wrap4_pop" style="width: 100%; height:185px;"></div>
                                        </div>                                        
                                    </div>
                                     <!-- grid -->
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!--// 계약 정보 -->
                </form>                
            </div>
        </div>
        <!-- popCon -->
    </div>
    <!--// 신규 제품추가 -->

</body>
</html>