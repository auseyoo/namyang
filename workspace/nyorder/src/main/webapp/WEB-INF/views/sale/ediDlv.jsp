<!--
	@File Name: ediOrg
	@File 설명 : EDI 납품 조회
	@UI ID : UI-PSAL-0601.html
	@작성일 : 2022.01.18
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
	var myGridID;
	var myGridID2;
	var gridData = [{
		"id" : "#Cust0",
		"vendCd" : "00001",
		"vendNm" : "거래처1"
	}, {
		"id" : "#Cust1",
		"vendCd" : "00002",
		"vendNm" : "거래처2"
	}, {
		"id" : "#Cust1",
		"vendCd" : "00003",
		"vendNm" : "거래처3"
	}];
	var gridData2 = [{
		"id" : "#Cust01",
		"prdSapCd" : "X12345",
		"prdNm" : "타사제품1",
		"enterQan01" : 1200,
		"enterQan02" : 3,
		"enterQan03" : 6,
		"unipc" : "",
		"vat" : "",
		"total" : 54000,
		"ordDt" : "2022-01-12",
		"inpDt" : ""
	}, {
		"id" : "#Cust12",
		"prdSapCd" : "X12345",
		"prdNm" : "타사제품1",
		"enterQan01" : 1200,
		"enterQan02" : 3,
		"enterQan03" : 6,
		"unipc" : "",
		"vat" : "",
		"total" : 54000,
		"ordDt" : "2022-01-12",
		"inpDt" : ""
	}];

	$(document).ready(function() {
		// AUIGrid 생성 후 반환 ID
		createAUIGrid();
		//createAUIGrid(columnLayout2);
		// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.

		AUIGrid.setGridData(myGridID, gridData);
		AUIGrid.setFooter(myGridID);

		AUIGrid.setGridData(myGridID2, gridData2);
		AUIGrid.setFooter(myGridID2, footerLayout2);
	});

	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : false,

			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase : true,

			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "multipleCells",
			showFooter : true,

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

	var columnLayout = [{
		dataField : "vendCd",
		headerText : "거래처코드",
		width : "50%",

	}, {
		dataField : "vendNm",
		headerText : "거래처명",

	}, ];

	var columnLayout2 = [
			{
				dataField : "prdSapCd",
				headerText : "제품코드",
				width : "12%",
			},
			{
				dataField : "prdNm",
				headerText : "제품명",
			},
			{
				dataField : "enterQan",
				headerText : "주문수량",
				children : [{
					dataField : "enterQan01",
					headerText : "BOX",
					width : "8%",
					style : "auiRight",
				}, {
					dataField : "enterQan02",
					headerText : "낱봉",
					width : "8%",
					style : "auiRight",
				}, {
					dataField : "enterQan03",
					headerText : "총수량",
					width : "7%",
					style : "auiRight"
				}]
			},
			{
				dataField : "ordUnipc",
				headerText : "주문금액",
				children : [
						{
							dataField : "unipc",
							headerText : "금액",
							width : "8%",
							renderer : {
								type : "TemplateRenderer"
							},
							labelFunction : function(rowIndex, columnIndex,
									value, headerText, item, dataField, cItem) { // HTML 템플릿 작성
								if (!value)
									return "";
								var width = (cItem.width - 12); // 좌우 여백 생각하여 12 빼줌.
								var template = '<input type="text" class="auiInput01 right w80"';
								template += ' style="width:' + width + 'px;"'; // 칼럼 전체 크기를 변경했을 때 작성한 input 도 같이 변경시키기 위함.
								template += ' value="'
										+ value
										+ '" onblur="javascript:myInputHandler('
										+ rowIndex + ', this.value, event);"'
								template += ' onkeydown="if(event.keyCode == 9) event.preventDefault();"' //탭 키를 누르면 브라우저에서 자동으로 다음 input 을 찾는데 이를 방지.
								template += '>';
								return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
							}
						},
						{
							dataField : "vat",
							headerText : "VAT",
							width : "8%",
							renderer : {
								type : "TemplateRenderer"
							},
							labelFunction : function(rowIndex, columnIndex,
									value, headerText, item, dataField, cItem) { // HTML 템플릿 작성
								if (!value)
									return "";
								var width = (cItem.width - 12); // 좌우 여백 생각하여 12 빼줌.
								var template = '<input type="text" class="auiInput01 right w80"';
								template += ' style="width:' + width + 'px;"'; // 칼럼 전체 크기를 변경했을 때 작성한 input 도 같이 변경시키기 위함.
								template += ' value="'
										+ value
										+ '" onblur="javascript:myInputHandler('
										+ rowIndex + ', this.value, event);"'
								template += ' onkeydown="if(event.keyCode == 9) event.preventDefault();"' //탭 키를 누르면 브라우저에서 자동으로 다음 input 을 찾는데 이를 방지.
								template += '>';
								return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
							}
						}, {
							dataField : "total",
							headerText : "계",
							width : "7%",
							style : "auiRight"
						}]
			}, {
				dataField : "ordDt",
				headerText : "주문일",
				width : "12%",
				style : "auiRight"
			}, {
				dataField : "inpDt",
				headerText : "납품요청일",
				dataType : "numeric",
				width : "12%",
				style : "auiRight"
			}];

	// 푸터 설정
	var footerLayout2 = [{
		labelText : "∑",
		positionField : "#base"
	}, {
		dataField : "prdSapCd",
		positionField : "prdSapCd",
		operation : "SUM",
		colSpan : 3, // 자신을 포함하여 4개의 푸터를 가로 병합함.
		labelFunction : function(value, columnValues, footerValues) {
			// return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
			return "합계 : "
		}
	}, {
		dataField : "enterQan01",
		positionField : "enterQan01",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1,
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
		}
	}, {
		dataField : "enterQan02",
		positionField : "enterQan02",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1,
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
		}
	}, {
		dataField : "enterQan03",
		positionField : "enterQan03",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1,
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
		}
	}, {
		dataField : "unipc",
		positionField : "unipc",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1,
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
		}
	}, {
		dataField : "vat",
		positionField : "vat",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1,
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
		}
	}, {
		dataField : "total",
		positionField : "total",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1,
		labelFunction : function(value, columnValues, footerValues) {
			return " " + AUIGrid.formatNumber(value, "#,##0");
		}
	}];

	function requestJsonData() {

		// 요청 URL
		var url = "./data/normal_500.json";

		// ajax 요청 전 그리드에 로더 표시
		AUIGrid.showAjaxLoader(myGridID);

		// ajax (XMLHttpRequest) 로 그리드 데이터 요청
		ajax({
			url : url,
			onSuccess : function(data) {

				//console.log(data);

				// 그리드에 JSON 데이터 설정
				// data 는 JSON 을 파싱한 Array-Object 임
				AUIGrid.setGridData(myGridID, data);

				// 로더 제거
				AUIGrid.removeAjaxLoader(myGridID);
			},
			onError : function(status, e) {
				alert("데이터 요청에 실패하였습니다.\r\n status : "
						+ status
						+ "\r\nWAS 를 IIS 로 사용하는 경우 json 확장자가 web.config 의 handler 에 등록되었는지 확인하십시오.");
				// 로더 제거
				AUIGrid.removeAjaxLoader(myGridID);
			}
		});
	};
</script>
<style>
.mb44 {
	margin-bottom: 44px !important;
}
</style>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />

	<!-- 조회 -->
	<div class="inquiryBox dtShort">
		<dl>
			<dt>납품일자</dt>
			<dd>
				<div class="formWrap">
					<div class="dateWrap">
						<input type="text" name="date" value="10/24/1984" class="inp"
							id="datepicker" readonly>
						<button type="button" class="datepickerBtn" title="날짜입력"
							data-target-id="datepicker"></button>
					</div>
					<span class="divi02">~</span>
					<div class="dateWrap">
						<input type="text" name="date" value="10/24/1984" class="inp"
							id="datepicker02" readonly>
						<button type="button" class="datepickerBtn" title="날짜입력"
							data-target-id="datepicker02"></button>
					</div>
				</div>
			</dd>
			<dt>위탁거래처</dt>
			<dd>
				<select name="" class="sel w120">
					<option>전체</option>
					<option>점주</option>
					<option>판매원</option>
					<option>판촉사원</option>
					<option>총무</option>
					<option>주간판매점</option>
				</select>
				<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
			</dd>
		</dl>

		<div class="btnGroup right">
			<button type="button" name="" class="comBtn">엑셀다운</button>
		</div>
	</div>
	<!-- 조회 -->

	<!-- grid -->
	<div class="girdBoxGroup">
		<div class="girdBox w20per">
			<div class="titleArea mb44">
				<h3 class="tit01">거래처 정보</h3>
			</div>
			<div id="grid_wrap"></div>
		</div>

		<div class="girdBox">
			<div class="titleArea">
				<h3 class="tit01">발주 정보</h3>
			</div>
			<p class="numState">
				<em>총 <span class="pColor01 fb">100</span></em> 건 이 조회되었습니다.
			</p>

			<div id="grid_wrap2"></div>
		</div>
	</div>
	<!-- grid -->
</div>
