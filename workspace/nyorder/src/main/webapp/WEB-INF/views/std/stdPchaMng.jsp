<!-- 
	@File Name: stdPchaMng
	@File 설명 : 매입처 관리
	@UI ID : UI-PSTD-0401.html
	@작성일 : 2022.01.11
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<code:makeSelect commGrpCd="USE_CD" var="useCdList"	name="useCd" classNm="sel" all="false" />

<script type="text/javascript">

	var myGridID;
	
	//행추가 이벤트 플레그
	var addFlag = true;
	
	$(document).ready(function(){
		//데이트피커 로드
		datepickerLoad();
		
		//초기진입시 날짜 설정
		var statDt = $("#datepicker01").val().replace('-','').replace('-','');
		$("#statDt").val( statDt );
		var endDt = $("#datepicker02").val().replace('-','').replace('-','');
		$("#endDt").val( endDt );
		
		// AUIGrid 생성 후 반환 ID
		createAUIGrid(columnLayout);
		
		// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
		selectPchaList();
		
		AUIGrid.bind(myGridID, "rowNumCellClick", function(event) {
			var item = AUIGrid.getItemByRowIndex(myGridID, event.rowIndex );
			//시퀀스 셋팅
			$("#puchSeq").val( item.puchSeq );
			
			if( item.puchCd ){//행에 데이터 있는경우
				$("#crudMode").val("U");
				//상세조회
				selectPchaDetail( item );
			}else{//컬럼데이터 없는 경우
				//input값 초기화
				$("#frmDetail input").each(function(idx,item){ item.value = "";});
				//$("#puchCd").empty();
				$("#useCd option:eq(0)").prop("selected", true);
				$("#mobNo1 option:eq(0)").prop("selected", true);
				$("#crudMode").val("C");
				//매입처코드 생성
				getNextPuchCd();
			}
		});

		//수정 / 저장 이벤트
		$("#saveBtn").click(function(){
			var popupParam = [];
			
			if( $("#puchSeq").val() == "" && $("#crudMode").val() == "U" ){
				//기본값이 등록되지 않았습니다.\n다시 확인해주세요.
				popupParam.data = {
					title : "매입처 관리",
					message : "<spring:message code='alert.stdPchaMng1'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}else if( $("input[name='puchCd']").val() == "" && ( $("#crudMode").val() == "C" || $("#crudMode").val() == "" ) ){
				//기본값이 등록되지 않았습니다.\n다시 확인해주세요.
				popupParam.data = {
					title : "매입처 관리",
					message : "<spring:message code='alert.stdPchaMng1'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			//수정 / 저장
			savePchaDetail();
		});

		//삭제 이벤트
		$("#deleteBtn").click(function(){
			var popupParam = [];
			
			if( !$("#puchSeq").val() ){
				//기본값이 등록되지 않았습니다.\n다시 확인해주세요.
				popupParam.data = {
					title : "매입처 관리",
					message : "<spring:message code='alert.stdPchaMng1'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
			popupParam.data = {
					title : "매입처 관리",
					message : "<spring:message code='alert.stdPchaMng2'/>",
					showBtn1 : 'Y',
					btn1Func : removeStdPchaMng,
					showBtn2 : 'Y'
			}
			layerAlert(popupParam);
			return;
		});

		$("#searchBtn").click(function(){
			//리스트 조회
			selectPchaList();
			//상세 폼 초기화
			callback();
			//행추가버튼 플레그 초기화
			addFlag = true;
		});
		
		$("#addRowBtn").click(function(){
			if( addFlag ){
				var obj = {};
				//그리드 행추가
				AUIGrid.addRow(myGridID, obj, "frist");
				//상세 폼 초기화
				callback();
				//행추가버튼 플레그 변경
				addFlag = false;
				//매입처 코드 조회
				getNextPuchCd();
				$("#crudMode").val("C");
			}
		});
		
		$(document).on("change", "#sel_email", function() {
			if( $(this).val() ){
				$("#puchEml2").val( $(this).val() );
			}else{
				$("#puchEml2").val( "" );
			}
		});
		
	});
	
	function selectPchaDetail( obj ){
		$.ajax({
			url : "/std/selectPchaDetail.do", 
			type : "POST", 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(obj),
			success : function(data) {
				//이메일셋팅
				data.detail.puchEml1 = data.detail.puchEml.split("@")[0];
				data.detail.puchEml2 = data.detail.puchEml.split("@")[1];
				//사업자번호 셋팅
				data.detail.bizNo1 = data.detail.bizNo.split("-")[0];
				data.detail.bizNo2 = data.detail.bizNo.split("-")[1];
				data.detail.bizNo3 = data.detail.bizNo.split("-")[2];
				
				$("#detailArea").html($("#detailTmpl").tmpl( data.detail ));
				
				$('#useCd  option[value=' + data.detail.useCd + ']').attr('selected', 'selected');
				$('#mobNo1  option[value=' + data.detail.mobNo1 + ']').attr('selected', 'selected');
				
				//데이트피커 로드
				datepickerLoad();
			},
			error : function(xhr, status) {
				alert("상세 조회중 오류가 발생하였습니다.");
			}
		}); 
	}
	
	function savePchaDetail(){
		if( validation() ){
			//사업자번호
			var bizNo = $("#bizNo1").val().trim() + $("#bizNo2").val().trim() + $("#bizNo3").val().trim();
			$("#bizNo").val( bizNo );
			//업체 전화번호
			var telNo = $("#telNo1").val().trim() + $("#telNo2").val().trim() + $("#telNo3").val().trim();
			$("#telNo").val( telNo.trim() );
			//휴대전화번호
			var mobNo = $("#mobNo1").val().trim() + $("#mobNo2").val().trim() + $("#mobNo3").val().trim();
			$("#mobNo").val( mobNo.trim() );
			//팩스번호
			var faxNo = $("#faxNo1").val().trim() + $("#faxNo2").val().trim() + $("#faxNo3").val().trim();
			$("#faxNo").val( faxNo.trim() );
			//이메일주소
			var puchEml = $("#puchEml1").val().trim() + "@" + $("#puchEml2").val().trim();
			$("#puchEml").val( puchEml.trim() );
			
			var formSerializeArray = $('#frmDetail').serializeArray();
			var object = {};
			for (var i = 0; i < formSerializeArray.length; i++){
				object[formSerializeArray[i]['name']] = formSerializeArray[i]['value'];
			}
			
			console.log( "object=" , object );
			
			$.ajax({
				url : "/std/savePchaDetail.do", 
				type : "POST", 
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(object),
				success : function(data) {
					//리스트 출력
					selectPchaList();
					
					//후처리 함수
					callback();
					
					//행추가버튼 플레그 변경
					addFlag = true;
					
					var popupParam = [];
					popupParam.data = {
							title : "매입처 관리",
							message : data.msg,
							showBtn2 : 'N'
						}
						layerAlert(popupParam);
						return;
				}, // success 
				error : function(xhr, status) {
					console.log("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	// AUIGrid 를 생성합니다.
	function createAUIGrid(columnLayout) {
		// 그리드 속성 설정
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
		
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	}

	var columnLayout = [{
			dataField : "puchCd",
			headerText : "매입처<br>코드",
			width : "15%",
			style : "auiLink"
		},{
			dataField : "puchNm",
			headerText : "매입처명",
			width : "15%",
			style : "auiLeft"
		},{
			dataField : "compNm",
			headerText : "상호",
			width : "13%",
			style : "auiLeft"
		},{
			dataField : "bizNo",
			headerText : "사업자번호",
		},{
			dataField : "bizCon",
			headerText : "업태",
			width : "9%",
			style : "auiLeft",
		},{
			dataField : "bizIndu",
			headerText : "종목",
			width : "11%",
			style : "auiLeft",
		},{
			dataField : "useCd",
			headerText : "상태",
			width : "15%"
		}
	];

	//매입처 조회
	function selectPchaList(){
		$.ajax({
			url : "/std/selectPchaList.do", 
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$(".pColor01").html(data.list.length);
			}, // success
			error : function(xhr, status) {
				console.log("매입처 조회중 오류가 발생하였습니다.");
			}
		});
	}

	function validation(){
		
		var result = true;
		
		var popupParam = [];
		
		if( $("#telNo1").val() != "" || $("#telNo2").val() != "" || $("#telNo3").val() != "" ){
			if( !( $("#telNo1").val() != "" && $("#telNo2").val() != "" && $("#telNo3").val() != "" ) ){
				popupParam.data = {
						title : "매입처 관리",
						message : "업체전화번호를 모두 입력해주세요.",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				
				result = false;
			}
		}
		if( $("#mobNo2").val() != "" || $("#mobNo3").val() != "" ){
			if( !( $("#mobNo2").val() != "" && $("#mobNo3").val() != "" ) ){
				popupParam.data = {
						title : "매입처 관리",
						message : "업체전화번호를 모두 입력해주세요.",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				
				result = false;
			}
		}
		if( $("#faxNo1").val() != "" || $("#faxNo2").val() != "" || $("#faxNo3").val() != "" ){
			if( !( $("#faxNo1").val() != "" && $("#faxNo2").val() != "" && $("#faxNo3").val() != "" ) ){
				popupParam.data = {
						title : "매입처 관리",
						message : "팩스번호를 모두 입력해주세요.",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				
				result = false;
			}
		}
		if( $("#puchEml1").val() != "" || $("#puchEml2").val() != "" ){
			if( !( $("#puchEml1").val() != "" && $("#puchEml2").val() != "" ) ){
				popupParam.data = {
						title : "매입처 관리",
						message : "이메일을 모두 입력해주세요.",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				
				result = false;
			}
		}
		if( $("#bizNo1").val() != "" || $("#bizNo2").val() != "" || $("#bizNo3").val() != "" ){
			if( !( $("#bizNo1").val() != "" && $("#bizNo2").val() != "" && $("#bizNo3").val() != "" ) ){
				popupParam.data = {
						title : "매입처 관리",
						message : "사업자번호를 모두 입력해주세요.",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				
				result = false;
			}
		}
		
		return result;
	}
	//수정 / 등록 /삭제후 후처리함수
	function callback(){
		//상세 input 초기화
		$("#frmDetail input").each(function(idx,item){item.value = "";});
		$("#puchCd").empty();
		$("#useCd option:eq(0)").prop("selected", true);
		$("#mobNo1 option:eq(0)").prop("selected", true);
		$("#sel_email option:eq(0)").prop("selected", true);
	}
	//매입처 코드생성 함수
	function getNextPuchCd(){
		$.ajax({
			url : "/std/getNextPuchCd.do", 
			type : 'POST',
			success : function(data) {
				//매입처 코드 셋팅
				$("#puchCd").text( data.nextPuchCd );
				$("input[name='puchCd']").val( data.nextPuchCd );
			}, // success
			error : function(xhr, status) {
				console.log("매입처 코드 조회중 오류가 발생하였습니다.");
			}
		});
	}
	//매입처 삭제
	function removeStdPchaMng(){
		$("#crudMode").val("D");
		var item = {"crudMode" : $("#crudMode").val() , "puchSeq" : $("#puchSeq").val() };
		
		$.ajax({
			url : "/std/removePcha.do", 
			type : "POST", 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(item),
			success : function(data) {
				//리스트출력
				selectPchaList();
				
				//상세 폼 초기화
				callback();
				
				//행추가버튼 플레그 초기화
				addFlag = true;
				
				var popupParam = [];
				popupParam.data = {
						title : "매입처 관리",
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

	function datepickerLoad(){
		$("#datepicker01").daterangepicker({
			"singleDatePicker": true,
			"showDropdowns": true,
			"changeMonth": true,
			"showMonthAfterYear": true,
			"locale": {
				"format": "YYYY-MM-DD",
				"separator": " - ",
				"applyLabel": "Apply",
				"cancelLabel": "Cancel",
				"fromLabel": "From",
				"toLabel": "To",
				"customRangeLabel": "Custom",
				"weekLabel": "W",
				"applyLabel": "확인",
				"cancelLabel": "취소", 
				"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
				"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				"firstDay": 1
			},
				"showCustomRangeLabel": false,
			}, function(start, end, label) {
				$("#statDt").val( start.format('YYYYMMDD') );
		});
		
		$("#datepicker02").daterangepicker({
			"singleDatePicker": true,
			"showDropdowns": true,
			"changeMonth": true,
			"showMonthAfterYear": true,
			"locale": {
				"format": "YYYY-MM-DD",
				"separator": " - ",
				"applyLabel": "Apply",
				"cancelLabel": "Cancel",
				"fromLabel": "From",
				"toLabel": "To",
				"customRangeLabel": "Custom",
				"weekLabel": "W",
				"applyLabel": "확인",
				"cancelLabel": "취소", 
				"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
				"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				"firstDay": 1
			},
				"showCustomRangeLabel": false,
			}, function(start, end, label) {
				$("#endDt").val( start.format('YYYYMMDD') );
		});
	}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	<!-- 조회 -->
	<form id="frm">
	<div class="inquiryBox dtShort">
		<dl>
			<dt>매입처</dt>
			<dd>
				<div class="formWrap">
					<input type="text" class="inp" value="" name="puchNm">
					<button type="button" name="" class="comBtn" id="searchBtn">조회</button>
				</div>
			</dd>
		</dl>
	</div>
	</form>
	<!-- 조회 -->
	
	<!-- grid -->
	<div class="girdBoxGroup">
		<div class="girdBox w55per">
			<div class="titleArea">
				<h3 class="tit01">매입처 목록</h3>
			</div>

			<div class="titleArea right">
				<p class="numState">
					<em>총 <span class="pColor01 fb">2</span></em> 건 이 조회되었습니다.
				</p>
			</div>
			<div class="btnGroup">
					<button type="button" name="" class="inquBtn small" id="addRowBtn">행추가</button>
				</div>
			<div id="grid_wrap"></div>
		</div>

		<div class="conBox w43per">
			<div class="titleArea right">
				<h3 class="tit01">세부 정보</h3>

				<div class="btnGroup">
					<button type="button" name="" class="inquBtn small" id="saveBtn">저장</button>
					<button type="button" name="" class="cancelBtn small" id="deleteBtn">삭제</button>
				</div>
			</div>

			<!-- 세부정보 -->
			<form id="frmDetail">
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
								<th scope="row">
									매입처코드
								</th>
								<td colspan="3">
									<p id="puchCd"></p>
									<input type="hidden" name="puchCd" value="">
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="inp_puchNm" class="required" title="필수입력">매입처명</label>
								</th>
								<td colspan="3">
									<input type="text" id="inp_puchNm" class="inp" value="" name="puchNm">
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="inp_compNm" class="required" title="필수입력">상호</label>
								</th>
								<td colspan="3">
									<input type="text" id="inp_compNm" class="inp" value="" name="compNm">
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="bizNo1" class="required" title="필수입력">사업자번호</label>
								</th>

								<td colspan="3">
									<div class="formWrap">
										<input type="text" id="bizNo1" class="inp w130 mr10" value="" name="bizNo1" minlength="3" maxlength="3">
										<input type="text" id="bizNo2" class="inp w130 mr10" value="" name="bizNo2" minlength="2" maxlength="2">
										<input type="text" id="bizNo3" class="inp w130" value="" name="bizNo3" minlength="5" maxlength="5">
										<input type="hidden" name="bizNo" value="" id="bizNo">
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="inp_agenPrst" title="필수입력" class="required">대표자명</label> 
								</th>
								<td>
									<input type="text" id="inp_agenPrst" class="inp" value="" name="prstNm">
								</td>
								<th scope="row">
									<label for="sel_stus" class="required">상태</label>
								</th>
								<td class="ar">
									${useCdList}
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="inp_bizCon" title="필수입력" class="required">업태</label> 
								</th>
								<td>
									<input type="text" id="inp_bizCon" class="inp" value="" name="bizCon">
								</td>
								<th scope="row">
									<label for="inp_indt" class="required">종목</label>
								</th>
								<td class="ar">
									<input type="text" id="inp_indt" class="inp" value="" name="bizIndu">
								</td>
							</tr>
							<tr colspan="3">
								<th scope="row" rowspan="3">
									<label for="addr1" class="required" title="필수입력">주소</label>
								</th>
								<td class="borderBN">
									<div class="postWrap">
										<input type="text" id="zipCd" class="inp" value="" name="zipCd" readonly>
										<button type="button" class="postBtn" title="우편번호 찾기" onclick="fnSetPostcode('#zipCd', '#addr1');"></button>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3" class="borderBN">
									<input type="text" id="addr1" class="inp bg_gray" value="" name="addr1" placeholder="우편번호를 입력해 주세요.">
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<input type="text" id="addr2" class="inp" value="" name="addr2" placeholder="상세주소를 입력해 주세요.">
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="telNo1" class="required" title="필수입력">업체전화번호</label>
								</th>
								<td colspan="3">
									<div class="formWrap">
										<input type="text" id="telNo1" class="inp w130 mr10" value="" name="telNo1" minlength="2" maxlength="3">
										<input type="text" id="telNo2" class="inp w130 mr10" value="" name="telNo2" minlength="3" maxlength="4">
										<input type="text" id="telNo3" class="inp w130" value="" name="telNo3" minlength="4" maxlength="4">
										<input type="hidden" value="" name="telNo" id="telNo">
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="mobNo1" class="required" title="필수입력">휴대전화번호</label>
								</th>
								<td colspan="3">
									<div class="formWrap">
										<select name="mobNo1" class="sel mr10" id="mobNo1">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="019">019</option>
											<option value="016">016</option>
										</select>
										<input type="text" id="mobNo2" class="inp w130 mr10" value="" name="mobNo2" minlength="3" maxlength="4">
										<input type="text" id="mobNo3" class="inp w130" value="" name="mobNo3" minlength="4" maxlength="4">
										<input type="hidden" name="mobNo" id="mobNo">
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="faxNo1">팩스번호</label>
								</th>
								<td colspan="3">
									<div class="formWrap">
										<input type="text" id="faxNo1" class="inp w130 mr10" value="" name="faxNo1" minlength="2" maxlength="3">
										<input type="text" id="faxNo2" class="inp w130 mr10" value="" name="faxNo2" minlength="3" maxlength="4">
										<input type="text" id="faxNo3" class="inp w130" value="" name="faxNo3" minlength="4" maxlength="4">
										<input type="hidden" name="faxNo" id="faxNo">
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="puchEml1">이메일 주소</label>
								</th>
								<td colspan="3">
									<div class="formWrap email">
										<input type="text" id="puchEml1" class="inp w250" name="puchEml1"> <span class="divi"> @ </span>
										<input type="text" id="puchEml2" class="inp w290" name="puchEml2">
										<input type="hidden" name="puchEml" id="puchEml">
										<select name="" class="sel w160" id="sel_email">
											<option value="">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="google.com">google.com</option>
											<option value="hanmail.net">hanmail.net</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="datepicker01" class="required" title="필수입력">거래시작일자</label>
								</th>
								<td>
									<div class="formWrap">
										<div class="dateWrap wAuto">
											<input type="text" class="inp" id="datepicker01">
											<input type="hidden" name="statDt" id="statDt">
											<button type="button" class="datepickerBtn" title="날짜입력"></button>
										</div>
									</div>
								</td>
								<th scope="row">
									<label for="datepicker02">거래종료일자</label>
								</th>
								<td>
									<div class="formWrap">
										<div class="dateWrap">
											<input type="text" class="inp" id="datepicker02">
											<input type="hidden" name="endDt" id="endDt">
											<button type="button" class="datepickerBtn" title="날짜입력"></button>
										</div>
									</div>
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
				<th scope="row">
					매입처코드
				</th>
				<td colspan="3">
					<p id="puchCd">\${puchCd}</p>
					<input type="hidden" name="puchCd" value="\${puchCd}">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="puchNm" class="required" title="필수입력">매입처명</label>
				</th>
				<td colspan="3">
					<input type="text" id="puchNm" class="inp" value="\${puchNm}" name="puchNm">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="compNm" class="required" title="필수입력">상호</label>
				</th>
				<td colspan="3">
					<input type="text" id="compNm" class="inp" value="\${compNm}" name="compNm">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="bizNo1" class="required" title="필수입력">사업자번호</label>
				</th>

				<td colspan="3">
					<div class="formWrap">
						<input type="text" id="bizNo1" class="inp w130 mr10" value="\${bizNo1}" name="bizNo1" minlength="3" maxlength="3">
						<input type="text" id="bizNo2" class="inp w130 mr10" value="\${bizNo2}" name="bizNo2" minlength="2" maxlength="2">
						<input type="text" id="bizNo3" class="inp w130" value="\${bizNo3}" name="bizNo3" minlength="5" maxlength="5">
						<input type="hidden" name="bizNo" value="" id="bizNo">
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="prstNm" title="필수입력" class="required">대표자명</label> 
				</th>
				<td>
					<input type="text" id="prstNm" class="inp" value="\${prstNm}" name="prstNm">
				</td>
				<th scope="row">
					<label for="sel_stus" class="required">상태</label>
				</th>
				<td class="ar">
					${useCdList}
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="bizCon" title="필수입력" class="required">업태</label> 
				</th>
				<td>
					<input type="text" id="bizCon" class="inp" value="\${bizCon}" name="bizCon">
				</td>
				<th scope="row">
					<label for="bizIndu" class="required">종목</label>
				</th>
				<td class="ar">
					<input type="text" id="bizIndu" class="inp" value="\${bizIndu}" name="bizIndu">
				</td>
			</tr>
			<tr colspan="3">
				<th scope="row" rowspan="3">
					<label for="addr1" class="required" title="필수입력">주소</label>
				</th>
				<td class="borderBN">
					<div class="postWrap">
						<input type="text" id="zipCd" class="inp" value="\${zipCd}" name="zipCd" readonly>
						<button type="button" class="postBtn" title="우편번호 찾기" onclick="fnSetPostcode('#zipCd', '#addr1');"></button>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="borderBN">
					<input type="text" id="addr1" class="inp bg_gray" value="\${addr1}" name="addr1" placeholder="우편번호를 입력해 주세요.">
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<input type="text" id="addr2" class="inp" value="\${addr2}" name="addr2" placeholder="상세주소를 입력해 주세요.">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="telNo1" class="required" title="필수입력">업체전화번호</label>
				</th>
				<td colspan="3">
					<div class="formWrap">
						<input type="text" id="telNo1" class="inp w130 mr10" value="\${telNo1}" name="telNo1" minlength="2" maxlength="3">
						<input type="text" id="telNo2" class="inp w130 mr10" value="\${telNo2}" name="telNo2" minlength="3" maxlength="4">
						<input type="text" id="telNo3" class="inp w130" value="\${telNo3}" name="telNo3" minlength="4" maxlength="4">
						<input type="hidden" value="" name="telNo" id="telNo">
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="mobNo2" class="required" title="필수입력">휴대전화번호</label>
				</th>
				<td colspan="3">
					<div class="formWrap">
						<select name="mobNo1" class="sel mr10" id="mobNo1">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="019">019</option>
						</select>
						<input type="text" id="mobNo2" class="inp w130 mr10" value="\${mobNo2}" name="mobNo2" minlength="3" maxlength="4">
						<input type="text" id="mobNo3" class="inp w130" value="\${mobNo3}" name="mobNo3" minlength="4" maxlength="4">
						<input type="hidden" name="mobNo" id="mobNo" value="">
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="faxNo1">팩스번호</label>
				</th>
				<td colspan="3">
					<div class="formWrap">
						<input type="text" id="faxNo1" class="inp w130 mr10" value="\${faxNo1}" name="faxNo1" minlength="2" maxlength="3">
						<input type="text" id="faxNo2" class="inp w130 mr10" value="\${faxNo2}" name="faxNo2" minlength="3" maxlength="4">
						<input type="text" id="faxNo3" class="inp w130" value="\${faxNo3}" name="faxNo3" minlength="4" maxlength="4">
						<input type="hidden" name="faxNo" id="faxNo" value="">
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="puchEml1">이메일 주소</label>
				</th>
				<td colspan="3">
					<div class="formWrap email">
						<input type="text" id="puchEml1" class="inp w250" name="puchEml1" value="\${puchEml1}"> <span class="divi"> @ </span>
						<input type="text" id="puchEml2" class="inp w290" name="puchEml2" value="\${puchEml2}">
						<input type="hidden" name="puchEml" id="puchEml">
						<select name="" class="sel w160" id="sel_email">
							<option value="">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="hanmail.net">hanmail.net</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="datepicker01" class="required" title="필수입력">거래시작일자</label>
				</th>
				<td>
					<div class="formWrap">
						<div class="dateWrap wAuto">
							<input type="text" class="inp" id="datepicker01">
							<input type="hidden" name="statDt" id="statDt" value="\${statDt}">
							<button type="button" class="datepickerBtn" title="날짜입력"></button>
						</div>
					</div>
				</td>
				<th scope="row">
					<label for="datepicker02">거래종료일자</label>
				</th>
				<td>
					<div class="formWrap">
						<div class="dateWrap">
							<input type="text" class="inp" id="datepicker02">
							<input type="hidden" name="endDt" id="endDt" value="\${endDt}">
							<button type="button" class="datepickerBtn" title="날짜입력"></button>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</script>