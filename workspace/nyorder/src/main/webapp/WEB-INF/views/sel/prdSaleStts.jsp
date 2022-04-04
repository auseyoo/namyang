<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
	var myGridID;
	var myGridID2;

	$(document).ready(function(){
		$(".monPicker").hide();
		createAUIGrid();
		AUIGrid.setFooter(myGridID2, footerLayout2);
		//searchList();

		$("input[name='srcType']").change(function(e){
			if(	$("input[name='srcType']:checked").val() == "month"){
				$(".monPicker").show();
				$(".dayPicker").hide();
			}
			if(	$("input[name='srcType']:checked").val() == "day"){
				$(".monPicker").hide();
				$(".dayPicker").show();
			}
		});
		searchList();

		$("#excelDonw").click(function(){
			AUIGrid.exportToXlsx(myGridID2, {
				// 스타일 상태 유지 여부(기본값:true)
				exportWithStyle : true,
				fileName : "제품별 판매 현황"
			});
		});
	});
 
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
				headerHeight : 29,
				rowHeight : 29,
				// 편집 가능 여부 (기본값 : false)
				editable : false,
				
				enterKeyColumnBase : true, // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
				//fixedColumnCount : 7,
				editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
				wrapSelectionMove : true,
				showRowCheckColumn : true, // 체크박스 사용 
				
				// 셀 선택모드 (기본값: singleCell)
				selectionMode : "singleRow",
				showFooter: false,
				
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
				
		};

		var gridPros2 = {
			headerHeight : 29,
			rowHeight : 29,
			showFooter: true,
			selectionMode : "singleRow",
		}
	
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
		myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
	}

	// 그리드 속성 설정
	var auiGridProps = {
			//scrollHeight : 18, // 스크롤의 높이
			//scrollThumbHeight : 16, // 스크롤 썸(thumb)의 높이
			fixedColumnCount : 1
	};

	var columnLayout = [{
			dataField : "prdSapCd",
			headerText : "제품코드",
			width : "25%",	
			style: "auiLink"
		},{
			dataField : "prdNm",
			headerText : "제품명",
			style: "auiLeft"
		}
	];

	var columnLayout2 = [{
			dataField : "saleDt",
			headerText : "판매일자",
			dataType : "date",
			width : "11%",
		},{
			dataField : "puchQty",
			headerText : "매입",
			dataType : "numeric",
			style : "auiRight"			
		},{
			dataField : "pType",
			headerText : "유형",
				children : [{
					dataField : "saleQty",
					headerText : "판매",
					dataType : "numeric",
					width : "11%",
					style : "auiRight"
				}, {
					dataField : "rtgdQty",
					headerText : "반품",
					dataType : "numeric",
					width : "11%",
					style : "auiRight"
				}, {
					dataField : "prsntQty",
					headerText : "증정",
					dataType : "numeric",
					width : "11%",
					style : "auiRight"
				}, {
					dataField : "exchgQty",
					headerText : "교환",
					dataType : "numeric",
					headerStyle : "auiRightBorR",
					width : "11%",
					style : "auiRight"
				}]
		},{
			dataField : "sAmount",
			headerText : "매출금액",
				children : [{
					dataField : "suCt",
					headerText : "공급가",
					dataType : "numeric",
					width : "11%",
					style : "auiRight"
				}, {
					dataField : "vatCt",
					headerText : "VAT",
					dataType : "numeric",
					width : "11%",
					style : "auiRight"
				}, {
					dataField : "saleAmt",
					headerText : "計",
					dataType : "numeric",
					width : "14%",
					style : "auiRight"
				}]
		}
	];


	// 푸터 설정
	var footerLayout2 = [{
		labelText : "∑",
		positionField : "#base"
		}, {
			dataField : "sellDate",
			positionField : "sellDate",
			operation : "SUM",
			colSpan : 1, 
			formatString : "#,##0"
		}, {
			dataField : "puchQty",
			positionField : "puchQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			formatString : "#,##0"
		}, {
			dataField : "saleQty",
			positionField : "saleQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			formatString : "#,##0"
		}, {
			dataField : "rtgdQty",
			positionField : "rtgdQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			formatString : "#,##0"
		}, {
			dataField : "prsntQty",
			positionField : "prsntQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			formatString : "#,##0"
		}, {
			dataField : "exchgQty",
			positionField : "exchgQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			formatString : "#,##0"
		}, {
			dataField : "suCt",
			positionField : "suCt",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			formatString : "#,##0"
		}, {
			dataField : "vatCt",
			positionField : "vatCt",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			formatString : "#,##0"
		}, {
			dataField : "saleAmt",
			positionField : "saleAmt",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			formatString : "#,##0"
	}];


	/* 표준 제품 - 리스트 조회 */
	function searchList(){
		$.ajax({
			url : "/std/selectStdPrdMngList.do", 
			type : 'POST', 
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}

	function searchSaleList(){
		var rows = AUIGrid.getCheckedRowItems(myGridID);
		if(rows.length > 0){
			var prdSeqs=new Array();
			$.each(rows, function(i, v){
				prdSeqs.push(v.item.prdSeq);
			});
			$("#prdSeqs").val(prdSeqs.join(",")); 
		}else{
			$("#prdSeqs").val("");
		}
		if( $("input[name='srcType']:checked").val() == "day" ){
			var srcStartDate = $("#srcStartDate").val().split("-");
			var srcEndDate = $("#srcEndDate").val().split("-");
			var sDate = new Date(srcStartDate[0],srcStartDate[1],srcStartDate[2]);
			var eDate = new Date(srcEndDate[0],srcEndDate[1],srcEndDate[2]);
			if((eDate.getTime()-sDate.getTime()) /(1000*60*60*24) > 31){
				var popupParam = [];
				popupParam.data = {
					title : "담당자별 판매현황",
			 	 	message : "<spring:message code='alert.saleStts1'/>",
			 	 	showBtn2 : 'N'
				}
				layerAlert(popupParam);
				$("#srcStartDate").val(fnGetToMon()+"-01");
				$("#srcEndDate").val(fnGetToDay());
				return;
			}
		}
		if( $("input[name='srcType']:checked").val() == "month"){
			var srcStartMonth = $("#srcStartMonth").val().split("-");
			var srcEndMonth = $("#srcEndMonth").val().split("-");
			var sDate = new Date(srcStartMonth[0],srcStartMonth[1],"01");
			var eDate = new Date(srcEndMonth[0],srcEndMonth[1],"01");
			if((eDate.getTime()-sDate.getTime()) /(1000*60*60*24) >= 365){
				var popupParam = [];
				popupParam.data = {
					title : "담당자별 판매현황",
			 	 	message : "<spring:message code='alert.saleStts2'/>",
			 	 	showBtn2 : 'N'
				}
				layerAlert(popupParam);
				$("#srcStartMonth").val(fnGetToMon());
				$("#srcEndMonth").val(fnGetToMon());
				return;
			}
		}
		$.ajax({
			url : "/sel/selectPrdSaleSttsList.do", 
			type : 'POST', 
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID2, data);
				$("#salesListCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}

	function resizeGrid(){
		AUIGrid.resize(myGridID, $("#grid_wrap").width());
		AUIGrid.resize(myGridID2, $("#grid_wrap2").width());
	}
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	
	
	<form id="frm">
	<!-- 조회 -->
		<div class="inquiryBox">
			<dl>
				<dt>판매일</dt>
				<dd>
					<div class="formWrap">
						<div class="dateWrap dayPicker">
							<input type="text" name="srcStartDate" value="10/24/1984" class="inp datepicker" id="srcStartDate" readonly>										
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="srcStartDate"></button>										
						</div> 
	
						<span class="divi02 dayPicker">-</span>
						
						<div class="dateWrap dayPicker">
							<input type="text" name="srcEndDate" value="10/24/1984"class="inp datepicker" id="srcEndDate" readonly>
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="srcEndDate"></button>										
						</div> 
						
						<div class="dateWrap monPicker">
							<input type="text" name="srcStartMonth" value="" class="inp monthPicker" id="srcStartMonth" readonly/>
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="srcStartMonth"></button>										
						</div> 
	
						<span class="divi02 monPicker">-</span>
						
						<div class="dateWrap monPicker">
							<input type="text" name="srcEndMonth" value="" class="inp monthPicker" id="srcEndMonth" readonly/>
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="srcEndMonth"></button>										
						</div> 
														
						<div class="checkGroup">
							<input type="radio" name="srcType" id="day" 	class="type01" value="day" checked="checked"><label for="day"><span>일 기준</span></label>
							<input type="radio" name="srcType" id="month" 	class="type01" value="month"><label for="month"><span>월 기준</span></label>
						</div>
						<input type="hidden" id="prdSeqs" name="prdSeqs"/>
						<button type="button" name="" class="comBtn" id="inp_name01" onclick="searchSaleList()">조회</button>
					</div>
				</dd>
			</dl>
		</div>
	</form>
	<!-- 조회 -->

	<!-- grid -->
	<div class="girdBoxGroup">
		<div class="girdBox topBlank w33per">
			<div id="grid_wrap"></div>
		</div>

		<div class="girdBox">
			<!-- 일 기준 -->
			<div class="rTabBox" id="dayCon">
				<div class="titleArea right">
					<p class="numState">
						<em>총 <span class="pColor01 fb" id="salesListCnt">0</span></em> 건 이 조회되었습니다.
					</p>

					<button type="button" name="" class="comBtn small" id="excelDonw">엑셀다운</button>
				</div>

				<div id="grid_wrap2"> </div>
			</div>
			<!-- 일 기준 -->
		</div>
	</div>
	<!-- grid -->

</div>
