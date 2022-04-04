<!-- 
	@File Name: stdPrdCdMng
	@File 설명 : 타사제품코드 관리
	@UI ID : UI-PSTD-0301.html
	@작성일 : 2022.01.17
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 과세구분 -->
<code:makeSelect commGrpCd="TAXT_CD" var="taxtCdList"	name="taxtCd" classNm="sel" all="false" />

<script type="text/javascript">
	var myGridID;
	var myGridID2;
	var addFlag = true;
	
	$(document).ready(function(){
		$(" #initBtn , #removeBtn ").hide();
		$("#initBtn").show();
		// AUIGrid 생성 후 반환 ID
		createAUIGrid();
		
		createAUIGrid(columnLayout2);
		// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
		
		//매입처 조회
		selectStdPchaList();

		//매입처 클릭이벤트
		AUIGrid.bind(myGridID, "rowNumCellClick", function(event) {
			var item = AUIGrid.getItemByRowIndex(myGridID, event.rowIndex );
			item.prdType = $("#prdType").val();
			
			selectStdPrdCdMstList( item );
			
			$("#frm input[name='puchSeq']").val( item.puchSeq );
			$("#frm input[name='puchCd']").val( item.puchCd );
			$("#frm input[name='puchNm']").val( item.puchNm );
			$("#puchSeq").val( item.puchSeq );
		});

		AUIGrid.bind(myGridID2, "rowNumCellClick", function(event) {
			$(" #initBtn , #removeBtn ").hide();//초기화,삭제 버튼 hide
			
			var item = AUIGrid.getItemByRowIndex(myGridID2, event.rowIndex );
			
			if( item.prdDtlSeq ){
				$("#removeBtn").show();//삭제버튼 활성화
				$("#crudMode").val("U");
				
				selectStdPrdCdDetail( item );
			}else{
				$("#initBtn").show();//초기화버튼 활성화
				$("#crudMode").val("C");
				$("#detailForm input , #detailForm select ").not("#crudMode , #puchSeq, #taxtCd ,#prdType").val("");
				$(" #spprc , #vat ").empty();
				
				getNextPuchCd( item );
				
				$("#puchCd").html( $("#frm input[name='puchCd']").val() );
				$("#puchNm").html( $("#frm input[name='puchNm']").val() );
				
				$("#tdPrdType").empty();
				$("#tdPrdType p").remove();
				var select = $("<select/>",{"class" : "sel" , "id" : "prdType" , "name" : "prdType"}).append(
						$("<option/>",{"value":""}).text("선택"),
						$("<option/>",{"value":"FER1"}).text("제품"),
						$("<option/>",{"value":"HAW2"}).text("판촉물")
				);
				$("#tdPrdType").append(select);

				var activeIdx = $(".tabsWrap .tabs").find(".active").data("idx");

				$('#prdType option').removeAttr("disabled");
				
				if( activeIdx == 1 ){//전체
					$('#prdType').children('option:eq(0)').attr('selected', 'selected');
				}else if( activeIdx == 2 ){//제품
					$('#prdType').children('option').removeAttr('selected', 'selected');
					$('#prdType option[value="FER1"]').attr('selected', 'selected');
					$('#prdType').children('option:not(:eq(1))').attr('disabled', 'disabled');
				}else{//판촉물
					$('#prdType').children('option').removeAttr('selected', 'selected');
					$('#prdType  option[value="HAW2"]').attr('selected', 'selected');
					$('#prdType').children('option:not(:eq(2))').attr('disabled', 'disabled');
				}
				
			}
		});

		$("#searchBtn").click(function(){
			var formSerializeArray = $('#frm').serializeArray();
			var item = {};
			for (var i = 0; i < formSerializeArray.length; i++){
				item[formSerializeArray[i]['name']] = formSerializeArray[i]['value'];
			}
			
			if( item.puchSeq == "" ){
				var popupParam = [];
				// 체크박스 선택여부 확인하기
				popupParam.data = {
					title : "타사제품코드 관리",
					 message : "<spring:message code='alert.stdPrdCdMng1'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			selectStdPrdCdMstList( item );
		});

		//행추가 이벤트
		$("#addRowBtn").click(function(){
			if( addFlag ){
				if( $("#puchSeq").val() ){
					var obj = {};
					//그리드 행추가
					AUIGrid.addRow(myGridID2, obj, "frist");
					//행추가버튼 플레그 변경
					addFlag = false;
					$("#crudMode").val("C");
				}
			}
		});
		
		//행 삭제 이벤트
		$("#removeRowBtn").click(function(){
			var popupParam = [];
			var checkedItems = AUIGrid.getCheckedRowItems( myGridID2 );
			if(checkedItems.length <= 0) {
				// 체크박스 선택여부 확인하기
				popupParam.data = {
						title : "타사제품코드 관리",
						message : "선택된 제품이 없습니다. 다시 확인해주세요.",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			var rowItem;
			for(var i = checkedItems.length-1; i>=0; i--) {
				rowItem = checkedItems[i];
				AUIGrid.removeRow( myGridID2 , rowItem.rowIndex );
			}

			addFlag = true;
		});

		//팝업 불러오기 이벤트
		$("#popOpen").click(function(){
			
		});

		//저장버튼 클릭이벤트
		$("#saveBtn").click(function(){
			saveStdPrdCdDetail();
		});

		$("#removeBtn").click(function(){
			var popupParam = [];
			if( !$("#puchSeq").val() ){
				// 체크박스 선택여부 확인하기
				popupParam.data = {
					title : "타사제품코드 관리",
					 message : "<spring:message code='alert.stdPrdCdMng1'/>",
					showBtn2 : 'N'
				}
				
				layerAlert(popupParam);
				
				return;
			}
			
			popupParam.data = {
					title : "타사제품코드 관리" ,
					message : "<spring:message code='alert.stdPrdCdMng2'/>" ,
					showBtn1 : 'Y' ,
					btn1Func : removeStdPrdCd ,
					showBtn2 : 'Y'
			}
			
			layerAlert(popupParam);
			
			return;
		});
		
		$(".content .tabsWrap ul.tabs li").click(function(){
			$(".content .tabsWrap ul.tabs li").removeClass("active");
			$(this).addClass("active");
			
			var activeIdx = $(".tabsWrap .tabs").find(".active").data("idx");

			$('#prdType option').removeAttr("disabled");
			
			if( activeIdx == 1 ){//전체
				$('#prdType').children('option:eq(0)').attr('selected', 'selected');
			}else if( activeIdx == 2 ){//제품
				$('#prdType').children('option').removeAttr('selected', 'selected');
				$('#prdType option[value="FER1"]').attr('selected', 'selected');
				$('#prdType').children('option:not(:eq(1))').attr('disabled', 'disabled');
			}else{//판촉물
				$('#prdType').children('option').removeAttr('selected', 'selected');
				$('#prdType  option[value="HAW2"]').attr('selected', 'selected');
				$('#prdType').children('option:not(:eq(2))').attr('disabled', 'disabled');
			}
		});
		
		//매입단가 체인지 이벤트
		untpcKeyUpEvent();

		//과세구분 체인지 이벤트
		taxtCdChangeEvent();

		//초기화버튼 클릭이벤트
		$("#initBtn").click(function(){
			$("#crudMode")
			if( $("#crudMode").val() && $("#crudMode").val() == "C" ){
				$("#detailForm input , #detailForm select ").not("#crudMode , #puchSeq , #taxtCd , #prdType").val("");
				$(" #spprc , #vat ").empty();
			}
		});
	});
	
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros1 = {
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
				groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
		};

		var gridPros2 = {
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
				groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
				softRemoveRowMode: false,
				// 엑스트라 체크박스 표시 설정
				showRowCheckColumn : true,
				// 엑스트라 체크박스에 shiftKey + 클릭으로 다중 선택 할지 여부 (기본값 : false)
				enableRowCheckShiftKey : true,
				// 전체 체크박스 표시 설정
				showRowAllCheckBox : true
		};
		
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros1);
		myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
	}
	
	var columnLayout = [
		{
			dataField : "puchNm",
			headerText : "매입처명",
			width : "100%",
		}
	];

	var columnLayout2 = [
		{
			dataField : "prdDtlCd",
			headerText : "제품 코드",
			width : "20%",
			style : "auiLink"
		},{
			dataField : "stdPrdNm",
			headerText : "본사<br>제품명",
			width : "20%",
			style : "auiLeft"
		},{
			dataField : "untpc",
			headerText : "매입단가",
			width : "15%",
			style : "auiRight"
		},{
			dataField : "spprc",
			headerText : "공급가",
			width : "18%",
			style : "auiRight"
		},{
			dataField : "vat",
			headerText : "VAT",
			style : "auiRight"
		}
	];

	/* 타사제품코드 관리 매입처 조회 */
	function selectStdPchaList(){
		$.ajax({
			url : "/std/selectPrdCdPchaList.do",
			type : 'POST',
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}

	/* 타사제품코드 관리 마스터 조회 */
	function selectStdPrdCdMstList( obj ){
		$.ajax({
			url : "/std/selectPrdCdMstList.do", 
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(obj),
			success : function(data) {
				AUIGrid.setGridData(myGridID2, data.list);
				$(".pColor01").html(data.list.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	function selectStdPrdCdDetail( obj ){
		$.ajax({
			url : "/std/selectStdPrdCdDetail.do", 
			type : 'POST', 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(obj),
			success : function(data) {
				$("#detailArea").html($("#detailTmpl").tmpl( data ));
				$('#detailForm #taxtCd  option[value=' + data.taxtCd + ']').attr('selected', 'selected');
				$("#detailForm #prdType").remove();
				$("#detailForm #tdPrdType").html("<p>"+data.prdType+"</p>");
				$("#detailForm #puchCd").html( $("#frm input[name='puchCd']").val() );
				$("#detailForm #puchNm").html( $("#frm input[name='puchNm']").val() );
				$("#detailForm #prdDtlCd").text(data.prdDtlCd);
				
				//매입단가 keyup 이벤트
				untpcKeyUpEvent();

				//과세구분 체인지 이벤트
				taxtCdChangeEvent();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}

	/* 타사제품코드 관리 - 제품 등록 */
	function saveStdPrdCdDetail(){
		//벨리데이션 체크
		if( validationCheck() ){
			var formSerializeArray = $('#detailForm').serializeArray();
			var item = {};
			for (var i = 0; i < formSerializeArray.length; i++){
				item[formSerializeArray[i]['name']] = formSerializeArray[i]['value'];
			}
			
			$.ajax({
				url : "/std/saveStdPrdCdDetail.do", 
				type : 'POST',
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(item),
				success : function(data) {
					var popupParam = [];
					popupParam.data = {
						title : "타사제품코드 관리",
						 message : data.msg,
						showBtn2 : 'N'
					}
					layerAlert(popupParam);
					return;
				}, // success 
				error : function(xhr, status) {
					alert(xhr + " : " + status);
				}
			});
		}
	}

	//제품코드 생성 함수
	function getNextPuchCd(){
		var obj = {"puchSeq" : $("#puchSeq").val()};
		$.ajax({
			url : "/std/getNextPrdDtlCd.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(obj),
			success : function(data) {
				//매입처 코드 셋팅
				$("#detailForm #prdDtlCd").text( data.nextPrdDtlCd );
				$("#detailForm input[name='prdDtlCd']").val( data.nextPrdDtlCd );
			}, // success
			error : function(xhr, status) {
				alert("매입처 코드 조회중 오류가 발생하였습니다.");
			}
		});
	}
	
	function removeStdPrdCd(){
		$("#crudMode").val("D");
		var item = {"crudMode" : $("#crudMode").val() , "puchSeq" : $("#puchSeq").val() , "prdSeq" : $("#prdSeq").val() };
		$.ajax({
			url : "/std/removeStdPrdCd.do",
			type : "POST", 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(item),
			success : function(data) {
				var popupParam = [];
				popupParam.data = {
					title : "타사제품코드 관리",
					 message : data.msg,
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}

	function validationCheck(){
		var result = true;
		var msg = "";
		
		if( $("#detailForm #crudMode").val() == "C" && !$("#detailForm #prdType").val() ){
			msg = "자재유형을 선택해주세요.";
			result = false;
		}else if( !$("#detailForm #stdPrdNm").val() ){
			msg = "제품명을 입력해주세요.";
			result = false;
		}else if( !$("#detailForm #faltQty").val() ){
			msg = "BOX 입수량을 입력해주세요.";
			result = false;
		}else if( !$("#detailForm #iddyStdr").val() ){
			msg = "낱봉기준을 입력해주세요.";
			result = false;
		}else if( !$("#detailForm #untpc").val() ){
			msg = "매입단가를 입력해주세요.";
			result = false;
		}else if( !$("#detailForm #prdOrdr").val() ){
			msg = "판매우선순위를 입력해주세요.";
			result = false;
		}
		
		if( !result ){
			var popupParam = [];
			popupParam.data = {
					title : "타사제품코드 관리",
					 message : msg,
					showBtn2 : 'N'
				}
			layerAlert(popupParam);
			return;
		}

		return result;
	}

	//매입단가 keyUp 이벤트
	function untpcKeyUpEvent(){
		$("#untpc").keyup(function() {
			var untpc = Number( $(this).val() );
			var vat = 0;
			var spprc = 0;
			
			if( $("#taxtCd").val() == 'TAXT' ){//과세
				//vat 계산식 매입단가 / 11
				vat = untpc / 11;
				//공급가 계산식 매입단가 - VAT
				spprc = untpc - vat;
			}else{//면세
				//VAT = 0
				vat = 0;
				//공급가 = 매입단가
				spprc = untpc;
			}
			
			$("#spprc").text( spprc );
			$("#vat").text( vat );
			$("input[name='spprc']").val( spprc );
			$("input[name='vat']").val( vat );
		});
	}

	//과세구분 체인지 이벤트
	function taxtCdChangeEvent(){
		$("#taxtCd").change( function(){
			var untpc = Number( $("#untpc").val() );
			var vat = 0;
			var spprc = 0;
			
			if( $(this).val() == 'TAXT' ){//과세
				//vat 계산식 매입단가 / 11
				vat = untpc / 11;
				//공급가 계산식 매입단가 - VAT
				spprc = untpc - vat;
			}else{//면세
				//VAT = 0
				vat = 0;
				//공급가 = 매입단가
				spprc = untpc;
			}
			
			$("#spprc").text( spprc );
			$("#vat").text( vat );
			$("input[name='spprc']").val( spprc );
			$("input[name='vat']").val( vat );
		});
	}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- 조회 -->
	<form id="frm" method="post">
		<input type="hidden" name="puchSeq">
		<input type="hidden" name="puchCd">
		<input type="hidden" name="puchNm">
		<div class="inquiryBox dtShort">
			<dl>
				<dt>제품</dt>
				<dd>
					<div class="formWrap">
						<input type="text" id="prdDtlCd" name="prdDtlCd" class="inp w120 mr10" value="" placeholder="제품코드" maxlength="8">
						<input type="text" id="stdPrdNm" name="stdPrdNm" class="inp w160 mr7" value="" placeholder="제품명">
						<button type="button" class="comBtn" id="searchBtn">조회</button>
					</div>
				</dd>
			</dl>
		</div>
	</form>
	<!-- 조회 -->
	
	<div class="tabsWrap">
		<ul class="tabs">
			<li class="active" rel="tab01" data-idx="1">전체</li>
			<li class="" rel="tab02" data-idx="2">제품</li>
			<li class="" rel="tab03" data-idx="3">판촉물</li>
		</ul>
	</div>
		<!-- grid -->
		<div class="titleArea right">
			<h3 class="tit01">타사제품코드 목록</h3>
		</div>
		
		<div class="girdBoxGroup">
			<div class="gridSBox w55per">
				<div class="gridItem topBlank w33per">
					<div id="grid_wrap"></div>
				</div>
				
				<div class="gridItem">
					<div class="titleArea right">
						<p class="numState">
							<em>총 <span class="pColor01 fb"></span></em> 건 이 조회되었습니다.
						</p>
						<div class="btnGroup">
							<button type="button" class="comBtn small" id="popOpen">불러오기</button>
							<button type="button" class="comBtn small" id="addRowBtn">행추가</button>
							<button type="button" class="comBtn small" id="removeRowBtn">행삭제</button>
						</div>
					</div>
					<div id="grid_wrap2"></div>
				</div>
			</div>
				
			<div class="conBox w43per">
				<div class="titleArea right">
					<h3 class="tit01">세부 정보</h3>
	
					<div class="btnGroup">
						<button type="button" name="" class="comBtn small" id="initBtn">초기화</button>
						<button type="button" name="" class="cancelBtn small" id="removeBtn">삭제</button>
						<button type="button" class="inquBtn small" id="saveBtn">저장</button>
					</div>
				</div>
				<!-- 세부정보 -->
				<form id="detailForm">
					<input type="hidden" name="crudMode" id="crudMode">
					<input type="hidden" name="puchSeq" id="puchSeq">
					<div id="detailArea">
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
										<td>
											<p id="puchCd"></p>
										</td>
										<th scope="row">매입처명</th>
										<td>
											<p id="puchNm"></p>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="sel_bankNum02" title="필수입력">제품코드</label>
										</th>
										<td>
											<p id="prdDtlCd"></p>
											<input type="hidden" name="prdDtlSeq" id="prdDtlSeq" value=""/>
											<input type="hidden" name="prdDtlCd" value=""/>
										</td>
										<th scope="row">
											<label for="prdType" class="required" title="필수입력">자재유형</label>
										</th>
										<td id="tdPrdType">
											<select name="prdType" class="sel" id="prdType">
												<option value="">선택</option>
												<option value="FER1">제품</option>
												<option value="HAW2">판촉물</option>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="stdPrdNm" class="required" title="필수입력">제품명</label>
										</th>
										<td colspan="3">
											<input type="text" id="stdPrdNm" name="stdPrdNm" class="inp" value="">
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="faltQty" class="required" title="필수입력">BOX 입수량</label>
										</th>
										<td>
											<input type="number" id="faltQty" name="faltQty" class="inp" value="">
										</td>
										<th scope="row">
											<label for="iddyStdr" class="required" title="필수입력">낱봉기준</label>
										</th>
										<td>
											<input type="number" id="iddyStdr" name="iddyStdr" class="inp" value="">
										</td>
									</tr>
									<tr>
										<th scope="row">과세구분</th>
										<td>
											${taxtCdList}
										</td>
										<th scope="row">
											<label for="untpc" class="required" title="필수입력">매입단가</label>
										</th>
										<td>
											<input type="number" id="untpc" name="untpc" class="inp" value="">
										</td>
									</tr>
									<tr>
										<th scope="row">공급가</th>
										<td>
											<p id="spprc"></p>
											<input type="hidden" name="spprc" class="inp" value="">
										</td>
										<th scope="row">VAT</th>
										<td>
											<p id="vat"></p>
											<input type="hidden" name="vat" class="inp" value="">
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="prdOrdr" class="required" title="필수입력">판매우선순위</label>
										</th>
										<td>
											<input type="number" id="prdOrdr" name="prdOrdr" class="inp" value="">
										</td>
										<th scope="row">박스바코드</th>
										<td>
											<input type="text" id="brcd" name="brcd" class="inp" value="">
										</td>
									</tr>
									<tr>
										<th scope="row">소포장바코드</th>
										<td>
											<input type="text" id="etcBrcd" name="etcBrcd" class="inp" value="" />
										</td>
										<th scope="row">낱봉바코드</th>
										<td>
											<input type="text" id="iddyBrcd" name="iddyBrcd" class="inp" value=""/>
										</td>
									</tr>
									<tr>
										<th scope="row">제품군</th>
										<td colspan="3">
											<input type="text" id="suiteNm" name="suiteNm" class="inp" value="" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</form>
				<!-- 세부정보 -->
			</div>
		</div>
		<!-- grid -->
</div>

<script id="detailTmpl" type="text/x-jquery-tmpl">
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
				<td>
					<p id="puchCd"></p>
				</td>
				<th scope="row">매입처명</th>
				<td>
					<p id="puchNm"></p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="sel_bankNum02" title="필수입력">제품코드</label>
				</th>
				<td>
					<p id="prdDtlCd"></p>
					<input type="hidden" name="prdDtlSeq" id="prdDtlSeq" value="\${prdDtlSeq}"/>
					<input type="hidden" name="prdDtlCd" value="\${prdDtlCd}"/>
				</td>
				<th scope="row">
					<label for="prdType" class="required" title="필수입력">자재유형</label>
				</th>
				<td id="tdPrdType">
					<select name="prdType" class="sel" id="prdType">
						<option value="">선택</option>
						<option value="FER1">제품</option>
						<option value="HAW2">판촉물</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="stdPrdNm" class="required" title="필수입력">제품명</label>
				</th>
				<td colspan="3">
					<input type="text" id="stdPrdNm" name="stdPrdNm" class="inp" value="\${stdPrdNm}">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="faltQty" class="required" title="필수입력">BOX 입수량</label>
				</th>
				<td>
					<input type="number" id="faltQty" name="faltQty" class="inp" value="\${faltQty}">
				</td>
				<th scope="row">
					<label for="iddyStdr" class="required" title="필수입력">낱봉기준</label>
				</th>
				<td>
					<input type="number" id="iddyStdr" name="iddyStdr" class="inp" value="\${iddyStdr}">
				</td>
			</tr>
			<tr>
				<th scope="row">과세구분</th>
				<td>
					${taxtCdList}
				</td>
				<th scope="row">
					<label for="untpc" class="required" title="필수입력">매입단가</label>
				</th>
				<td>
					<input type="number" id="untpc" name="untpc" class="inp" value="\${untpc}">
				</td>
			</tr>
			<tr>
				<th scope="row">공급가</th>
				<td>
					<p id="spprc">\${spprc}</p>
					<input type="hidden" name="spprc" class="inp" value="\${spprc}">
				</td>
				<th scope="row">VAT</th>
				<td>
					<p id="vat">\${vat}</p>
					<input type="hidden" name="vat" class="inp" value="\${vat}">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="prdOrdr" class="required" title="필수입력">판매우선순위</label>
				</th>
				<td>
					<input type="number" id="prdOrdr" name="prdOrdr" class="inp" value="\${prdOrdr}">
				</td>
				<th scope="row">박스바코드</th>
				<td>
					<input type="text" id="brcd" name="brcd" class="inp" value="\${brcd}">
				</td>
			</tr>
			<tr>
				<th scope="row">소포장바코드</th>
				<td>
					<input type="text" id="etcBrcd" name="etcBrcd" class="inp" value="\${etcBrcd}" />
				</td>
				<th scope="row">낱봉바코드</th>
				<td>
					<input type="text" id="iddyBrcd" name="iddyBrcd" class="inp" value="\${iddyBrcd}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">제품군</th>
				<td colspan="3">
					<input type="text" id="suiteNm" name="suiteNm" class="inp" value="\${suiteNm}" />
				</td>
			</tr>
		</tbody>
	</table>
</div>
</script>