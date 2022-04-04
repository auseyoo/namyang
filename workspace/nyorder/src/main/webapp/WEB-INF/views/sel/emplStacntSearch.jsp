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
		dataField : "sellNm",
		headerText : "판매원명",
		width : "5%",
	},{
		dataField : "name",
		headerText : "지역명",				  
	},{
		dataField : "thisMonth",
		headerText : "금월",
			children : [{
				dataField : "thisMonth01",
				headerText : "금월출고",
				dataType : "numeric",				
				width : "6%",
				style: "auiRight",				   
			}, {
				dataField : "thisMonth02",
				headerText : "판촉비",
				dataType : "numeric",
				width : "6%",
				style: "auiRight",
			}, {
				dataField : "thisMonth03",
				headerText : "판촉물",
				dataType : "numeric",
				width : "6%",
				style: "auiRight",
			}, {
				dataField : "thisMonth04",
				headerText : "기타",
				dataType : "numeric",
				width : "6%",
				style: "auiRight"
			}, {
				dataField : "thisMonth05",
				headerText : "금월합계",
				headerStyle : "auiRightBorR",
				dataType : "numeric",
				width : "8%",
				style: "auiRight"				
			}]
	},{
		dataField : "beMonth",
		headerText : "전월",
			children : [{
				dataField : "beMonth01",
				headerText : "전월청구",	   
				dataType : "numeric",			 
				width : "6%",
				style: "auiRight",				   
			}, {
				dataField : "beMonth02",
				headerText : "전월입금",
				dataType : "numeric",
				width : "6%",
				style: "auiRight",
			}, {
				dataField : "beMonth03",
				headerText : "전월미수",
				headerStyle : "auiRightBorR",
				dataType : "numeric",
				width : "6%",
				style: "auiRight",				
			}]
	},{
		dataField : "cal",
		headerText : "정산",
			children : [{
				dataField : "cal01",
				headerText : "중간입금",	
				dataType : "numeric",				
				width : "6%",
				style: "auiRight",				   
			}, {
				dataField : "cal02",
				headerText : "애음자정산",
				dataType : "numeric",
				width : "6%",
				style: "auiRight",
			}, {
				dataField : "cal03",
				headerText : "입금총액",
				dataType : "numeric",
				width : "7%",
				style: "auiRight",				
			}]
	},{
		dataField : "tax",
		headerText : "세금",
		dataType : "numeric",
		width : "6%",
		style: "auiRight"
	},{
		dataField : "fees",
		headerText : "수수료",
		dataType : "numeric",
		width : "6%",
		style: "auiRight"
	},{
		dataField : "billing",
		headerText : "청구금액",
		dataType : "numeric",
		width : "7%",
		style: "auiRight"
	}
];

// 푸터 설정
var footerLayout = [{
	labelText : "∑",
	positionField : "#base"
	}, {
		dataField : "sellNm",
		positionField : "sellNm",
		operation : "SUM",
		colSpan : 2, // 자신을 포함하여 ..
		labelFunction : function(value, columnValues, footerValues) {
		   return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
		}
	}, {
		dataField : "thisMonth01",
		positionField : "thisMonth01",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
		}
	}, {
		dataField : "thisMonth05",
		positionField : "thisMonth05",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
		}
	}, {
		dataField : "billing",
		positionField : "billing",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
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
						<input type="text" name="srcYear" value="2021" class="inp yearpicker" id="srcYear" readonly>
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
			<div class="btnGroup right">
				<button type="button" name="" class="comBtn">애음자정산설정</button>
				<button type="button" name="" class="comBtn">결산월마감처리</button>
			</div>
		</div>
	</form>
	
	<!-- 조회 -->
	<div class="titleArea right">
		<p class="numState">
			<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
		</p>
		<div class="formGroup">
			<button type="button" name="" class="comBtn small mr5">지역결산서</button>
			<button type="button" name="" class="comBtn small mr5">제품별 지역결산서</button>
			<button type="button" name="" class="comBtn small mr5">전지역결산서</button>
			<button type="button" name="" class="comBtn small">세무사제출용</button>
		</div>
	</div>

	<!-- grid -->
	<div class="girdBox">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->

</div>
