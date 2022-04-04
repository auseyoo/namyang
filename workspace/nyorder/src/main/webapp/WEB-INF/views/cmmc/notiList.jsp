<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>


<script type="text/javascript">
	var mGrid;
	var arrChildren = [];

	$(document).ready(function() {
		createAUIGrid();
		searchList();

		AUIGrid.bind(mGrid, "cellClick", function( event ) {
			if(event.item.nttSeq === $('#nttSeq').val()) return;
			
			$.ajax({
				url : "/cmmc/selectNtt.do", 
				type : "POST", 
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(event.item),
				success : function(data) {

					$("#updateDetailArea").html($("#detailTmpl").tmpl(data));
					
				}, // success 
				error : function(xhr, status) {
					alert(xhr + " : " + status);
				}
			}); 	
		});
	});
	var columnLayout = [{
		dataField : "nttSub",
		headerText : "제목",
		width : "40%",
		style : "auiLink"
	}, {
		dataField : "regSeq",
		headerText : "작성자",
		width : "10%",
		style : "auiLink"
	}, {
		dataField : "regDtm",
		headerText : "작성일시",
		width : "auiLeft"
	}, {
		dataField : "nttCd",
		headerText : "그룹 코드",
		children : arrChildren
	}, ];
	var auiGridProps = {
		headerHeight : 29,
		rowHeight : 29,
		// 편집 가능 여부 (기본값 : false)
		editable : false,
		// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
		enterKeyColumnBase : true,
		// 셀 선택모드 (기본값: singleCell)
		selectionMode : "multipleCells",
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
		mGrid = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps);
	}

	function searchList() {
		$.ajax({
			url : "/cmmc/selectNotiList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(mGrid, data);
				$("#nttCd").html(data);
				console.log("data =====::" + data);
				$("#totCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	//엑셀 내보내기(Export);
	function exportTo() {
		AUIGrid.exportToXlsx(mGrid, {
			// 스타일 상태 유지 여부(기본값:true)
			exportWithStyle : true,
			fileName : "게시판 리스트"
		});
	};

	function resizeGrid() {
		AUIGrid.resize(mGrid, $("#content").width());
	}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />


	<div class="inquiryBox dtShort">
		<dl>
			<dt>등록일</dt>
			<dd>
				<div class="formWrap">
					<div class="dateWrap">
						<input type="text" name="date" value="10/24/1984" class="inp"
							id="datepicker" readonly>
						<button type="button" class="datepickerBtn" title="날짜입력"></button>
					</div>

					<span class="divi02">-</span>

					<div class="dateWrap">
						<input type="text" name="date" value="01/13/2022" class="inp"
							id="datepicker02" readonly>
						<button type="button" class="datepickerBtn02" title="날짜입력"></button>
					</div>

					<div class="checkGroup">
						<input type="radio" name="date" id="day" class="type01" id="day"
							checked="checked"><label for="day"><span>일
								기준</span></label> <input type="radio" name="date" id="month" class="type01"
							id="month"><label for="month"><span>월 기준</span></label>
					</div>
				</div>
			</dd>
			<dt>검색어</dt>
			<dd>
				<div class="formWrap">
					<select name="" class="sel w120" id="sel_purchase">
						<option>전체</option>
						<option>작성자</option>
						<option>제목+내용</option>
					</select>
				</div>
			</dd>

			<dd>
				<div class="formWrap">

					<input type="text" id="inp_product02" class="inp w160 mr7" value=""
						name="" placeholder="검색어">

					<button type="button" name="" class="comBtn" id="inp_name01"
						onclick="searchList()">조회</button>
				</div>
			</dd>
		</dl>

		<div class="btnGroup right">
			<button type="button" name="" class="inquBtn">등록</button>
		</div>
	</div>
	<!-- 조회 -->

	<form id="frm">
		<!-- grid -->
		<div class="girdBoxGroup">
			<div class="girdBox w55per">
				<div class="titleArea">
					<h3 class="tit01">공지사항 목록</h3>
				</div>

				<div class="titleArea right">
					<p class="numState">
						<em>총 <span class="pColor01 fb" id="totCnt"></span></em> 건 이 조회되었습니다.
					</p>

				</div>

				<div class="girdBox">
					<div id="grid_wrap"></div>
				</div>
			</div>
	</form>
	<div class="conBox w43per">
		<form id="frm2" action="/cmmc/saveNoti.do" method="post" enctype="multipart/form-data">

			<div class="titleArea right">
				<h3 class="tit01">제목</h3>
				<!-- 글작성 폼 -->

				<div class="btnGroup">
					<button type="submit" name="submitBtn" id="submitBtn"
						class="inquBtn small">등록</button>
					<button type="button" name="deleteBtn" id="deleteBtn"
						class="cancelBtn small">삭제</button>
				</div>
			</div>


			<!-- 세부정보 div start -->
			<div id="updateDetailArea">
						
			</div>
			<!-- 세부정보 div end -->
		</form>
	</div>
</div>
<!-- grid -->

</div>

<script id="detailTmpl" type="text/x-jquery-tmpl">
<div class="tblWrap">
<input type="hidden" name="nttSeq" id="nttSeq" value="\${nttSeq}" />

<table class="tbl">
	<caption>등록</caption>
	<colgroup>
		<col style="width: 132px;">
		<col>
		<col style="width: 132px;">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">제목</th>
			<td><input name="nttSub" id="nttSub"
				style="border: none !important" value="\${nttSub}"></input></td>
			<th scope="row">작성일시</th>
			<td>
				<input type = "hidden" id="regDtm" name="regDtm"></input>
				<p>\${regDtm}</p>
			</td>
		</tr>
		<tr>
			<th scope="row">내용</th>
			<td colspan="3"><textarea name="nttCntt" id="nttCntt"
					placeholder="" style="border: none !important">\${nttCntt}</textarea></td>
		</tr>
	</tbody>
</table>

<div class="titleArea">
	<h3 class="tit01">첨부파일</h3>
</div>

<table class="tbl">
	<caption>첨부파일 정보</caption>
	<colgroup>
		<col style="width: 132px;">
		<col>
		<col style="width: 132px;">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">파일명</th>
			<td colspan="3"><input type="file" class="inp" value="" id="file" name="file" /></td>
		</tr>
	</tbody>
</table>

</div>
</script>