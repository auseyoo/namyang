<!-- 
	@File Name: stdPrdMng.jsp
	@File 설명 : 표준제품 관리
	@UI ID : UI-PSTD-0201
	@작성일 : 2022. 1. 11.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
var mGrid;	// 메인
var mGrid3;	// 순서 
var arrChildren = [];
$(document).ready(function(){
	/* 그리드 생성*/
	createAUIGrid();

	// 제품 정보 초기화
	$("#updateDetailArea").html($("#detailTmpl").tmpl({}));
	$("#updateDetailArea #detailForm input").val("");
	
	/* 그리드 이벤트 바인드 */
	AUIGrid.bind(mGrid, "cellClick", function( event ) {
		$.ajax({
			url : "/std/selectStdPrdMngDetail.do", 
			type : "POST", 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(event.item),
			success : function(data) {
				data.price = setComma(parseFloat(data.spprc) + parseFloat(data.vatSpprc));
				data.spprc = setComma(data.spprc);
				data.vatSpprc = setComma(data.vatSpprc);
				$("#updateDetailArea").html($("#detailTmpl").tmpl(data));
				$("#updateDetailArea #taxtCd").val(data.taxtCd).attr("selected", "selected");
				$("#updateDetailArea #stdPrdYn").val(data.stdPrdYn).attr("selected", "selected");
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	});
	/* 검색 멀티 콤보 이벤트 바인드 */
	$(".prdCls").change(function(){
		var target = $(this).data("clsTarget");
		setMultiCombo(target);
	});

	/* 버튼 바인드 */
	$("#addPopBtn").on("click", function(){
		$.ajaxDialog({
			id: "addStdPrdPop",
			ajax: {
				url: "/std/addStdPrdPop.do",
			},
			dialog: {
				width:1640,
				height:800,
				modal: true,
				draggable: false
			},
			success: function(data) {
				alert("여기로 리턴됨 ㅇㅇ >> "+ data.prdNm);
				
			}
		});
	});
	$("#uptBtn").on("click", uptStdPrd);
	$("#ordrPopBtn").on("click", function(){
		$.ajaxDialog({
			id: "editStdPrdOrdrPop",
			ajax: {
				url: "/std/editStdPrdOrdrPop.do",
			},
			dialog: {
				width:680,
				height:420,
				modal: true,
				draggable: false
			},
			success: function(data) {
				alert("여기로 리턴됨 ㅇㅇ >> "+ data.prdNm);
				
			}
		});
	});
	
	$("#rmvBtn").on("click", rmvStdPrdConfirm);
	$("#stdPrdBndChgBtn").on("click", stdPrdBndChg);
	
	$("button[name='ordrClsBtn']").on("click", function(){
		//openPopup('modalConfirm');
		if (! fnIsEmpty(AUIGrid.getEditedRowColumnItems(mGrid3))){
			var popupParam = [];
			popupParam.data = {
				title : "표준제품 일괄 변경",
		 	 	message : "<spring:message code='alert.noSave'/>",
		 	 	btn1Func : function(){ 
			 	 	closePopup('modalAgencyViews02');
			 	 	closePopup('modalAlert'); 
		 	 	}
			}
			layerAlert(popupParam);
		}else{
			closePopup('modalAgencyViews02');
		}
		
	});
	
	$("#appDate").val(fnGetToDay())
});
var columnLayout = [
	{
		dataField : "prdOrdr",
		headerText : "우선<br/>순위",
		width : "6%"
	},{
		dataField : "prdSapCd",
		headerText : "제품코드",
		width : "12%" ,
		style : "auiLink"
	},{
		dataField : "prdNm",
		headerText : "본사<br>제품명",
		style : "auiLeft"	
	},{
		dataField : "lclsNm",
		headerText : "제품<br/>대분류",
		width : "12%"
	},{
		dataField : "mclsNm",
		headerText : "제품<br/>중분류",
		width : "12%"
	},{
		dataField : "sclsNm",
		headerText : "제품<br/>소분류",
		width : "12%"
	},{
		dataField : "dclsNm",
		headerText : "제품<br/>세분류",
		width : "12%"
	},{
		dataField : "ordUseYnTx",
		headerText : "주문여부",
		width : "13%"
	}
];
var gridPros = {
	headerHeight : 58,
	rowHeight : 29,
	// 편집 가능 여부 (기본값 : false)
	editable : false,
	// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
	enterKeyColumnBase : true,
	// 셀 선택모드 (기본값: singleCell)
	selectionMode : "multipleCells",
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
//AUIGrid 를 생성합니다.
function createAUIGrid() {
	mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
}
/* 표준 제품 - 리스트 조회 */
function searchList(){
	$.ajax({
		url : "/std/selectStdPrdMngList.do", 
		type : 'POST', 
		data : $("#frm").serialize(),
		success : function(data) {
			AUIGrid.setGridData(mGrid, data);
			$("#dtlCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 	
}


/* 표준 제품 - 수정 */
function uptStdPrd(){
	var popupParam = [];
	if(fnIsEmpty($("#updateDetailArea #prdDtlSeq").val())){
		popupParam.data = {
	 	 	message : "<spring:message code='alert.noPrdSelect' />",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}

	if(fnIsEmpty($("#updateDetailArea #detailForm #prdOrdr").val())){
		popupParam.data = {
			title : "표준 제품 관리",
	 	 	message : "<spring:message code='alert.required' arguments="${'우선순위'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		$("#updateDetailArea #detailForm #prdOrdr").focus();
		return;
	}
	if(fnIsEmpty($("#updateDetailArea #detailForm #abrvNm").val())){
		popupParam.data = {
			title : "표준 제품 관리",
	 	 	message : "<spring:message code='alert.required' arguments="${'약어'}"/>",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		$("#updateDetailArea #detailForm #abrvNm").focus();
		return;
	}
	
	var prdOrdr = $("#updateDetailArea #detailForm #prdOrdr").val();
	if( prdOrdr.indexOf(".") == 0 ){
		$("#updateDetailArea #detailForm #prdOrdr").val("");
	}
	$.ajax({
		url : "/std/saveStdPrdDetail.do", 
		type : 'POST', 
		data : $("#updateDetailArea #detailForm").serialize(),
		success : function(data) {
			var popupParam = [];
			popupParam.data = {
				title : "표준제품 관리",
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

/* 표준 제품 - 삭제 */
function rmvStdPrdConfirm(){
	var popupParam = [];
	if(fnIsEmpty($("#updateDetailArea #prdDtlSeq").val())){
		popupParam.data = {
	 	 	message : "<spring:message code='alert.noPrdSelect' />",
	 	 	showBtn2 : 'N'
		}
		layerAlert(popupParam);
		return;
	}

	popupParam.data = {
 	 	message : "<spring:message code='alert.rmvCfm'/>",
 	 	btn1Func : rmvStdPrd,
 	 	showBtn2 : 'Y'
	}
	layerAlert(popupParam);
	
}

function rmvStdPrd(){
	$(".modalCloseBtn").click();
	$.ajax({
		url : "/std/delStdPrdDetail.do", 
		type : 'POST', 
		data : $("#updateDetailArea #detailForm").serialize(),
		success : function(data) {
			var popupParam = [];
			popupParam.data = {
				title : "표준제품 관리",
				message : data,
				showBtn2 : "N"
			}
			layerAlert(popupParam);
			searchList();

			// 제품 정보 초기화
			$("#updateDetailArea").html($("#detailTmpl").tmpl({}));
			$("#updateDetailArea #detailForm input").val("");
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

function stdPrdBndChg(){
	$("#frm").attr("action", "${request.contextPath}/std/stdPrdBndChg.do");
	$("#frm").submit();
}

function resizeGrid(){
	AUIGrid.resize(mGrid, $("#content").width());
}

</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	
	<form id="frm" method="get">
		
		<!-- 조회 -->
		<div class="inquiryBox dtShort">
			<dl>
				<dt>주문여부</dt>
				<dd>
					<div class="formWrap">
						<select name="ordChk" class="sel w120" id="ordChk">
							<option value="">전체</option>
							<option value="Y">주문 가능</option>
							<option value="N">주문 불가</option>
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
				<button type="button" name="" class="inquBtn" data-id="modalAgencyViews" id="addPopBtn">등록</button>
			</div>
		</div>
		<!-- 조회 -->
	</form>

	<!-- grid -->
	<div class="girdBoxGroup">
		<div class="girdBox w55per">
			<div class="titleArea">
				<h3 class="tit01">표준제품 목록</h3>
			</div>

			<div class="titleArea right">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="dtlCnt">0</span></em> 건 이 조회되었습니다.
				</p>
				<div class="btnGroup">
					<button type="button" name="" class="comBtn small" id="ordrPopBtn">우선순위변경</button>
					<button type="button" name="" class="comBtn small" id="stdPrdBndChgBtn">일괄변경</button>
				</div>
			</div>
			<div id="grid_wrap"></div>
		</div>

		<div class="conBox w43per">
			<div class="titleArea right">
				<h3 class="tit01">세부 정보</h3>
				<div class="btnGroup">
					<button type="button" name="" class="cancelBtn small"	id="rmvBtn">삭제</button>
					<button type="button" name="" class="inquBtn small" 	id="uptBtn">저장</button>
				</div>
			</div>
			
			<!-- 세부정보 div Start -->
			<div id="updateDetailArea">
				
			</div>
			<!-- 세부정보 div End  -->
		</div>
	</div>
	<!-- grid -->
</div>

<!-- 표준제품 등록 -->
<div class="modal_bg" id="modal_bg"></div> <!-- modal 배경 -->

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
