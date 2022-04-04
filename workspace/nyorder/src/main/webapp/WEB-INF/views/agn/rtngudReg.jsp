<!-- 
	@File Name: rtngudReg
	@File 설명 : 반품등록
	@UI ID : UI-PORD-0302.html
	@작성일 : 2022.01.21
	@작성자 : 김정애
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
     var myGridID;
     var selRowIndex;
     var popupParam = {};
     var addedRowCount = 0;

		$(document).ready(function () {

         createAUIGrid(columnLayout);

		// 바인딩
		$("#selectBtn").on("click", fnSearchList);
		$("#saveBtn").on("click", fnSaveRtgd);   

		// 매달 25일이 넘어가면 저장, 전송 버튼 비활성화 처리
		var today = new Date();
		var day = today.getDate();
		if(day > 25){
			$("#saveBtn").attr("disabled",true);
			$("#sendBtn").attr("disabled",true);
		} 

		let popupObjSend = {};
        popupObjSend.title = "반품 등록";
        popupObjSend.message = '<spring:message code="alert.msgRtgdReg9" />';        
        popupObjSend.showBtn1 = 'Y';
        popupObjSend.btn1Func = fnSendRtgd;        
        popupObjSend.showBtn2 = 'Y';
		$("#sendBtn").on("click", popupObjSend, layerAlert);  

		let popupObjStdPrd = {};
        popupObjStdPrd.title = "반품 등록";
        popupObjStdPrd.message = '<spring:message code="alert.msgRtgdReg4" />';        
        popupObjStdPrd.showBtn1 = 'Y';
        popupObjStdPrd.btn1Func = fnStdPrdList;        
        popupObjStdPrd.showBtn2 = 'Y';
		$("#stdPrdBtn").on("click", popupObjStdPrd, layerAlert);		 

		let popupObjPrevRtgd = {};
        popupObjPrevRtgd.title = "반품 등록";
        popupObjPrevRtgd.message = '<spring:message code="alert.msgRtgdReg4" />';        
        popupObjPrevRtgd.showBtn1 = 'Y';
        popupObjPrevRtgd.btn1Func = fnPrevRtgdList;        
        popupObjPrevRtgd.showBtn2 = 'Y';
		$("#prevRtgdBtn").on("click", popupObjPrevRtgd, layerAlert);	

		$("#addRowBtn").on("click", addRow);        
		
        let popupObjRemRow = {};
        popupObjRemRow.title = "반품 등록";
        popupObjRemRow.message = '<spring:message code="alert.msgRtgdReg7" />';        
        popupObjRemRow.showBtn1 = 'Y';
        popupObjRemRow.btn1Func = removeRow;        
        popupObjRemRow.showBtn2 = 'Y';        
        $("#removeRowBtn").on("click", popupObjRemRow, layerAlert);
        
		AUIGrid.bind(myGridID, "cellEditEnd", auiCellEditingHandler);

		AUIGrid.bind(myGridID, "cellClick", function(event) {
			if((event.dataField == "prdDtlCd" || event.dataField == "prdNm")){
				selRowIndex = event.rowIndex;
				fnStdPrdPop();
			}
		});
		
		// 데이터 조회
		//fnSearchList();
		AUIGrid.clearGridData(myGridID);
        AUIGrid.setFooter(myGridID, footerLayout);
     });

     // AUIGrid 를 생성합니다.
     function createAUIGrid(columnLayout) {
         // 그리드 속성 설정
         var gridPros = {
             headerHeight : 29,
             rowHeight: 29,
             // 편집 가능 여부 (기본값 : false)
             editable: true,
             rowIdField : "rownum",
             wrapSelectionMove : true,

             // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
             enterKeyColumnBase: true,

             // 셀 선택모드 (기본값: singleCell)
             selectionMode: "singleRow",
             showFooter: true,

             // 컨텍스트 메뉴 사용 여부 (기본값 : false)
             useContextMenu: true,

             // 필터 사용 여부 (기본값 : false)
             enableFilter: true,

             // 그룹핑 패널 사용
             useGroupingPanel: false,

             // 상태 칼럼 사용
             showStateColumn: false,

             // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
             displayTreeOpen: true,

             noDataMessage: "출력할 데이터가 없습니다.",

             groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",


             // 삭제 행 표시 기능 없이 삭제와 동시에 그리드에서 제거할때 (기본값:true)
             softRemoveRowMode: false,


            /*********************************/ 
            /* 행삭제할때 체크박스 사용 관련 추가 시작 */
            /*********************************/

     		// 엑스트라 체크박스 표시 설정
     		showRowCheckColumn : true,
     		
     		// 엑스트라 체크박스에 shiftKey + 클릭으로 다중 선택 할지 여부 (기본값 : false)
     		enableRowCheckShiftKey : true,
     		
     		// 전체 체크박스 표시 설정
     		showRowAllCheckBox : true,             

     		/*********************************/
     		/* 행삭제할때 체크박스 사용 관련 추가 종료 */
     		/*********************************/
 			
         };

         // 실제로 #grid_wrap 에 그리드 생성
         myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
     }

     var columnLayout = [
   	 {
            dataField: "rownum",
            visible:false
	}, {
         dataField: "ordRtgdSeq",
         visible:false
     }, {
         dataField: "prdDtlCd",
         headerText: "제품코드",
         width: "7%",
         renderer : { // HTML 템플릿 렌더러 사용
    		type : "TemplateRenderer"
         },
         // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
         labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
             if(item.prdDtlCd){
                 var template = item.prdDtlCd
             }else{
                 var template = '<div class="searchWrap">';
                 template += '<span class="my_div_text_box"><a href="#" class="serach popBtn" data-id="modalAgencyViews"></a></span>';
                 template += '</div>';
             }
             return template;
         }
     }, {
         dataField: "prdNm",
         headerText: "제품명",
         style: "auiLeft",
         renderer : {
    		type : "TemplateRenderer"
         },
         labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
             if(item.prdNm || item.prdDtlCd){
                 var template = item.prdNm
             }else{
                 var template = '<div class="searchWrap">';
                 template += '<span class="my_div_text_box"><a href="#" class="serach"></a></span>';
                 template += '</div>';
             }
             return template;
         }
     }, {
         dataField: "delFlag",
         headerText: "삭제<br/>구분",
         width: "5%",
     }, {
         dataField: "errFlag",
         headerText: "오류<br/>여부",
         width: "4.5%",
     }, {
         dataField: "faltQty",
         headerText: "입수량",
         width: "5%",
         style: "auiRight"
     },{
         dataField: "ordStusQty",
         headerText: "반품수량",
         children: [{
             dataField: "reqBoxQty",
             headerText: "BOX",
             width: "6%",
             style: "auiRight",
             renderer : { // HTML 템플릿 렌더러 사용
        		type : "TemplateRenderer"
             },
             // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
             labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
                 var template = '<div class="my_div">';
                 template += '<span class="my_div_text_box right">' + value + '</span>';
                 template += '</div>';
                 return template;
             }
         }, {
             dataField: "reqIddyQty",
             headerText: "낱봉",
             width: "6%",
             style: "auiRight",
             renderer : { // HTML 템플릿 렌더러 사용
        		type : "TemplateRenderer"
             },
             // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
             labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
            	 var template = '<div class="my_div">';
                 template += '<span class="my_div_text_box right">' + value + '</span>';
                 template += '</div>';
                 return template;
             }
         }, {
             dataField: "reqQty",
             headerText: "총 수량",
             width: "6%",
             style: "auiRight",
             renderer : { // HTML 템플릿 렌더러 사용
        		type : "TemplateRenderer"
             },
             // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
             labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
                 var template = '<div class="my_div">';
                 template += '<span class="my_div_text_box right">' + value + '</span>';
                 template += '</div>';
                 return template;
             }			
         }]
     },{
         dataField: "untpc",
         headerText: "반품<br/>단가",
         dataType : "numeric",
         width: "9%",
         style: "auiRight"
     }, {
         dataField: "taxtCd",
         headerText: "과/면세",
         dataType : "numeric",
         visible:false
     }, {    	 
         dataField: "total",
         headerText: "합계",
         children: [{
             dataField: "spprc",
             headerText: "공급가",
             dataType : "numeric",
             width: "6%",
             style: "auiRight"
         }, {
             dataField: "vatSpprc",
             headerText: "VAT",
             dataType : "numeric",
             width: "6%",
             style: "auiRight",
         },{
             dataField: "totAmount",
             headerText: "計",
             dataType : "numeric",
             width: "6%",
             style: "auiRight"
         }]
     }, {
         dataField: "trnstYn",
         headerText: "전송<br/>여부",
         width: "6%",
     }, {
         dataField: "errMsg",
         headerText: "에러 메세지",
         style: "auiLeft"
     }];

     // 푸터 설정
     var footerLayout = [{
         labelText: "∑",
         positionField: "#base"
     }, {
         dataField: "code",
         positionField: "code",
         operation: "SUM",
         colSpan: 6, // 자신을 포함하여 6개의 푸터를 가로 병합함.
         labelFunction: function (value, columnValues, footerValues) {
             //return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
             return "합계 : "
         }
     }, {
         dataField: "reqBoxQty",
         positionField: "reqBoxQty",
         operation: "SUM",
         style: "auiRight",
         colSpan: 1,
         labelFunction: function (value, columnValues, footerValues) {
             return " " + AUIGrid.formatNumber(value, "#,##0");
         }
     }, {
         dataField: "reqIddyQty",
         positionField: "reqIddyQty",
         operation: "SUM",
         style: "auiRight",
         colSpan: 1,
         labelFunction: function (value, columnValues, footerValues) {
             return " " + AUIGrid.formatNumber(value, "#,##0");
         }
     }, {
         dataField: "reqQty",
         positionField: "reqQty",
         operation: "SUM",
         style: "auiRight",
         colSpan: 1,
         labelFunction: function (value, columnValues, footerValues) {
             return " " + AUIGrid.formatNumber(value, "#,##0");
         }
     },{
         dataField: "spprc",
         positionField: "spprc",
         operation: "SUM",
         style: "auiRight",
         colSpan: 1,
         labelFunction: function (value, columnValues, footerValues) {
             return " " + AUIGrid.formatNumber(value, "#,##0");
         }     
     },{
         dataField: "vatSpprc",
         positionField: "vatSpprc",
         operation: "SUM",
         style: "auiRight",
         colSpan: 1,
         labelFunction: function (value, columnValues, footerValues) {
             return " " + AUIGrid.formatNumber(value, "#,##0");
         }
     },{
         dataField: "totAmount",
         positionField: "totAmount",
         operation: "SUM",
         style: "auiRight",
         colSpan: 1,
         labelFunction: function (value, columnValues, footerValues) {
             return " " + AUIGrid.formatNumber(value, "#,##0");
         }
     }];
     
     //행추가
     var cnt = 0;
     function addRow(rowPos) {

 		if(addedRowCount > 4)
		{
			alert('행추가는 최대 5개까지 가능합니다.\r\n저장 후 다시 행추가 작업할 수 있습니다.');
			return;
		}
		
  		var trnstYn = fnCheckRtgdSend();
  	 	if(trnstYn == 'Y'){
 			popupParam.data = {
 				title : "반품 등록",
 		 	 	message : "<spring:message code='alert.msgRtgdReg11' />",
 		 	 	showBtn2 : 'N'
 			};
 	 		layerAlert(popupParam);
 			return;
 		}
  	 	
         var item = new Object();
         AUIGrid.addRow(myGridID, item, rowPos);
         addedRowCount++;		
     }

     // 행 삭제
     function removeRow() {

		var trnstYn = fnCheckRtgdSend();
   	 	if(trnstYn == 'Y'){
  			popupParam.data = {
  				title : "반품 등록",
  		 	 	message : "<spring:message code='alert.msgRtgdReg11' />",
  		 	 	showBtn2 : 'N'
  			};
  	 		layerAlert(popupParam);
  			return;
  		}

    	 var checkedItems = AUIGrid.getCheckedRowItems(myGridID);
		if(checkedItems.length <= 0) {
			// 체크박스 선택여부 확인하기
			var popupMsgParam = {};
			popupMsgParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg6' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupMsgParam);
			return;			
		}

		var rowItem;
		for(var i=checkedItems.length-1; i>=0; i--) {
			rowItem = checkedItems[i];
			AUIGrid.removeRow(myGridID, rowItem.rowIndex);
		}
     }

   	// 수량변경 계산 처리
 	function auiCellEditingHandler(event) {
     	 var item = event.item;

 		var faltQty =  0;		//입수량
     	var reqBoxQty = 0;		//수량 box
 		var reqIddyQty = 0;		//수량 낱봉
 		var reqQty = 0;			//총수량
 		var untpc = 0;			//단가

 		var totAmount = 0;
 		var amount = 0;
 		var taxAmount = 0;		// 과세, 면세에 따른 계산방식 확인 필요함!!!		

 		// box/낱봉 수량변경에 따른 총수량 변경  
 		if(event.dataField == "reqBoxQty" || event.dataField == "reqIddyQty")
 		{
 			reqBoxQty = ( Number(item.reqBoxQty) ) ? Number(item.reqBoxQty) : 0;		
 			reqIddyQty = ( Number(item.reqIddyQty) ) ? Number(item.reqIddyQty) : 0;		
 			faltQty = ( Number(item.faltQty) ) ? Number(item.faltQty) : 0;				
 			reqQty = Number( (faltQty * reqBoxQty) + reqIddyQty);
 			
 			AUIGrid.updateRow(myGridID, {'reqQty': reqQty}, event.rowIndex);

 			untpc = ( Number(item.untpc) ) ? Number(item.untpc) : 0;	
 		}
 		// 총수량 변경에 따른 box/낱봉 수량 변경
 		else if(event.dataField == "reqQty")
 		{
 			reqQty = Number(event.value);
 			faltQty = ( Number(item.faltQty) ) ? Number(item.faltQty) : 0;					
 			reqBoxQty = (faltQty != 0 ? Math.floor(Number(reqQty / item.faltQty)) : 0);		
 			reqIddyQty = (faltQty != 0 ? Number(reqQty % item.faltQty) : 0);				

 			AUIGrid.updateRow(myGridID, {'reqBoxQty': reqBoxQty}, event.rowIndex);
 			AUIGrid.updateRow(myGridID, {'reqIddyQty': reqIddyQty}, event.rowIndex);

 			untpc = ( Number(item.untpc) ) ? Number(item.untpc) : 0;	
 		}

 		//금액 변경
 		if(event.dataField == "reqBoxQty" 
 	 		|| event.dataField == "reqIddyQty" 
			|| event.dataField == "reqQty"
 	 		)
 		{	
 			totAmount = Number(reqQty * untpc);
 			spprc = Math.round(Number(totAmount * 0.9));
 			vatSpprc = Math.round(Number(totAmount * 0.1));

 			AUIGrid.updateRow(myGridID, {'spprc': spprc}, event.rowIndex);
 			AUIGrid.updateRow(myGridID, {'vatSpprc': vatSpprc}, event.rowIndex);
 			AUIGrid.updateRow(myGridID, {'totAmount': totAmount}, event.rowIndex);			
 		}		
 	}     

 	function fnSearchList(){

		if($("#rtgdSec").val() == ''){
			popupParam.data = {
					title : "반품 등록",
			 	 	message : "<spring:message code='alert.msgRtgdReg3' />",
			 	 	showBtn2 : 'N'
				};
		 		layerAlert(popupParam);
			return;
		}
 	 	
		$.ajax({
			url : "/agn/selectRtgdRegList.do", 
			type : 'POST', 
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#listCnt").text(data.cnt);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}

 	function fnStdPrdList(){

		var trnstYn = fnCheckRtgdSend();
   	 	if(trnstYn == 'Y'){
  			popupParam.data = {
  				title : "반품 등록",
  		 	 	message : "<spring:message code='alert.msgRtgdReg11' />",
  		 	 	showBtn2 : 'N'
  			};
  	 		layerAlert(popupParam);
  			return;
  		}
  		 	 	
		$.ajax({
			url : "/agn/selectStdPrdList.do", 
			type : 'POST', 
			data : null,
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#listCnt").text(data.cnt);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}	

 	function fnPrevRtgdList(){

		var trnstYn = fnCheckRtgdSend();
   	 	if(trnstYn == 'Y'){
  			popupParam.data = {
  				title : "반품 등록",
  		 	 	message : "<spring:message code='alert.msgRtgdReg11' />",
  		 	 	showBtn2 : 'N'
  			};
  	 		layerAlert(popupParam);
  			return;
  		}
  		
		$.ajax({
			url : "/agn/selectPrevRtgdList.do", 
			type : 'POST', 
			data : null,
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#listCnt").text(data.cnt);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}	


 	function fnSaveRtgd(){

		var trnstYn = fnCheckRtgdSend();
 	 	if(trnstYn == 'Y'){
			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg11' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}

 		var rtgdSec = $("#rtgdSec").val();
 		var monthPicker = $("#monthPicker").val().replace('-','');
		
		var saveData = new Array();
		$.each(AUIGrid.getGridData(myGridID), function(idx,item){	
			if(item.reqQty > 0)
			{
				// 추가, 수정할 데이터
				item.crudMode = "M";
				item.rtgdSec = rtgdSec;
				saveData.push(item);			
			}	
		});

        $.each(AUIGrid.getRemovedItems(myGridID), function(idx,item){	
			// 삭제할 데이터
			item.crudMode = "D";
			item.rtgdSec = rtgdSec;
			saveData.push(item);	
		});
        
		if(saveData.length == 0){
			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg10' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}

		if($("#rtgdSec").val() == ''){
			popupParam.data = {
					title : "반품 등록",
			 	 	message : "<spring:message code='alert.msgRtgdReg3' />",
			 	 	showBtn2 : 'N'
				};
		 		layerAlert(popupParam);
			return;
		}

		/* 저장 이벤트 호출시 날짜 체크 시작 */
		var today = new Date();
	    var year = today.getFullYear();
	    var month = ("0" + (1 + today.getMonth())).slice(-2);	    

		if($("#rtgdSec").val() == '201' && today.getDate() > 20){
			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg1' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}
		if($("#rtgdSec").val() == '202' && today.getDate() > 25){

			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg2' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}
		/* 저장 이벤트 호출시 날짜 체크 종료 */
		
		$.ajax({
			url : "/agn/saveRtgdReg.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(saveData),
			success : function(data) {

				popupParam.data = {
					title : "반품 등록",
			 	 	message : "<spring:message code='alert.msgRtgdReg8' />",
			 	 	showBtn2 : 'N'
				};
		 		layerAlert(popupParam);
				
				//리스트 조회
				fnSearchList();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	 	
	}
	
 	function fnSendRtgd(){

		// 전송여부 체크
 		var trnstYn = fnCheckRtgdSend();
 	 	if(trnstYn == 'Y'){
			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg11' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}

		// 저장된 데이터 체크
 		var savedYn = fnCheckRtgdSaved();
 	 	if(savedYn == 'N'){
			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg12' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}
		
 		// 전송할 데이터 체크
		var saveData = new Array();
		$.each(AUIGrid.getGridData(myGridID), function(idx,item){	
			if(item.reqQty > 0)
			{
				// 추가, 수정할 데이터
				item.crudMode = "M";
				item.rtgdSec = rtgdSec;
				saveData.push(item);			
			}	
		});
        
		if(saveData.length == 0){
			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg10' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}
 	 	
		/* 전송 이벤트 호출시 날짜 체크 시작 */
		var today = new Date();
	    var year = today.getFullYear();
	    var month = ("0" + (1 + today.getMonth())).slice(-2);	    

		if($("#rtgdSec").val() == '201' && today.getDate() > 20){
			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg1' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}
		if($("#rtgdSec").val() == '202' && today.getDate() > 25){
			popupParam.data = {
				title : "반품 등록",
		 	 	message : "<spring:message code='alert.msgRtgdReg2' />",
		 	 	showBtn2 : 'N'
			};
	 		layerAlert(popupParam);
			return;
		}
		if(today.getDate() >= 26){
			alert("반품전송 기간이 경과되어 반품전송 불가합니다.");
		}
		/* 저장 이벤트 호출시 날짜 체크 종료 */

		$.ajax({
			url : "/agn/sendRtgdReg.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(AUIGrid.getGridData(myGridID)),
			success : function(data) {
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 			
	}

 	// 반품 전송 여부 체크 
 	function fnCheckRtgdSend(){

		// 전송(한번이라도 했는지) 여부 조회 시작
 		var trnstYn = null;
 	 	$.ajax({
			url : "/agn/selectTrnstYn.do",
			type : 'POST',
			data : $("#frm").serialize(),
			async:false,
			success : function(data) {
				trnstYn = data;
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});

		return trnstYn;
 	}

 	// 반품 저장 여부 체크 
 	function fnCheckRtgdSaved(){

		// 저장된 데이터 존재 여부 조회
 		var savedYn = null;
 	 	$.ajax({
			url : "/agn/selectSavedYn.do",
			type : 'POST',
			data : $("#frm").serialize(),
			async:false,
			success : function(data) {
				savedYn = data;
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});

		return savedYn;
 	}
 	function fnStdPrdPop(){
		$.ajaxDialog({
			id: "rtgdStdPrdPop",
			ajax: {
				url: "/agn/rtgdStdPrdPop.do",
			},
			success: function(data) {
				fnSetRowData(data);
			},			
			dialog: {
				width:800,
				height:560
			}
		});
	}
	 	
 	// 제품등록 팝업창에서 전달받은 데이터, 그리드에 update
	function fnSetRowData(gridData){
		var iCnt = 0;

 		// 행추가-선택한 제품이 기존 그리드에 존재하는지 체크하기
		$.each(AUIGrid.getGridData(myGridID), function(idx,item){
			if(item.prdDtlSeq == gridData.prdDtlSeq){
				iCnt++;
			}
		});

		if(iCnt > 0){
			popupParam.data = {
					title : "반품 등록",
			 	 	message : "<spring:message code='alert.msgRtgdReg5' />",
			 	 	showBtn2 : 'N'
				};
		 		layerAlert(popupParam);
		}else{
			AUIGrid.updateRow(myGridID, {'prdDtlSeq': gridData.prdDtlSeq}, selRowIndex);
			AUIGrid.updateRow(myGridID, {'prdDtlCd': gridData.prdDtlCd}, selRowIndex);
			AUIGrid.updateRow(myGridID, {'prdNm': gridData.prdNm}, selRowIndex);
			AUIGrid.updateRow(myGridID, {'faltQty': gridData.faltQty}, selRowIndex);
			AUIGrid.updateRow(myGridID, {'taxtCd': gridData.taxtCd}, selRowIndex);
		}
	}

</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	<!-- 조회 -->
	<form id="frm">	
		<div class="inquiryBox">
	        <dl>
	            <dt>반품월</dt>
	            <dd>
	                <div class="formWrap">
	                    <div class="dateWrap">
	                        <input type="text" name="reqYm" value="" class="inp monthPicker" id="monthPicker">
	                        <button type="button" class="datepickerBtn" title="날짜입력"></button>
	                    </div>
	                </div>
	            </dd>
	            <dt>반품유형</dt>
	            <dd>
	                <div class="formWrap">
	                	<select name="rtgdSec" class="sel mr7" id="rtgdSec">
	                        <option value="">선택</option>
	                        <option value="201">정기반품</option>
	                        <option value="202">특별반품</option>
	                    </select>
	                    <button type="button" name="" class="comBtn" id="selectBtn">조회</button>
	                </div>
	
	
	            </dd>
	        </dl>
	
	        <div class="btnGroup right">
	            <button type="button" name="" class="inquBtn" id="saveBtn">저장</button>
	            <button type="button" name="" class="inquBtn" id="sendBtn">전송</button>
	        </div>
	    </div>
	</form>	    
	<!-- 조회 -->
	
	<div class="titleArea right">
        <p class="numState">
            <em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
        </p>

        <div class="formGroup">
            <button type="button" name="" class="comBtn small" id="stdPrdBtn">표준제품 불러오기</button>
            <button type="button" name="" class="comBtn small" id="prevRtgdBtn">전월반품 불러오기</button>
            <button type="button" name="" class="comBtn small" id="addRowBtn">행추가</button>
            <button type="button" name="" class="comBtn small" id="removeRowBtn">행삭제</button>
        </div>
    </div>

    <!-- grid -->
    <div class="girdBox">
        <div id="grid_wrap"></div>
    </div>
    <!-- grid -->

</div>
