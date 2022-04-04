<!-- 
	@File Name: stdPrdSearch
	@File 설명 : 제품 조회
	@UI ID : UI-PSTD-0401.html
	@작성일 : 2022.01.17
	@작성자 : 박예솔
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<style>
/* 커스컴 disable 스타일*/
.mycustom-disable-color {
	color : #cccccc;
}
</style>
<script type="text/javascript">
var mGrid1;
var mGrid2;
var mGrid3;
var mGrid4;
$(document).ready(function(){
	//tabs
	$(".content .tabContent").hide();
	$(".content .tabContent:first").show();

	$(".content .tabsWrap ul.tabs li").click(function (){
		$(".content .tabsWrap ul.tabs li").removeClass("active");
		$(this).addClass("active");
		$(".content .tabsWrap .tabContent").hide();
		var activeTab = $(this).attr("rel");
		$("#" + activeTab).fadeIn(100); 
		if( typeof resizeGrid == 'function' ){
			resizeGrid();
		}
	});

	$(".lnbTabsWrap > .tabContent").hide();
	$(".lnbTabsWrap > .tabContent:first").show();

	$(".lnbTabsWrap > ul.tabs li").click(function (){
		$(".lnbTabsWrap > ul.tabs li").removeClass("active");
		$(this).addClass("active");
		$(".lnbTabsWrap > .tabContent").hide();
		var activeTab = $(this).attr("rel");
		$("#" + activeTab).fadeIn(100); 
	});
	
	$("#alertTitle").html("제품 조회");
	$("#alertBtn2").hide();
	
	createAUIGrid();
	resizeGrid();
	$("#tab1Area").html($("#detailTmpl").tmpl({}));

	$(".tabs").click(function(){
		var idx = $(this).find(".active").data("idx");
		$("#tab"+idx+"Area").html($("#detailTmpl").tmpl({}));
		
	});
	$("#saveBtn").click(saveStdPrd);
	AUIGrid.bind(mGrid1, "cellClick", function(event) {
		if(event.dataField != "stdPrdYn"){
			searchDetail("1", event.item);
		}
	});
	AUIGrid.bind(mGrid2, "cellClick", function(event) {
		searchDetail("2", event.item);
	});
	AUIGrid.bind(mGrid3, "cellClick", function(event) {
		searchDetail("3", event.item);
	});
	AUIGrid.bind(mGrid4, "cellClick", function(event) {
		searchDetail("4", event.item);
	});
	$(".prdCls").change(function(){
		var target = $(this).data("clsTarget");
		setMultiCombo(target);
	});
});

//AUIGrid 를 생성합니다.
function createAUIGrid() {
	mGrid1	= AUIGrid.create("#grid_wrap", 	columnLayout, gridPros);
	mGrid2	= AUIGrid.create("#grid_wrap2", columnLayout, gridPros);
	mGrid3	= AUIGrid.create("#grid_wrap3", columnLayout2, gridPros);
	mGrid4	= AUIGrid.create("#grid_wrap4", columnLayout2, gridPros);
}
var gridPros = {
		headerHeight : 58,
		rowHeight : 29,
		// 편집 가능 여부 (기본값 : false)
		editable : false,
		
		// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
		enterKeyColumnBase : true,
		
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
}

var columnLayout = [
	{
		dataField : "stdPrdYn", // 이미지렌더러로 체크박스 모양 만들기
		headerText : "표준<br/>제품",
		width: "6%",
		renderer: {
			type: "CheckBoxEditRenderer",
			editable: true,
			imgHeight : 15,
			imgTableRef : {
				"true" : "/images/check_on.png",
				"false" : "/images/check_default.png",
				"default" : "/images/check_on.png"
			},
			disabledFunction : function(rowIndex, columnIndex, value, isChecked, item, dataField) {
				if(item.prdType == "FER1")
					return false;
				return true;
			},
		}
	},{
		dataField : "prdSapCd",
		headerText : "제품 코드",
		width : "10%",
		style : "auiLink" 
	},{
		dataField : "prdNm",
		headerText : "제품명",
		style : "auiLeft"	
	},{
		dataField : "lclsNm",
		headerText : "제품<br/>대분류",
		width : "11%"
	},{
		dataField : "mclsNm",
		headerText : "제품<br/>중분류",
		width : "11%"
	},{
		dataField : "sclsNm",
		headerText : "제품<br/>소분류",
		width : "11%"
	},{
		dataField : "dclsNm",
		headerText : "제품<br/>세분류",
		width : "11%"
	},{
		dataField : "prdTypeNm",
		headerText : "자재유형",
		width : "11%"
	},{
		dataField : "useYnTx",
		headerText : "상태",
		width : "11%"
	},
	
];
var columnLayout2 = [
	{
		dataField : "prdSapCd",
		headerText : "제품 코드",
		width : "10%",
		style : "auiLink" 
	},{
		dataField : "prdNm",
		headerText : "제품명",
		style : "auiLeft"	
	},{
		dataField : "lclsNm",
		headerText : "제품<br/>대분류",
		width : "11%"
	},{
		dataField : "mclsNm",
		headerText : "제품<br/>중분류",
		width : "11%"
	},{
		dataField : "sclsNm",
		headerText : "제품<br/>소분류",
		width : "11%"
	},{
		dataField : "dclsNm",
		headerText : "제품<br/>세분류",
		width : "11%"
	},{
		dataField : "prdType",
		headerText : "자재유형",
		width : "11%"
	},{
		dataField : "useYnTx",
		headerText : "상태",
		width : "11%"
	},
];

/* 표준 제품 - 리스트 조회 */
function searchList(){
	if( fnIsEmpty($("#lcls").val())){
		var popupParam = [];
		popupParam.data = {
			title : "제품 조회",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'대분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#mcls").val())){
		var popupParam = [];
		popupParam.data = {
			title : "제품 조회",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'중분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#scls").val())){
		var popupParam = [];
		popupParam.data = {
			title : "제품 조회",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'소분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#dcls").val())){
		var popupParam = [];
		popupParam.data = {
			title : "제품 조회",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'세분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	
	$.ajax({
		url : "/std/selectPrdMstList.do", 
		type : 'POST', 
		data : $("#frm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(mGrid1, data);
			$("#tab1Cnt").html(data.length)
			AUIGrid.setGridData(mGrid2, data.filter( row => row.prdType == 'FER1'));
			$("#tab2Cnt").html(data.filter( row => row.prdType == 'FER1').length);
			AUIGrid.setGridData(mGrid3, data.filter( row => row.prdType == 'ERS1'));
			$("#tab3Cnt").html(data.filter( row => row.prdType == 'ERS1').length);
			AUIGrid.setGridData(mGrid4, data.filter( row => row.prdType == 'HAW2'));
			$("#tab4Cnt").html(data.filter( row => row.prdType == 'HAW2').length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}
/* 상세 조회 */
function searchDetail(type, row){
	$.ajax({
		url : "/std/selectStdPrdMngDetail.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(row),
		success : function(data) {
			data.price = setComma(parseFloat(data.spprc) + parseFloat(data.vatSpprc));
			data.spprc = setComma(data.spprc);
			data.vatSpprc = setComma(data.vatSpprc);
			$("#tab"+type+"Area").html($("#detailTmpl").tmpl(data));
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}
/* 검색 멀티콤보 설정 */
function setMultiCombo(type){
	$("#"+type+"cls option").remove();
	switch(parseInt($("#"+type+"cls").data("clsLvl"))){
		case 2 : {
			$("#mcls option").remove();
			$("#mcls").append("<option value=''>중분류</option>");
		}
		case 3 : {
			$("#scls option").remove();
			$("#scls").append("<option value=''>소분류</option>");
		}
		case 4 : {
			$("#dcls option").remove();
			$("#dcls").append("<option value=''>세분류</option>");
		}
	}
	if(fnIsEmpty($("#lcls").val())){ return;}
	$.ajax({
		url : "/comm/selectPrdCls.do", 
		type : 'POST', 
		data : $("#frm").serialize(),
		success : function(data) {
			$("#"+type+"cls").append($("#codeTmpl").tmpl({"codeList": data}));
		},
		error : function(xhr, status) {
		}
	}); 	
	
}

/* 제품 저장 */
function saveStdPrd(){
	var gridIdx = $(".tabsWrap ul").find(".active").data("idx");
	if( fnIsEmpty(AUIGrid.getItemsByValue(eval("mGrid"+gridIdx), "stdPrdYn", true))){
		var popupParam = [];
		popupParam.data = {
	 	 	message : "<spring:message code='alert.noPrdSelect' />",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	var saveData = AUIGrid.getItemsByValue(eval("mGrid"+gridIdx), "stdPrdYn", true);
	$.ajax({
		url : "/std/addStdPrdList.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(saveData),
		success : function(data) {
			var popupParam = [];
			popupParam.data = {
				title : "제품 조회",
				message : data,
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			searchList();
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function resizeGrid(){
	AUIGrid.resize(mGrid1, $("#grid_wrap").width());
	AUIGrid.resize(mGrid2, $("#grid_wrap2").width());
	AUIGrid.resize(mGrid3, $("#grid_wrap3").width());
	AUIGrid.resize(mGrid4, $("#grid_wrap4").width());
}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	
	<!-- 조회 -->
	<form id="frm" method="post">
		<div class="inquiryBox dtShort">
			<dl>
				<dt>자재 그룹</dt>
				<dd>
					<div class="formWrap">
						<select name="prdType" class="sel w120 mr10" id="prdType">
							<option value="">전체</option>
							<option value="FER1">제품</option>
							<option value="ERS1">크레이트</option>
							<option value="HAW2">판촉물</option>
						</select>
					</div>
				</dd>
				<dt>분류</dt>
				<dd>
					<div class="formWrap">
						<select name="lcls" class="sel w120 mr10 prdCls" id="lcls" data-cls-target="m" data-cls-lvl="1">
							<option value="">대분류</option>
							<c:forEach items="${lclsList}" var="i" >
								<option value="${i.code}">${i.name}</option>
							</c:forEach>
						</select>
						<select name="mcls" class="sel w120 mr10 prdCls" id="mcls" data-cls-target="s" data-cls-lvl="2">
							<option value="">중분류</option>
						</select>
						<select name="scls" class="sel w120 mr10 prdCls" id="scls" data-cls-target="d" data-cls-lvl="3">
							<option value="">소분류</option>
						</select>
						<select name="dcls" class="sel w120" id="dcls" data-cls-lvl="4">
							<option value="">세분류</option>
						</select>
					</div>
				</dd>
				<dt>제품</dt>
				<dd>
					<div class="formWrap">
						<input type="text" id="srcPrdCd" class="inp w120 mr10" value="" name="srcPrdCd" placeholder="제품코드" maxlength="8">
						<input type="text" id="srcPrdNm" class="inp w160 mr7" value="" name="srcPrdNm" placeholder="제품명">
						<button type="button" name="" class="comBtn" id="inp_name01" onclick="searchList()">조회</button>
					</div>
				</dd>
			</dl>
				 <div class="btnGroup right">
					<button type="button" name="" class="inquBtn" id="saveBtn">저장</button>
				</div>
		</div>
	</form>
	<!-- 조회 -->

	<!-- tabs -->
	<div class="tabsWrap">
		<ul class="tabs">
			<li class="active" rel="tab01" data-idx="1">전체</li>
			<li class="" rel="tab02" data-idx="2">제품</li>
			<li class="" rel="tab03" data-idx="3">크레이트</li>
			<li class="" rel="tab04" data-idx="4">판촉물</li>
		</ul>

		<!-- tabContent 전체 -->
		<div id="tab01" class="tabContent">
			<div class="girdBoxGroup">
				<!-- grid -->
				<div class="girdBox w55per">
					<div class="titleArea right">
						<p class="numState">
							<em>총 <span class="pColor01 fb" id="tab1Cnt">0</span></em> 건 이 조회되었습니다.
						</p>
					</div>
					<div id="grid_wrap"></div>
				</div>
				<!-- grid -->
	  
				<div class="conBox w43per">
					<div class="titleArea right">
						<h3 class="tit01">세부 정보</h3>
					</div>
					
					<!-- 세부정보 -->
					<div id="tab1Area"></div>
					<!-- 세부정보 -->
				</div>	
			</div>
		</div>
		<!-- tabContent 전체 -->


		<!-- tabContent 제품 -->
		<div id="tab02" class="tabContent">
			<div class="girdBoxGroup">
				<div class="girdBox w55per">
					<div class="titleArea right">
						<p class="numState">
							<em>총 <span class="pColor01 fb" id="tab2Cnt">0</span></em> 건 이 조회되었습니다.
						</p>
					</div>
					<div id="grid_wrap2" style="width:100%"></div>
				</div>

				<div class="conBox w43per">
					<div class="titleArea right">
						<h3 class="tit01">세부 정보</h3>
					</div>
					
					<!-- 세부정보 -->
					<div id="tab2Area"></div>
					<!-- 세부정보 -->
				</div>
			</div>
		</div>
		<!-- tabContent 제품 -->

		<!-- tabContent 크레이트 -->
		<div id="tab03" class="tabContent">
			<div class="girdBoxGroup">
				<div class="girdBox w55per">
					<div class="titleArea right">
						<p class="numState">
							<em>총 <span class="pColor01 fb" id="tab3Cnt">0</span></em> 건 이 조회되었습니다.
						</p>
					</div>
					<div id="grid_wrap3" style="width:100%"></div>
				</div>

				<div class="conBox w43per">
					<div class="titleArea right">
						<h3 class="tit01">세부 정보</h3>
					</div>

					<!-- 세부정보 -->
					<div id="tab3Area"></div>
					<!-- 세부정보 -->
				</div>
			</div>
		</div>
		<!-- tabContent 크레이트 -->

		
		<!-- tabContent 판촉물 -->
		<div id="tab04" class="tabContent">
			<div class="girdBoxGroup">
				<div class="girdBox w55per">
					<div class="titleArea right">
						<p class="numState">
							<em>총 <span class="pColor01 fb" id="tab4Cnt">0</span></em> 건 이 조회되었습니다.
						</p>
					</div>
					<div id="grid_wrap4" style="width:100%"></div>
				</div>

				<div class="conBox w43per">
					<div class="titleArea right">
						<h3 class="tit01">세부 정보</h3>
					</div>
					
					<!-- 세부정보 -->
					<div id="tab4Area"></div>
					<!-- 세부정보 -->
				</div>
			</div>
		</div>
		<!-- tabContent 판촉물 -->
		</div>
	</div>
	<!-- tabs -->

<script id="codeTmpl" type="text/x-jquery-tmpl">
{{each(i, e) codeList }}
	<option value='\${e.code}'>\${e.name}</option>
{{/each}}
</script>

<script id="detailTmpl" type="text/x-jquery-tmpl">
<form id="detailForm">
<div class="tblWrap">
	<table class="tbl">
		<caption>세부 정보</caption>
		<colgroup>
			<col style="width:132px;">
			<col>
			<col style="width:132px;">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">매입처코드</th>
				<td><p>\${puchCd}</p></td>
				<th scope="row">매입처명</th>
				<td><p>\${puchNm}</p></td>
			</tr>
			<tr>
				<th scope="row">제품코드</th>
				<td>
					<p>\${prdSapCd}</p>
				</td>
				<th scope="row">자재유형</th>
				<td><p>\${prdTypeNm}</p></td>
			</tr>
			<tr>
				<th scope="row">제품명</th>
				<td colspan="3"><p>\${prdNm}</p></td>
			</tr>
			<tr>
				<th scope="row">제품 대분류</th>
				<td><p>\${lclsNm}</p></td>
				<th scope="row">제품 중분류</th>
				<td><p>\${mclsNm}</p></td>
			</tr>
			<tr>
				<th scope="row">제품 소분류</th>
				<td><p>\${sclsNm}</p></td>
				<th scope="row">제품 세분류</th>
				<td><p>\${dclsNm}</p></td>
			</tr>
{{if prdType == 'FER1'}}			
			<tr>
				<th scope="row">주문여부</th>
				<td><p>\${ordUseYnTx}</p></td>
				<th scope="row">표준제품</th>
				<td><p>\${stdPrdYnTx}</p></td>
			</tr>
			<tr>
				<th scope="row">BOX 입수량</th>
				<td class="ar">
					<p>\${faltQty}</p>
				</td>
				<th scope="row">낱봉기준</th>
				<td>\${iddyStdr}</td>
			</tr>
			<tr>
				<th scope="row">규격</th>
				<td class="ar"><p>\${prdStrd}</p></td>
				<th scope="row">단위</th>
				<td><p>\${prdUnit}</p></td>
			</tr>
			<tr>
				<th scope="row">낱봉주문</th>
				<td><p>\${iddyUntYn}</p></td>
				<th scope="row">주문기간</th>
				<td>
					<p>\${ordPd}</p>
				</td>
			</tr>
			<tr>
				<th scope="row">과세구분</th>
				<td>${taxtNm}</td>
				<th scope="row">매입단가</th>
				<td class="ar">
					<p>\${price}</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					공급가
				</th>
				<td class="ar">
					<p>\${spprc}</p>
				</td>
				<th scope="row">
					VAT
				</th>
				<td class="ar">
					<p>\${vatSpprc}</p>
				</td>
			</tr>
{{/if}}
			<tr>
				<th scope="row">박스바코드</th>
				<td><p>\${brcd}</p></td>
				<th scope="row">대표제품명</th>
				<td><p></p></td>
			</tr>
			<tr>
				<th scope="row">소포장바코드</th>
				<td><p>\${etcBrcd}</p></td>
				<th scope="row">사이즈</th>
				<td><p></p></td>
			</tr>
			<tr>
				<th scope="row">낱봉바코드</th>
				<td><p>\${iddyBrcd}</p></td>
				<th scope="row">크레이트명</th>
				<td><p></p></td>
			</tr>
			<tr>
				<th scope="row">상태</th>
				<td colspan="3"><p>\${useYnTx}</p></td>
			</tr>
		</tbody>
	</table>
</div>
</form>
</script>