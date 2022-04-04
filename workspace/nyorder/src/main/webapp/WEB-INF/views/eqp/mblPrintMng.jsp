<!-- 
	@File Name: mblPrintMng.jsp
	@File 설명 : 모바일프린터 관리
	@UI ID : UI-PEQU-0101
	@작성일 : 2022. 3. 7.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" 	prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 		prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags"  	prefix="spring"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<code:makeSelect commGrpCd="EQP_STUS_SEC" 	var="eqpStusSec"	name="eqpStusSec" classNm="sel w160"/>
<code:makeSelect commGrpCd="EQP_STUS_SEC" 	var="eqpStusSec2"	name="eqpStusSec" classNm="sel w160" all="false"/>
<script type="text/javascript">
var myGridID;
	$(document).ready(function(){
		createAUIGrid();
		// 조회 버튼 
		$("#srcBtn").click(searchList);
		// 저장 버튼
		$("#saveBtn").click(updateMblPrint);

		$("#resetBtn").click(function(){
			$("#addFrm #agenEqpSeq").val("");
			$("#addFrm #eqpNm").val("");
			$("#addFrm #eqpCd").val("");
			$("#addFrm #chagEmplSeq option:eq(0)").prop("selected", true);
			$("#addFrm #eqpStusSec option:eq(0)").prop("selected", true);
			$("#addFrm #pymDt").val(fnGetToDay());
			$("#addFrm #colDt").val("");
		});
		
		$("#colDt").val("");

		/* 그리드 이벤트 바인드 */
		AUIGrid.bind(myGridID, "cellClick", function( event ) {
			$("#addFrm #agenEqpSeq").val(event.item.agenEqpSeq);
			$("#addFrm #eqpNm").val(event.item.eqpNm);
			$("#addFrm #eqpCd").val(event.item.eqpCd);
			$("#addFrm #eqpStusSec").val(event.item.eqpStusSec);
			$("#addFrm #chagEmplSeq").val(event.item.chagEmplSeq);
			$("#addFrm #pymDt").val(fnConvertDate2(event.item.pymDt));
			$("#addFrm #colDt").val(fnConvertDate2(event.item.colDt));
		});
		
	});
	
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	}

	// 그리드 속성 설정
	 var gridPros = {
		headerHeight : 29,
		rowHeight : 29,
		// 편집 가능 여부 (기본값 : false)
		editable : false,
		// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
		enterKeyColumnBase : false,
		showRowCheckColumn : false, // 체크박스 사용
		// 셀 선택모드 (기본값: singleCell)
		selectionMode : "singleRow",
		showFooter : false,
		noDataMessage : "출력할 데이터가 없습니다.",
		groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
	};

	var columnLayout = [{
		 dataField : "eqpNm",
			headerText : "장비명",			
			style: "auiLeft"
		},{
			dataField : "eqpCd",
			headerText : "장비번호",
			width : "16%",
	 },{
			dataField : "eqpStusSecNm",
			headerText : "상태",
			width : "12%",
	 },{
			dataField : "chagEmplNm",
			headerText : "담당자",
			width : "12%",
	 },{
			dataField : "pymDt",
			headerText : "지급일자",
			dataType : "date",
			formatString : "yyyy-mm-dd",
		 	width : "12%",
	 },{
			dataField : "colDt",
			headerText : "회수일자",
			dataType : "date",
			formatString : "yyyy-mm-dd",
		 	width : "12%",
	 },{
			dataField : "updDtm",
			headerText : "저장일시",
			dataType : "date",
			formatString : "yyyy-mm-dd HH:MM",
			width : "12%",
		}
	];

	// 리스트 조회
	function searchList(){
		$.ajax({
			url : "/eqp/selectMblPrintMngList.do", 
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

	// 저장
	function updateMblPrint(){
		$.ajax({
			url : "/eqp/updateMblPrintMng.do", 
			type : 'POST', 
			data : $("#addFrm").serialize(),
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
				if ( Common.IsJsonString(xhr.responseText) )
				{
					var message = JSON.parse(xhr.responseText).message;
					alert(message);
				}
				else
				{
					alert("처리중 오류가 발생 하였습니다.");
				}
			}
		}); 
	}
	
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	
	<!-- 조회 -->
	<form id="frm">
		<div class="inquiryBox">
			<dl>
				<dt>상태</dt>
				<dd>
					${eqpStusSec}
				</dd>
				<dt>담당자</dt>
				<dd>
					<select name="chagEmplSeq" class="sel w160" id="chagEmplSeq">
						<option value="">전체</option>
						<c:forEach var="empl" items="${emplList}" varStatus="status">
							<option value="${empl.emplSeq}">${empl.emplNm}</option>
						</c:forEach>
					</select>
				</dd>
				<dt>장비명</dt>
				<dd>
					<div class="formWrap">
						<input type="text" id="srcEqpNm" class="inp mr10" value="" title="제품 입력" name="eqpNm">
						<button type="button" name="" class="comBtn" id="srcBtn" >조회</button>
					</div>
				</dd>
			</dl>

			<div class="btnGroup right">
				<button type="button" name="" class="comBtn"	id="resetBtn">신규</button>
				<button type="button" name="" class="inquBtn"	id="saveBtn">저장</button>
			</div>
		</div>
	</form>
	<!-- 조회 -->

	<div class="titleArea right">
		<h3 class="tit01">프린터 지급 정보</h3>
	</div>

	<div class="titleArea">
		<p class="numState">
			<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
		</p>
	</div>

	<!-- grid -->
	<div class="girdBox h340">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->

	<div class="titleArea type02 right">
		<h3 class="tit01">지급 상세 정보</h3>
	</div>

	<form id="addFrm">
		<input type="hidden" id="agenEqpSeq" name="agenEqpSeq"/>
		<div class="tblWrap">
			<table class="tbl">
				<caption>지급 상세 정보</caption>
				<colgroup>
					<col style="width:170px;">
					<col>
					<col style="width:170px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">
							<label for="eqpNm">장비명</label>
						</th>
						<td>
							<input type="text" id="eqpNm" class="inp" value="" name="eqpNm">
						</td>
						<th scope="row">
							<label for="eqpStusSec">상태</label>
						</th>
						<td>
							${eqpStusSec2}
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="eqpCd">장비번호</label>
						</th>
						<td>
							<input type="text" id="eqpCd" class="inp" value="" name="eqpCd">
						</td>
						<th scope="row">
							<label for="chagEmplSeq">담당자</label>
						</th>
						<td>
							<select name="chagEmplSeq" class="sel w160" id="chagEmplSeq">
								<option value="">전체</option>
								<c:forEach var="empl" items="${emplList}" varStatus="status">
									<option value="${empl.emplSeq}">${empl.emplNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="pymDt">지급일자</label>
						</th>
						<td>
							<div class="dateWrap">
								<input type="text" name="pymDt" value="" class="inp datepicker" id="pymDt">
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="pymDt"></button>
							</div>
						</td>
						<th scope="row">
							<label for="colDt">회수일자</label>
						</th>
						<td>
							<div class="dateWrap">
								<input type="text" name="colDt" value="" class="inp datepicker" id="colDt">
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="colDt"></button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>

</div>
