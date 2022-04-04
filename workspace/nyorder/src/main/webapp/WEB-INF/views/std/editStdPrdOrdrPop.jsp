<!-- 
	@File Name: stdPrdMng.jsp
	@File 설명 : 표준제품 관리
	@UI ID : UI-PSTD-0201
	@작성일 : 2022. 1. 11.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<code:makeSelect commGrpCd="TAXT_CD" 	var="taxtCdList"	name="taxtCd"	all="false" />
<style>
/* 커스텀 열 스타일 */
.my-column-style {
	background:#eeeeee;
	color:#005500;
	font-weight:bold;
	padding: 1px solid black;
	
}
</style>

<script type="text/javascript">
var popGrid;	// 메인
$(document).ready(function(){
	/* 그리드 생성*/
	createAUIGrid();

	$("#closeBtn").click(function(){
		$.closeDialog("<c:out value='${param.id}'/>");
	});

	$("#saveOrdrBtn").on("click", uptStdPrdOrdr);

	popSearchList();
});
//AUIGrid 를 생성합니다.
function createAUIGrid() {
	if(AUIGrid.isCreated(popGrid) ){
		AUIGrid.destroy(popGrid);
	}
	popGrid	= AUIGrid.create("#pop_grid_wrap", 	columnLayout,	gridPros);
}

var columnLayout = [
	{
		dataField : "prdOrdr",
		headerText : "순서",
		width : "20%" ,
		editable : true,
		editRenderer : {
			// 0~9만 입력가능
			onlyNumeric : true,
			// 소수점( . ) 도 허용할지 여부
			allowPoint : true, 
			// 마이너스 부호(-) 허용 여부
			allowNegative : false,
			maxlength : 3,
		},
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) { // HTML 템플릿 작성
			var width = (cItem.width - 12);
			var template = '<input type="text" class="auiInput01 w50"';
			template += ' style="width:' + width + 'px;"'; 
			template += ' value="' + value +'" onblur="javascript:myInputHandler(' + rowIndex + ', this.value, event,\'prdOrdr\', this);"'
			template += ' onkeydown="if(event.keyCode == 9) event.preventDefault();"' 
			template += '>';
			return template;
		}
	},{
		dataField : "prdSapCd",
		headerText : "제품코드",
		width : "20%",
		editable : false
	},{
		dataField : "prdNm",
		headerText : "제품명",
		style : "auiLeft",
		editable : false
	}
];

var gridPros = {
	headerHeight : 58, 
	rowHeight : 29,
	editable : true,
	showRowCheckColumn : false,
};

function myInputHandler(rowIndex, selectedValue, event, datafieldName, t) {
	$(t).val(selectedValue);
	modifyItem = {	[datafieldName] : selectedValue	};
	AUIGrid.updateRow(popGrid, modifyItem, rowIndex);

};

/* 표준 제품 - 리스트 조회 */
function popSearchList(){
	var frm = $('<form></form>');
	resizeGrid();
	
	$.ajax({
		url : "/std/selectStdPrdMngList.do", 
		type : 'POST', 
		data : frm.serialize(),
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
			$("#ordCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}

/* 표준 제품 순서 변경 팝업 - 순서 저장 */
function uptStdPrdOrdr(){
	var list = AUIGrid.getGridData(popGrid);

	$.each(list, function(i, v){
		if(!fnIsEmpty(v.prdOrdr)){
			if( v.prdOrdr.indexOf(".") == 0 ){
				v.prdOrdr = "";
			}
		}
	});
	
	$.ajax({
		url : "/std/saveStdPrdOrdr.do", 
		type : 'POST', 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(list),
		success : function(data) {
			/* var popupParam = [];
			popupParam.data = {
				title : "표준제품 우선순위 변경",
				message : data,
				showBtn2 : "N"
			}
			layerAlert(popupParam); */
			popSearchList();
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 
}

function resizeGrid(){
	AUIGrid.resize(popGrid, $("#content").width());
}

</script>

<!-- 표준제품 순서변경 -->
<div class="popWrap small modal_wrap">
	<header>
		<h3>표준제품 우선순위 변경</h3>
	</header>

	<div class="popCon">
		<div class="popTitArea">
			<h3>표준제품 우선순위 변경</h3>

			<div class="popBtnArea">
				<button type="button" name="" class="inquBtn" id="saveOrdrBtn">저장</button>
				<button type="button" name="closeBtn" id="closeBtn" class="comBtn">닫기</button>				   
			</div>
		</div>

		<p class="numState">
			<em>총 <span class="pColor01 fb" id="ordCnt">0</span></em> 건 이 조회되었습니다.
		</p>

		<!-- grid -->
		<div class="girdBox">
			<div id="pop_grid_wrap"></div>
		</div>
		<!-- grid -->
	</div>
</div>
<!-- 표준제품 순서변경 -->


<!-- Alert03 -->
<div class="alertWrap small modal_wrap" data-popup="modalConfirm">
	<header>
		<h3>표준제품 우선순위변경</h3>
		<button type="button" name="" class="closeBtn modalCloseBtn" data-target="modalConfirm"></button>
	</header>
	<div class="alertCon">
		<p id="confirmMessage">
			변경사항이 저장되지 않았습니다. <br/>
			그대로 진행하시겠습니까?
		</p>
		<div class="popBtnArea">
			<button type="button" name="" class="inquBtn" id="confirmBtn">확인</button>
			<button type="button" name="" class="comBtn modalCloseBtn" data-target="modalConfirm">취소</button>
		</div>
	</div>
</div>
<!--// Alert03 -->