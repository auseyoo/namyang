<!-- 
	@File Name: searchAreaPrdPop
	@File 설명 : 표준제품검색 팝업
	@UI ID : 
	@작성일 : 2022. 2. 28.
	@작성자 : JIHUN
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
var popGridID;

$(document).ready(function() {
	createAUIGrid();

	AUIGrid.bind(popGridID, "selectionChange", function(event) {
        $.successDialog("<c:out value='${param.id}'/>", event.primeCell.item);
		closePop();
    })

	$("#layerSearchBtn").on('click', searchPrdList);
})

// events

function closePop() {
	AUIGrid.destroy(popGridID)
    $.closeDialog("<c:out value='${param.id}'/>")
}

// methods

function createAUIGrid() {
	var popColumnLayout = [{
			dataField : "prdDtlSeq",
			headerText : "제품코드",
            width : "15%" ,
            style : "auiLink"           	
        },{
			dataField : "prdNm",
			headerText : "제품명",
            style : "auiLink",
		},{
			dataField : "pchaUntpc",
			visible : false,
		},{
			dataField : "untpc",
			visible : false,
		},{
			dataField : "puchSeq",
			visible : false,
		},{
			dataField : "prdDtlSeq",
			visible : false,
		},{
			dataField : "prdSeq",
			visible : false,
		},{
			dataField : "emplUntpc",
			visible : false,
		}
	];

	var popGridPros = {
		headerHeight : 30,
		rowHeight : 30,
		editable : false,
		enterKeyColumnBase : true,
		selectionMode : "multipleCells",
		useContextMenu : true,
		enableFilter : true,
		useGroupingPanel : false,
		showRowCheckColumn : false,
		displayTreeOpen : true,
		noDataMessage : "출력할 데이터가 없습니다.",
		groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
	};

	popGridID = AUIGrid.create("#grid_wrap5", popColumnLayout, popGridPros);
}

// api

function searchPrdList(){
	var data = {};
	var searchField = $("#layerSearchField").val();
	var q = $("#layerSearchQ").val();

	if (searchField !== 'prdNm') {
		data.prdNm = q;
	} 
	if (searchField !== 'prdSapCd') {
		data.prdDtlSeq = q;
	}

	var url;
	if(typeof getActivedMygridID === 'function') { // 단가관리 페이지
		url = '/cst/selectAgenPrdPopList.do';
		var areaGridID = getActivedMygridID() == myGridID2 ? myGridID : myGridID3;
		data.areaSeq = AUIGrid.getCellValue(areaGridID, AUIGrid.getSelectedIndex(areaGridID)[0], "areaSeq");
		data.mrgnPrdCd = getActivedMygridID() == myGridID2 ? 'empl' : 'cst';
	} else { // 제품 일괄변경 페이지
		url = '/cst/searchBndChgPrdPopList.do'
	}	

	$.ajax({
		url : url, 
		type : 'POST', 
		data : data,
		success : function(data) {
			AUIGrid.setGridData(popGridID, data);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}


</script>
<div class="popArea">
	<%-- 제품 등록 레이어 S --%>
	<div class="popWrap small modal_wrap h560">
		<header>
			<h3>제품 등록</h3>
			<%-- <button type="button" name="" class="closeBtn" onclick = 'closePop()'></button> --%>
		</header> 

		<!-- popCon -->
		<div class="popCon">
			<div class="popTitArea">
				<h3>제품 등록</h3>

				<div class="popBtnArea">
					<button type="button" name="" class="comBtn" onclick = 'closePop()'>닫기</button>
				</div>
			</div>

			<!-- 조회 -->
			<div class="inquiryBox dtShort">
				<dl>
					<dt>구분</dt>
					<dd>
						<div class="formWrap">
							<select name="" class="sel w120 mr10" id="layerSearchField">
								<option value="">전체</option>
								<option value="prdNm">제품명</option>
								<option value="prdDtlSeq">제품코드</option>
							</select>                            
						</div>
					</dd>
					
					<dd>
						<div class="formWrap">
							<input type="text" class="inp w160 mr7" value="" id="layerSearchQ">
							<button type="button" name="" class="comBtn" id="layerSearchBtn">조회</button>
						</div>
					</dd>
				</dl>
			</div>
			<!-- 조회 -->

			<!-- grid -->
			<div class="girdBox" style="height:300px">
				<div id="grid_wrap5"></div>
			</div>
			<!-- grid -->

		</div>
		<!-- popCon -->
	</div>
	<%-- 제품 등록 레이어 E --%>
</div>