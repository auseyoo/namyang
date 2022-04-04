<!--
	@File Name: bcncMng
	@File 설명 : 거래처관리
	@UI ID : UI-PSAL-0101.html
	@작성일 : 2022.01.14
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<code:makeSelect commGrpCd="VEND_SEC_CD"	var="vendSecCdList"	name="vendSecCd" />
<code:makeSelect commGrpCd="VEND_STUS_SEC" var="vendStusSecList"	name="vendStusSec"/>

<script type="text/javascript">
var mGrid;
var arrChildren = [];
$(document).ready(function(){
	createAUIGrid();
	searchList();
});
var columnLayout = [
	{
		dataField : "vendSeq",
		headerText : "거레처시퀸스",
		visible: false
	},
	{
		dataField : "vendCd",
		headerText : "거래처코드",
		width : "10%",
		style : "auiLink",
		renderer : {
			type : "LinkRenderer",
			baseUrl :"javascript",
			linkField : "vendCd",
			jsCallback : function(rowIndex, item) {
				bcncMngDtl(rowIndex, item);
			}
		}
	},
	{
		dataField : "vendNm",
		headerText : "거래처명",
		width : "10%",
		style : "auiLink",
		renderer : {
			type : "LinkRenderer",
			baseUrl :"javascript",
			linkField : "vendCd",
			jsCallback : function(rowIndex, item) {
				bcncMngDtl(rowIndex, item);
			}
		}
	},
	{
		dataField : "vendPrst",
		headerText : "대표자",
		width : "10%"
	},
	{
		dataField : "emplNm",
		headerText : "담당직원",
		width : "10%"
	},
	{
		dataField : "vendSecNm",
		headerText : "거래처유형",
		width : "10%"
	},
	{
		dataField : "vendStusSecNm",
		headerText : "상태",
		width : "10%"
	},
	{
		dataField : "bizNo",
		headerText : "사업자번호",
		width : "10%"
	},
	{
		dataField : "telNo",
		headerText : "전화번호",
		width : "10%"
	},
	{
		dataField : "fullAddr",
		headerText : "주소",
		style :"auiLeft"
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
	selectionMode : "multipleCells",
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
//AUIGrid 를 생성합니다.
function createAUIGrid() {
	mGrid = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps);
}


function searchList(){
	$.ajax({
		url : "/sale/selectBcncMngList.do",
		type : 'POST',
		data : $("#frm").serialize(),
		success : function(data) {
			console.log(data);
			AUIGrid.setGridData(mGrid, data);
			$("#listCnt").html(data.length);
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

//엑셀 내보내기(Export);
function exportTo() {
	AUIGrid.exportToXlsx(mGrid, {
		// 스타일 상태 유지 여부(기본값:true)
		exportWithStyle : true,
		fileName : "거래처 리스트"
	});
};

function resizeGrid(){
	AUIGrid.resize(mGrid, $("#content").width());
}

function bcncMngDtl(rowIndex,item){
	var vendSeq = AUIGrid.getCellValue(mGrid, rowIndex, "vendSeq");
	$("#vendSeq").val(vendSeq);
	document.frm.action ="/sale/bcncMngDtl.do";
	document.frm.method ="get";
	document.frm.submit();
}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- 조회 -->
	<form id="frm" name ="frm">
		<input name="vendSeq" id="vendSeq" type="hidden" value="">
		<div class="inquiryBox dtShort">
			<dl>
				<dt>담당직원</dt>
				<dd>
					<select name="targetEmplSeq" class="sel">
						<option value="">전체</option>
						<c:forEach var="empl" items="${emplList}" varStatus="status">
							<option value="<c:out value="${empl.emplSeq}" />" ><c:out value="${empl.emplNm}" /></option>
						</c:forEach>
					</select>
				</dd>
				<dt>거래처유형</dt>
				<dd>
					${vendSecCdList}
				</dd>
				<dt>상태</dt>
				<dd>
					${vendStusSecList}
				</dd>
				<dt>거래처명</dt>
				<dd>
					<div class="formWrap">
						<input type="text" id="inp_name01" class="inp w120" name="vendNm" value="" title="성명 입력">
						<button type="button" name="" class="comBtn" id="inp_name01"  onclick="searchList()" >조회</button>
					</div>
				</dd>
			</dl>
			<div class="btnGroup right">
				<button type="button" name="" class="comBtn" onclick="exportTo();">엑셀다운</button>
				<button type="button" name="" class="inquBtn" onclick="location.href='/sale/bcncMngDtl.do'">등록</button>
			</div>
		</div>
	</form>
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
