<!-- 
	@File Name: stdPrdSearchPop
	@File 설명 : 표준 제품 팝업
	@UI ID : 
	@작성일 : 2022. 3. 3.
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

	$("#preSrcBtn").click(baseListSearch);

	baseListSearch();

	AUIGrid.bind(popGrid, "cellClick", function(event) {
		AUIGrid.destroy(popGrid);
		$.successDialog("<c:out value='${param.id}'/>", event.item);
		$.closeDialog("<c:out value='${param.id}'/>");
	});

	
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
		selectionMode : "singleCell",
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
	{
		dataField : "prdSapCd",
		headerText : "제품코드",
		width : "25%",
		style : "auiLink"
	},{
		dataField : "prdNm",
		headerText : "제품명",
		style : "auiLeft"
	},{
		dataField : "prdSeq",
		headerText : "코드",
		visible:false,
	},{
		dataField : "prdDtlSeq",
		headerText : "상세코드",
		visible:false,
	}
];

/* 표준 제품 조회(이전제품) - 리스트 조회 */
function baseListSearch(){
	var frm = $('#preFrm');
	$.ajax({
		url : "/std/selectStdPrdMngList.do",
		type : 'POST', 
		data : frm.serialize(),
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}

</script>


<div class="popWrap mideum" data-popup="srcAgenStdPrdPop">
	<header>
		<h3>제품 조회</h3>
		<button type="button" name="" class="closeBtn modalCloseBtn"></button>
	</header>  

	<!-- popCon -->
	<div class="popCon">
		<div class="popTitArea">
			<h3>제품 조회</h3>
		</div>
		
		<!-- 조회 -->
		<form id="preFrm">
			<div class="inquiryBox dtShort">
				<dl>
					<dt>구분</dt>
					<dd>
						<div class="formWrap">
							<select name="srcType" class="sel w120 mr10" id="srcType">
								<option value="">전체</option>
								<option value="prdNm">제품명</option>
								<option value="prdCd">제품코드</option>
							</select>							
						</div>
					</dd>
					
					<dd>
						<div class="formWrap">
							<input type="text" id="srcKeyword" class="inp w160 mr7" value="" name="srcKeyword">
							<button type="button" name="" class="comBtn" id="preSrcBtn">조회</button>
						</div>
					</dd>
				</dl>
			</div>
		</form>
		<!-- 조회 -->

		<div class="girdBoxGroup" style="height:300px">
			<!-- grid -->
			<div class="girdBox" style="height:300px">
				<div id="pop_grid_wrap"></div>
			</div>
			<!-- grid -->
		</div>
	</div>
	<!-- popCon -->
</div>