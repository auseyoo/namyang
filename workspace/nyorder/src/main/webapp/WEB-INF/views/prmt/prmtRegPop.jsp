<!-- 
	@File Name: prmtRegPop.jsp
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 3. 2.
	@작성자 : JUNGAE
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
	var myGridIDPop;

	$(document).ready(function() {

		// 화면에서 팝업을 두번째 오픈할때 비정상동작되어 그리드 삭제 코드 추가함
		AUIGrid.destroy("#pop_grid_wrap");
		myGridIDPop = null;
		

		// AUIGrid 생성 후 반환 ID
		createAUIGridPop();

		$("#searchPart option:eq(0)").attr("selected", "selected");
		$("#searchTxt").val("");
		$("#btnPrmtSrh").on("click", fnSelectprmt);

		AUIGrid.bind(myGridIDPop, "cellClick", function(event) {
			$.successDialog("<c:out value='${param.id}'/>", event.item);
			$.closeDialog("<c:out value='${param.id}'/>");
		});

		$("#closeBtn").click(function() {
			$.closeDialog("<c:out value='${param.id}'/>");
		});
	});

	// AUIGrid 를 생성합니다.
	function createAUIGridPop() {
		// 그리드 속성 설정
		var gridProsPop = {
			headerHeight : 30,
			rowHeight : 30,
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
			// 체크박스 사용 
			//showRowCheckColumn : true,
			// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
			displayTreeOpen : true,
			noDataMessage : "출력할 데이터가 없습니다.",
			groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
			rowNumColumnWidth : 50,
		};
		
		myGridIDPop = AUIGrid.create("#pop_grid_wrap", columnLayoutPop, gridProsPop);
	}

	var columnLayoutPop = [ {
		dataField : "prdDtlCd",
		headerText : "제품코드",
		width : "25%",
		style : "auiLink"
	}, {
		dataField : "prdNm",
		headerText : "제품명",
		style : "auiLinkLeft",
	} ];

	// 판촉물 리스트 조회
	function fnSelectprmt() {
		$.ajax({
			url : "/prmt/selectPrmtList.do",
			type : 'POST',
			data : $("#popFrm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridIDPop, data.list);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
</script>
<div class="popArea">
	<div class="popWrap large modal_wrap">
		<header>
			<h3>판축물 등록</h3>
		</header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>판축물 등록</h3>
            </div>

            <!-- 조회 -->
            <form id="popFrm" method="post">
            <div class="inquiryBox">
                <dl>
                    <dt>구분</dt>
                    <dd>
                        <div class="formWrap">
                            <select name="searchPart" class="sel w120 mr10" id="searchPart">
                                <option value="">전체</option>
                                <option value="PRD_NM">제품명</option>
                                <option value="PRD_DTL_CD">제품코드</option>
                            </select>                            
                        </div>
                    </dd>
                    
                    <dd>
                        <div class="formWrap">
                            <input type="text" id="searchTxt" class="inp w160 mr7" value="" name="searchTxt">
                            <button type="button" name="" class="comBtn" id="btnPrmtSrh">조회</button>
                        </div>
                    </dd>
                </dl>
            </div>
            </form>
            <!-- 조회 -->

            <!-- grid -->
			<div class="girdBox">
				<div id="pop_grid_wrap"></div>
			</div>
			<!-- grid -->

        </div>
        <!-- popCon -->
    </div>
    <!-- 판축물 등록 -->
    <!--// layerPopup -->
</div>