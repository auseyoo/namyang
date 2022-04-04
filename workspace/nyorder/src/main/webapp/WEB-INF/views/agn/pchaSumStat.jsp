<!-- 
	@File Name: pchaSumStat
	@File 설명 : 매입 집계 현황
	@UI ID : UI-PORD-0701.html
	@작성일 : 2022.01.25
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">
var mGrid;
var mGrid2;
var mGrid3;
$(document).ready(function(){
	createAUIGrid();
	
	//매입처 리스트 조회
	selectSumStatPchaList();

	AUIGrid.bind(mGrid, "rowNumCellClick", function(event) {
		var item = AUIGrid.getItemByRowIndex(mGrid, event.rowIndex );
		$("#puchSeq").val( item.puchSeq );
		
		var id = $("#pcha input[name='date']:checked").attr('id');
		
		if( item.agenSeq == 0 ){//메이저 매입처
			if( id == 'day' ){//일조회
				selectMjrPchaSumStatDayList(item);
			}else{//월조회
				if( validation() ){
					selectMjrPchaSumStatMonList(item);
				}
			}
		}else{//대리점매입처
			if( id == 'day' ){//일조회
				selectPchaSumStatDayList(item);
			}else{//월조회
				if( validation() ){
					selectPchaSumStatMonList(item);
				}
			}
		}
	});
	
	var options = {
			MonthFormat: 'yy-mm',
			ShowIcon: false,
			i18n: {
				year: '년도',
				prevYear: '이전년도',
				nextYear: '다음년도',
				next12Years: '다음 12년',
				prev12Years: '이전 12년',
				nextLabel: '다음',
				prevLabel: '이전',
				buttonText: 'Open Month Chooser',
				jumpYears: '년도로 이동',
				backTo: '뒤로',
				months: ['1 월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			}
	};
	
	$('#monthPicker1').MonthPicker(options);
	$('#monthPicker2').MonthPicker(options);
	
	$("#datepicker01").daterangepicker({
		"singleDatePicker": true,
		"showDropdowns": true,
		"changeMonth": true,
		"showMonthAfterYear": true,
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
			//$("#changeDt").val( start.format('YYYYMMDD') );
	});

	$("#datepicker02").daterangepicker({
		"singleDatePicker": true,
		"showDropdowns": true,
		"changeMonth": true,
		"showMonthAfterYear": true,
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
			//$("#changeDt").val( start.format('YYYYMMDD') );
	});
	
	$("#searchBtn").click(function(){
		if( !$("#puchSeq").val() ){
			var popupParam = [];
			popupParam.data = {
					title : "매입집계 현황",
					message : "매입처를 선택해주세요.",
					showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}
		
		var id = $("#pcha input[name='date']:checked").attr('id');
		var item = {"puchSeq" : $("#puchSeq").val() , "prdDtlCd" : $("#prdDtlCd").val() , "stdPrdNm" : $("#stdPrdNm").val()};
		if( item.agenSeq == 0 ){//메이저
			if(id == "day"){//일조회
				//그리드 초기화
				mGrid3 = null;
				AUIGrid.destroy("#grid_wrap3");
				selectMjrPchaSumStatDayList(item);
			}else{
				if( validation() ){
					//그리드 초기화
					mGrid2 = null;
					AUIGrid.destroy("#grid_wrap2");
					//월조회
					selectMjrPchaSumStatMonList( item );
				}
			}
		}else{
			if(id == "day"){//일조회
				//그리드 초기화
				mGrid3 = null;
				AUIGrid.destroy("#grid_wrap3");
				selectPchaSumStatDayList(item);
			}else{
				if( validation() ){
					//그리드 초기화
					mGrid2 = null;
					AUIGrid.destroy("#grid_wrap2");
					//월조회
					selectPchaSumStatMonList( item );
				}
			}
		}

	});
	
	//radio div show/hide
	$('input[type="radio"]').change(function(){
		$("#dayPicker,#monPicker").hide();
		$("#dayCon,#monthCon").hide();
		if( $(this).attr('id') == "day" ){
			$("#dayPicker,#dayCon").show();
		}else{
			$("#monPicker,#monthCon").show();
		}
	});
});

var auiGridProps = {
		headerHeight : 29,
		rowHeight : 29,
		// 편집 가능 여부 (기본값 : false)
		editable : false,
		enterKeyColumnBase : true, // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
		fixedColumnCount : 7,
		editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
		wrapSelectionMove : true,
		// 셀 선택모드 (기본값: singleCell)
		selectionMode : "singleRow",
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
		groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};

var columnLayout = [{
	dataField : "puchNm",
	headerText : "매입처명",
	width : "100%",		
}];

//일 그리드 생성
function createDayGrid( data ){
	var saveData = new Array();
	
	data.list.forEach(function(item,idx){
		if( item.ordStusList ){
			item.ordStusList.split(",").forEach(function(itm,i){
				var boxQty = Number(itm.split(':')[1]);
				var iddyQty = Number(itm.split(':')[2]);
				var faltQty = item.faltQty;
				
				saveData.push( { "rDate" : itm.split(':')[0].substring(4,6) + "-" + itm.split(':')[0].substring(6,8),
								 "sumData" : ( boxQty * faltQty ) + iddyQty,
								 "prdDtlSeq" : item.prdDtlSeq });
			});
		}
	});
	
	//두날짜 차이 리스트
	var dayList = getDatesToLast( $("#datepicker01").val() , $("#datepicker02").val() );
	
	var obj = {};
	
	dayList.forEach(function(itm,idx){
		var regiDate = "regiDate" + idx;
		saveData.forEach(function(item,index){
			if( itm == item.rDate ){
				obj[regiDate] = item.sumData;
				obj["prdDtlSeq"] = item.prdDtlSeq;
			}
		});
	});
	
	var resultData = new Array();
	
	//오브젝트 합치기
	data.list.forEach(function(item,idx){
		if( obj.prdDtlSeq == item.prdDtlSeq ){
			Object.assign( item , obj );
		}
	});
	
	var calendarLayout = [];
	var footerLayout = [];
	
	for( var i = 0; i < dayList.length; i++ ){
		//레이아웃데이터 set
		calendarLayout[i] = {
				dataField : "regiDate" + i,
				headerText : dayList[i],
				width : "6%",
				style : "auiRight"
			}
		footerLayout[i] = {
					dataField : "regiDate" + i,
					positionField : "regiDate" + i,
					operation : "SUM",
					style : "auiRight",
					colSpan : 1, 
					labelFunction : function(value, columnValues, footerValues) {
						return " " + AUIGrid.formatNumber(value, "#,##0");
				}
		}
		
	}
	
	var columnLayout = [
		{
			dataField : "prdDtlCd",
			headerText : "제품코드",
			width : "8%",
		},{
			dataField : "stdPrdNm",
			headerText : "제품명",
			style : "auiLeft"
		},{
			dataField : "totalCnt",
			headerText : "총수량",
			width : "7%",
			style: "auiRight",
			expFunction : function(  rowIndex, columnIndex, item, dataField ) {
				var faltQty = item.faltQty;
				var ordStusList = item.ordStusList;
				var totalCnt = 0;
				if( ordStusList ){
					ordStusList.split(",").forEach(function(itm,i){
						var boxQty = Number(itm.split(':')[1]);
						var iddyQty = Number(itm.split(':')[2]);
					
						totalCnt += totalCnt + (boxQty * faltQty) + iddyQty;
					});
				}
				return totalCnt;
			}
		},{
			dataField : "untpc",
			headerText : "매입가",
			dataType : "numeric",
			width : "7%",
			style : "auiRight"
		},{
			dataField: "total",
			headerText: "합계",
			children: [{
				dataField: "spprc",
				headerText: "공급가",
				width: "6%",
				style: "auiRight",
				dataType : "numeric",
				expFunction : function(  rowIndex, columnIndex, item, dataField ) {
					var totalCnt = Number( item.totalCnt );
					var untpc = Number( item.untpc );
					var spprc = untpc * totalCnt;
					var result = null;
					if( item.taxtCd == "TAXT" ){
						result = ( spprc / 11 * 100 );
					}else{
						result = spprc;
					}
				
					return Number( result );
				}
			},{
				dataField: "vat",
				headerText: "VAT",
				width: "6%",
				style: "auiRight",
				dataType : "numeric",
				expFunction : function(  rowIndex, columnIndex, item, dataField ) {
					var spprc = item.spprc;
					var result = null;
					if( item.taxtCd == "TAXT" ){
						result = Number( ( spprc * 10 / 100 ) );
					}else{
						result = null;
					}
					return result;
				}
			},{
				dataField: "sum",
				headerText: "計",
				width: "6%",
				style: "auiRight",
				dataType : "numeric",
				expFunction : function(  rowIndex, columnIndex, item, dataField ) {
					var spprc = item.spprc;
					var vat = item.vat;
				
					return Number(spprc + vat);
				}
			}]
		},{
			dataField : "regiDate",
			headerText : "등록일",
			children : calendarLayout
		}
	];

	var footerLayout1 = [
		{
			labelText : "∑",
			positionField : "#base"
		}, {
			dataField : "prdDtlCd",
			positionField : "prdDtlCd",
			operation : "SUM",
			colSpan : 2, 
			labelFunction : function(value, columnValues, footerValues) {
				return "합계 : " 
			}
		}, {
			dataField : "totalCnt",
			positionField : "totalCnt",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "spprc",
			positionField : "spprc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "vat",
			positionField : "vat",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "sum",
			positionField : "sum",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		},{
			dataField : "regiDate",
			positionField : "regiDate",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}
	];

	footerLayout.forEach(function (item){ footerLayout1.push( item ) });
	
	mGrid3 = AUIGrid.create( "#grid_wrap3", columnLayout , auiGridProps );
	
	AUIGrid.setGridData(mGrid3, data.list);
	
	AUIGrid.setFooter(mGrid3, footerLayout1);
	
	//그리드 새로고침
	AUIGrid.refresh( mGrid3 );

	
}

//월 그리드 생성
function createMonthGrid( data ){
	var saveData = new Array();
	
	data.list.forEach(function(item,idx){
		if( item.monList ){
			item.monList.split(",").forEach(function(itm,i){
				var boxQty = Number(itm.split(':')[1]);
				var iddyQty = Number(itm.split(':')[2]);
				var faltQty = item.faltQty;
				saveData.push( { "rDate" : itm.split(':')[0],
					 "sumData" : ( boxQty * faltQty ) + iddyQty,
					 "prdDtlSeq" : item.prdDtlSeq });
			});
		}
	});
	
	//두날짜 차이 리스트
	var monList = getMonToLast( $("#monthPicker1").val() , $("#monthPicker2").val() );
	var obj = {};
	
	monList.forEach(function(itm,idx){
		var regiDate = "regiDate" + idx;
		saveData.forEach(function(item,index){
			if( itm.date == item.rDate ){
				obj[regiDate] = item.sumData;
				obj["prdDtlSeq"] = item.prdDtlSeq;
			}
		});
		
	});
	
	var resultData = new Array();
	
	//오브젝트 합치기
	data.list.forEach(function(item,idx){
		if( obj.prdDtlSeq == item.prdDtlSeq ){
			Object.assign( item , obj );
		}
	});
	
	var calendarLayout = [];
	var footerLayout = [];
	
	for( var i = 0; i < monList.length; i++ ){
		//레이아웃데이터 set
		calendarLayout[i] = {
				dataField : "regiDate"+i,
				headerText : monList[i].text,
				width : "11%",
				style : "auiRight"
		}
		footerLayout[i] = {
				dataField : "regiDate" + i,
				positionField : "regiDate" + i,
				operation : "SUM",
				style : "auiRight",
				colSpan : 1, 
				labelFunction : function(value, columnValues, footerValues) {
					return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}
	}
	
	var columnLayout = [
		{
			dataField : "prdDtlCd",
			headerText : "제품코드",
			width : "8%",
		},{
			dataField : "stdPrdNm",
			headerText : "제품명",
			style : "auiLeft"
		},{
			dataField : "totalCnt",
			headerText : "총수량",
			width : "7%",
			style: "auiRight",
			dataType : "numeric",
			expFunction : function(  rowIndex, columnIndex, item, dataField ) {
				var faltQty = item.faltQty;
				var monList = item.monList;
				var totalCnt = 0;
				if( monList ){
					monList.split(",").forEach(function(itm,i){
						var boxQty = Number(itm.split(':')[1]);
						var iddyQty = Number(itm.split(':')[2]);
					
						totalCnt += totalCnt + (boxQty * faltQty) + iddyQty;
					});
				}
				return totalCnt;
			}
		},{
			dataField : "untpc",
			headerText : "매입가",
			dataType : "numeric",
			width : "7%",
			style : "auiRight"
		},{
			dataField: "total",
			headerText: "합계",
			children: [{
				dataField: "spprc",
				headerText: "공급가",
				width: "6%",
				style: "auiRight",
				dataType : "numeric",
				expFunction : function( rowIndex, columnIndex, item, dataField ) {
					var totalCnt = Number( item.totalCnt );
					var untpc = Number( item.untpc );
					var spprc = untpc * totalCnt;
					var result = null;
					if( item.taxtCd == "TAXT" ){
						result = ( spprc / 11 * 100 );
					}else{
						result = spprc;
					}
				
					return Number( result );
				}
			},{
				dataField: "vat",
				headerText: "VAT",
				width: "6%",
				style: "auiRight",
				dataType : "numeric",
				expFunction : function(  rowIndex, columnIndex, item, dataField ) {
					var spprc = item.spprc;
					var result = null;
					if( item.taxtCd == "TAXT" ){
						result = Number( ( spprc * 10 / 100 ) );
					}else{
						result = null;
					}
					return result;
				}
			},{
				dataField: "sum",
				headerText: "計",
				width: "6%",
				style: "auiRight",
				dataType : "numeric",
				expFunction : function(  rowIndex, columnIndex, item, dataField ) {
					var spprc = item.spprc;
					var vat = item.vat;
				
					return Number(spprc + vat);
				}
			}]
		},{
			dataField : "regiDate",
			headerText : "등록일",
			children : calendarLayout
		}
	];

	var footerLayout1 = [
		{
			labelText : "∑",
			positionField : "#base"
		}, {
			dataField : "prdDtlCd",
			positionField : "prdDtlCd",
			operation : "SUM",
			colSpan : 2, // 자신을 포함하여 4개의 푸터를 가로 병합함.
			labelFunction : function(value, columnValues, footerValues) {
				// return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
				return "합계 : " 
			}
		}, {
			dataField : "totalCnt",
			positionField : "totalCnt",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "spprc",
			positionField : "spprc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "vat",
			positionField : "vat",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "sum",
			positionField : "sum",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}
	];

	footerLayout.forEach(function (item){ footerLayout1.push( item ) });
	
	mGrid2 = AUIGrid.create( "#grid_wrap2", columnLayout , auiGridProps );
	
	AUIGrid.setGridData(mGrid2, data.list);

	AUIGrid.setFooter(mGrid2, footerLayout1);

	//그리드 새로고침
	AUIGrid.refresh( mGrid2 );
}

// 푸터 설정
var footerLayout = [{
labelText : "∑",
positionField : "#base"
}, {
	dataField : "code",
	positionField : "code",
	operation : "SUM",
	colSpan : 1, 
	/*labelFunction : function(value, columnValues, footerValues) {
	   // return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
	   return "합계 : " 
	}*/
}];

var auiGridProps = {
	headerHeights : [58, 29],
	rowHeight : 29,
	// 편집 가능 여부 (기본값 : false)
	editable : false,
	// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
	enterKeyColumnBase : true,
	editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
	wrapSelectionMove : true,
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
	groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};

//표준제품 조회 그리드 속성
var auiGridProps1 = {
	headerHeight : 29,
	rowHeight : 29,
	// 편집 가능 여부 (기본값 : false)
	editable : false,
	autoGridHeight : true
};

//AUIGrid 를 생성합니다.
function createAUIGrid() {
	//매입처 그리드 생성
	mGrid = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps1);
}

function selectSumStatPchaList(){
	$.ajax({
		url : "/agn/selectSumStatPchaList.do", 
		type : 'POST', 
		//data : $("#frm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(mGrid, data.list);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

//엑셀 내보내기(Export);
function exportToDay() {
	AUIGrid.exportToXlsx(mGrid3, {
		// 스타일 상태 유지 여부(기본값:true)
		exportWithStyle : true,
		fileName : "매입집계 현황 일별 리스트"
	});
};

function exportToMon() {
	AUIGrid.exportToXlsx(mGrid2, {
		// 스타일 상태 유지 여부(기본값:true)
		exportWithStyle : true,
		fileName : "매입집계 현황 월별 리스트"
	});
};

function resizeGrid(){
	AUIGrid.resize(mGrid, $("#content").width());
	AUIGrid.resize(mGrid2, $("#content").width());
	AUIGrid.resize(mGrid3, $("#content").width());
}

function getDatesToLast(startDate, lastDate) {
	var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
	if(!(regex.test(startDate) && regex.test(lastDate))) return "날짜 포맷이 맞지않습니다.";
	
	var result = [];
	
	var curDate = new Date(startDate);
	
	while(curDate <= new Date(lastDate)) {
		var year = curDate.toISOString().split("T")[0].split("-")[0];
		var month = curDate.toISOString().split("T")[0].split("-")[1];
		var day = curDate.toISOString().split("T")[0].split("-")[2];

		result.push( month + "-" + day);
		curDate.setDate(curDate.getDate() + 1);
	}
	return result;
}

function getMonToLast( startMon, lastMon ) {
	var regex = RegExp(/^\d{4}-(0[1-9]|1[012])$/);
	if(!(regex.test(startMon) && regex.test(lastMon))) return "날짜 포맷이 맞지않습니다.";
/* 	var input1="2022-01";
	var input2="2022-04"; */
	
	var startYear = startMon.split("-")[0];
	var startMonth = startMon.split("-")[1];
	var endYear = lastMon.split("-")[0];
	var endMonth = lastMon.split("-")[1];
	
	var startDt = new Date( startYear , startMonth );
	var endDt = new Date( endYear , endMonth );

	//시작월
	var useStartDt = ( startDt.getMonth() == 0 ) ? 12 : startDt.getMonth();
	//종료월
	var useEndDt = ( endDt.getMonth() == 0) ? 12 : endDt.getMonth();
	
	var result = [];
	if( useStartDt == useEndDt ){
		var firstDay = new Date( startDt.getFullYear() , useStartDt , 1 );
		var lastDay = new Date( startDt.getFullYear() , useEndDt , 0 );
		
		result.push( { "text" :startDt.getMonth()+"월" + "(0"+firstDay.getDate()+" ~ "+lastDay.getDate()+")" ,"date" : startDt.getMonth() } );
	}else{
		var monListSize = useEndDt - useStartDt;
		for(var i = 0; i <= monListSize; i++ ){
			var firstDay = new Date( startDt.getFullYear() , startDt.getMonth()+i , 1 );
			var lastDay = new Date( startDt.getFullYear() , startDt.getMonth()+i , 0 );
			result.push( { "text" : startDt.getMonth()+i+"월" + "(0"+firstDay.getDate()+" ~ "+lastDay.getDate()+")" ,"date" : startDt.getMonth()+i } );
		}
	}
	
	return result;
}

function validation(){
	var popupParam = [];
	var result = true;
	
	if( !$("#monthPicker1").val() || !$("#monthPicker2").val() ){
		result = false;
		popupParam.data = {
				title : "매입집계 현황",
				message : "등록일을 선택해주세요.",
				showBtn2 : 'N'
		}
		layerAlert(popupParam);
		//return;
	}
	return result;
}

function selectPchaSumStatDayList( item ){
	if( !$("#puchSeq").val() ){
		var popupParam = [];
		popupParam.data = {
				title : "매입집계 현황",
				message : "매입처를 선택해주세요.",
				showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	
	item.startDt = $("#datepicker01").val().replace("-",'').replace("-",'');
	item.endDt = $("#datepicker02").val().replace("-",'').replace("-",'');
	
	$.ajax({
		url : "/agn/selectPchaSumStatDayList.do",
		type : 'POST',
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(item),
		success : function(data) {
			createDayGrid( data );
			$("#dayCon .pColor01").html(data.list.length);
		},
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function selectPchaSumStatMonList( item ){
	if( !$("#puchSeq").val() ){
		var popupParam = [];
		popupParam.data = {
				title : "매입집계 현황",
				message : "매입처를 선택해주세요.",
				showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	
	item.startMon = $("#monthPicker1").val().split("-")[1];
	item.endMon = $("#monthPicker2").val().split("-")[1];
		
	$.ajax({
		url : "/agn/selectPchaSumStatMonList.do",
		type : 'POST',
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(item),
		success : function(data) {
			createMonthGrid(data);
			$("#monthCon .pColor01").html(data.list.length);
		},
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function selectMjrPchaSumStatDayList( item ){
	if( !$("#puchSeq").val() ){
		var popupParam = [];
		popupParam.data = {
				title : "매입집계 현황",
				message : "매입처를 선택해주세요.",
				showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	
	item.startDt = $("#datepicker01").val().replace("-",'').replace("-",'');
	item.endDt = $("#datepicker02").val().replace("-",'').replace("-",'');
	
	$.ajax({
		url : "/agn/selectMjrPchaSumStatDayList.do",
		type : 'POST',
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(item),
		success : function(data) {
			createDayGrid( data );
			$("#dayCon .pColor01").html(data.list.length);
		},
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function selectMjrPchaSumStatMonList( item ){
	if( !$("#puchSeq").val() ){
		var popupParam = [];
		popupParam.data = {
				title : "매입집계 현황",
				message : "매입처를 선택해주세요.",
				showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	
	item.startMon = $("#monthPicker1").val().split("-")[1];
	item.endMon = $("#monthPicker2").val().split("-")[1];
		
	$.ajax({
		url : "/agn/selectMjrPchaSumStatMonList.do",
		type : 'POST',
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(item),
		success : function(data) {
			createMonthGrid(data);
			$("#monthCon .pColor01").html(data.list.length);
		},
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>


	<!-- 조회 -->
	<form id="frm">
		<input type="hidden" id="puchSeq" name="puchSeq">
		<div class="inquiryBox">
			<dl>
				<dt>등록일</dt>
				<dd>
					<div class="formWrap">
						<div class="formWrap" id="dayPicker">
							<div class="dateWrap">
								<input type="text" name="startDt" value="" class="inp" id="datepicker01" readonly>
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker01"></button>
							</div>
							<span class="divi02">-</span>
							<div class="dateWrap">
								<input type="text" name="endDt" value=""class="inp" id="datepicker02" readonly>
								<button type="button" class="datepickerBtn02" title="날짜입력" data-target-id="datepicker02"></button>
							</div>
						</div>
						
						<div class="formWrap" id="monPicker" style="display: none;">
							<div class="dateWrap">
								<input type="text" name="startMon" value="" class="inp" id="monthPicker1" readonly>
								<button type="button" class="datepickerBtn" title="날짜입력"></button>
							</div>
							<span class="divi02">-</span>
							<div class="dateWrap">
								<input type="text" name="endMon" value=""class="inp" id="monthPicker2" readonly>
								<button type="button" class="datepickerBtn02" title="날짜입력"></button>
							</div>
						</div>
						<div class="checkGroup" id="pcha">
							<input type="radio" name="date" id="day" class="type01" id="day" checked="checked"><label for="day"><span>일 기준</span></label>
							<input type="radio" name="date" id="month" class="type01" id="month"><label for="month"><span>월 기준</span></label>
						</div>
					</div>
					
					<div class="formWrap" id="monPicker" style="display: none;">

					</div>
					
				</dd>
				<dt>제품</dt>
				<dd>
					<div class="formWrap">
						<input type="text" id="prdDtlCd" class="inp w120 mr10" value="" name="prdDtlCd" placeholder="제품코드">
						<input type="text" id="stdPrdNm" class="inp w160" value="" name="" placeholder="제품명">
						
						<button type="button" name="" class="comBtn" id="searchBtn">조회</button>
					</div>
				</dd>
			</dl>
		</div>
	</form>
	<!-- 조회 -->

	<!-- grid -->
	<div class="girdBoxGroup">
		<div class="girdBox topBlank w20per">
			<div id="grid_wrap"></div>
		</div>

		<div class="girdBox">
			<!-- 일 기준 -->
			<div class="rTabBox" id="dayCon">
			
				<div class="titleArea right">
					<p class="numState">
						<em>총 <span class="pColor01 fb"></span></em> 건 이 조회되었습니다.
					</p>
					<button type="button" name="" class="comBtn small" onclick="exportToDay();">엑셀다운</button>
				</div>
				<div id="grid_wrap3"> </div>
			</div>
			<!-- 일 기준 -->

			<!-- 월 기준 -->
			<div class="rTabBox hide" id="monthCon">
				<div class="titleArea right">
					<p class="numState">
						<em>총 <span class="pColor01 fb"></span></em> 건 이 조회되었습니다.
					</p>
					<button type="button" name="" class="comBtn small" onclick="exportToMon();">엑셀다운</button>
				</div>

				<div id="grid_wrap2" style="display: block;"> </div>
			</div>
			<!-- 월 기준 -->
		</div>
	</div>
</div>
