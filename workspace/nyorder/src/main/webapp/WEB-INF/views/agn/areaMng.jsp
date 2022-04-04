<!-- 
	@File Name: areaMng.jsp
	@File 설명 : 지역 관리
	@UI ID : UI-PCLI-1401T1
	@작성일 : 2022. 3. 17.
	@작성자 : GAIN -> YESOL
 -->
 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<code:makeSelect commGrpCd="BANK_CD" var="bankCdList" name="bankCd" classNm="sel" all="true" allNm="선택" />

<script type="text/javascript">
var myGridID; //지역 목록
var myGridID2; // 애음자 지역변경 탭
var addFlag = false;
var preRow = "";
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

		// AUIGrid 생성 후 반환 ID
		createAUIGrid();

		//순서변경 버튼 클릭
		$("#changeOrdrBtn").click(function(){
			//selectAgenAreaListByOrdr();
			$.ajaxDialog({
				id: "areaOrdrChgPop",
				ajax: {
					url: "/agn/areaOrdrChgPop.do",
				},
				dialog: {
					width:800,
					height:620,
					modal: true,
					draggable: false
				},
				success: function(data) {
					selectAgenAreaList();
				}
			});
		});

		$("#cstAreaChgHisPopBtn").click(function(){
			$.ajaxDialog({
				id: "cstAreaChgHisPop",
				ajax: {
					url: "/agn/cstAreaChgHisPop.do",
				},
				dialog: {
					width:1500,
					height:720,
					modal: true,
					draggable: false
				},
				success: function(data) {
					selectAgenAreaList();
				}
			});
		});
			
		
		//조회 버튼 클릭
		$("#searchBtn").click(function() {
			//리스트 조회
			selectAgenAreaList();
		});
		//저장 버튼 클릭
		$("#saveBtn").click(function() {
			if( $("input[name='agenAreaCd']").val() == ""){
				var popupParam = [];
				popupParam.data = {
					title : "지역관리",
					message : "<spring:message code='alert.areaMng03' />",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			//수정 / 저장
			saveAgenAreaMng();
		});

		//행추가 버튼 클릭
		$("#addRowBtn").click(function(){
			if(! addFlag ){
				//행추가
				var obj = { areaSeq : "", "agenAreaCd" : "" , "areaNm" : "" , "emplNm" : "" , "dlvOrdr" : "" , "telNm" : "" };
				//그리드 행추가
				AUIGrid.addRow(myGridID, obj, "first");
				
				//행추가버튼 플레그 변경
				addFlag = true;
				preRow = "";
				//매입처 코드 조회
				getNextAgenAreaCd();
				$("#detailArea").html($("#detailTmpl").tmpl( {crudMode : "C", dlvStpgYn: "N", emplNm:"", areaNm: "", mobNo2:"", mobNo3:"", zipCd:"", addr1:"", addr2:"", areaSeq:"",areaRm:"" }));
			}else{
				var popupParam = [];
				popupParam.data = {
					title : "지역관리",
					message : "<spring:message code='alert.areaMng02' />",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
		});
		
		//초기화 버튼 클릭
		$("#resetBtn").click(function(){
			$("#detailArea").html($("#detailTmpl").tmpl( {crudMode : "C", dlvStpgYn: "N", emplNm:"", areaNm: "", mobNo2:"", mobNo3:"", zipCd:"", addr1:"", addr2:"", areaSeq:"",areaRm:"" }));
		});

		// 순서 입력 이벤트
		$("#areaOrdr").change(function(){
			this.value	=	parseFloat(this.value).toFixed(1);
		})
		
		//그리드 클릭 이벤트
		AUIGrid.bind(myGridID, "cellClick", function(event) {
			if(	addFlag && $("#crudMode").val() == "C" && preRow != event.item.areaSeq ){
				var popupParam = [];
				popupParam.data = {
					message : "<spring:message code='alert.areaMng04'/>",
					btn1Func : function(){
						$('[data-popup="modalAlert"]').fadeOut(100);
						$('[data-popup="modalAlert"]').parent().find(".modal_bg").fadeOut(100);
						selectAgenAreaMngDetail(event.item); 
						preRow = event.item.areaSeq;
					},
					showBtn2 : 'Y',
					btn2Func : clickReset
				}
				layerAlert(popupParam);
			}else if( preRow != event.item.areaSeq ){
				//시퀀스 셋팅
				$("#agenSeq").val(event.item.agenSeq);
				$("#areaSeq").val(event.item.areaSeq);
				 if (event.item.areaSeq) {//행에 데이터 있는경우
					//상세조회
					selectAgenAreaMngDetail(event.item); 
					preRow = event.item.areaSeq;
				} else {//컬럼데이터 없는 경우
					//매입처코드 생성
					getNextAgenAreaCd();
					$("#detailArea").html($("#detailTmpl").tmpl( {crudMode : "C", dlvStpgYn: "N", emplNm:"", areaNm: "", mobNo2:"", mobNo3:"", zipCd:"", addr1:"", addr2:"", areaSeq:"",areaRm:"" }));
					preRow = ""; 
				}
			}
			
		});

		<!--애음자 지역변경 탭 -->
		//조회 버튼 클릭
		$("#searchCstAreaChgBtn").click(function(){
			//애음자 지역변경 - 변경 전 리스트 조회
			if($("#beforeAreaSeq").val() == ''){
				var popupParam = [];
				popupParam.data = {
					title : "지역관리",
					message : "<spring:message code='alert.areaMng06' />",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			selectCstAreaChgList();
		});

		$("#detailArea").html($("#detailTmpl").tmpl( {}));

		//저장 버튼 클릭
		$("#saveCstAreaChgBtn").click(function(){
			var checkedItems = AUIGrid.getCheckedRowItems(myGridID2);
			var chgDt = $("#chgDt").val().replace('-','').replace('-','');
			if(checkedItems.length == 0){
				var popupParam = [];
				popupParam.data = {
					title : "지역관리",
					message : "<spring:message code='alert.areaMng07' />",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}		
			if( $("#chgDt").val() <= fnGetToDay() ){
				var popupParam = [];
				popupParam.data = {
					title : "지역관리",
					message : "<spring:message code='alert.areaMng09' />",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			if($("#afterAreaSeq").val() == ""){
				var popupParam = [];
				popupParam.data = {
					title : "지역관리",
					message : "<spring:message code='alert.areaMng08' />",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			//업데이트 처리
			updateCstAgenArea();	
		 });
			
		$("#afterAreaSeq").change(function(e){
			var before = $("#beforeAreaSeq").val();
			if(before == this.value){
				this.value = "";
				return false;
			}
		});

		// 달력 내일 날짜 셋팅
		var dt = new Date();
		dt.setDate(dt.getDate()+1)
		$('#chgDt').data('daterangepicker').setStartDate(fnConvertDate(dt));
		$('#chgDt').data('daterangepicker').setEndDate(fnConvertDate(dt));
		
		// 변경시 날짜 체크
		$("#chgDt").change(function(){
			if(this.value <= fnGetToDay()){
				var popupParam = [];
				popupParam.data = {
					title : "지역관리",
					message : "<spring:message code='alert.areaMng09' />",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				var dt = new Date();
				dt.setDate(dt.getDate()+1)
				this.value = fnConvertDate(dt);
				$('#chgDt').data('daterangepicker').setStartDate(fnConvertDate(dt));
				$('#chgDt').data('daterangepicker').setEndDate(fnConvertDate(dt));
				return;
			}
		})
	});

	function clickReset(){
		AUIGrid.setSelectionBlock(myGridID,0, 0, 0, 2);
		$('[data-popup="modalAlert"]').fadeOut(100);
		$('[data-popup="modalAlert"]').parent().find(".modal_bg").fadeOut(100);
	}
	
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			showStateColumn : true,
			wrapSelectionMove : true,
			editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
			showStateColumn : false,  // 앞에 보이는 아이콘 사용여부
			editable : false,
			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase : true,
			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "singleRow",
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

		var gridPros2 = {
			headerHeight : 29,
			rowHeight : 29,
			selectionMode : "singleRow",
			showStateColumn : false,
			autoGridHeight : true,
			showRowCheckColumn : true, // 체크박스 사용
			showEditedCellMarker : false,
		}

		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
		myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
		
	}

	var columnLayout = [{
		dataField : "agenAreaCd",
		headerText : "지역코드",
		width : "18%",
		editable : true
	},{
		dataField : "areaNm",
		headerText : "지역명",
		style : "auiLeft" 
	},{
		dataField : "emplNm",
		headerText : "판매원명"
	}, {
		dataField : "areaOrdr",
		headerText : "순서",
		width : "5%"
	}, {
		dataField : "mobNo",
		headerText : "휴대폰번호",
		width : "20%"
	}];

	var columnLayout2 = [{
		dataField : "cstInfo",
		headerText : "애음자 정보",
			children : [{
				dataField : "cstAgenCd",
				headerText : "애음자코드",					
				width : "8%",
			}, {
				dataField : "cstNm",
				headerText : "성명",
				width : "6%",
			}, {
				dataField : "dlvAddr",
				headerText : "배달주소",
				style: "auiLeft"
			}, {
				dataField : "mobNo",
				headerText : "휴대폰번호",
				width : "8%",
			}]
		},{
			dataField : "chBefore",
			headerText : "변경 전",
			children : [{
				dataField : "beforeAreaCd",
				headerText : "지역코드",					
				width : "8%",
			}, {
				dataField : "beforeAreaNm",
				headerText : "지역명",
				width : "6%",
			}, {
				dataField : "beforeEmplCd",
				headerText : "직원코드",
				width : "8%",
			}, {
				dataField : "beforeEmplNm",
				headerText : "판매원명",
				width : "8%",
			}]
		},{
			dataField : "chAfter",
			headerText : "변경 후",
			children : [{
				dataField : "afterAreaCd",
				headerText : "지역코드",					
				width : "8%",
			}, {
				dataField : "afterAreaNm",
				headerText : "지역명",
				width : "6%",
			}, {
				dataField : "afterEmplCd",
				headerText : "직원코드",
				width : "8%",
			}, {
				dataField : "afterEmplNm",
				headerText : "판매원명",
				width : "8%",
			}]	
		}
	];

	//지역 목록 조회
	function selectAgenAreaList() {
		$.ajax({
			url : "/agn/selectAgenAreaList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data);
				$("#totCnt").html(data.length);
				addFlag = false;
			}, // success 
			error : function(xhr, status) {
				alert("지역 목록 조회 중 오류가 발생하였습니다");
			}
		});
	}

	function openEmplSearchPop(){
		$.ajaxDialog({
			id: "emplSearchPop",
			ajax: {
				url: "/agn/emplSearchPop.do",
			},
			dialog: {
				width:800,
				height:620,
				modal: true,
				draggable: false
			},
			success: function(data) {
				$("#emplNm").val( data.emplNm );
				$("#saleEmplSeq").val( data.emplSeq );
				if(CommUtil.isNotEmpty(data.mobNo)){
					var mobNo = data.mobNo.split("-");
					$("#mobNo1").val( mobNo[0]);
					$("#mobNo2").val( mobNo[1]);
					$("#mobNo3").val( mobNo[2]);
				}
				$("#zipCd").val( data.zipCd );
				$("#addr1").val( data.addr1 );
				$("#addr2").val( data.addr2 );
				selectEmplAcctList(data);
			}
		});
	}
	
	//상세보기 함수
	function selectAgenAreaMngDetail( obj ){
		$.ajax({
			url : "/agn/selectAreaMngDetail.do", 
			type : "POST", 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(obj),
			success : function(data) {
				$("#detailArea").html($("#detailTmpl").tmpl( data));
				$("#crudMode").val("U");
				$("#dlvStpgYn").val(data.dlvStpgYn);

				if(CommUtil.isNotEmpty(data.mobNo)){
					var mobNo = data.mobNo.trim().split("-");
					$("#mobNo1").val( mobNo[0]);
					$("#mobNo2").val( mobNo[1]);
					$("#mobNo3").val( mobNo[2]);
				}
				$("#areaOrdr").change(function(){
					this.value	=	parseFloat(this.value).toFixed(1);
				})

				selectEmplAcctList(data);
			},
			error : function(xhr, status) {
				alert("상세 조회중 오류가 발생하였습니다.");
			}
		}); 
	}
	
	//세부 정보 수정/저장 함수
	function saveAgenAreaMng() {
		if(fnIsEmpty($("#areaNm").val()) || fnIsEmpty($("#areaOrdr").val()) || fnIsEmpty($("#emplNm").val())){
			var popupParam = [];
			popupParam.data = {
				title : "지역관리",
				message : "<spring:message code='alert.areaMng03' />",
				showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}
		
		$.ajax({
			url : "/agn/saveAreaMng.do", 
			type : 'POST', 
			data : $("#frmDetail").serialize(),
			success : function(data) {
				if (CommUtil.isNotEmpty(data.res) && data.res){
					var popupParam = [];
					popupParam.data = {
						title : "지역 관리",
						message : "<spring:message code='alert.areaMng10' />",
						showBtn2 : 'N'
	 				}
	 				layerAlert(popupParam);
					//리스트 출력
					selectAgenAreaList();
				}else{
					
					alert("저장 실패 하였습니다.\n다시 시도해 주세요.");
				}
			}, // success 
			error : function(xhr, status) {
				if ( Common.IsJsonString(xhr.responseText) )
				{
					var message = JSON.parse(xhr.responseText).message;
					popupParam.data = {
						title : "지역 관리",
						message : message,
						showBtn2 : 'N'
	 				}
	 				layerAlert(popupParam);
	 				return
				}
				else{
					alert("처리중 오류가 발생 하였습니다.");
				}
			}
		});
	}

	//지역코드 생성 함수
	function getNextAgenAreaCd() {
		$.ajax({
			url : "/agn/getNextAgenAreaCd.do",
			type : 'POST',
			success : function(data) {
				//매입처 코드 셋팅
				$("#agenAreaCd").text(data.nextAgenAreaCd);
				$("input[name='agenAreaCd']").val(data.nextAgenAreaCd);
			}, // success
			error : function(xhr, status) {
				alert("지역 코드 조회중 오류가 발생하였습니다.");
			}
		});
	}

	//판매원명 - 계좌 리스트 조회
	function selectEmplAcctList( obj ) {
		$.ajax({
			url : "/agn/selectEmplAcctList.do",
			type : 'POST',
			data : $("#frmDetail").serialize(),
			success : function(data) {
				$("#acctRow").after( $("#acctTmpl").tmpl({"acctList": data}) );
				for(i=0;i<data.length;i++){
					 $("select[name=bankCd]")[i].value = data[i].bankCd; 
					 $("select[name=bankCd]").attr("disabled","disabled");
				}
			}, // success 
			error : function(xhr, status) {
				alert("판매원 계좌 조회 중 오류가 발생하였습니다");
			}
		});
	}

	<!--애음자 지역변경 탭-->
	//애음자 지역변경 - 변경 전 리스트 조회
	function selectCstAreaChgList() {
		$.ajax({
			url : "/agn/selectCstAreaChgList.do",
			type : 'POST',
			data : $("#frm2").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID2, data);
				$("#cstTotCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert("판매원명 조회 중 오류가 발생하였습니다");
			}
		});
	}
	
	//애음자 지역변경 - 변경 전/후 지역 옵션 리스트 조회
	function selectAgenAreaCdList(){
		$.ajax({
			url : "/agen/selectAgenAreaCdList.do",
			type : 'POST',
			data : JSON.stringify(),
			success : function(data) {
				var selectBef = document.querySelector("#addrSelectBef");
				var selectAft = document.querySelector("#addrSelectAft");
				for(i = 0; i < data.list.length; i++){
					$(selectBef).append($("<option></option>").attr("value",data.list[i].agenAreaCd).text(data.list[i].areaNm));
					$(selectAft).append($("<option></option>").attr("value",data.list[i].agenAreaCd).text(data.list[i].areaNm));
					}
			}, // success 
			error : function(xhr, status) {
				alert("지역 목록 조회 중 오류가 발생하였습니다");
			}
		});
	}


	//애음자 지역변경 저장
	function updateCstAgenArea() {
		var saveData = new Array();
		var rows = AUIGrid.getCheckedRowItems(myGridID2);
		
		for(i=0; i<rows.length;i++){
			var row = rows[i].item;
			row.afterAreaSeq	= $("#afterAreaSeq").val();
			row.chgDt			= $("#chgDt").val();
			saveData.push(row);
		}

		//저장 처리
		$.ajax({
			url : "/agn/saveCstAgenAreaChg.do",
			type : 'POST', 
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(saveData),
			success : function(data) {
				if (CommUtil.isNotEmpty(data.res) && data.res){
					var popupParam = [];
					popupParam.data = {
						title : "지역 관리",
						message : "<spring:message code='alert.areaMng10' />",
						showBtn2 : 'N'
	 				}
	 				layerAlert(popupParam);

					var rowIndexs = _.map(AUIGrid.getCheckedRowItems(myGridID2),"rowIndex");
					$.each(rowIndexs, function(i,v){
						AUIGrid.updateRow(
							myGridID2, 
							{ 
								afterAreaCd: data.rtnData.afterAreaCd,	
								afterAreaNm: data.rtnData.afterAreaNm,
								afterAreaSeq: data.rtnData.afterAreaSeq,
								afterEmplCd: data.rtnData.afterEmplCd,
								afterEmplNm: data.rtnData.afterEmplNm
							}, v);
					});
				}else{
					alert("저장 실패 하였습니다.\n다시 시도해 주세요.");
				}
			}, // success 
			error : function(xhr, status) {
				if ( Common.IsJsonString(xhr.responseText) )
				{
					var message = JSON.parse(xhr.responseText).message;
					popupParam.data = {
						title : "지역 관리",
						message : message,
						showBtn2 : 'N'
	 				}
	 				layerAlert(popupParam);
	 				return
				}
				else{
					alert("처리중 오류가 발생 하였습니다.");
				}
			}
		});
	}
	
	

	function resizeGrid(){
		AUIGrid.resize(myGridID, $("#content").width());
		AUIGrid.resize(myGridID2, $("#content").width());
	}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/> 
		<!-- tabs -->
		<div class="tabsWrap">
			<ul class="tabs">
				<li class="active" rel="tab01">지역관리</li>
				<li class="" rel="tab02">애음자 지역변경</li>
			</ul>

			<!-- tabContent 지역관리 -->
			<div id="tab01" class="tabContent">
				<!-- 조회 -->
				<form id="frm">
				<div class="inquiryBox type02">
					<dl>
						<dt>판매원</dt>
						<dd>
							<div class="formWrap">
								<input type="text" class="inp w160 mr7" value="" name="emplNm" placeholder="">
								<button type="button" name="" class="comBtn" id="searchBtn">조회</button>   
							</div>
						</dd>
					</dl>
					<div class="btnGroup right">
						<button type="button" name="" class="comBtn" id="resetBtn">초기화</button>
						<button type="button" name="" class="inquBtn" id="saveBtn">저장</button>
					</div>
				</div>
				</form>
				<!-- 조회 -->

				<!-- grid -->
				<div class="girdBoxGroup">
					<div class="girdBox w55per">
						<div class="titleArea">
							<h3 class="tit01">지역 목록</h3>
						</div>

						<div class="titleArea right">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="totCnt">0</span></em> 건 이 조회되었습니다.
							</p>

							<div class="btnGroup">
								<button type="button" class="comBtn small" value="추가하기" id="addRowBtn">행추가</button>
								<button type="button" name="" class="comBtn small" id="changeOrdrBtn">순서변경</button>
							</div>
						</div>
						<div id="grid_wrap"></div>
					</div>
					<div class="conBox w43per">
						<div class="titleArea right">
							<h3 class="tit01">세부 정보</h3>
						</div>

						<!-- 세부정보 -->
						<form id="frmDetail">
							<div id="detailArea">
								<div class="tblWrap"></div>
							</div>
						</form>
						<!-- 세부정보 -->
					</div>
				</div>
			<!-- grid -->
			</div>
			<!-- //tabContent 지역관리 -->

			<!-- tabContent 애음자 지역변경 -->
		
			<div id="tab02" class="tabContent">
				<!-- 조회 -->
				<form id="frm2">		
					<div class="inquiryBox type02">
						<dl>
							<dt>기존 지역</dt>
							<dd>
								<select name="beforeAreaSeq" id="beforeAreaSeq" class="sel w160">
									<option value="">선택</option>
										<c:forEach var="area" items="${areaList}" varStatus="status">
											<option value="<c:out value="${area.areaSeq}" />">
												<c:out value="${area.areaNm}" />
											</option>
										</c:forEach>
								</select>
							</dd>
							<dt>애음자</dt>
							<dd>
								<div class="formWrap">
									<input type="text" id="cstNm" class="inp w100 mr7"	value=""	name="srcCstNm"	placeholder="성명">
									<input type="text" id="addr" class="inp w160 mr7"	value=""	name="srcAddr"	placeholder="주소">
									<button type="button" name="" class="comBtn" id="searchCstAreaChgBtn">조회</button>   
								</div>
							</dd>
						</dl>
						<dl>
							<dt>변경 지역</dt>
							<dd>
								<select name="afterAreaSeq" id="afterAreaSeq" class="sel w160">
									<option value="">선택</option>
										<c:forEach var="area" items="${areaList}" varStatus="status">
											<option value="<c:out value="${area.areaSeq}" />">
												<c:out value="${area.areaNm}" />
											</option>
										</c:forEach>
								</select>
							</dd>
							<dt>적용일자</dt>
							<dd>
								<div class="dateWrap">
									<input type="text" name="date" value="" class="inp datepicker" id="chgDt" readonly>
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="chgDt"></button>
								</div> 
							</dd>
						</dl>
						<div class="btnGroup right verAlign">
							<button type="button" name="" class="comBtn" id="cstAreaChgHisPopBtn">이력보기</button>
							<button type="button" name="" class="inquBtn" id="saveCstAreaChgBtn">저장</button>
						</div>
					</div>
				</form>		
				<!-- 조회 -->

				<div class="titleArea">
					<p class="numState">
						<em>총 <span class="pColor01 fb" id="cstTotCnt"></span>0</em> 건 이 조회되었습니다.
					</p>
				</div>

				<!-- grid -->
				<div class="girdBox">
					<div id="grid_wrap2"></div>
				</div>
				<!-- grid -->
			</div>
		
			<!-- //tabContent 애음자 지역변경 -->
		</div>
</div>
<!-- content -->

<div class="modal_bg"></div>

<script id="detailTmpl" type="text/x-jquery-tmpl">
<!-- 세부정보 -->
<div class="tblWrap">
	<input type="hidden" name="crudMode" 	id="crudMode" 	value="\${crudMode}">
	<input type="hidden" name="areaSeq" 	id="areaSeq" 	value="\${areaSeq}"> 
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
				지역코드
			</th>
			<td>
				<p id="agenAreaCd">\${agenAreaCd}</p>
				<input type="hidden" name="agenAreaCd" value="\${agenAreaCd}">
			</td>
			<th scope="row">
				<label for="sel_deliStop">배달중지</label>
			</th>
			<td>
				<select name="dlvStpgYn" class="sel" id="dlvStpgYn">
					<option value="Y" <c:if test="${dlvStpgYn == 'Y'}">selected</c:if>>예</option>
					<option value="N" <c:if test="${dlvStpgYn == 'N'}">selected</c:if>>아니오</option>
				</select>
			</td>
		</tr>
		<tr>
			<th scope="row">
				<label for="areaNm" class="required" title="필수입력">지역명</label>
			</th>
			<td>
				<input type="text" id="areaNm" class="inp" value="\${areaNm}" name="areaNm">
			</td>
			
			<th scope="row">
				<label for="sel_deadline">마감여부</label>
			</th>
			<td>
				<select name="clsYn" class="sel" id="clsYn">
					<option value="Y" <c:if test="\${clsYnCd == 'Y'}">selected</c:if>>예</option>
					<option value="N" <c:if test="\${clsYnCd == 'N'}">selected</c:if>>아니오</option>
				</select>
			</td>
			
		</tr>
		<tr>
			<th scope="row">
				<label for="emplNm" class="required" title="필수입력">판매원명</label>
			</th>
			<td>
				<div class="searchWrap">
					<input type="text"		id="emplNm" 		name="emplNm" 		value="\${emplNm}" 	class="inp" readonly>
					<input type="hidden"	id="saleEmplSeq" 	name="saleEmplSeq" 	value="\${saleEmplSeq}" class="inp" readonly>
					<button type="button" class="postBtn" name="" title="검색하기" data-id="modalAgencyViews02"  onclick="openEmplSearchPop()"></button>
				</div>
			</td>
			<th scope="row">
				<label for="inp_weekStore">본사주간판매점</label>
			</th>
			<td>
				<div class="searchWrap">
					<input type="text" name="vendNm" value="\${vendNm}" class="inp" readonly>
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row">
				<label for="dlvOrdr" class="required" title="필수입력">순서</label>
			</th>
			<td>
				<input type="number" id="areaOrdr" class="inp" value="\${areaOrdr}" name="areaOrdr" maxlength="6">
			</td>
			<th scope="row">
			</th>
			<td>
			</td>
		</tr>
		<tr id="acctRow">
			<th scope="row">
				<label for="mobNo1" title="필수입력">휴대폰번호</label>
			</th>
			<td colspan="3">
				<div class="formWrap">
					<select name="mobNo1" class="sel mr10" id="mobNo1" disabled>
						<option value="">선택</option>
						<option value="010" <c:if test="${mobNo1 == '010'}">selected</c:if>>010</option>
						<option value="011" <c:if test="${mobNo1 == '011'}">selected</c:if>>011</option>
						<option value="016" <c:if test="${mobNo1 == '011'}">selected</c:if>>016</option>
						<option value="017" <c:if test="${mobNo1 == '011'}">selected</c:if>>017</option>
						<option value="018" <c:if test="${mobNo1 == '011'}">selected</c:if>>018</option>
					</select>
					<span class="dash"></span>
					<input type="text" id="mobNo2" class="inp w130 mr10" value="\${mobNo2}" name="mobNo2" minlength="3" maxlength="4" readonly>
					<span class="dash"></span>
					<input type="text" id="mobNo3" class="inp w130" value="\${mobNo3}" name="mobNo3" minlength="4" maxlength="4" readonly>
					<input type="hidden" name="mobNo" id="mobNo" value="">
					</div>
				</td>
			</tr>
			<tr colspan="3">
				<th scope="row" rowspan="3">
					<label for="addr1" title="필수입력">주소</label>
				</th>
				<td class="borderBN">
					<div class="postWrap">
						<input type="text" id="zipCd" class="inp" value="\${zipCd}" name="zipCd" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="borderBN">
					<input type="text" id="addr1" class="inp bg_gray" value="\${addr1}" name="addr1" placeholder="">
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<input type="text" id="addr2" class="inp bg_gray" value="\${addr2}" name="addr2" placeholder="">
				</td>
			</tr>
		<tr>
			<th scope="row">
				<label for="areaRm">메모</label>
			</th>
			<td colspan="3">
				<textarea id="areaRm" name="areaRm" rows="15" class="h110" >\${areaRm}</textarea>
			</td>
		</tr>
	</tbody>
</table>
</div>
<!-- 세부정보 -->
</script>

<script id="acctTmpl" type="text/x-jquery-tmpl">
{{each(i, e) acctList }}
   <tr>
		<th scope="row">
			<label for="stmAcctNo">계좌정보</label>
		</th>
		<td colspan="3">
			<div class="formWrap">
				${bankCdList}
				<span class="dash"></span>
				<input type="text" id="stmAcctNo" class="inp" value="\${e.stmAcctNo}" name="stmAcctNo" disabled>
				<span class="dash"></span>
				<input type="text" id="acctDpsr" class="inp" value="\${e.acctDpsr}" name="acctDpsr" disabled>
			</div>
		</td>
	</tr>
{{/each}}
</script>