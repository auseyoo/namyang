<!-- 
	@File Name: agentMenuRoleList.jsp
	@File 설명 : 권한 관리
	@UI ID : UI-PMYP-0401T1 / UI-PMYP-0401T2
	@작성일 : 2022. 12. 29.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<code:getCommCode commGrpCd="EMPL_SEC_CD" var="emplList" />
<script type="text/javascript">
var mGrid;
var mGrid2;
var arrChildren = [];
var arrChildren2 = [];

<c:forEach var="code" items="${emplList}" varStatus="status">	
	<c:if test="${code.commCd ne 'SYS'}">
	arrChildren[arrChildren.length] = 
		{
			dataField: "${code.commCd}", 
			headerText: "${code.commNm}", 
			headerRenderer : {
				type : "CheckBoxHeaderRenderer",
				dependentMode : true, 			
				position : "bottom" // 기본값 "bottom"
			},
			renderer : {
				type : "CheckBoxEditRenderer",
				showLabel : false,	// 참, 거짓 텍스트 출력여부( 기본값 false )
				editable : true, 	// 체크박스 편집 활성화 여부(기본값 : false)
				checkValue : "Y", 	// true, false 인 경우가 기본
				unCheckValue : "N",
				showRowCheckColumn:true
			}
		};
	</c:if>
</c:forEach>
<c:forEach var="name" items="${emplSeqList}" varStatus="status">	
	arrChildren2[arrChildren2.length] = {
			dataField: "${name.emplSeq}", 
			headerText: "${name.emplSeq}",
			headerRenderer : {
				type : "CheckBoxHeaderRenderer",
				dependentMode : true, 			
				position : "bottom" // 기본값 "bottom"
			},
			renderer : {
				type : "CheckBoxEditRenderer",
				showLabel : false, // 참, 거짓 텍스트 출력여부( 기본값 false )
				editable : true, // 체크박스 편집 활성화 여부(기본값 : false)
				checkValue : "Y", // true, false 인 경우가 기본
				unCheckValue : "N"
			},
			 position : "left"

	};
</c:forEach>

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
	
	createAUIGrid();
	createAUIGrid2();
	searchList();
	searchList2();
	$("#tab01").click();
});
//AUIGrid 칼럼 설정		formatString : "#,##0",	style : "left",
var columnLayout = [
	{	dataField : "menuSeq",		headerText : "메뉴일련번호",	width:100,	visible:false	},
	{	dataField : "menuType",		headerText : "메뉴타입",		width:100,	visible:false	},
	{	dataField : "lvl1",			headerText : "LEVEL1",		width:150,	style : "left"	},
	{	dataField : "lvl2",			headerText : "LEVEL2",		width:150,	style : "left"	},
	{	dataField : "lvl3",			headerText : "LEVEL3",		width:150,	style : "left"	},
	{
		headerText : "그룹 코드",
		children: arrChildren
	},
	];
var auiGridProps = {
		editable : true,			// 수정 가능 여부
		enableFilter : true,		// 필터 활성화
		// row Height
		headerHeight : 60,
};
//AUIGrid 를 생성합니다.
function createAUIGrid() {
	mGrid = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps);
}

var auiGridProps2 = {
		// 수정 가능 여부
		editable : true,
		// 필터 활성화
		enableFilter : true,
		// row Height
		headerHeight : 60,
		width : 1200
};

//AUIGrid 칼럼 설정		formatString : "#,##0",	style : "left",
var columnLayout2 = [
	{	dataField : "id",			headerText : "ID",			visible:false	},
	{	dataField : "menu_seq",		headerText : "메뉴일련번호",	visible:false,	width:100	},
	{	dataField : "agen_seq",		headerText : "대리점일련번호",	visible:false,	width:100	},
	{	dataField : "lvl1",			headerText : "LEVEL1",		width:150,	style : "left"	},
	{	dataField : "lvl2",			headerText : "LEVEL2",		width:150,	style : "left"	},
	{	dataField : "lvl3",			headerText : "LEVEL3",		width:150,	style : "left"	},
	{
		headerText : "직원코드",
		children: arrChildren2
	},
];

function createAUIGrid2() {
	mGrid2 = AUIGrid.create("#grid_wrap2", columnLayout2, auiGridProps2);
}

function searchList(){
	$.ajax({
		url : "/myp/selectAgentMenuRoleGrpList.do", 
		type : 'POST', 
		data : $("#frm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(mGrid, data.list);
			$("#grpCnt").html(data.list.length);
			$("#lastUpdNm").html(data.lastUpd.lastUpdNm);
			$("#lastUpdDtm").html(data.lastUpd.lastUpdDtm);
		}, // success 
		error : function(xhr, status) {
			if ( Common.IsJsonString(xhr.responseText) ){
				var message = JSON.parse(xhr.responseText).message;
				alert(message);
			}else{
				alert("처리중 오류가 발생 하였습니다.");
			}
		}
	}); 	
}


function searchList2(){
	$.ajax({
		url : "/myp/selectAgentMenuRoleEmpList.do", 
		type : 'POST', 
		data : $("#frm2").serialize(),
		success : function(data) {
			AUIGrid.setGridData(mGrid2, data.list);
			$("#emplCnt").html(data.list.length);
			$("#lastUpdNm2").html(data.lastUpd.lastUpdNm);
			$("#lastUpdDtm2").html(data.lastUpd.lastUpdDtm);
		}, // success 
		error : function(xhr, status) {
			if ( Common.IsJsonString(xhr.responseText) ){
				var message = JSON.parse(xhr.responseText).message;
				alert(message);
			}else{
				alert("처리중 오류가 발생 하였습니다.");
			}
		}
	}); 	
}

function saveEmplGrp(){

	var saveData = new Array();
	$.each(AUIGrid.getEditedRowItems(mGrid), function(k,v){
		$.each(arrChildren, function(index, item){
			var useYn = v[item.dataField];
			saveData.push({"menuSeq": v.menu_seq, "emplSec":item.dataField, "useYn": useYn});
		});
	});
	if(!saveData.length > 0){
		alert("저장할 내용이 없습니다."); return;
	}
	
	$.ajax({
		url : "/myp/saveEmplGrpList.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(saveData),
		success : function(data) {
			alert(data);
			searchList();
		}, // success 
		error : function(xhr, status) {
			if ( Common.IsJsonString(xhr.responseText) ){
				var message = JSON.parse(xhr.responseText).message;
				alert(message);
			}else{
				alert("처리중 오류가 발생 하였습니다.");
			}
		}
	}); 	
}
function saveEmpl(){
	var saveData = new Array();
	$.each(AUIGrid.getEditedRowItems(mGrid2), function(k,v){
		$.each(arrChildren2, function(index, item){
			var useYn = v[item.dataField];
			saveData.push({"menuSeq": v.menu_seq, "agenSeq":v.agen_seq, "emplSeq":item.dataField, "emplSec":item.dataField, "useYn": useYn	});
		});
	});
	if(!saveData.length > 0){
		alert("저장할 내용이 없습니다."); return;
	}
	$.ajax({
		url : "/myp/saveEmplList.do", 
		type : "POST", 
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(saveData),
		success : function(data) {
			alert(data);
			searchList2();
		}, // success 
		error : function(xhr, status) {
			if ( Common.IsJsonString(xhr.responseText) ){
				var message = JSON.parse(xhr.responseText).message;
				alert(message);
			}else{
				alert("처리중 오류가 발생 하였습니다.");
			}
		}
	}); 	
}

function resizeGrid(){
	AUIGrid.resize(mGrid, $("#content").width());
	AUIGrid.resize(mGrid2, $("#content").width());
}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	
	<!-- tabs -->
	<div class="tabsWrap">
		<ul class="tabs">
			<li class="active" rel="tab01">그룹별 권한</li>
			<li class="" rel="tab02">직원별 권한</li>
		</ul>
		<!-- tabContent 그룹별 권한 -->
		<div id="tab01" class="tabContent">
			<!-- 조회 -->
			<form id="frm">
			<div class="inquiryBox type02">
				<dl>
					<dt>메뉴</dt>
					<dd>
						<select name="level" class="sel">
							<option value="">전체</option>
							<option value="1">Level1</option>
							<option value="2">Level2</option>
							<option value="3">Level3</option>
						</select>
					</dd>
					<dd>
						<button type="button" name="" class="comBtn"  id="inp_name01" onclick="searchList()">조회</button>
					</dd>
				</dl>

				<div class="btnGroup right">
					<button type="button" name="" class="inquBtn" onclick="saveEmplGrp();">저장</button>
				</div>
			</div>
			</form>
			<!-- 조회 -->

			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="grpCnt">24</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="gridBox">
				<div id="grid_wrap" style="height:500px"></div>
			</div>
			<!-- grid -->
			
			<div class="tblWrap">
				<table class="tbl">
					<caption>그룹별 권한</caption>
					<colgroup>
						<col style="width:170px;">
						<col>
						<col style="width:170px;">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">
								작업자
							</th>
							<td id="lastUpdNm">
								김남양
							</td>
							<th scope="row">
								작업일시
							</th>
							<td id="lastUpdDtm">
								2021.12.12. 12:12:12
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- tabContent 그룹별 권한 -->


		<!-- tabContent 직원별 권한 -->
		<div id="tab02" class="tabContent">
			<!-- 조회 -->
			<form id="frm2">
			<div class="inquiryBox type02">
				<dl>
					<dt>메뉴</dt>
					<dd>
						<select name="level" class="sel">
							<option value="">전체</option>
							<option value="1">Level1</option>
							<option value="2">Level2</option>
							<option value="3">Level3</option>
						</select>
					</dd>
					<dd>
						<button type="button" name="" id="inp_name01" class="comBtn" onclick="searchList2()">조회</button>
					</dd>
				</dl>

				<div class="btnGroup right">
					<button type="button" name=""  class="inquBtn" onclick="saveEmpl();">저장</button>
				</div>
			</div>
			</form>
			<!-- 조회 -->

			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="emplCnt">24</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="gridBox">
				<div id="grid_wrap2" style="width:100%; height:500px"></div>
			</div>
			<!-- grid -->
			
			<div class="tblWrap">
				<table class="tbl">
					<caption>그룹별 권한</caption>
					<colgroup>
						<col style="width:170px;">
						<col>
						<col style="width:170px;">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">
								작업자
							</th>
							<td id="lastUpdNm2">
								김남양
							</td>
							<th scope="row">
								작업일시
							</th>
							<td id="lastUpdDtm2">
								2021.12.12. 12:12:12
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			
		</div>
		<!-- tabContent 직원별 권한 -->
	</div>
	<!-- tabs -->
</div>
