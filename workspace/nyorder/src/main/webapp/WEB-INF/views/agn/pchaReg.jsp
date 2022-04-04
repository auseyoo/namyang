<!-- 
	@File Name: pchaReg
	@File 설명 : 매입등록
	@UI ID : UI-PORD-0601.html
	@작성일 : 2022.01.19
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
	var mGrid;
	var mGrid2;
	
	$(document).ready(function(){
		//그리드 생성
		createAUIGrid();

		//매입처 조회
		selectPchaList();
		
		AUIGrid.setFooter( mGrid2 , footerLayout );
	
		//매입처 셀클릭
		AUIGrid.bind(mGrid, "cellClick", function(event) {
			var item = AUIGrid.getItemByRowIndex(mGrid, event.rowIndex );
	
			$("#puchSeq").val( item.puchSeq );
			
			//매입처 제품리스트 조회
			selectPchaRegList( item );
		});
		
		AUIGrid.bind(mGrid2, "cellClick", function(event) {
			var col = AUIGrid.getSelectedIndex( mGrid2 );
			var id = AUIGrid.getDataFieldByColumnIndex( mGrid2,col[1]);
				
			if( id == "prdDtlCd" ){
				//타사제품 조회 팝업 오픈
				$.ajaxDialog({
					id: "othComPrdPop",
					visibility: "visible", 
					openComplete: function() {
						//$("#testValue").focus();
					},
					success: function(data) {
					},
					ajax: {
						url: "/agn/othComPrdPop.do",
						method: "get",
						async: false,
						data : { "puchSeq" : $("#frm #puchSeq").val() }
					},
					dialog: {
						modal: true,
						width:600,
						height:370
					}
				});
			}
		});
		
		//저장 이벤트
		$("#savePchaRegBtn").click(function(){
			var popupParam = [];
			
			if( !$("#puchSeq").val() ){
				popupParam.data = {
						title : "매입등록",
						message : "<spring:message code='alert.pchaReg5'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			var valiCnt = 0;
			var saveData = new Array();
			
			$.each(fnGetGridListCRUD( mGrid2 ), function(idx,item){
				//입고정보가 있는지 없는지 확인
				if( item.reqBoxQty == 0 && item.reqIddyQty == 0 ) valiCnt++;
				
				saveData.push({
							"crudMode": item.crudMode,
							"boxQty" : item.reqIddyQty,//입고 수량 박스
							"iddyQty" : item.reqBoxQty,//입고 수량 낱봉
							"puchSeq" : $("#puchSeq").val(),
							"prdDtlSeq" : item.prdDtlSeq,
							"ordStusDt" : $("#ordStusDt").val(),
							"untpc" : item.untpc,
							"faltQty" : item.faltQty
						});
			});
			
			if( valiCnt > 0 ){
				popupParam.data = {
						title : "매입등록",
						message : "<spring:message code='alert.pchaReg3'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			if( saveData.length > 0 ){
				popupParam.data = {
						title : "매입등록",
						message : "<spring:message code='alert.pchaReg4'/>",
						showBtn1 : 'Y',
						btn1Func : savePchaReg( saveData ),
						showBtn2 : 'Y'
				}
				layerAlert(popupParam);
				return;
			}else{
				popupParam.data = {
						title : "매입등록",
						message : "<spring:message code='alert.pchaReg3'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
	
		});
	
		//로우추가 이벤트
		$("#addRowBtn").click(function(){
			var popupParam = [];
			
			if( !$("#puchSeq").val() ){
				popupParam.data = {
						title : "매입등록",
						message : "<spring:message code='alert.pchaReg5'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			addRow();
		});
		
		//로우삭제 이벤트
		$("#removeRowBtn").click(function(){
			var popupParam = [];
			
			if( !$("#puchSeq").val() ){
				popupParam.data = {
						title : "매입등록",
						message : "<spring:message code='alert.pchaReg5'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			var checkedItems = AUIGrid.getCheckedRowItems(mGrid2);
			if(checkedItems.length <= 0) {
				// 체크박스 선택여부 확인하기
				popupParam.data = {
						title : "매입등록",
						message : "<spring:message code='alert.pchaReg1'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			popupParam.data = {
					title : "매입등록",
					message : "<spring:message code='alert.pchaReg2'/>",
					showBtn1 : 'Y',
					btn1Func : removeRowItem,
					showBtn2 : 'Y'
			}
			
			layerAlert(popupParam);
			return;
		});

		// 미래일자 선택 불가하도록 달력 재설정
		$("#datepicker01").daterangepicker({
			singleDatePicker: true,
			maxDate : new Date(),
			showDropdowns: true,
			changeMonth: true,
			showMonthAfterYear: true,
			locale: {
				format: "YYYY-MM-DD",
				separator: " - ",
				applyLabel: "Apply",
				cancelLabel: "Cancel",
				fromLabel: "From",
				toLabel: "To",
				customRangeLabel: "Custom",
				weekLabel: "W",
				applyLabel: "확인",
				cancelLabel: "취소",
				daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
				monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월",],
				firstDay: 1,
			},"showCustomRangeLabel": false,
				}, function(start, end, label) {
			$("#ordStusDt").val( start.format('YYYYMMDD') );
		});
		
		//초기진입시 날짜 설정
		var ordStusDt = $("#datepicker01").val().replace('-','').replace('-','');
		$("#ordStusDt").val( ordStusDt );
		
	});
	
	var columnLayout = [{
		dataField : "puchNm",
		headerText : "매입처명",
		width : "100%",
	}];
	
	var columnLayout2 = [
		{
			dataField : "prdDtlCd",
			headerText : "제품코드",
			width : "9%",
			renderer : {
				type : "TemplateRenderer"
			},
			labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
				if( item.prdDtlCd && !item.applYn ){
					var template = item.prdDtlCd;
				}
				if(item.applYn == "N" ){
					var template = '<div class="searchWrap">';
					template += '<span class="my_div_text_box">'+value+'<a href="javascript:void(0);" class="serach popBtn" data-prd-type="prdDtlCd"></a></span>';
					template += '</div>';
				}
				return template;
			}
		},{
			dataField : "stdPrdNm",
			headerText : "제품명",
			style : "auiLeft"
		},{
			dataField : "untpc",
			headerText : "매입가",
			dataType : "numeric",
			width : "8%",
			style : "auiRight",
		},{
			dataField : "faltQty",
			headerText : "입수량",
			width : "8%",
			style: "auiRight"
		},{
			dataField : "enterQan",
			headerText : "입고수량",
				children : [{
					dataField : "reqBoxQty",
					headerText : "BOX",
					width : "8%",
					renderer : {
						type : "TemplateRenderer"
					},
					labelFunction : function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) { // HTML 템플릿 작성
						if(!value)	return "";
						var width = (cItem.width - 12); // 좌우 여백 생각하여 12 빼줌.
						var template = '<input type="text" class="auiInput01 right w80"';
						template += ' style="width:' + width + 'px;"'; // 칼럼 전체 크기를 변경했을 때 작성한 input 도 같이 변경시키기 위함.
						template += ' value="' + value +'" onblur="javascript:myInputHandler(' + rowIndex + ', this.value, event,\'enterQan01\');"'
						template += ' onkeydown="if(event.keyCode == 9) event.preventDefault();"' //탭 키를 누르면 브라우저에서 자동으로 다음 input 을 찾는데 이를 방지.
						template += '>';
						return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				}
				}, {
					dataField : "reqIddyQty",
					headerText : "낱봉",
					width : "8%",
					renderer : {
						type : "TemplateRenderer"
					},
					labelFunction : function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) { // HTML 템플릿 작성
						if(!value)	return "";
						var width = (cItem.width - 12); // 좌우 여백 생각하여 12 빼줌.
						var template = '<input type="text" class="auiInput01 right w80"';
						template += ' style="width:' + width + 'px;"'; // 칼럼 전체 크기를 변경했을 때 작성한 input 도 같이 변경시키기 위함.
						template += ' value="' + value +'" onblur="javascript:myInputHandler(' + rowIndex + ', this.value, event,\'enterQan02\');"'
						template += ' onkeydown="if(event.keyCode == 9) event.preventDefault();"' //탭 키를 누르면 브라우저에서 자동으로 다음 input 을 찾는데 이를 방지.
						template += '>';
						return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				}
				}, {
					dataField : "enterQan03",
					headerText : "총수량",
					width : "7%",
					style : "auiRight",
					expFunction : function(  rowIndex, columnIndex, item, dataField ) {
						var tmpEnterQan01Val =Number(item.reqBoxQty);
						var tmpEnterQan02Val =Number(item.reqIddyQty);
						var tmpIntakeVal =Number(item.faltQty);
						return Number(tmpIntakeVal * tmpEnterQan01Val + tmpEnterQan02Val);
					}
				}]
		},{
			dataField : "totalPrice",
			headerText : "합계금액",
			dataType : "numeric",
			width : "12%",
			style : "auiRight",
			expFunction : function(  rowIndex, columnIndex, item, dataField ) {
				var tmpPurchasePriceVal =Number(item.untpc);
				var tmpEnterQan03Val =Number(item.enterQan03);
				return Number(tmpPurchasePriceVal*tmpEnterQan03Val); 
			}
		}
	];
	
	// 푸터 설정
	var footerLayout = [
			{
				labelText : "∑",
				positionField : "#base"
			}, {
				dataField : "prdDtlCd",
				positionField : "prdDtlCd",
				operation : "SUM",
				colSpan : 4, // 자신을 포함하여 4개의 푸터를 가로 병합함.
				labelFunction : function(value, columnValues, footerValues) {
				   // return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
				   return "합계 : "
				}
			}, {
				dataField : "reqBoxQty",
				positionField : "reqBoxQty",
				operation : "SUM",
				style : "auiRight",
				colSpan : 1, 
				labelFunction : function(value, columnValues, footerValues) {
					return " " + AUIGrid.formatNumber(value, "#,##0");
				}
			}, {
				dataField : "reqIddyQty",
				positionField : "reqIddyQty",
				operation : "SUM",
				style : "auiRight",
				colSpan : 1, 
				labelFunction : function(value, columnValues, footerValues) {
					return " " + AUIGrid.formatNumber(value, "#,##0");
				}
			}, {
				dataField : "enterQan03",
				positionField : "enterQan03",
				operation : "SUM",
				style : "auiRight",
				colSpan : 1, 
				labelFunction : function(value, columnValues, footerValues) {
					return " " + AUIGrid.formatNumber(value, "#,##0");
				}
			}, {
				dataField : "totalPrice",
				positionField : "totalPrice",
				operation : "SUM",
				style : "auiRight",
				colSpan : 1, 
				labelFunction : function(value, columnValues, footerValues) {
					return " " + AUIGrid.formatNumber(value, "#,##0");
				}
			}
	];
	
	//AUIGrid 를 생성합니다.
	function createAUIGrid() {
		//표준제품 조회 그리드 속성
		var auiGridProps1 = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : false,
			autoGridHeight : true
		};

		var auiGridProps2 = {
				headerHeight : 29,
				rowHeight : 29,
				// 편집 가능 여부 (기본값 : false)
				editable : true,
				// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
				enterKeyColumnBase : true,
				// 셀 선택모드 (기본값: singleCell)
				selectionMode : "multipleCells",
				showFooter : true,
				// 컨텍스트 메뉴 사용 여부 (기본값 : false)
				useContextMenu : true,
				// 필터 사용 여부 (기본값 : false)
				enableFilter : true,
				// 그룹핑 패널 사용
				useGroupingPanel : false,
				// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
				displayTreeOpen : true,
				noDataMessage : "출력할 데이터가 없습니다.",
				groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
				softRemoveRowMode: false,
				// 엑스트라 체크박스 표시 설정
				showRowCheckColumn : true,
				// 엑스트라 체크박스에 shiftKey + 클릭으로 다중 선택 할지 여부 (기본값 : false)
				enableRowCheckShiftKey : true,
				// 전체 체크박스 표시 설정
				showRowAllCheckBox : true
		};
		
		mGrid = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps1);
		mGrid2 = AUIGrid.create("#grid_wrap2", columnLayout2, auiGridProps2);
	}
	
	function resizeGrid(){
		AUIGrid.resize(mGrid, $("#content").width());
	}
	
	function myInputHandler(rowIndex, selectedValue, event, datafieldName ) {
		var tmpEnterQan01Val;
		var tmpEnterQan02Val;
		var modifyItem ;
	
		modifyItem = {[datafieldName] : Number(selectedValue)};
		AUIGrid.updateRow(mGrid2, modifyItem, rowIndex);
	
		tmpEnterQan01Val = Number(AUIGrid.getCellValue(mGrid2, rowIndex, "enterQan01"));
		tmpEnterQan02Val = Number(AUIGrid.getCellValue(mGrid2, rowIndex, "enterQan02"));
		AUIGrid.updateRow(mGrid2, {'enterQan03': Number(tmpEnterQan01Val+tmpEnterQan02Val)}, rowIndex);
	};
	
	/*저장 누를시 함수 */
	function savePchaReg( saveData ){
		$.ajax({
			url : "/agn/savePchaReg.do",
			type : 'POST', 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify( saveData ),
			success : function(data) {
				//제품리스트 출력
				var item = { "puchSeq" : $("#puchSeq").val() };
				selectPchaRegList( item );
				
				var popupParam = [];
				popupParam.data = {
						title : "매입등록",
						message : data,
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	};
	
	function selectPchaList(){
		$.ajax({
			url : "/agn/selectPchaList.do", 
			type : 'POST',
			success : function(data) {
				AUIGrid.setGridData(mGrid, data.list);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	function selectPchaRegList( item ){
		//날짜 설정
		item.ordStusDt = $("#ordStusDt").val();
		
		$.ajax({
			url : "/agn/selectPchaRegList.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(item),
			success : function(data) {
				AUIGrid.setGridData(mGrid2, data.list);
				$("#listCnt").html(data.list.length);
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	//로우 추가이벤트
	function addRow(){
		var item = {};
		item.applYn = "N";
		//그리드 행추가
		AUIGrid.addRow(mGrid2 , item , "frist");
	}
	
	//로우 삭제이벤트
	function removeRowItem(){
		var checkedItems = AUIGrid.getCheckedRowItems(mGrid2);
		var rowItem;
		for(var i=checkedItems.length-1; i>=0; i--) {
			rowItem = checkedItems[i];
			AUIGrid.removeRow(mGrid2, rowItem.rowIndex);
		}
		$(".modalCloseBtn").click();
	}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	
	<!-- 조회 -->
	<form id="frm">
		<input type="hidden" name="puchSeq" id="puchSeq">
		<input type="hidden" name="ordStusDt" id="ordStusDt">
		<!-- <input type="hidden" id="changeDt"> -->
		
		<div class="inquiryBox">
			<dl>
				<dt>등록일</dt>
				<dd>
					<div class="formWrap">
						<div class="dateWrap">
							<input type="text" class="inp" id="datepicker01">
							<button type="button" class="datepickerBtn" title="날짜입력"></button>
						</div>
						
						<!-- <button type="button" name="" class="comBtn" id="searchBtn">조회</button> -->
					</div>
				</dd>
			</dl>
			<div class="btnGroup right">
				<button type="button" name="" class="inquBtn" id="addRowBtn" >행추가</button>
				<button type="button" name="" class="inquBtn" id="removeRowBtn" >행삭제</button>
				<button type="button" name="" class="inquBtn" id="savePchaRegBtn" >저장</button>
			</div>
		</div>
	</form>
	<!-- 조회 -->

	<div class="txtInfo">
		※ 남양제품은 <span class="pColor02">별도의 입고 절차 없이</span> 납품일에 자동으로 입고 처리됩니다.
	</div>
	
	<!-- grid -->
	<div class="girdBoxGroup">
		<div class="girdBox topBlank w20per">
			<div id="grid_wrap"></div>
		</div>
		
		<div class="girdBox">
			<p class="numState">
				<em>총 <span class="pColor01 fb" id="listCnt"></span></em> 건 이 조회되었습니다.
			</p>
			
			<div id="grid_wrap2"> </div>
		</div>
	</div>
</div>
