<!-- 
	@File Name: PrmtEmplMng.jsp
	@File 설명 : 판촉사원 관리
	@UI ID : UI-PPRO-0401.html
	@작성일 : 2022. 3. 11.
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
		createAUIGrid( columnLayout );
		
		//판촉사원 그룹코드 조회
		selectCommCodeList();
		
		//리스트 조회
		$("#srcBtn").on("click", searchList);

		//저장 클릭 이벤트
		$("#saveBtn").on("click", savePrmtEmplHis );
		
		AUIGrid.bind(myGridID, "cellEditBegin", function(event) {
			if( (event.dataField == "newAgenHop" || event.dataField == "recntrAgenHop" || event.dataField == "chpdyAgenCt") && event.item.emplSecCd == 'HOFF_PRMT_EMPL' ){
				return false; // false 반환. 기본 행위인 편집 불가
			}
		});
		
		$('#monthPicker2').val( new Date().getFullYear() + '-' + (new Date().getMonth() + 4) );
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
				enterKeyColumnBase : true,
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
		
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	}

	var columnLayout = [
		{
			dataField : "prmtEmplCd",
			headerText : "판촉사원코드",
			width : "8.3%",
			editable : false
		},{
			dataField : "emplNm",
			headerText : "성명",
			width : "8.3%",
			editable : false
		},{
			dataField : "emplSecNm",
			headerText : "판촉사원구분",
			width : "8.3%",
			editable : false
		},{
			dataField : "brthdy",
			headerText : "생년월일",
			width : "8.3%",
			editable : false
		},{
			dataField : "cntrYnNm",
			headerText : "계약여부",
			width : "8.3%",
			editable : false
		},{
			dataField : "telNo",
			headerText : "휴대폰<br>번호",
			width : "8.3%",
			editable : false
		},{
			dataField : "newAgenHop",
			headerText : "신규계약<br>홉단가(대리점)",
			dataType : "numeric",
			width : "8.3%",
			style : "auiRight",
			editable : true,
			editRenderer : {
				type : "InputEditRenderer",
				onlyNumeric : true, // 0~9 까지만 허용
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
			dataField : "recntrAgenHop",
			headerText : "재계약<br>홉단가(대리점)",
			dataType : "numeric",
			width : "8.3%",
			style : "auiRight",
			editable : true,
			editRenderer : {
				type : "InputEditRenderer",
				onlyNumeric : true, // 0~9 까지만 허용
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
			dataField : "chpdyAgenCt",
			headerText : "일당",
			dataType : "numeric",
			width : "8.3%",
			style : "auiRight",
			editable : true,
			editRenderer : {
				type : "InputEditRenderer",
				onlyNumeric : true, // 0~9 까지만 허용
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
			dataField : "cntrDt",
			headerText : "계약일",
			wwidth : "8.3%",
			editable : false
		},{
			dataField : "cntrEndDt",
			headerText : "종료일",
			width : "8.3%",
			editable : false
		},{
			dataField : "bhfcNm",
			headerText : "지점",
			width : "8.3%",
			editable : false
		}
	];
	
	/* 판촉사원 관리 조회 */
	function searchList() {
		var srcStartMonth = $("#frm #monthPicker1").val().split("-");
		var srcEndMonth = $("#frm #monthPicker2").val().split("-");
		var sDate = new Date(srcStartMonth[0],srcStartMonth[1],"01");
		var eDate = new Date(srcEndMonth[0],srcEndMonth[1],"01");
		if((eDate.getTime()-sDate.getTime()) /(1000*60*60*24) >= 365){
			var popupParam = [];
			popupParam.data = {
				title : "판촉사원 관리",
		 	 	message : "<spring:message code='alert.prmtEmplMng2'/>",
		 	 	showBtn2 : 'N'
			}
			layerAlert(popupParam);
			$("#frm #monthPicker1").val(fnGetToMon());
			$("#frm #monthPicker2").val( new Date().getFullYear() + '-' + (new Date().getMonth() + 4) );
			return;
		}
		
		var item = {
				"startMon" : $("#frm #monthPicker1").val(),
				"endMon" : $("#frm #monthPicker2").val(),
				"cntrYn" : $("#frm #cntrYn").val(),
				"emplSecCd" : $("#frm #emplSecCd").val(),
				"cntrYn" : $("#frm #cntrYn").val()
		};
		
		$.ajax({
			url : "/prmt/selectPrmtEmplMngList.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(item),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#listCnt").html(data.list.length);
			},
			error : function(xhr , status , a) {
				alert(xhr + " : " + status);
			}
		});
	}

	//판촉사원 관리 저장
	function savePrmtEmplHis(){
		
		var saveData = getSaveData();
		
		if(!saveData.length > 0){
			//저장할 데이터가 없습니다.
			var popupParam = [];
			popupParam.data = {
				title : " 판촉사원 관리",
				message : "<spring:message code='alert.prmtEmplMng1'/>",
				showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}

		console.log( "saveData" , saveData );
		
		$.ajax({
			url : "/prmt/savePrmtEmplHis.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(saveData),
			success : function(data) {
				//리스트 조회
				searchList();
				
				var popupParam = [];
				popupParam.data = {
					title : "판촉사원 관리",
					message : data,
					showBtn2 : 'N'
				}
				
				layerAlert(popupParam);
				return;
			},
			error : function( xhr , status ) {
				alert( xhr + " : " + status );
			}
		});
		
	}
	
	function getSaveData(){
		var saveData = new Array();
		
		$.each(fnGetGridListCRUD( myGridID ), function(idx,item){
			saveData.push({
				"crudMode" : item.crudMode,
				"prmtEmplHisSeq" : item.prmtEmplHisSeq,
				"prmtEmplSeq" : item.prmtEmplSeq,
				"bhfcSeq" : item.bhfcSeq,
				"newAgenHop" : item.newAgenHop,
				"recntrAgenHop" : item.recntrAgenHop,
				"chpdyAgenCt" : item.chpdyAgenCt,
				"cntrDt" : item.cntrDt
			});
		});
		return saveData;
	}

	function selectCommCodeList(){
		$.ajax({
			url : "/comm/selectCommCodeList.do",
			type : 'POST',
			data : {"useYn" : "Y" , "commGrpCd" : "EMPL_SEC_CD"},
			success : function(data) {
				var option =
						data.filter(function(el , idx , array){
							return el.commCd == "AGENT_PRMT_EMPL" || el.commCd == "HOFF_PRMT_EMPL";
						}).map(function(item , idx){
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
					<dt>기간</dt>
					<dd>
						<div class="formWrap">
							<div class="dateWrap">
								<input type="text" name="startMon" value="" class="inp monthPicker" id="monthPicker1" readonly>
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="monthPicker1"></button>
							</div>
							<span class="divi02">~</span>
							<div class="dateWrap">
								<input type="text" name="endMon" value="" class="inp monthPicker" id="monthPicker2" readonly>
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="monthPicker2"></button>
							</div>
						</div>
					</dd>
					<dt>판촉사원</dt>
					<dd>
						<div class="formWrap">
							<select name="emplSecCd" id="emplSecCd" class="sel">
								<option value="">전체</option>
							</select>
						</div>
					</dd>
					<dt>계약여부</dt>
					<dd>
						<div class="formWrap">
							<select name="cntrYn" id="cntrYn" class="sel">
								<option value="">전체</option>
								<option value="Y">계약중</option>
								<option value="N">계약종료</option>
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