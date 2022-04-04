<!-- 
	@File Name: emplSearchPop
	@File 설명 : 판매원 선택(팝업)
	@UI ID : UI-PCLI-1401P1
	@작성일 : 2022. 3. 17.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">
var popGrid;	// 메인
$(document).ready(function(){
	/* 그리드 생성*/
	createAUIGrid();

	$("#closeBtn").click(function(){
		AUIGrid.destroy(popGrid);
		$.closeDialog("<c:out value='${param.id}'/>");
	});	
		

	/* 지역 관리 - 세부 정보 - 판매원명 */
	AUIGrid.bind(popGrid, "cellClick", function(event) {
		AUIGrid.destroy(popGrid);
		$.successDialog("<c:out value='${param.id}'/>", event.item);
		$.closeDialog("<c:out value='${param.id}'/>");
	});

	selectEmplList();
});

function createAUIGrid() {
	if(AUIGrid.isCreated(popGrid) ){
		AUIGrid.destroy(popGrid);
	}
	popGrid	= AUIGrid.create("#pop_grid_wrap", 	columnLayout,	gridPros);
}

var gridPros = {
		headerHeight : 30,
		rowHeight : 30,
		// 편집 가능 여부 (기본값 : false)
		editable : false,
		// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
		enterKeyColumnBase : true,
		// 셀 선택모드 (기본값: singleCell)
		selectionMode : "singleRow",
		// 그룹핑 패널 사용
		useGroupingPanel : false,
		// 체크박스 사용 
		showRowCheckColumn : false,
		// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
		displayTreeOpen : true,
		noDataMessage : "출력할 데이터가 없습니다.",
		groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
};
var columnLayout = [
	{	dataField : "emplCd",	headerText : "직원코드",	width : "18%",	style : "auiLink"	},
	{	dataField : "emplNm",	headerText : "판매원명"	},
	{	dataField : "mobNo",	headerText : "휴대폰번호",	width : "20%",	},
	{	dataField : "reteYnNm",	headerText : "상태",		width : "20%"	}
];

function selectEmplList() {
	$.ajax({
		url : "/agn/selectEmplList.do",
		type : 'POST',
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
			$("#popTotCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert("판매원명 조회 중 오류가 발생하였습니다");
		}
	});
}


</script>

<!-- 판매원 선택 -->
<div class="popWrap mideum modal_wrap h520" data-popup="modalAgencyViews02">
	<header>
		<h3>판매원 선택</h3>
	</header>  

	<div class="popCon">
		<div class="popTitArea">
			<h3>판매원 선택</h3>

			<div class="popBtnArea">
				<button type="button" class="comBtn modalCloseBtn ui-dialog-titlebar-close" id="closeBtn">닫기</button>
			</div>
		</div>

		<p class="numState">
			<em>총 <span class="pColor01 fb" id="popTotCnt">0</span></em> 건 이 조회되었습니다.
		</p>

		<!-- grid -->
		<div class="girdBox">
			<div id="pop_grid_wrap"></div>
		</div>
		<!-- grid -->

	</div>
</div>
<!-- 판매원 선택 -->