<!-- 
	@File Name: stdPrdMng.jsp
	@File 설명 : 표준제품 관리
	@UI ID : UI-PSTD-0201P1
	@작성일 : 2022. 1. 11.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<code:makeSelect commGrpCd="TAXT_CD" 	var="taxtCdList"	name="taxtCd"	all="false" />
<style>
/* 커스텀 열 스타일 */
.my-column-style {
	background:#eeeeee;
	color:#005500;
	font-weight:bold;
	padding: 1px solid black;
	
}
</style>

<script type="text/javascript">
var popGrid;	// 메인
$(document).ready(function(){
	/* 그리드 생성*/
	createAUIGrid();

	$("#srchBtn").click(popSearchList);

	$("#addBtn").on("click", addStdPrd);

	
	/* 검색 멀티 콤보 이벤트 바인드 */
	$(".prdCls").change(function(){
		var target = $(this).data("clsTarget");
		setMultiCombo(target);
	});

	$("#closeBtn").click(function(){
		$.closeDialog("<c:out value='${param.id}'/>");
	});
	
	AUIGrid.bind(popGrid, "cellClick", function( event ) {
		$.ajax({
			url : "/std/selectStdPrdMngDetail.do", 
			type : "POST", 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(event.item),
			success : function(data) {
				data.price = setComma(parseFloat(data.spprc) + parseFloat(data.vatSpprc));
				data.spprc = setComma(data.spprc);
				data.vatSpprc = setComma(data.vatSpprc);
				$("#addDetailArea").html($("#adddetailTmpl").tmpl(data));
				$("#addDetailArea #taxtCd").val(data.taxtCd).attr("selected", "selected");
				$("#addDetailArea #stdPrdYn").val("Y").attr("selected", "selected");
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	});
	
	/* 버튼 바인드 */
	$("#baseSrchBtn").on("click",mstSearchList);
});
//AUIGrid 를 생성합니다.
function createAUIGrid() {
	if(AUIGrid.isCreated(popGrid) ){
		AUIGrid.destroy(popGrid);
	}
	popGrid	= AUIGrid.create("#pop_grid_wrap", 	columnLayout,	gridPros);
}

var columnLayout = [
	{
		dataField : "prdSapCd",
		headerText : "제품코드",
		width : "12%" ,
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
		dataField : "ordUseYnTx",
		headerText : "주문여부",
		width : "13%"
	}
];

var gridPros = {
		headerHeight : 58,
		showRowCheckColumn : false,
};
/* 표준 제품 - 리스트 조회 */
function popSearchList(){
	$.ajax({
		url : "/std/selectStdPrdMngList.do", 
		type : 'POST', 
		data : $("#addfrm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
			$("#dtlCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}


/* 표준 제품 등록 팝업 - 리스트 조회 */
function mstSearchList(){
	var popupParam = [];
	if( fnIsEmpty($("#lcls").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'대분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#mcls").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'중분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#scls").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'소분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#dcls").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'세분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}

	$.ajax({
		url : "/std/selectPrdMstList.do", 
		type : 'POST', 
		data : $("#addfrm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
			$("#mstCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}


/* 표준 제품 등록 팝업 - 리스트 조회 */
function mstSearchList(){
	var popupParam = [];
	if( fnIsEmpty($("#lcls").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'대분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#mcls").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'중분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#scls").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'소분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if( fnIsEmpty($("#dcls").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noSelect' arguments="${'세분류'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}

	$.ajax({
		url : "/std/selectPrdMstList.do", 
		type : 'POST', 
		data : $("#addfrm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(popGrid, data);
			$("#mstCnt").html(data.length);
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
		data : $("#addfrm").serialize(),
		success : function(data) {
			$("#"+type+"cls").append($("#codeTmpl").tmpl({"codeList": data}));
		},
		error : function(xhr, status) {
		}
	}); 	
	
}

function resizeGrid(){
	AUIGrid.resize(popGrid, $("#content").width());
}


/* 표준 제품 등록 팝업 - 제품 등록 */
function addStdPrd(){
	var popupParam = [];
	if(fnIsEmpty($("#addDetailArea #detailForm #prdSeq").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.noPrdSelect' />",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}
	if(fnIsEmpty($("#addDetailArea #detailForm #prdOrdr").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.required' arguments="${'우선순위'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		$("#addDetailArea #detailForm #prdOrdr").focus();
		return;
	}
	if(fnIsEmpty($("#addDetailArea #detailForm #abrvNm").val())){
		popupParam.data = {
			title : "표준 제품 등록",
	 	 	message : "<spring:message code='alert.required' arguments="${'약어'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		$("#addDetailArea #detailForm #abrvNm").focus();
		return;
	}
	
	$.ajax({
		url : "/std/saveStdPrdDetail.do", 
		type : 'POST', 
		data : $("#addDetailArea #detailForm").serialize(),
		success : function(data) {
			var popupParam = [];
			popupParam.data = {
				title : "표준제품 등록",
				message : data,
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			addStdPrdPop();
			$("#addDetailArea #detailForm input").val("");
			popSearchList();
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 
}


</script>

<div class="popWrap large modal_wrap" data-popup="modalAgencyViews"> <!-- small 사이즈 600px * 370px -->
	<header>
		<h3>표준제품 등록</h3>
	</header>  

	<!-- popCon -->
	<div class="popCon">
		<div class="popTitArea">
			<h3>표준제품 등록</h3>

			<div class="popBtnArea">
				<button type="button" id="addBtn" class="inquBtn">저장</button>
				<button type="button" id="closeBtn" name="" class="comBtn modalCloseBtn" data-target="modalAgencyViews">닫기</button>				   
			</div>
		</div>

		<!-- 조회 -->
		<form id="addfrm">
			<div class="inquiryBox dtShort">
				<dl>
					<dt>분류</dt>
					<dd>
						<div class="formWrap">
							<input type="hidden" id="prdType" name="prdType"/>
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

							<div class="checkGroup">
								<input type="checkbox" id="baseChk" name="baseChk" class="type01" checked value="Y"><label for="baseChk"><span>표준제품제외</span></label>
							</div>
						</div>
					</dd>
					<dt>제품</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="srcPrdCd" 	class="inp w120 mr10"	value="" 	name="srcPrdCd"		placeholder="제품코드" maxlength="8">
							<input type="text" id="srcPrdNm" 	class="inp w160 mr7"	value="" 	name="srcPrdNm"		placeholder="제품명">

							<button type="button" name="baseSrchBtn" class="comBtn" id="baseSrchBtn">조회</button>
						</div>
					</dd>
				</dl>
			</div>
		</form>
		<!-- 조회 -->

		<div class="girdBoxGroup">
			<div class="girdBox w55per">
				<div class="titleArea">
					<h3 class="tit01">남양제품 목록</h3>
				</div>

				<p class="numState">
					<em>총 <span class="pColor01 fb" id="mstCnt">0</span></em> 건 이 조회되었습니다.
				</p>
	
				<!-- grid -->
				<div class="girdBox">
					<div id="pop_grid_wrap"></div>
				</div>
				<!-- grid -->
			</div>

			<div class="conBox w43per">
				<div class="titleArea">
					<h3 class="tit01">세부 정보</h3>
				</div>
				<div id="addDetailArea"></div>
			</div>
		</div>
	</div>
	<!-- popCon -->
</div>
<!--// 표준제품 등록 -->

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
					<input type="hidden" name="prdSeq" 		id="prdSeq" value="\${prdSeq}"/>
					<input type="hidden" name="prdDtlSeq"	id="prdDtlSeq" value="\${prdDtlSeq}"/>
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
			<tr>
				<th scope="row">주문여부</th>
				<td><p>\${ordUseYnTx}</p></td>
				<th scope="row">표준제품</th>
				<td><p>\${stdPrdYnTx}</p></td>
			</tr>
			<tr>
				<th scope="row">BOX 입수량</th>
				<td class="ar"><p>\${faltQty}</p></td>
				<th scope="row">과세구분</th>
				<td>${taxtNm}</td>
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
				<th scope="row">매입단가</th>
				<td class="ar">
					<p>\${price}</p>
				</td>
				<th scope="row">
					매입단가<br>공급가/VAT
				</th>
				<td class="ar">
					<p>\${spprc} / \${vatSpprc}</p>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="prdOrdr" class="required" title="필수입력">우선순위</label></th>
				<td>
					<input type="number" id="prdOrdr" class="inp" value="\${prdOrdr}" name="prdOrdr" length="5">
				</td>
				<th scope="row">
					<label for="abrvNm" class="required" title="필수입력">약어(8 Byte)</label>
				</th>
				<td>
					<input type="text" id="abrvNm" class="inp" value="\${abrvNm}" name="abrvNm" length="20">
				</td>
			</tr>
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
		</tbody>
	</table>
</div>
</form>
</script>
<script id="adddetailTmpl" type="text/x-jquery-tmpl">
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
					<input type="hidden" name="prdSeq" 		id="prdSeq" value="\${prdSeq}"/>
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
				<td class="ar"><p>\${faltQty}</p></td>
				<th scope="row">과세구분</th>
				<td>${taxtNm}</td>
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
				<th scope="row">매입단가</th>
				<td class="ar">
					<p>\${price}</p>
				</td>
				<th scope="row">
					매입단가<br>공급가/VAT
				</th>
				<td class="ar">
					<p>\${spprc} / \${vatSpprc}</p>
				</td>
			</tr>
{{/if}}
			<tr>
				<th scope="row"><label for="prdOrdr" class="required" title="필수입력">우선순위</label></th>
				<td>
					<input type="number" id="prdOrdr" class="inp" value="\${prdOrdr}" name="prdOrdr" length="5">
				</td>
				<th scope="row">
					<label for="abrvNm" class="required" title="필수입력">약어(8 Byte)</label>
				</th>
				<td>
					<input type="text" id="abrvNm" class="inp" value="\${abrvNm}" name="abrvNm" length="20">
				</td>
			</tr>
		</tbody>
	</table>
</div>
</form>
</script>
