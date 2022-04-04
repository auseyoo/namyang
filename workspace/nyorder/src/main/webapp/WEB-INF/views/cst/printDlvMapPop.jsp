<!-- 
	@File Name: dlvMapPop.jsp
	@File 설명 : 배달 지도 인쇄 팝업
	@작성일 : 2022. 2. 15.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"  %>
<!DOCTYPE html>
<style>
	body,html{margin:0; padding:0; font-size:12pt; overflow-y:auto;}
	* {color-adjust: exact!important; -webkit-print-color-adjust: exact!important; print-color-adjust: exact!important; box-sizing:border-box; -moz-box-sizing: border-box;}
     .page {width:29.7cm; min-height:1cm; padding:1cm 1cm; margin:1cm auto; background:#fff; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}
	/*.subpage {padding:1cm; height:256mm;}*/
	@page {
		/*size: A4 landscape;*/    /*Portrait*/
		size: A4 landscape; /* 가로 */ 
		margin:5px 0 5px;	
	}
	@media print {
		html, body {margin:0; padding:0; overflow-y:inherit;}
		.page {margin:0; border:initial; border-radius:initial; width:initial; min-height:initial; box-shadow:initial; background:initial; size: A4 landscape;}
		.tbl tbody th {background:#f5f5f5 !important;}
		.aui-grid .aui-grid-table td{font-size:9pt;}
	}

	/*table, img, svg {break-inside:avoid;}*/
	.printWrap{text-align:center;}
	.printWrap h2{font-size:27px; text-decoration:underline;}

	.tblWrap{height:100%;}
	table[class*="tbl"] {table-layout:fixed; width:100%; height:100%; clear:both; border-collapse:collapse;}
	table[class*="tbl"] tr > * {vertical-align:middle;}
	.tbl {border:1px solid #dedede;}
	.tbl tbody th, .tbl tbody td{white-space:nowrap;}
	.tbl thead th {font-size:10pt; font-weight:bold; height:20px; line-height:20px; background:#f5f5f5; border-right:1px solid #dedede; border-bottom:1px solid #dedede; padding:0 5px; color:#000;}
	.tbl tbody td {font-size:9.5pt; text-align:left; border-right:1px solid #dedede; border-bottom:1px solid #dedede; padding:4px 7px 4px 7px; height:100%;}
	.tbl tbody td p{margin:0;}
	.tbl tbody td.ac{text-align:center;}
	.tbl tbody td.ar{text-align:right;}
	caption,legend{visibility:hidden;}

	.dateInfo{font-size:12pt; text-align:center; margin:10px 0 18px;}

	.confirm{display:flex; justify-content:space-between; font-size:11pt;}
	.ac{text-align:center;}
	.ar{text-align:right;}

	.mapBoxWrap{}
	.mapBoxWrap .mapBox{display:inline-block; position:relative; margin-right:20px;}
	.mapBoxWrap .girdBox{display:inline-block;}
	.mapBoxWrap .pin{position:absolute; width:38px; height:46px; background:url('../images/pin_bg_01.png') no-repeat center 0; text-align:center;}
	.mapBoxWrap .pin span{width:100%; font-size:14px; text-align:center; padding-top:7px;}
	.mapBox{position:relative; overflow:hidden; width:100%; height:520px; border:1px solid #b9b9b9; text-align:center;}

	.w50per{width:50% !important}
	.h600{height:600px !important}
	.ml10{margin-left:10px}
</style>
<script type="text/javascript">
//AUIGrid 생성 후 반환 ID
var myGridID1;

var customOverlayList = [];
var markers = [];
var bounds = new kakao.maps.LatLngBounds();
var map;
$(document).ready(function(){
	createAUIGrid();
	searchList();
	
	// 지도 bind
	var container = document.getElementById("mapArea");	//지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	map = new kakao.maps.Map(container, options);
	container.style.height = $(".mapBox").height();
	map.relayout();

	$("#weekDay").html(fnGetWeekDay("${param.srcDate}"));

	
	// 그리드 클릭 시 좌표 이동
	AUIGrid.bind(myGridID1, "cellClick", function( event ) {
		if(event.item.laloYn == "Y"){
			var moveLatLon = new kakao.maps.LatLng(event.item.mapLotu, event.item.mapLatu);
			map.setLevel(1);
			// 지도 중심을 이동 시킵니다
			map.setCenter(moveLatLon);
		}
	});
});

var columnLayout = [
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
		headerHeight : 58,
		rowHeight : 29,
		// 편집 가능 여부 (기본값 : false)
		showRowNumColumn : false, 
		editable : false,
		enterKeyColumnBase : true,
		autoGridHeight : true,
		// 셀 선택모드 (기본값: singleCell)
		selectionMode : "singleRow",
};
//AUIGrid 를 생성합니다.
function createAUIGrid() {
	myGridID1 = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
}

function searchList(){
	var params = {
		"areaSeq" : $(opener.document).find("#areaSeq").val(),
		"srcDate" : $(opener.document).find("#srcDate").val()
	}
	$.ajax({
		url : "/cst/selectDailDlvCstDetailList.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(params),
		success : function(data) {
			AUIGrid.setGridData(myGridID1, data);
			searchAddr();
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}


function searchAddr(){
	$.each(customOverlayList, function(i,v){
		v.setMap(null);
	});
	
	bounds = new kakao.maps.LatLngBounds();
	var geocoder = new kakao.maps.services.Geocoder();
	var rows = _.uniqBy(AUIGrid.getGridData(myGridID1), "cstSeq")
	var loc = new Array();
	var cnt = 0
	$.each(rows, function(i,v){
		if(cnt < 50){
			if(!fnIsEmpty(v.laloYn) && v.laloYn == "Y"){
				// LatLngBounds 객체에 좌표를 추가합니다
				displayMarker({x: v.mapLatu, y:v.mapLotu}, v.dlvOrdr);
				cnt++;
			}else if(!fnIsEmpty(v.dlvAddr) && !fnIsEmpty(v.dlvOrdr) ){
				geocoder.addressSearch(v.dlvAddr, function(data, status, pagination){
					if (status === kakao.maps.services.Status.OK) {
						// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
						
						AUIGrid.getRowIndexesByValue(myGridID1, "cstSeq", v.cstSeq).forEach(function(i){
							AUIGrid.updateRow(myGridID1,{ mapLatu : data[0].x, mapLotu: data[0].y, laloYn: "Y"}, i);
						});
						
						// LatLngBounds 객체에 좌표를 추가합니다
						displayMarker(data[0], v.dlvOrdr);
						cnt++;
					}else{
						AUIGrid.getRowIndexesByValue(myGridID1, "cstSeq", v.cstSeq).forEach(function(i){
							AUIGrid.updateRow(myGridID1,{ laloYn : "N"}, i);
						});
					}
				})
			}else{
				AUIGrid.getRowIndexesByValue(myGridID1, "cstSeq", v.cstSeq).forEach(function(i){
					AUIGrid.updateRow(myGridID1,{ laloYn : "N"}, i);
				});
			}
		}
	});
	
}

//지도에 마커를 표시하는 함수입니다
function displayMarker(place, dlvOrdr) {
	// 커스텀 오버레이에 표시할 내용입니다     
	// HTML 문자열 또는 Dom Element 입니다 
	var content = "";
	if(dlvOrdr.length > 2){
		content = '<div class="pin"><span class="fs13">'+dlvOrdr+'</span></div>';
	}else{
		content = '<div class="pin"><span>'+dlvOrdr+'</span></div>';
	}
	
	// 커스텀 오버레이가 표시될 위치입니다 
	var position = new kakao.maps.LatLng(place.y, place.x);

	// 커스텀 오버레이를 생성합니다
	customOverlay = new kakao.maps.CustomOverlay({
		position: position,
		content: content,
		map: map
	});

	// 커스텀 오버레이를 지도에 표시합니다
	customOverlay.setMap(map);
	customOverlayList.push(customOverlay);
	
	bounds.extend(new kakao.maps.LatLng(place.y, place.x));
	// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	map.setBounds(bounds);
}
</script>
<body>
	<div class="printWrap">
		<div class="page" style="page-break-before : auto;">
			<h2>배달지도</h2>

			<p class="dateInfo">${param.srcDate}<span class="ml10" id="weekDay"></span></p>

			<div class="mapBoxWrap">
				<div class="mapBox h600 w71per">
					<div id="mapArea" class="map" style="height: 600px;">
						<!--<span>지도 들어갈 자리 (개발작업예정)</span>-->
					</div>
				</div>
	
				<!-- grid -->
				<div class="girdBox w43per h600">  <!-- 배달불가 data가 나오는 경우 class="dataNot02" -->
					<div id="grid_wrap">
					</div>
				</div>
				<!-- grid -->
			</div>
			
		</div>
	</div>
</body>
