<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
	var myGridID;//왼쪽 그리드
	var myGridID2;//오른쪽 그리드

	$(document).ready(function(){
		createAUIGrid();
		//조회 버튼 클릭
		$("#searchBtn").click(function(){
			//조회
			selectRcbodList();
		});
		
	  //왼쪽 그리드 클릭 이벤트
		AUIGrid.bind(myGridID, "cellClick", function( event ) {
			var item = AUIGrid.getItemByRowIndex(myGridID, event.rowIndex);
			console.log("item", item);
			selectRcbodDtlList(item);
		});
	});
	
   
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
				headerHeight : 29,
				rowHeight : 29,
				// 편집 가능 여부 (기본값 : false)
				editable : true,
				enterKeyColumnBase : false, // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
				fixedColumnCount : 7,
				editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
				wrapSelectionMove : true,
				// 셀 선택모드 (기본값: singleCell)
				selectionMode : "multipleCells",
				showFooter : false,
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
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
		myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros);
	  
	}

	// 그리드 속성 설정
	var auiGridProps = {
			//scrollHeight : 18, // 스크롤의 높이
			//scrollThumbHeight : 16, // 스크롤 썸(thumb)의 높이
			fixedColumnCount : 7
	};

	var columnLayout = [{
			dataField : "rcbodSub",
			headerText : "제목",
			style: "auiLeft",
		},{
			dataField : "regDtm",
			headerText : "날짜",
			width : "30%",
			editable : false,	dataType : "date",		formatString: "yyyy-mm-dd" 
		}
	];

	var columnLayout2 = [{
			dataField : "agenCd",
			headerText : "대리점코드",
			width : "15%",
		},{
			dataField : "invc",
			headerText : "운송장번호",
			width : "15%",
		},{
			dataField : "prdNm",
			headerText : "물품명",
			width : "15%",
			style : "auiLeft"
		},{
			dataField : "qty",
			headerText : "수량",
			width : "5%",
			style : "auiRight"
		},{
			dataField : "consge",
			headerText : "수하인명",
			width : "10%",
		},{
			dataField : "addr",
			headerText : "주소",
			style : "auiLeft",
		}
	];
 	
	//왼쪽 그리드 자료실 리스트 조회
	function selectRcbodList(){
		$.ajax({
			url : "/cmmc/selectRcbodList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data);
				$("#totCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert("자료실 조회 중 오류가 발생하였습니다");
			}
		});
	}

	//왼쪽 그리드 셀 클릭 시 내용 조회
	function selectRcbodDtlList(obj){
 	$.ajax({
			url : "/cmmc/selectRcbodDtlList.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(obj),
			success : function(data) {
				AUIGrid.setGridData(myGridID2, data);
			}, // success 
			error : function(xhr, status) {
				alert("자료실 목록 조회 중 오류가 발생하였습니다");
			}
		});
 }
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />
	<!-- 조회 -->
	<div class="inquiryBox">
		<dl>
			<dt>검색어</dt>
			<dd>
				<form id="frm">
					<div class="formWrap">
						<select id="srcType" class="sel mr10" name="srcType">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="all">제목+내용</option>
						</select>
						<input type="text" name="srcKeyword" id="srcKeyword" class="inp w160 mr10"></input>
						<button type="button" name="searchBtn" class="comBtn" id="searchBtn">조회</button>
					</div>
				</form>
			</dd>
		</dl>
	</div>
	<!-- 조회 -->

	<div class="girdBoxGroup type02">
		<div class="girdBox w33per">
			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="totCnt">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap"></div>
			</div>
			<!-- grid -->
		</div>

		<div class="conBox w65per">
			<div class="titleArea right">
				<h3 class="tit01">내용</h3>
			</div>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap2"></div>
			</div>
			<!-- grid -->
		</div>
	</div>

</div>
