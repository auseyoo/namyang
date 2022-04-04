<!--
	@File Name: doubleHisPop
	@File 설명 : 더블작업 이력 (팝업)
	@UI ID : UI-PCLI-0701P1
	@작성일 : 2022. 3. 22.
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var popGrid;

	$(document).ready(function(){
		if(AUIGrid.isCreated(popGrid) ){
			AUIGrid.destroy(popGrid);
		}
        popCreateAUIGrid();
        setDaterangepicker();
    });
	var popGridPros = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
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

	// AUIGrid 를 생성합니다.
	function popCreateAUIGrid() {
		popGrid = AUIGrid.create("#pop_grid_wrap", popColumnLayout, popGridPros);


	}
	var popColumnLayout = [{
			dataField : "legacyDlvDt",
			headerText : "보내는 날",
            width : "15%",
        },{
			dataField : "chgDlvDt",
			headerText : "받는 날",
			width : "15%"
		},{
			dataField : "areaNm",
			headerText : "지역명",
			style : "auiLeft",
			width : "15%"
		},{
			dataField : "prdNm",
			headerText : "제품명",
			style : "auiLeft",
			width : "15%"
		},{
			dataField : "regDtm",
			headerText : "작업일자",
		},{
			dataField : "regNm",
			headerText : "작업자",
			width : "10%"
		},{
			dataField : "updDtm",
			headerText : "분리일자",
			width : "15%"
		},{
			dataField : "updNm",
			headerText : "작업자",
			width : "10%"
		}
	];

	function selectDoubleHisList(){
		AUIGrid.clearGridData(popGrid);
		$("#popListCnt").html(0);
		$.ajax({
			url : "/cst/selectDoubleHisList.do",
			type : 'POST',
			data : $("#popFrm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(popGrid, data);
				$("#popListCnt").html(data.length);
			}, // success
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
</script>
<form name="popFrm" id ="popFrm" onsubmit="return false;">
<div class="popArea">
	<div class="popWrap mideum modal_wrap h500" data-popup="modalAgencyViews01">
		<header>
			<h3>더블작업 이력</h3>
		</header>

		<div class="popCon">
			<div class="popTitArea">
				<h3>더블작업 이력</h3>

				<div class="popBtnArea">
					<!--<button type="button" name="" class="inquBtn">저장</button>-->
<!-- 					<button type="button" name="" class="comBtn modalCloseBtn" id="modalCloseBtn">닫기</button> -->
				</div>
			</div>

			<!-- 조회 -->
			<div class="inquiryBox">
				<dl>
					<dt>기간</dt>
					<dd>
						<div class="formWrap">
							<div class="dateWrap">
								<input type="text" name="srcStatDate" value="10/24/1984" class="datepicker" id="datepicker3" readonly="">
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker3"></button>
							</div>
							<span class="divi02">~</span>
							<div class="dateWrap">
								<input type="text" name="srcEndDate" value="10/24/1984" class="datepicker" id="datepicker4" readonly="">
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker4"></button>
							</div>
							<button type="button" name="" class="comBtn" id="inp_name01" onclick ="selectDoubleHisList();">조회</button>
						</div>
					</dd>
				</dl>
			</div>
			<!--// 조회 -->

			<p class="numState">
				<em>총 <span class="pColor01 fb" id="popListCnt">0</span></em> 건 이 조회되었습니다.
			</p>

			<!-- grid -->
			<div class="girdBox h321">
				<div id="pop_grid_wrap"></div>
			</div>
			<!-- grid -->

		</div>
	</div>
	<!-- 더블작업 이력조회 -->
</div>
 </form>