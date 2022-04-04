<!--
	@File Name: spclOrdReg
	@File 설명 : 특수처 출고의뢰 주문 등록
	@UI ID : 	UI-PORD-1001.html
	@작성일 : 2022.03.22
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
	var myGridID;//주문등록 그리드
	var myGridID3;//특수처 그리드
	
	$(document).ready(function(){
		
		$("#datepicker01").daterangepicker({
			"singleDatePicker": true,
			"showDropdowns": true,
			"changeMonth": true,
			"showMonthAfterYear": true,
			minDate : getPickerDate(),
			"locale": {
				"format": "YYYY-MM-DD",
				"separator": " - ",
				"applyLabel": "Apply",
				"cancelLabel": "Cancel",
				"fromLabel": "From",
				"toLabel": "To",
				"customRangeLabel": "Custom",
				"weekLabel": "W",
				"applyLabel": "확인",
				"cancelLabel": "취소", 
				"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
				"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				"firstDay": 1
			},
			"showCustomRangeLabel": false,
			}, function(start, end, label) {
				$("#changeDt").val( start.format('YYYYMMDD') );
		});
		
		//초기진입시 날짜 설정
		var dlvDt = $("#datepicker01").val().replace('-','').replace('-','');
		//출고요청일
		$("#dlvDt").val( dlvDt );
		//주문일
		$("#ordDt").val( getToday() );
		
		// AUIGrid 생성 후 반환 ID
		createAUIGrid();
		
		//특수처 리스트 조회
		selectSchlList();
		
		//여신잔액 조회
		getCdtlInfo(setCdtlInfo);
		
		AUIGrid.setFooter( myGridID , footerLayout );
		
		//행추가 이벤트
		$("#addRowBtn").click(function(){
			if( !$("#vendSeq").val() ){
				var popupParam = [];
				popupParam.data = {
						title : "특수처 출고의뢰 주문등록",
						message : "<spring:message code='alert.ordReg16'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			var item = {};
			item.applYn = "N";
			//그리드 행추가
			AUIGrid.addRow(myGridID , item , "frist");
		});

		//행삭제 이벤트
		$("#removeRowBtn").click(function(){
			var popupParam = [];
			if( !$("#vendSeq").val() ){
				popupParam.data = {
						title : "특수처 출고의뢰 주문등록",
						message : "<spring:message code='alert.ordReg16'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			var checkedItems = AUIGrid.getCheckedRowItems(myGridID);
			if(checkedItems.length <= 0) {
				// 체크박스 선택여부 확인하기
				popupParam.data = {
						title : "특수처 출고의뢰 주문등록",
						message : "<spring:message code='alert.ordReg4'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			popupParam.data = {
					title : "특수처 출고의뢰 주문등록",
					message : "<spring:message code='alert.ordReg5'/>",
					showBtn1 : 'Y',
					btn1Func : removeRowItem,
					showBtn2 : 'Y'
			}
			
			layerAlert(popupParam);
			return;
		});
		
		//일괄반영 이벤트
		$("#batchBtn").click(function(){
			if( !$("#vendSeq").val() ){
				var popupParam = [];
				popupParam.data = {
						title : "특수처 출고의뢰 주문등록",
						message : "<spring:message code='alert.ordReg16'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			if( $("#batch").val() == "reset" ){
				$.each(AUIGrid.getGridData(myGridID), function(k,v){
					AUIGrid.restoreEditedRows(myGridID, k);
				});
			}
		});
		
		//주문등록 그리드 제품조회 셀 클릭 이벤트
		AUIGrid.bind(myGridID, "cellClick", function(event) {
			var popupParam = [];
			var col = AUIGrid.getSelectedIndex( myGridID );
			var item = AUIGrid.getItemByRowIndex(myGridID, event.rowIndex);
			var id = AUIGrid.getDataFieldByColumnIndex( myGridID,col[1]);
			
			if( id == "prdSapCd" && !item.prdSapCd ){
				//제품조회 팝업 오픈
				$.ajaxDialog({
					id: "stdPrdPop",
					visibility: "visible", 
					openComplete: function() {
						//$("#testValue").focus();
					},
					success: function(data) {
					},
					ajax: {
						url: "/agn/stdPrdPop.do",
						method: "get",
						async: false
					},
					dialog: {
						modal: true,
						width:1600,
						height:800
					}
				});
			} else if ( id == "myQuantity01" || id == "myQuantity02" ){
				if( item.ordUseYn == 'Y'  && item.iddyUntYn == 'N' ){
					//해당제품은 낱봉주문이 불가한 제품입니다.\n다시 확인해 주세요.
					popupParam.data = {
							title : "특수처 출고의뢰 주문등록",
							message : "<spring:message code='alert.ordReg6'/>",
							showBtn2 : 'N'
					}
					layerAlert(popupParam);
					return false;
				}else if( item.ordUseYn == 'N' ){
					//해당제품은 주문이 불가한 제품입니다.\n대체상품은 <공지사항>을 확인해 주세요.
					popupParam.data = {
							title : "특수처 출고의뢰 주문등록",
							message : "<spring:message code='alert.ordReg7'/>",
							showBtn2 : 'N'
					}
					layerAlert(popupParam);
					return false;
				}
			}
		});
		
		//전송버튼 이벤트
		$("#sendBtn").click(function(){
			var popupParam = [];
			if( !$("#vendSeq").val() ){
				popupParam.data = {
						title : "특수처 출고의뢰 주문등록",
						message : "<spring:message code='alert.ordReg16'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			//주문저장 내역 조회
			selectOrderCnt();
		});

		AUIGrid.bind(myGridID, "cellEditBegin", function(event) {
			var item = event.item;
			if ( event.dataField == "myQuantity01" || event.dataField == "myQuantity02" ){
				if( item.ordUseYn == 'Y'  && item.iddyUntYn == 'N' ){
					return false;
				}else if( item.ordUseYn == 'N' ){
					return false;
				}
				if( !item.myQuantity01 ) return false;
				if( !item.myQuantity02 ) return false;
			}
		});
		
		//저장버튼 클릭이벤트
		$("#saveBtn").on("click",function(){
			var popupParam = [];
			if( !$("#vendSeq").val() ){
				popupParam.data = {
						title : "특수처 출고의뢰 주문등록",
						message : "<spring:message code='alert.ordReg16'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			popupParam.data = {
					title : "특수처 출고의뢰 주문등록" ,
					message : "<spring:message code='alert.ordReg8'/>" ,
					showBtn1 : 'Y' ,
					btn1Func : saveOrdReg ,
					showBtn2 : 'Y'
			}
			layerAlert(popupParam);
			return;
		});
		
		//여신상세 보기 클릭이벤트
		$("#cdtlnDetailBtn").click(function(){
			//여신상세 팝업 오픈
			$.ajaxDialog({
				id: "cdtlInfoPop",
				visibility: "visible", 
				openComplete: function() {
					//$("#testValue").focus();
				},
				success: function(data) {
				},
				ajax: {
					url: "/agn/cdtlInfoPop.do",
					method: "get",
					async: false
				},
				dialog: {
					modal: true,
					width:600,
					height:370
				}
			});
		});

		//여신잔액 새로고침
		$("#cdtlnResetBtn").click(function(){
			getCdtlInfo(setCdtlInfo);
		});
		
		//조회 버튼 클릭이벤트
		$("#searchBtn").click(function(){
			var changeDt = $("#changeDt").val();
			if( changeDt ){
				$("#dlvDt").val( changeDt );
			}
			searchList();
		});
		
		AUIGrid.bind(myGridID, "cellEditEnd", function( event ) {
			var item = AUIGrid.getItemByRowIndex(myGridID, event.rowIndex);
			var col = AUIGrid.getSelectedIndex( myGridID );
			var id = AUIGrid.getDataFieldByColumnIndex( myGridID,col[1]);
			var emplCd = "<c:out value='${userInfo.emplCd}'/>";
			//var emplCd = "20001";
			
			var myQuantity01 = ( item.myQuantity01 ) ? Number( item.myQuantity01 ) : 0;
			var myQuantity02 = ( item.myQuantity02 ) ? Number( item.myQuantity02 ) : 0;
			var grfrReqBoxQty = ( item.grfrReqBoxQty ) ? Number( item.grfrReqBoxQty ) : 0;
			var grfrReqIddyQty = ( item.grfrReqIddyQty ) ? Number( item.grfrReqIddyQty ) : 0;
			
			if( emplCd == "10001" ){//점주
				if( Math.sign( myQuantity01 ) == -1 ){
					//총무 주문수량보다 박스 큰경우
					if( Math.abs(myQuantity01) > grfrReqBoxQty ){
						myQuantity01 = grfrReqBoxQty * -1;
						AUIGrid.updateRow(myGridID, {'myQuantity01': Number( myQuantity01 )}, event.rowIndex);
					}
				}
				if( Math.sign( myQuantity02 ) == -1 ){
					//총무 주문수량보다 낱봉 큰경우
					if( Math.abs(myQuantity02) > grfrReqIddyQty ){
						myQuantity02 = grfrReqIddyQty * -1;
						AUIGrid.updateRow(myGridID, {'myQuantity02': Number( myQuantity02 )}, event.rowIndex);
					}
				}
				if( id == 'myQuantity01' ) AUIGrid.updateRow(myGridID, {'storReqBoxQty': Number( myQuantity01 )}, event.rowIndex);
				if( id == 'myQuantity02' ) AUIGrid.updateRow(myGridID, {'storReqIddyQty': Number( myQuantity02 )}, event.rowIndex);
			} else if( emplCd == "20001" ){//총무
				if( id == 'myQuantity01' ) AUIGrid.updateRow(myGridID, {'grfrReqBoxQty': Number( myQuantity01 + grfrReqBoxQty )}, event.rowIndex);
				if( id == 'myQuantity02' ) AUIGrid.updateRow(myGridID, {"grfrReqIddyQty": Number(myQuantity02 + grfrReqIddyQty)} , event.rowIndex);
			}
		});

		//학교리스트 셀 클릭이벤트
		AUIGrid.bind(myGridID3 , "cellClick", function(event) {
			var item = AUIGrid.getItemByRowIndex(myGridID3, event.rowIndex);
			$("#vendSeq").val( item.vendSeq );
			searchList();
			//총무의 주문건수 조회
			selectGrfrOrdCnt();
		});
	});
	
	//주문등록 그리드 컬럼 레이아웃
	var columnLayout = [{
			dataField : "prdSapCd",
			headerText : "제품코드",
			width : "8%",
			editable : false,
			renderer : {
				type : "TemplateRenderer"
			},
			labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
				if( item.prdSapCd && !item.applYn ){
					var template = item.prdSapCd;
				}
				if(item.applYn == "N" ){
					var template = '<div class="searchWrap">';
					template += '<span class="my_div_text_box">'+value+'<a href="javascript:void(0);" class="serach popBtn" data-prd-type="prdSapCd"></a></span>';
					template += '</div>';
				}
				return template;
			}
		},{
			dataField : "prdNm",
			headerText : "제품명",
			style : "auiLeft",
			editable : false
		},{
			dataField : "untpc",
			headerText : "매입<br/>단가",
			dataType : "numeric",
			width : "5%",
			style : "auiRight",
			formatString : "#,##0",
			editable : false
		},{
			dataField : "faltQty",
			headerText : "BOX<br/>입수량",
			width : "6%",
			style: "auiRight",
			dataType : "numeric",
			formatString : "#,##0",
			editable : false
		},{
			dataField : "singleStd",
			headerText : "낱봉<br/>기준",
			width : "5%",
			style: "auiRight",
			editable : false
		},{
			dataField : "iddyUntYnTx",
			headerText : "낱봉<br/>가능<br>여부",
			width : "5%",
			editable : false
		},{
			dataField : "myQuantity",
			headerText : "내 입력수량",
				children : [{
					dataField : "myQuantity01",
					headerText : "BOX",
					width : "4%",
					style: "auiRight",
					editable : true,
					renderer : {
						type : "TemplateRenderer"
					},
					// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
					labelFunction : function ( rowIndex, columnIndex, value, headerText, item , dataField, cItem ) {
						if(!value)	return "";
						var template = '<div class="my_div">';
						template += '<span class="my_div_text_box center">' + value + '</span>';
						template += '</div>';
						return template;
					}
				}, {
					dataField : "myQuantity02",
					headerText : "낱봉",
					width : "4%",
					style: "auiRight",
					editable : true,
					renderer : {
						type : "TemplateRenderer"
					},
					labelFunction : function ( rowIndex, columnIndex, value, headerText, item , dataField, cItem ) {
						if(!value)	return "";
						var template = '<div class="my_div">';
						template += '<span class="my_div_text_box center">' + value + '</span>';
						template += '</div>';
						
						return template;
					}
				}, {
					dataField : "myQuantity03",
					headerText : "총수량",
					colSpan : 2,
					width : "4%",
					style: "auiRight",
					headerStyle: "auiBorR",
					editable : false,
					expFunction : function(  rowIndex, columnIndex, item, dataField ) {
						var myQuantity01 = ( Number(item.myQuantity01) ) ? Number(item.myQuantity01) : 0;//내입력수량 box
						var myQuantity02 = ( Number(item.myQuantity02) ) ? Number(item.myQuantity02) : 0;//내입력수량 낱봉
						
						var faltQty = ( Number(item.faltQty) ) ? Number(item.faltQty) : 0;//입수량
						
						var myQuantity04 = Number( (faltQty * myQuantity01) + myQuantity02);

						if( myQuantity04 > 200 ){
							myQuantity04 = 200;
						}
						
						AUIGrid.updateRow(myGridID, {'myQuantity04': myQuantity04 }, rowIndex);
						
						return Number( (faltQty * myQuantity01) + myQuantity02);
					}
				},{
					dataField : "myQuantity04",
					headerText : "",
					width : 80,
					dataType : "numeric",
					formatString : "#,##0",
					style : "left",
					width : "4%",
					editable : false,
					renderer : {
						type : "BarRenderer",
						showLabel : false,
						min : 0,
						max : 200
					},
					styleFunction : function(rowIndex, columnIndex, value, headerText, dataField, item) {
						if( value == 200 ) return "c-red";
						return "";
					}
				}]
		},{
			dataField : "ownerOrder",
			headerText : "점주 주문",
				children : [{
					dataField : "storReqBoxQty",
					headerText : "BOX",
					width : "4%",
					style: "auiRight",
					editable : false
				}, {
					dataField : "storReqIddyQty",
					headerText : "낱봉",
					width : "4%",
					style: "auiRight",
					editable : false
				}]
		},{
			dataField : "seOrder",
			headerText : "총무 주문<br/>(합계)",
				children : [{
					dataField : "grfrReqBoxQty",
					headerText : "BOX",
					width : "4%",
					style: "auiRight",
					editable : false
				}, {
					dataField : "grfrReqIddyQty",
					headerText : "낱봉",
					width : "4%",
					style: "auiRight",
					headerStyle: "auiBorR",
					editable : false
				}]
		},{
			dataField : "orderTotal",
			headerText : "주문 합계",
				children : [{
					dataField : "orderTotal01",
					headerText : "BOX",
					width : "4%",
					style: "auiRight",
					editable : false,
					expFunction : function(  rowIndex, columnIndex, item, dataField ) {
						var storReqBoxQty = ( Number(item.storReqBoxQty) ) ? Number(item.storReqBoxQty) : 0;//점주 주문 box
						var grfrReqBoxQty = ( Number(item.grfrReqBoxQty) ) ? Number(item.grfrReqBoxQty) : 0;//총무 주문 box
						var totalReqBoxQty;
						
						if( Math.sign( storReqBoxQty ) > -1 ){
							totalReqBoxQty = Number( storReqBoxQty + grfrReqBoxQty );
						}else{
							totalReqBoxQty = Number( grfrReqBoxQty - Math.abs(storReqBoxQty) );
						}
						
						return totalReqBoxQty;
					}
				}, {
					dataField : "orderTotal02",
					headerText : "낱봉",
					width : "4%",
					style: "auiRight",
					editable : false,
					expFunction : function(  rowIndex, columnIndex, item, dataField ) {
						var storReqIddyQty = ( Number(item.storReqIddyQty) ) ? Number(item.storReqIddyQty) : 0;//점주 주문 낱봉
						var grfrReqIddyQty = ( Number(item.grfrReqIddyQty) ) ? Number(item.grfrReqIddyQty) : 0;//총무 주문 낱봉
						var totalReqIddyQty;
						
						if( Math.sign( storReqIddyQty ) > -1 ){//양수일경우 점주입력값 + 총무입력값
							totalReqIddyQty = Number(storReqIddyQty + grfrReqIddyQty);
						}else{//음수일경우 총무입력값 - 점수입력값
							totalReqIddyQty = Number( grfrReqIddyQty - Math.abs(storReqIddyQty) )
						}
						
						return totalReqIddyQty;
					}
				} , {
					dataField : "orderTotal03",
					headerText : "EA",
					width : "4%",
					style: "auiRight",
					editable : false,
					expFunction : function(  rowIndex, columnIndex, item, dataField ) {
						
						var orderTotal01 = ( Number(item.orderTotal01) ) ? Number(item.orderTotal01) : 0;//주문합계 BOX
						var orderTotal02 = ( Number(item.orderTotal02) ) ? Number(item.orderTotal02) : 0;//주문합계 낱봉
						
						var faltQty = ( Number(item.faltQty) ) ? Number(item.faltQty) : 0;//입수량
						
						return Number( (faltQty * orderTotal01) + orderTotal02);
					}
				}]
		},{
			dataField : "totalPrice",
			headerText : "합계<br/>금액",
			dataType : "numeric",
			width : "7%",
			style: "auiRight",
			editable : false,
			expFunction : function(  rowIndex, columnIndex, item, dataField ) {
				//점주 주문 box
				var storReqBoxQty = ( Number(item.storReqBoxQty) ) ? Number(item.storReqBoxQty) : 0;
				//점주 주문 낱봉
				var storReqIddyQty = ( Number(item.storReqIddyQty) ) ? Number(item.storReqIddyQty) : 0;
				//총무 주문 box
				var grfrReqBoxQty = ( Number(item.grfrReqBoxQty) ) ? Number(item.grfrReqBoxQty) : 0;
				//총무 주문 낱봉
				var grfrReqIddyQty = ( Number(item.grfrReqIddyQty) ) ? Number(item.grfrReqIddyQty) : 0;
				//입수량
				var faltQty = ( Number(item.faltQty) ) ? Number(item.faltQty) : 0;
				//매입단가
				var untpc = ( Number(item.untpc) ) ? Number(item.untpc) : 0;
				//총합산금액 계산식
				var boxPrice = Number( ( ( storReqBoxQty + grfrReqBoxQty ) * faltQty ) * untpc) //박스 총합산금액
				var iddyPrice = Number( (storReqIddyQty + grfrReqIddyQty) * untpc );//낱개 총합산금액 
				
				return Number( boxPrice + iddyPrice );
			}
		},{
			dataField : "ordUseYnTx",
			headerText : "주문<br/>가능<br/>여부",
			width : "4%"
		}
	];
	
	var columnLayout3 = [{
		dataField : "vendNm",
		headerText : "특수처명",
		width : "100%"
	}];
	
	// 푸터 설정
	var footerLayout = [{
			labelText : "∑",
			positionField : "#base"
		}, {
			dataField : "prdSapCd",
			positionField : "prdSapCd",
			operation : "SUM",
			colSpan : 7, // 자신을 포함하여 3개의 푸터를 가로 병합함.
			labelFunction : function(value, columnValues, footerValues) {
				//return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
				return "합계 : "
			}
		}, {
			dataField : "myQuantity01",
			positionField : "myQuantity01",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "myQuantity02",
			positionField : "myQuantity02",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "myQuantity03",
			positionField : "myQuantity03",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "storReqBoxQty",
			positionField : "storReqBoxQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "storReqIddyQty",
			positionField : "storReqIddyQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "grfrReqBoxQty",
			positionField : "grfrReqBoxQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1,
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "grfrReqIddyQty",
			positionField : "grfrReqIddyQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1,
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "orderTotal01",
			positionField : "orderTotal01",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "orderTotal02",
			positionField : "orderTotal02",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		} , {
			dataField : "orderTotal03",
			positionField : "orderTotal03",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		} , {
			dataField : "totalPrice",
			positionField : "totalPrice",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				//여신잔액 갱신
				var totalPrice = AUIGrid.getFooterValueByDataField(myGridID, "totalPrice");
				var availAmt = $("#availAmt").val();
				if( $("#availAmt").val() ){
					var price = setComma(availAmt - totalPrice);
					$("#cdtlnPrice").html( price + " <span>원</span>" );
				}
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
	}];

	var grfeCnt = "<c:out value='${grfeCnt}'/>";
	
	//대리점 총무가 없는경우 총무 주문 필드 삭제
	if( grfeCnt == 0 ){
		columnLayout.splice( 8 , 1 );
		footerLayout.splice( 7 , 2 );
	}

	// 주문등록 그리드 속성
	var gridPros = {
			headerHeights : [58, 29],
			rowHeight : 29,
			autoGridHeight : false,
			showRowNumColumn : true,
			rowNumColumnWidth : 30,
			enterKeyColumnBase : true,
			editingOnKeyDown : true,
			showFooter : true,
			editable : true,
			selectionMode : "singleRow",
			softRemoveRowMode: false,
			// 엑스트라 체크박스 표시 설정
			showRowCheckColumn : true,
			// 엑스트라 체크박스에 shiftKey + 클릭으로 다중 선택 할지 여부 (기본값 : false)
			enableRowCheckShiftKey : true,
			// 전체 체크박스 표시 설정
			showRowAllCheckBox : true,
			rowStyleFunction : function(rowIndex, item) {
				return "";
			}
	};

	// 그리드 속성 설정
	var gridPros3 = {
			headerHeight : 87 ,
			rowHeight : 29 ,
			// 편집 가능 여부 (기본값 : false)
			editable : false,
			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase : true,
			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "multipleCells",
			showFooter : false,
			// 컨텍스트 메뉴 사용 여부 (기본값 : false)
			useContextMenu : true,
			// 필터 사용 여부 (기본값 : false)
			enableFilter : true,
			// 그룹핑 패널 사용
			useGroupingPanel : false,
			// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
			displayTreeOpen : true,
			noDataMessage : "출력할 데이터가 없습니다.",
			groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
	}
	
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
		myGridID3 = AUIGrid.create("#grid_wrap3", columnLayout3,gridPros3);

		AUIGrid.setSelectionByIndex(myGridID3, 0, 0);
	};
	
	/* 특수처 출고의뢰 주문 상품리스트 */
	function searchList(){
		var item = { "ordDt" : getToday() , "dlvDt" : $("#dlvDt").val() , "vendSeq" : $("#vendSeq").val() , "ordType" : $("#ordType").val() };
		
		$.ajax({
			url : "/agn/selectSpclStdPrdList.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(item),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#searchCnt").html(data.list.length);
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	};
	
	//주문등록 저장 함수
	function saveOrdReg (){
		
		var saveData = new Array();
			
		$.each(fnGetGridListCRUD( myGridID ), function(idx,item){
			var reqBoxQty;
			var reqIddyQty;
				
			var emplCd = "<c:out value='${userInfo.emplCd}'/>";
				
			if( emplCd == "10001" ){
				reqBoxQty = item.myQuantity01;
				reqIddyQty = item.myQuantity02;
			} else if( emplCd == "20001" ){
				reqBoxQty = item.grfrReqBoxQty;
				reqIddyQty = item.grfrReqIddyQty;
			}
			
			saveData.push({
				"crudMode" : item.crudMode,
				"reqBoxQty" : reqBoxQty,
				"reqIddyQty" : reqIddyQty,
				"prdDtlSeq" : item.prdDtlSeq,
				"prdSeq" : item.prdSeq,
				"dlvDt" : $("#dlvDt").val(),
				"vendSeq" : $("#vendSeq").val(),
				"ordType" : $("#ordType").val(),
				"untpc" : item.untpc,
				"taxtCd" : item.taxtCd,
				"ordDt" : getToday()
			});
		});
		
		if(!saveData.length > 0){
			//주문정보가 없습니다.\n다시 확인해주세요.
			var popupParam = [];
			popupParam.data = {
				title : "주문등록",
				message : "<spring:message code='alert.ordReg14'/>",
				showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}
		
		$.ajax({
			url : "/agn/saveOrdReg.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(saveData),
			success : function(data) {
				//리스트 조회
				searchList();
				
				var popupParam = [];
				popupParam.data = {
					title : "주문등록",
					message : "<spring:message code='alert.ordReg9'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	//여신 잔액 조회
	function setCdtlInfo(data){
		var totalPrice = ( AUIGrid.getFooterValueByDataField(myGridID, "totalPrice") ) ? AUIGrid.getFooterValueByDataField(myGridID, "totalPrice") : 0;
		if( totalPrice > 0 ) totalPrice = totalPrice.split(',').join("");
		
		var price = setComma(data.CREDIT_LIMIT - totalPrice);
		
		$("#cdtlInfo").html(setComma(price) + '<span>원</span>');
		$("#availAmt").val( data.CREDIT_LIMIT );
	}
	
	//주문여부 확인
	function selectOrderCnt (){
		
		var item = {
					 "vendSeq" : $("#vendSeq").val() ,
					 "ordType" : $("#ordType").val() ,
					 "ordDt" : getToday()
					};
		
		$.ajax({
			url : "/agn/selectOrderCnt.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(item),
			success : function(data) {
				if( data.orderCnt == 0 ){
					//주문정보가 저장되지 않았습니다.\n전송 전 주문 정보를 저장해 주세요.
					var popupParam = [];
					popupParam.data = {
							title : "특수처 출고의뢰 주문등록",
							message : "<spring:message code='alert.ordReg11'/>",
							showBtn2 : 'N'
					}
					layerAlert(popupParam);
					return;
				}else{
					//sap 전송
				}
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	//학교리스트
	function selectSchlList(){
		$.ajax({
			url : "/agn/selectSchlList.do",
			type : 'POST',
			success : function(data) {
				AUIGrid.setGridData(myGridID3, data.list);
				//첫번째 행 선택
				AUIGrid.setSelectionByIndex( myGridID3 , 0 , 0 );
				
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}

	//그리드 로우 삭제 이벤트
	function removeRowItem(){
		var checkedItems = AUIGrid.getCheckedRowItems(myGridID);
		var rowItem;
		for(var i=checkedItems.length-1; i>=0; i--) {
			rowItem = checkedItems[i];
			AUIGrid.removeRow(myGridID, rowItem.rowIndex);
		}
	}

	/* 총무주문 건수 조회 */
	function selectGrfrOrdCnt(){
		var item = { "ordDt" : getToday() , "ordType" : $("#ordType").val() , "vendSeq" : $("#vendSeq").val() };
		$.ajax({
			url : "/agn/selectGrfrOrdCnt.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(item),
			success : function(data) {
				if( data.grfrOrdCnt > 0 ){
					var popupParam = [];
					popupParam.data = {
							title : "주문등록",
							message : "<spring:message code='alert.ordReg1'/>",
							showBtn2 : 'N'
					}
					layerAlert(popupParam);
					return;
				}
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	};

	function getToday(){
		return fnGetToDay().replace('-','').replace('-','');
	}

	function getPickerDate(){
		var today = new Date();
		var year = today.getFullYear();
		var month = (today.getMonth() + 1);
		var day;
		
		var hours = ('0' + today.getHours()).slice(-2); 
		var minutes = ('0' + today.getMinutes()).slice(-2);
		var timeString = hours + minutes;
		
		if( timeString > '${clsTm}' ){
			day = today.getDate() + 2;
		}else{
			day = today.getDate() + 1;
		}
		
		return year + '-' + month + '-' + day;
	}
	
</script>

<div class="rContentBox">
	<div class="content">
		<tiles:insertAttribute name="body.breadcrumb"/>
		
		<!-- 조회 -->
		<form id="frm">
			<input type="hidden" name="dlvDt" id="dlvDt">
			<input type="hidden" id="changeDt">
			<input type="hidden" name="vendSeq" id="vendSeq">
			<input type="hidden" name="ordType" id="ordType" value="SPECL">
			<input type="hidden" name="ordDt" id="ordDt">
			<div class="inquiryBox">
				<dl>
					<dt>출고 요청일</dt>
					<dd>
						<div class="formWrap">
							<div class="dateWrap">
								<input type="text" class="inp" id="datepicker01">
								<button type="button" class="datepickerBtn" title="날짜입력"></button>
							</div>
							<button type="button" class="comBtn" id="searchBtn" >조회</button>
						</div>
					</dd>
				</dl>
				
				<div class="btnGroup right">
					<button type="button" class="inquBtn" id="saveBtn">저장</button>
					<c:if test="${userInfo.emplCd == '10001'}">
						<button type="button" class="inquBtn" id="sendBtn">전송</button>
					</c:if>
				</div>
			</div>
		</form>
		<!-- 조회 -->
		
		<!-- 상태정보 -->
		<div class="stateInfo">
			<ul>
				<li>
					<div class="info">
						<p class="tit">여신잔액 : </p>
						<p class="num" id="cdtlInfo">
							0 <span>원</span>
						</p>
						<input type="hidden"id="availAmt">
						<div class="formGroup">
							<button type="button" class="reSetBtn mr5" title="reset" id="cdtlnResetBtn"></button>
							<c:if test="${userInfo.emplCd == '10001'}">
								<button type="button" id="cdtlnDetailBtn" class="comBtn small pom07" data-target="cdtlnDetailPop">여신 상세보기</button>
							</c:if>
						</div>
					</div>
				</li>
				<li>
					<div class="info orderState">
						<p class="tit">주문상태 : </p>
						<ul class="step">
							<li class="active">
								<div class="tooltip">
									주문가능
									<span class="tooltiptext tooltip-bottom" tabindex="0">
										주문 정보가 저장되지 않았습니다.<br/>
										주문 정보 저장 및 전송은 N시부터 13시까지 가능합니다.
									</span>
								</div>
							</li>
							<li>
								<div class="tooltip">
									여신초과(저장완료)
									<span class="tooltiptext tooltip-bottom" tabindex="0">
										저장된 주문 정보의 합계 금액이 여신보다 부족(1,000,000원)합니다.<br/>
										주문 정보를 전송하려면 주문 정보를 축소하거나 본사 계좌로 추가 입금해야 합니다.
									</span>
								</div>
							</li>
							<li>
								<div class="tooltip">
									저장완료
									<span class="tooltiptext tooltip-bottom" tabindex="0">
										주문 정보가 전송되지 않았습니다.<br/>
										13시까지 전송하지 않으면 물품을 배송받을 수 없습니다.
									</span>
								</div>
							</li>
							<li>
								<div class="tooltip">
									주문완료
									<span class="tooltiptext tooltip-bottom" tabindex="0">
										주문 정보가 전송되었습니다.<br/>
										&lt;주문확정/ 배송조회&gt; 메뉴에서 상태를 조회할 수 있습니다.
									</span>
								</div>
							</li>
						</ul>
					</div>
				</li>
				<li>
					<p class="tit lastTime">최종 전송시각 : <span class="time">2022-05-05 09:30:00</span></p>
				</li>
			</ul>
		</div>
		<!-- 상태정보 -->
		
		<!-- grid -->  <!-- 데이터가 +2 일때 class="dataPoint01" / 데이터가 +3 일때 class="dataPoint02" / 데이터불가 일때 class="dataNot" -->
		<div class="girdBoxGroup">
			<div class="girdBox topBlank w20per">
				<div id="grid_wrap3"></div>
			</div>
			
			<div class="girdBox">
				<div class="titleArea right">
					<p class="numState">
						<em>총 <span class="pColor01 fb" id="searchCnt"></span></em> 건 이 조회되었습니다.
					</p>
					
					<div class="formGroup">
						<button type="button" class="comBtn small mr5" id="addRowBtn">행추가</button>
						<button type="button" class="comBtn small mr30" id="removeRowBtn">행삭제</button>
						
						<select id="batch" class="sel small w120">
							<option value="reset">초기화</option>
						</select>
						<button type="button" class="comBtn small" id="batchBtn">일괄반영</button>
					</div>
				</div>
				<div id="grid_wrap"></div>
			</div>
		</div>
		<!-- grid -->
	</div>
</div>