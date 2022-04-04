<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
	var myGridID;

	
   $(document).ready(function(){
		// AUIGrid 생성 후 반환 ID
		createAUIGrid();

		//검색어 조회 버튼 클릭
		$("#noticeSearchBtn").click(function(){
			searchList();
		});
		
		searchList(); 

		//그리드 클릭 이벤트
		AUIGrid.bind(myGridID, "cellClick", function( event ) {
			var item = AUIGrid.getItemByRowIndex(myGridID, event.rowIndex);
			$("#contentArea").html(event.item.nttCntt);
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

	});
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : false,
			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "singleCell",
			showRowNumColumn : false,
			showFooter : false,
			noDataMessage : "출력할 데이터가 없습니다.",
			groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
		};
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	}

	var columnLayout = [
		{
			dataField : "nttOrdr",
			headerText : "순서",
			width: "12%",
		},{
			dataField : "nttSub",
			headerText : "제목",
			style: "auiLeft",
		},{
			dataField : "regDtm",
			headerText : "날짜",
			width : "30%",
			dataType : "date",
			formatString : "yyyy-mm-dd"
		}
	];
	//게시판 그리드 리스트 조회
	function searchList() {
		$.ajax({
			url : "/cmmc/selectNotiList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data);
				$("#totCnt").html(data.length);
				
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	function resizeGrid() {
		AUIGrid.resize(myGridID, $("#content").width());
	}

	function download(nttAtclDtlSeq) {
		var param = {};
		param.nttAtclDtlSeq = nttAtclDtlSeq;
		$.ajax({
			url : "/file/downloadFile.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(param),
			success : function(data) {
				
			},  
			error : function(xhr, status) {
				alert('수정하는 도중 오류가 발생하였습니다');
			}
		});
	}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/> 

	<!-- 조회 -->
	<form id="frm">
		<input type="hidden" id="nttAtclDtlSeq" name="nttAtclDtlSeq"/>
		<div class="inquiryBox">
			<dl>
				<dt>검색어</dt>
				<dd>
					<div class="formWrap">
						<select id="srcType" class="sel mr10" name="srcType">
							<option value="">전체</option>
							<option value="all">제목+내용</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
						<input type="text" name="srcKeyword" id="srcKeyword" class="inp w160 mr10" value="" title=""></input>
						<button type="button" name="" class="comBtn" id="noticeSearchBtn">조회</button>
					</div>
				</dd>
			</dl>
		</div>
	</form>
	<!-- 조회 -->

	<div class="girdBoxGroup type02">
		<div class="girdBox w25per">
			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="totCnt"></span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap"></div>
			</div>
			<!--// grid -->
		</div>

		<!-- 내용 -->
		<div class="conBox w74per">
			<div class="titleArea right">
				<h3 class="tit01">내용</h3>
			</div>

			<div class="fileInfo">
				<textarea name="contentArea" id="contentArea" class="h500"></textarea>
				<div id="fileArea"></div>
			</div>
		</div>
		<!--// 내용 -->
	</div>
</div>

<script id="attachTmpl" type="text/x-jquery-tmpl">
<div class="formWrap type02 file">
	<p class="tit">첨부파일 :</p>
	<p>
		<button type="button" class="comBtn small" onclick="download('\${nttAtclDtlSeq}')">다운로드</button>
		<span class="name">\${fileOriNm}</span>
	</p>
</div>
</script>