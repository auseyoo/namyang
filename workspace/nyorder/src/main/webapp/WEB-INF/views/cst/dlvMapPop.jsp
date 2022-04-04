<!-- 
	@File Name: dlvMapPop.jsp
	@File 설명 : 배달 지도 팝업
	@작성일 : 2022. 2. 15.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var popGrid;

var customOverlayList = [];
var markers = [];
var bounds = new kakao.maps.LatLngBounds();
var map;

$(document).ready(function(){
	createAUIGrid();
	
	// 지도 bind
	var container = document.getElementById("mapArea");	//지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	map = new kakao.maps.Map(container, options);
	container.style.height = $(".mapBox").height();
	map.relayout();

	// 그리드 클릭 시 좌표 이동
	AUIGrid.bind(popGrid, "cellClick", function( event ) {
		if(event.item.laloYn == "Y"){
			var moveLatLon = new kakao.maps.LatLng(event.item.mapLotu, event.item.mapLatu);
			map.setLevel(1);
			// 지도 중심을 이동 시킵니다
			map.setCenter(moveLatLon);
		}
	});

	$(".modalCloseBtn").click(function(){
		$.closeDialog("<c:out value='${param.id}'/>");
	});

	// 지도 인쇄
	$("#printBtn").on("click", printMap);
	
	searchList();

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
	// 셀 선택모드 (기본값: singleCell)
	selectionMode : "singleRow",
};
//AUIGrid 를 생성합니다.
function createAUIGrid() {
	if(AUIGrid.isCreated(popGrid) ){
		AUIGrid.destroy(popGrid);
	}
	popGrid = AUIGrid.create("#pop_grid_wrap", columnLayout, gridPros);
}

function searchList(){
	var params = {
		"areaSeq" : "${param.areaSeq}",
		"srcDate" : "${param.srcDate}"
	}
	$.ajax({
		url : "/cst/selectDailDlvCstDetailList.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(params),
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
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
	var rows = _.uniqBy(AUIGrid.getGridData(popGrid), "cstSeq")
	var loc = new Array();
	$.each(rows, function(i,v){
		// 키워드로 장소를 검색합니다
		if(!fnIsEmpty(v.laloYn) && v.laloYn == "Y"){
			// LatLngBounds 객체에 좌표를 추가합니다
			displayMarker({x: v.mapLatu, y:v.mapLotu}, v.dlvOrdr);
		}else if(!fnIsEmpty(v.dlvAddr) && !fnIsEmpty(v.dlvOrdr)){
			geocoder.addressSearch(v.dlvAddr, function(data, status, pagination){
				if (status === kakao.maps.services.Status.OK) {
					// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
					AUIGrid.getRowIndexesByValue(popGrid, "cstSeq", v.cstSeq).forEach(function(i){
						AUIGrid.updateRow(popGrid,{ mapLatu : data[0].x, mapLotu: data[0].y, laloYn: "Y"}, i);
					});
					// LatLngBounds 객체에 좌표를 추가합니다
					displayMarker(data[0], v.dlvOrdr);
					var row ={
						cstSeq : v.cstSeq,
						mapLatu : data[0].x, 
						mapLotu: data[0].y, 
						laloYn: "Y"
					}
					// 배달 정보 업데이트
					$.ajax({
						url : "/cst/saveDlvCstAddrLalo.do",
						contentType : "application/json; charset=utf-8",
						data : JSON.stringify(row),
						async: false,
						type : "POST",
						success : function(data) {

						}, // success
						error : function(xhr, status) {
							alert(xhr + " : " + status);
						}
					});	
				}else{
					AUIGrid.getRowIndexesByValue(popGrid, "cstSeq", v.cstSeq).forEach(function(i){
						AUIGrid.updateRow(popGrid,{ laloYn : "N"}, i);
					});
				}
			})
		}else{
			AUIGrid.getRowIndexesByValue(popGrid, "cstSeq", v.cstSeq).forEach(function(i){
				AUIGrid.updateRow(popGrid,{ laloYn : "N"}, i);
			});
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


function printMap(){
	var popFrm = $("#popFrm");
	var url = '${request.contextPath}/cst/printDlvMapPop.pop';
	var popup = window.open("","printDlvMapPop", 'width=1180px,height=820px,scrollbars=yes');

	popFrm.attr("target","printDlvMapPop");
	popFrm.attr("action",url);
	popFrm.attr("method","get");
	popFrm.submit();
}
</script>
<!-- 배달 지도 -->
<div class="popWrap largeLong" data-popup="dlvMapPop">
	<header>
		<h3>배달 지도</h3>
	</header>
	<div class="popCon">
		<form id="popFrm" >
			<input type="hidden" id="areaSeq" name="areaSeq" value="${param.areaSeq}"/>
			<input type="hidden" id="srcDate" name="srcDate" value="${param.srcDate}"/>
			<input type="hidden" id="agenSeq" name="agenSeq" value="${param.agenSeq}"/>
		
			<div class="popTitArea">
				<h3>배달 지도</h3>
				<div class="popBtnArea">
					<button type="button" name="" class="comBtn modalCloseBtn" id="modalCloseBtn">닫기</button>
					<button type="button" name="" class="comBtn" id="printBtn">인쇄</button>
				</div>
			</div>

			<div class="txtInfo pColor02">
				※ 강조된 애음자는 배달주소가 불확실하여 지도에 노출이 불가한 애음자입니다. 배달주소를 확인해주세요.
			</div>
			<div class="titleArea">
				<h3 class="tit01">지역명 : <span id="areaNm">${param.areaNm}</span></h3>	
			</div>
			<div class="mapBoxWrap">
				<div class="mapBox h600 w71per">
					<div id="mapArea" class="map" style="height: 600px;">
						<!--<span>지도 들어갈 자리 (개발작업예정)</span>-->
					</div>
				</div>
	
				<!-- grid -->
				<div class="girdBox w43per h600">  <!-- 배달불가 data가 나오는 경우 class="dataNot02" -->
					<div id="pop_grid_wrap"></div>
				</div>
				<!-- grid -->
			</div>
		</form>
	</div>
</div>
<!-- 배달 지도 -->