<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	var myGridID;

	$(document).ready(function() {
		createAUIGrid();
		$("#srcBtn").on("click", searchList);
	});

	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	}

	var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : true,
			autoGridHeight : true,
			
			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase : true,

			showRowNumColumn : true, 
			
			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "singleRow",
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

	var columnLayout = [{
		dataField : "month",
		headerText : "정산년월",
		width : "15%",
	},{
		dataField : "endDivi",
		headerText : "마감장 구분",
		width : "15%",
		style: "auiLeft"
	},{
		dataField : "fileNm",
		headerText : "파일명",
		style: "auiLeft auiLink"
	},{
		dataField : "download",
		headerText : "다운로드",
		width : "7%",
		style : "moBtn",
		renderer : {
			type : "ButtonRenderer",
			onClick : function(event) {
				alert("( " + event.rowIndex + ", " + event.columnIndex + " ) " + event.item.download + " 다운로드 클릭");
			},
		}
	}];

	/* 표준 제품 - 리스트 조회 */
	function searchList() {
		$.ajax({
			url : "/prmt/selectPrmtCstSearchList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data);
				$("#listCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}

	function resizeGrid() {
		AUIGrid.resize(myGridID, $("#grid_wrap").width());
	}
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />
	<form id="frm">
		<!-- 조회 -->
		<div class="inquiryBox">
			<dl>
				<dt>년도</dt>
				<dd>
					<div class="dateWrap">
						<input type="text" name="date" value="2021" class="inp yearpicker" id="srcYear" readonly>
						<button type="button" class="datepickerBtn" title="년도입력" data-target-id="srcYear"></button>
					</div>
				</dd>
				<dt>마감장 구분</dt>
				<dd>
					<div class="formWrap">  
						<select name="" class="sel">
							<option>전체</option>
							<option>마감장</option>
							<option>거래장</option>
						</select>
						<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
					</div>
				</dd>
			</dl>
		</div>
	</form>
	
	<div class="txtInfo pColor02">
		※ 참고 “ <a href="#">전자계약시스템</a>” (← 클릭하여 바로가기)
	</div>
	
	<!-- 조회 -->
	<div class="titleArea">
		<p class="numState">
			<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
		</p>
	</div>

	<!-- grid -->
	<div class="girdBox">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->

</div>
