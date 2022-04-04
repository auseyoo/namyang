<!-- 
	@File Name: rqbod.jsp
	@File 설명 : 요청게시판
	@UI ID : 	UI-PCOM-0301P1
	@작성일 : 2022. 3. 15.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
	var myGridID;
	var popupParam = [];
	$(document).ready(function() {
		createAUIGrid();

		$("#addBtn").click(function(){
			//팝업오픈
			$.ajaxDialog({
				id : "addRqbodPop",
				ajax : {
					url : "/cmmc/addRqbodPop.do",
				},
				dialog : {
					width : 600,
					height : 680
				},
				success : function(data) {
					alert(data);
				}
			});
		});
		
		//그리드 클릭 이벤트
		AUIGrid.bind(myGridID, "cellClick", function(event) {
			if(event.item.cfmYn == "Y"){
				$(".modBtn").hide();
			}else{
				$(".modBtn").show();
			}
			
			$("#contentArea").html(event.item.nttCntt);
			$("#nttSeq").val(event.item.nttSeq);
			$("#fileArea").html("");
			$.ajax({
	 			url : "/file/selectAtclList.do",
	 			type : 'POST',
	 			contentType : "application/json; charset=utf-8",
	 			data : JSON.stringify(event.item),
	 			success : function(data) {
					// attachTmpl
					$("#fileArea").html($("#attachTmpl").tmpl(data));
					
	 			}, // success 
	 			error : function(xhr, status) {
	 				alert('수정하는 도중 오류가 발생하였습니다');
	 			}
	 		});
		});

			//조회 버튼 클릭
		$("#searchBtn").click(function() {
			searchList();
		});
		
		//삭제 버튼 클릭
		$("#delBtn").click(function() {
			if(CommUtil.isEmpty( $("#nttSeq").val() )) {
				// 체크박스 선택여부 확인하기
				popupParam.data = {
					title : "자료실",
					message : "<spring:message code='alert.rqbod07'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			if(AUIGrid.getSelectedItems(myGridID)[0].item.cfmYn == "N"){
				popupParam.data = {
					message : "<spring:message code='alert.rqbod01'/>",
					btn1Func : deleteRqst,
					showBtn2 : 'Y'
				}
				layerAlert(popupParam);
			}else{
				popupParam.data = {
					title : "요청 게시판",
					message : "<spring:message code='alert.rqbod02' />",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			
		});
		//수정 버튼 클릭
		$("#updBtn").click(function() {
			if(!AUIGrid.getSelectedItems(myGridID).length > 0){
				popupParam.data = {
						title : "자료실",
						message : "<spring:message code='alert.rqbod07'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			var row = AUIGrid.getSelectedItems(myGridID)[0].item;
			$.ajaxDialog({
				id : "addRqbodPop",
				ajax : {
					url : "/cmmc/addRqbodPop.do",
					data:{
						nttSeq : row.nttSeq
					}
				},
				dialog : {
					width : 600,
					height : 680
				},
				success : function(data) {
					alert(data);
				}
			});
		});
	});
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : false,
			enterKeyColumnBase : true, // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			fixedColumnCount : 7,
			editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
			wrapSelectionMove : true,
			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "singleCell",
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

		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	}

	var columnLayout = [{
		dataField : "resSecCd",
		headerText : "수신구분",
		style : "auiLink",
		width : "20%",
	}, {
		dataField : "nttSub",
		headerText : "제목",
		style : "auiLeft auiLink",
	}, {
		dataField : "regDtm",
		headerText : "날짜",
		width : "30%",
	}];
	
	//게시판 그리드 리스트 조회
	function searchList() {
		$.ajax({
			url : "/cmmc/selectRqstList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data);
				AUIGrid.resize(myGridID, $("#content").width());
				$("#totCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert("요청게시판 목록 조회 중 오류가 발생하였습니다");
			}
		});
	}

	//게시판 글 논리삭제
	function deleteRqst() {
		$.ajax({
			url : "/cmmc/delRqbod.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(AUIGrid.getSelectedItems(myGridID)[0].item),
			success : function(data) {
				var popupParam = [];
				popupParam.data = {
					title : "요청 게시판",
					message : data,
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				searchList();
			}, // success 
			error : function(xhr, status) {
				alert('삭제하는 도중 오류가 발생하였습니다');
			}
		});
	}
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/> 
	<!-- 조회 -->
	<form id="frm">
		<input type="hidden" name="nttSeq" id="nttSeq" />
		<div class="inquiryBox">
			<dl>
				<dt>수신구분</dt>
				<dd>
					<select name="resSecCd" id="resSecCd" class="sel mr10">
						<option value="">전체</option>
						<option value="1">본사</option>
						<option value="2">지점</option>
					</select>
				</dd>
				<dt>검색어</dt>
				<dd>
					<div class="formWrap">
						<select name="srcType" id="srcType" class="sel mr10">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="all">제목+내용</option>
						</select>
						<input type="text" name="srcKeyword" id="srcKeyword" class="inp w160 mr10" value="" title=""></input>
						<button type="button" name="" class="comBtn" id="searchBtn">조회</button>
					</div>
				</dd>
			</dl>

			<div class="btnGroup right">
				<button type="button" name="" class="inquBtn" id="addBtn">등록</button>
			</div>
		</div>
	</form>
	<!-- 조회 -->
	<div class="txtInfo pColor02">※ 요청 내역은 3개월이 지나면 자동 삭제 됩니다. 담당자 확인
		후에는 수정/삭제할 수 없습니다.</div>

	<div class="girdBoxGroup type02">
		<div class="girdBox w33per">
			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="totCnt">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap"></div>
			</div>
			<!-- grid -->
		</div>

		<div class="conBox w65per">
			<div class="titleArea right">
				<h3 class="tit01">내용</h3>
				<div class="btnGroup modBtn" style="display:none;">
					<button type="button" name="" class="comBtn small" id="delBtn">삭제</button>
					<button type="button" name="" class="comBtn small" id="updBtn">수정</button>
				</div>
			</div>
			<div class="fileInfo">
				<textarea name="contentArea" id="contentArea" class="h500" readonly="readonly"></textarea>
				<div id="fileArea"></div>
			</div>
		</div>
	</div>
</div>
<div class="modal_bg"></div>
<!-- modal 배경 -->

<script id="attachTmpl" type="text/x-jquery-tmpl">
<div class="formWrap type02 file">
	<p class="tit">첨부파일 :</p>
	<p>
		<button type="button" class="comBtn small" onclick="download('\${nttAtclDtlSeq}')">다운로드</button>
		<span class="name">\${fileOriNm}</span>
	</p>
</div>
</script>
