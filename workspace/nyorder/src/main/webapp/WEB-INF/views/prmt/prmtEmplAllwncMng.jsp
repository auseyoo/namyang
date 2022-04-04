<!-- 
	@File Name: prmtEmplAllwncMng.jsp
	@File 설명 : 판촉사원 수당 관리
	@UI ID : UI-PPRO-0501.html
	@작성일 : 2022. 3. 10.
	@작성자 : 윤이준
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">
	var myGridID;
	
	$(document).ready(function(){
		// AUIGrid 생성 후 반환 ID
		createAUIGrid();

		//판촉사원 그룹코드 조회
		selectCommCodeList();

		searchList();
		
		//리스트 조회
		$("#srcBtn").on("click", searchList);
		
		//저장 클릭 이벤트
		$("#saveBtn").on("click", savePrmtEmplAllwnc );
		
	});
	
	// AUIGrid 를 생성합니다.
	function createAUIGrid(columnLayout) {
		// 그리드 속성 설정
		var gridPros = {
				headerHeight : 59,
				rowHeight : 29,
				// 편집 가능 여부 (기본값 : false)
				editable : true,
				// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
				enterKeyColumnBase : false,
				showRowNumColumn : true, 
				// 셀 선택모드 (기본값: singleCell)
				selectionMode : "singleRow",
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

		var columnLayout = [
			{
				dataField : "prmtEmplCd",
				headerText : "판촉사원 코드",
				width : "6.3%",
				editable : false
			},{
				dataField : "emplNm",
				headerText : "판촉사원",
				width : "5.5%",
				editable : false
			},{
				dataField : "newPrdCnt",
				headerText : "신규 제품수",
				width : "6.3%",
				style : "auiRight",
				editable : false
			},{
				dataField : "reCntrPrdCnt",
				headerText : "재계약 제품수",
				width : "6.3%",
				style : "auiRight",
				editable : false
			},{
				dataField : "totalPrd",
				headerText : "총 건수",
				width : "6.3%",
				style : "auiRight",
				editable : false,
				expFunction : function( rowIndex , columnIndex , itm , dataField ) {
					//신규 제품수
					var newPrdCnt = ( itm.newPrdCnt ) ? Number( itm.newPrdCnt ) : 0;
					//재계약 제품수
					var reCntrPrdCnt = ( itm.reCntrPrdCnt ) ? Number( itm.reCntrPrdCnt ) : 0;
					//신규 제품 + 재계약 제품
					return Number( newPrdCnt + reCntrPrdCnt );
				}
			},{
				dataField : "newHop",
				headerText : "신규 홉수",
				dataType : "numeric",
				width : "6.3%",
				style: "auiRight",
				editable : false
			},{
				dataField : "reCntrHop",
				headerText : "재계약 홉수",
				dataType : "numeric",
				width : "6.3%",
				style: "auiRight",
				editable : false
			},{
				dataField : "totalHop",
				headerText : "총 홉수",
				width : "6.3%",
				style: "auiRight",
				editable : false,
				expFunction : function( rowIndex , columnIndex , itm , dataField ) {
					//신규 홉수
					var newHop = ( itm.newHop ) ? Number( itm.newHop ) : 0;
					//재계약 홉수
					var reCntrHop = ( itm.reCntrHop ) ? Number( itm.reCntrHop ) : 0;
					//신규홉수 + 재계약 홉수
					return Number( newHop + reCntrHop );
				}
			},{
				dataField : "newAgenHop",
				headerText : "신규계약<br>홉단가(대리점)",
				dataType : "numeric",
				width : "6.3%",
				style : "auiRight",
				editable : false
			},{
				dataField : "recntrAgenHop",
				headerText : "재계약<br>홉단가(대리점)",
				dataType : "numeric",
				width : "6.3%",
				style : "auiRight",
				editable : false
			},{
				dataField : "hoffPay",
				headerText : "본사 수당",
				dataType : "numeric",
				width : "6.3%",
				style: "auiRight",
				editable : false,
				expFunction : function( rowIndex , columnIndex , itm , dataField ) {
					// 신규 홉수
					var newHop = ( itm.newHop ) ? Number( itm.newHop ) : 0;
					// 재계약 홉수
					var reCntrHop = ( itm.reCntrHop ) ? Number( itm.reCntrHop ) : 0;
					// 신규계약 홉단가(본사)
					var newHoffHop = ( itm.newHoffHop ) ? Number( itm.newHoffHop ) : 0;
					// 재계약 홉단가(본사)
					var recntrHoffHop = ( itm.recntrHoffHop ) ? Number( itm.recntrHoffHop ) : 0;

					//( 신규 홉수*신규계약 홉단가(본사) ) + ( 재계약 홉수*재계약 홉단가(본사) )
					return Number( ( newHop * newHoffHop ) + ( reCntrHop * recntrHoffHop ) );
				}
			},{
				dataField : "toTalHopPay",
				headerText : "홉수당 합계",
				dataType : "numeric",
				width : "6.3%",
				style: "auiRight",
				editable : false,
				expFunction : function( rowIndex , columnIndex , itm , dataField ) {
					// 신규 홉수
					var newHop = ( itm.newHop ) ? Number( itm.newHop ) : 0;
					// 재계약 홉수
					var reCntrHop = ( itm.reCntrHop ) ? Number( itm.reCntrHop ) : 0;
					//신규계약 홉단가(대리점)
					var newAgenHop = ( itm.newAgenHop ) ? Number( itm.newAgenHop ) : 0;
					//재계약 홉단가(대리점)
					var recntrAgenHop = ( itm.recntrAgenHop ) ? Number( itm.recntrAgenHop ) : 0;
					
					//( 신규 홉수 * 신규계약 홉단가(대리점) ) + ( 재계약 홉수 * 재계약 홉단가(대리점) )
					return Number( ( newHop * newAgenHop ) + ( reCntrHop * recntrAgenHop ) );
				}
			},{
				dataField : "agenPay",
				headerText : "대리점 수당",
				dataType : "numeric",
				width : "6.3%",
				style: "auiRight",
				editable : false,
				expFunction : function( rowIndex , columnIndex , itm , dataField ) {
					// 홉수당 합계
					var toTalHopPay = ( itm.toTalHopPay ) ? Number( itm.toTalHopPay ) : 0;
					// 본사 수당
					var hoffPay = ( itm.hoffPay ) ? Number( itm.hoffPay ) : 0;
					
					//홉수당 합계 – 본사수당
					return Number( toTalHopPay - hoffPay );
				}
			},{
				dataField : "chpdyAgenCt",
				headerText : "일당",
				dataType : "numeric",
				width : "6.3%",
				style: "auiRight",
				editable : false
			},{
				dataField : "speclAllwnc",
				headerText : "특별 수당",
				dataType : "numeric",
				width : "6.3%",
				style: "auiRight",
				editable : true,
				editRenderer : {
					type : "InputEditRenderer",
					onlyNumeric : true // 0~9 까지만 허용
				},
				renderer : {
					type : "TemplateRenderer"
				},
				labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
					var template = '<div class="my_div">';
					template += '<span class="my_div_text_box right">' + value + '</span>';
					template += '</div>';
					return template;
				}
			},{
				dataField : "allTotal",
				headerText : "총 합계",
				dataType : "numeric",
				width : "6.3%",
				style: "auiRight",
				editable : false,
				expFunction : function( rowIndex, columnIndex, item, dataField ) {
					//특별수당
					var speclAllwnc = ( item.speclAllwnc ) ? Number( item.speclAllwnc ) : 0;
					//일당
					var chpdyAgenCt = ( item.chpdyAgenCt ) ? Number( item.chpdyAgenCt ) : 0;
					//홉수당 합계
					var toTalHopPay = ( item.toTalHopPay ) ? Number( item.toTalHopPay ) : 0;
					
					return Number( toTalHopPay + chpdyAgenCt + speclAllwnc );
				}
			}
		];
		
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	}
	
	/* 판촉사원 수당 관리 조회 */
	function searchList() {
		$.ajax({
			url : "/prmt/selectPrmtEmplAllwncList.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify({"searchMon" : $("#frm #monthPicker").val() , "emplSecCd" : $("#frm #emplSecCd").val() }),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#listCnt").html(data.list.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	//판촉사원 수당 저장
	function savePrmtEmplAllwnc(){
		
		var saveData = new Array();
		
		$.each(fnGetGridListCRUD( myGridID ), function( idx , item ){
			saveData.push(item);
		});
		
		if(!saveData.length > 0){
			//저장할 내용이 없습니다.
			var popupParam = [];
			popupParam.data = {
				title : "판촉사원 수당 관리",
				message : "<spring:message code='alert.prmtEmplAllwncMng1'/>",
				showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}
		
		$.ajax({
			url : "/prmt/savePrmtEmplAllwnc.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(saveData),
			success : function(data) {
				//리스트 조회
				searchList();
				
				var popupParam = [];
				popupParam.data = {
					title : "판촉사원 수당관리",
					message : "<spring:message code='alert.prmtEmplAllwncMng2'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}

	function selectCommCodeList(){
		$.ajax({
			url : "/comm/selectCommCodeList.do",
			type : 'POST',
			data : {"useYn" : "Y" , "commGrpCd" : "EMPL_SEC_CD"},
			success : function(data) {
				var option =
						data.filter(function(el, idx, array){
							return el.commCd === "AGENT_PRMT_EMPL" || el.commCd == "HOFF_PRMT_EMPL";
						}).map(function( item , idx ){
							var option = $("<option/>",{"value":item.commCd}).text( item.commDesc4 );
							return option;
						});
				
				$("#emplSecCd").append( option );
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
</script>

<!-- content -->
<div class="rContentBox">
	<div class="content">
		<tiles:insertAttribute name="body.breadcrumb" />
		
		<!-- 조회 -->
		<form id="frm">
			<div class="inquiryBox">
				<dl>
					<dt>기준월</dt>
					<dd>
						<div class="dateWrap">
							<input type="text" name="cntrMonth" value="" class="inp monthPicker" id="monthPicker" readonly>
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="monthPicker"></button>
						</div>
					</dd>
					<dt>판촉사원</dt>
					<dd>
						<div class="formWrap">
							<select name="emplSecCd" id="emplSecCd" class="sel">
								<option value="">전체</option>
							</select>
							<button type="button" class="comBtn" id="srcBtn">조회</button>
						</div>
					</dd>
				</dl>
				<div class="btnGroup right">
					<button type="button" class="inquBtn" id="saveBtn">저장</button>
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
</div>
<!-- content -->