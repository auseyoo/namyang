<!-- 
	@File Name: areaOrdrChg.jsp
	@File 설명 : 순서변경
	@UI ID : 	UI-PCLI-1401P2
	@작성일 : 2022. 3. 21.
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
var popGrid;// 메인
$(document).ready(function(){
	/* 그리드 생성*/
	createAUIGrid();

	$("#closeBtn").click(function(){
		var list = fnGetGridListCRUD(popGrid);
		if(list.length> 0){
			var popupParam = [];
			popupParam.data = {
				title : "순서변경",
				message : "<spring:message code='alert.areaMng05'/>",
				btn1Func : function(){
					$.closeDialog("<c:out value='${param.id}'/>");
					closePopup('modalAlert');
				}, 
				showBtn2 : "Y"
			}
			layerAlert(popupParam);
			return;
		}

		AUIGrid.destroy(popGrid);
		$.closeDialog("<c:out value='${param.id}'/>");
	});	

	//순서변경 - 저장 버튼 클릭
	$("#saveOrdrBtn").click(function(){
		updateAreaByOrdrList();
	});
	
	selectAgenAreaListByOrdr();
});

function createAUIGrid() {
	if(AUIGrid.isCreated(popGrid) ){
		AUIGrid.destroy(popGrid);
	}
	popGrid	= AUIGrid.create("#pop_grid_wrap", 	columnLayout,	gridPros);
}

var gridPros = {
	headerHeight : 58,
	rowHeight : 29,
	// 편집 가능 여부 (기본값 : false)
	showStateColumn : true,
	wrapSelectionMove : true,
	editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
	showStateColumn : false,  // 앞에 보이는 아이콘 사용여부
	editable : false,
	// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
	enterKeyColumnBase : true,
	// 셀 선택모드 (기본값: singleCell)
	selectionMode : "singleRow",
	//showFooter : true,
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
var columnLayout = [
	{ dataField : "areaOrdr", headerText : "순서", width : "20%", editable : true, 
		renderer : { type : "TemplateRenderer" },
		labelFunction : function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) { // HTML 템플릿 작성
			var width = (cItem.width - 12);
			var template = '<input type="text" class="auiInput01 w50"';
			template += ' style="width:' + width + 'px;"'; 
			template += ' value="' + value +'" onblur="javascript:myInputHandler(' + rowIndex + ', this.value, event,\'areaOrdr\', this);"'
			template += ' onkeydown="if(event.keyCode == 9) event.preventDefault();"' 
			template += '>';
			return template;
		}
	}, 
	{ dataField : "agenAreaCd", headerText : "지역코드", width : "20%" }, 
	{ dataField : "areaNm", headerText : "지역명", style : "auiLeft" }, 
	{ dataField : "emplNm", headerText : "판매원명", width : "17%" }
];

function myInputHandler(rowIndex, selectedValue, event, datafieldName, t) {
	$(t).val(selectedValue);
	modifyItem = {	[datafieldName] : selectedValue	};
	AUIGrid.updateRow(popGrid, modifyItem, rowIndex);

};

function selectAgenAreaListByOrdr() {
	$.ajax({
		url : "/agn/selectAreaOrdrList.do",
		type : 'POST',
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
			$("#popTotCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert("순서변경 조회 중 오류가 발생하였습니다");
		}
	});
}

//순서변경 - 저장 
function updateAreaByOrdrList() {
	if(!fnGetGridListCRUD(popGrid).length > 0){
		alert("저장할 내용이 없습니다.");
		return;
	}

	var saveList = AUIGrid.getGridData(popGrid);
	$.each(saveList, function(i, v){
		if(!fnIsEmpty(v.areaOrdr)){
			if( v.areaOrdr.indexOf(".") == 0 ){
				v.areaOrdr = "";
			}
		}
	});
	
	$.ajax({
		url : "/agn/updateAreaOrdrList.do",
		type : 'POST', 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(saveList),
		success : function(data) {
			if (CommUtil.isNotEmpty(data.res) && data.res){
				var popupParam = [];
				popupParam.data = {
					title : "공지사항 관리",
					message : "저장 되었습니다.",
					showBtn2 : 'N'
 				}
 				layerAlert(popupParam);
				$.successDialog("<c:out value='${param.id}'/>");
				$.closeDialog("<c:out value='${param.id}'/>");
			}else{
				alert("저장 실패 하였습니다.\n다시 시도해 주세요.");
			}
		}, // success 
		error : function(xhr, status) {
			if ( Common.IsJsonString(xhr.responseText) )
			{
				var popupParam = [];
				var message = JSON.parse(xhr.responseText).message;
				popupParam.data = {
					title : "공지사항 관리",
					message : message,
					showBtn2 : 'N'
 				}
 				layerAlert(popupParam);
			}
			else{
				alert("처리중 오류가 발생 하였습니다.");
			}
		}
	});
}
</script>

<!-- 판매원 선택 -->
<div class="popWrap mideum modal_wrap h520" data-popup="modalAgencyViews02">
	<header>
		<h3>순서변경</h3>
	</header>

	<div class="popCon">
		<div class="popTitArea">
			<h3>순서변경</h3>

			<div class="popBtnArea">
					<button type="button" name="" class="inquBtn" id="saveOrdrBtn">저장</button>
					<button type="button" name="" class="comBtn" id="closeBtn">닫기</button>				   
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