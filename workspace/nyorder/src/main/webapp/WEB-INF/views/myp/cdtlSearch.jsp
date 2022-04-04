<!-- 
	@File Name: PrmtEmplMng.jsp
	@File 설명 : 여신 조회
	@UI ID : UI-PMYP-0201.html
	@작성일 : 2022. 3. 29.
	@작성자 : 윤이준
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">
	var myGridID;
	var arrChildren = [];

	var gridData = [
		{"id":"#Cust0","creditHistory":"보증보험/금융채권","guarantee":"김남양","price":300000,"stateDay":"2014-10-07","endDay":"2021-11-07","reDate":"4424","stopDateState":"ico_done.png","reflnot":"반영"},
		{"id":"#Cust1","creditHistory":"보증보험/금융채권","guarantee":"남양순","price":300000,"stateDay":"2014-10-07","endDay":"2021-11-07","reDate":"4424","stopDateState":"ico_30.png","reflnot":"미반영"},
		{"id":"#Cust1","creditHistory":"보증보험/금융채권","guarantee":"남양순","price":300000,"stateDay":"2014-10-07","endDay":"2021-11-07","reDate":"4424","stopDateState":"ico_3060.png","reflnot":"미반영"},
		{"id":"#Cust1","creditHistory":"보증보험/금융채권","guarantee":"남양순","price":300000,"stateDay":"2014-10-07","endDay":"2021-11-07","reDate":"4424","stopDateState":"ico_60.png","reflnot":"미반영"},
		{"id":"#Cust1","creditHistory":"보증보험/금융채권","guarantee":"남양순","price":300000,"stateDay":"2014-10-07","endDay":"2021-11-07","reDate":"4424","stopDateState":"ico_60.png","reflnot":"미반영"},
		{"id":"#Cust1","creditHistory":"보증보험/금융채권","guarantee":"남양순","price":300000,"stateDay":"2014-10-07","endDay":"2021-11-07","reDate":"4424","stopDateState":"ico_60.png","reflnot":"미반영"},
		{"id":"#Cust1","creditHistory":"보증보험/금융채권","guarantee":"남양순","price":300000,"stateDay":"2014-10-07","endDay":"2021-11-07","reDate":"4424","stopDateState":"ico_30.png","reflnot":"미반영"},
		{"id":"#Cust1","creditHistory":"보증보험/금융채권","guarantee":"남양순","price":300000,"stateDay":"2014-10-07","endDay":"2021-11-07","reDate":"4424","stopDateState":"ico_30.png","reflnot":"미반영"}
	];

	$(document).ready(function(){
		createAUIGrid();
		
		AUIGrid.setGridData(myGridID, gridData);
		
		//여신정보
		getCdtlInfo(setCdtlInfoDetail);
	});
	
	//AUIGrid 를 생성합니다.
	function createAUIGrid() {
		
		var columnLayout = [
			{
				dataField : "creditHistory",
				headerText : "여신내역",
			},{
				dataField : "guarantee",
				headerText : "담보제공자",
				width : "12%",
			},{
				dataField : "price",
				headerText : "금액",
				dataType : "numeric",
				width : "12%",
				style : "auiRight"
				
			},{
				dataField : "stateDay",
				headerText : "설정일",
				width : "12%"
			},{
				dataField : "endDay",
				headerText : "만료일",
				width : "12%"
			},{
				dataField : "reDate",
				headerText : "담보잔여일",
				width : "12%"
			},{
				dataField : "stopDateState",
				headerText : "잔여일상태",
				width : "12%",
				prefix : "../images/",
				renderer : {
					type : "ImageRenderer",
					imgHeight : 18,
					altField : "담보정보상태"
				},
			},{
				dataField : "reflnot",
				headerText : "여신반영여부",
				width : "12%"
			}
		];
		
		var auiGridProps = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : false,
			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase : true,
			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "singleCell",
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
		
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps);
	}

	function resizeGrid(){
		AUIGrid.resize( mGrid , $("#content").width() );
	}

	//여신 상세보기
	function setCdtlInfoDetail(data){
		//사용율
		data.RATE = Math.floor( data.AVAIL_AMT / data.CREDIT_LIMIT * 100 );
		//여신사용액
		data.USE_PRICE = setComma( data.CREDIT_LIMIT - data.AVAIL_AMT );
		//콤마 처리
		data.AVAIL_AMT = setComma( data.AVAIL_AMT );
		data.CREDIT_LIMIT = setComma( data.CREDIT_LIMIT );
		data.COMM_AR = setComma( data.COMM_AR );
		data.CMS_OVERDUE_AMT = setComma( data .CMS_OVERDUE_AMT );
		data.COMM_SO = setComma( data.COMM_SO );
		data.SO_AMT = setComma( data.SO_AMT );
		data.DO_AMT = setComma( data.DO_AMT );
		
		$("#detailArea").html($("#detailTmpl").tmpl( data ));
	}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	
	<div class="titleArea">
		<h3 class="tit01" >여신 정보</h3>
	</div>

	<div class="txtInfo pColor02">
		※ 장비담보는 여신에 반영되지 않습니다.
	</div>
	
	<div id="detailArea"></div>
	
	<div class="titleArea right">
		<h3 class="tit01">담보 정보</h3>

		<ul class="icoState">
			<li><i class="icoDone"></i> - 경과</li>
			<li><i class="ico30"></i> 30일 미만</li>
			<li><i class="ico3060"></i> 60일 미만</li>
			<li><i class="ico60"></i> 60일 이상</li>
		</ul>
	</div>

	<!-- grid -->
	<div class="girdBox h205">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->
</div>

<script id="detailTmpl" type="text/x-jquery-tmpl">

	<div class="tblWrap">
		<table class="tbl">
			<caption>여신 상세정보</caption>
			<colgroup>
				<col style="width:185px;">
				<col>
				<col style="width:185px;">
				<col>
			</colgroup>
			<tbody>
				<tr class="point">
					<th scope="row">여신잔액</th>
					<td>\${AVAIL_AMT}</td>
					<th scope="row">사용율(%)</th>
					<td>\${RATE}</td>
				</tr>
				<tr>
					<th scope="row">총 여신금액</th>
					<td>\${CREDIT_LIMIT}</td>
					<th scope="row">여신사용액</th>
					<td>\${USE_PRICE}</td>
				</tr>
				<tr>
					<th scope="row">부동산담보</th>
					<td></td>
					<th scope="row">매출채권</th>
					<td>\${COMM_AR}</td>
				</tr>
				<tr>
					<th scope="row">보증보험/금융채권</th>
					<td></td>
					<th scope="row">CMS 연체금액</th>
					<td>\${CMS_OVERDUE_AMT}</td>
				</tr>
				<tr>
					<th scope="row">특별여신</th>
					<td></td>
					<th scope="row">미매출액( A + B + C)</th>
					<td>\${COMM_SO}</td>
				</tr>
				<tr>
					<th scope="row">임시여신</th>
					<td>
					</td>
					<th scope="row">미결주문(A)</th>
					<td>\${SO_AMT}</td>
				</tr>
				<tr>
					<th scope="row">여신통화</th>
					<td>\${LIMIT_CURRENCY}</td>
					<th scope="row">납품금액(B)</th>
					<td>\${DO_AMT}</td>
				</tr>
				<tr>
					<th scope="row">I/F 일시</th>
					<td>\${DO_AMT}</td>
					<th scope="row">청구금액(C)</th>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
</script>
