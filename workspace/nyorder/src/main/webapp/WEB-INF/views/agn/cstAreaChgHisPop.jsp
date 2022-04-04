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

	$("#srcStartDate").daterangepicker(daterangepickerOption,{});
	$("#srcEndDate").daterangepicker(daterangepickerOption,{});
	
	
	//순서변경 - 저장 버튼 클릭
	$("#saveOrdrBtn").click(function(){
		updateAreaByOrdrList();
	});
	$("#searchAresChgHisBtn").click(selectCstAreaHis);
});

function createAUIGrid() {
	if(AUIGrid.isCreated(popGrid) ){
		AUIGrid.destroy(popGrid);
	}
	popGrid	= AUIGrid.create("#pop_grid_wrap", 	columnLayout,	gridPros);
}

var gridPros = {
	rowHeight : 30,
	selectionMode : "singleRow",
	showStateColumn : true,
	wrapSelectionMove : true,
	noDataMessage : "출력할 데이터가 없습니다.",
	showStateColumn : false,
	autoGridHeight : true,
	showRowCheckColumn : false, // 체크박스 사용
};
var columnLayout = [
	{ dataField : "cstInfo", headerText : "애음자 정보", 
		children : [
			{ dataField : "cstSeq", 	headerText : "애음자코드", width : "5%", }, 
			{ dataField : "cstNm", 		headerText : "성명", 		width : "6%", }, 
			{ dataField : "dlvAddr",	headerText : "배달주소", 	style: "auiLeft" }, 
			{ dataField : "mobNo", 		headerText : "휴대폰번호", width : "7%", }] 
	},
	{ dataField : "chBefore", headerText : "변경 전", 
		children : [
			{ dataField : "beforeAreaCd", 	headerText : "지역코드", 	width : "5%", }, 
			{ dataField : "beforeAreaNm", 		headerText : "지역명", 	width : "5%", }, 
			{ dataField : "beforeEmplCd", 		headerText : "직원코드", 	width : "5%", }, 
			{ dataField : "beforeEmplNm", 		headerText : "판매원", 	width : "5%", }] 
	},
	{ dataField : "chAfter", headerText : "변경 후", 
		children : [
			{ dataField : "afterAreaCd", headerText : "지역코드", width : "5%", }, 
			{ dataField : "afterAreaNm", headerText : "지역명", width : "5%", }, 
			{ dataField : "afterEmplCd", headerText : "지원코드", width : "5%", }, 
			{ dataField : "afterEmplNm", headerText : "판매원", width : "5%", }] 
	},
	{ dataField : "chgDt", headerText : "적용일자", width : "6%",
		dataType : "date",
		formatString : "yyyy-mm-dd"
	},
	{ dataField : "chgYnNm", 	headerText : "적용여부",	width : "5%", },
	{ dataField : "regNm", 		headerText : "작업자", 	width : "6%", },
	{ dataField : "regDtm", 	headerText : "작업시간", dataType : "date", formatString : "yyyy-mm-dd HH:MM:ss"}
];

function myInputHandler(rowIndex, selectedValue, event, datafieldName, t) {
	$(t).val(selectedValue);
	modifyItem = {	[datafieldName] : selectedValue	};
	AUIGrid.updateRow(popGrid, modifyItem, rowIndex);

};

function selectCstAreaHis() {
	$.ajax({
		url : "/agn/selectCstAreaHisList.do",
		type : 'POST',
		data : $("#popFrm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
			$("#popTotCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert("순서변경 조회 중 오류가 발생하였습니다");
		}
	});
}

</script>

<!-- 지역변경 이력 -->
<div class="popWrap large modal_wrap h620" data-popup="modalAgencyViews02">
	<header>
		<h3>지역 변경 이력</h3>
	</header>

	<div class="popCon">
		<div class="popTitArea">
			<h3>지역 변경 이력</h3>

			<div class="popBtnArea">
				<button type="button" name="" class="inquBtn" id="saveOrdrBtn">저장</button>
				<button type="button" name="" class="comBtn" id="closeBtn">닫기</button>				   
			</div>
		</div>
		
		<!-- 조회 -->
		<form id="popFrm">
			<div class="inquiryBox">
				<dl>
					<dt>작업시간</dt>
					<dd>
						<div class="formWrap">
							<div class="dateWrap">
								<input type="text" name="srcStartDate" value="" class="inp datepicker" id="srcStartDate" readonly>										
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="srcStartDate"></button>										
							</div> 
	
							<span class="divi02">-</span>
							
							<div class="dateWrap">
								<input type="text" name="srcEndDate" value="" class="inp datepicker" id="srcEndDate" readonly>
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="srcEndDate"></button>										
							</div>
	
							<button type="button" name="" class="comBtn" id="searchAresChgHisBtn">조회</button>
						</div>
					</dd>
				</dl>
			</div>
		</form>
		<!-- 조회 -->
		
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