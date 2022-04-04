<!--
	@File Name: bcncInfoPop.jsp
	@File 설명 : 대리점정보조회 팝업
	@UI ID : UI-PLOG-0101P1
	@작성일 : 2022. 3. 25.
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>
var myGridID;
var columnLayout = [{
    dataField: "agenCd",
    headerText: "대리점 코드",
    width: "22%",
}, {
    dataField: "agenNm",
    headerText: "대리점명",
}, {
    dataField: "emplCd",
    headerText: "직원코드",
    width: "20%"
}, {
    dataField: "emplNm",
    headerText: "직원명",
    width: "20%"
}];

$(document).ready(function() {
	if(AUIGrid.isCreated(myGridID) ){
		AUIGrid.destroy(myGridID);
	}
    createAUIGrid(columnLayout);
    agenSearch();

    AUIGrid.bind(myGridID, "selectionChange", function(event) {
		var primeCell = event.primeCell;
		var rowItem = primeCell.item;
		$("#emplCd").val(rowItem.emplCd);
		$("#bizEmplCd").val($("#bizNo").val() + "/" +rowItem.emplCd);
		$.successDialog("<c:out value='${param.id}'/>",null);
		closePop();
	});
});

var gridPros = {
    headerHeight: 29,
    rowHeight: 29,
    editable: false,
    enterKeyColumnBase: true,
    selectionMode: "singleRow",
    useContextMenu: true,
    enableFilter: true,
    useGroupingPanel: false,
    displayTreeOpen: true,
    noDataMessage: "출력할 데이터가 없습니다.",
    groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};

function createAUIGrid(columnLayout) {
    myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);

}
function agenSearch(){

	var formData = $("#loginform").serialize();
	console.log("formData=="+JSON.stringify(formData));
	formData = formData + "&username=" + $("#bizNo").val() + "," + $("#emplCd").val();

	$.ajax({
		cache : false,
		url : "/agenSearch.do",
		type : 'POST',
		data : formData,
		success : function(data) {
			AUIGrid.setGridData(myGridID, data);
			$("#listCnt").html(data.length);
		}, error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}
function closePop() {
    $.closeDialog("<c:out value='${param.id}'/>")
}
</script>
<div class="popArea">
	<div class="popWrap mideum h420" data-popup="bcncInfoPop" style="left:0; right:0;">
		<header>
			<h3>대리점 조회</h3>
		</header>

		<!-- popCon -->
		<div class="popCon">
			<div class="popTitArea">
				<h3>대리점 정보조회</h3>

				<div class="popBtnArea">
					<!-- <button type="button" name="" class="inquBtn">확인</button> -->
				</div>
			</div>

			<p class="numState">
				<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
			</p>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap"></div>
			</div>
			<!-- grid -->
		</div>
		<!-- popCon -->
	</div>
</div>
<script>

</script>