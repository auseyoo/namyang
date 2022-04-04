<!-- 
	@File Name: areaSearchPop.jsp
	@File 설명 : 이사내역관리 - 변경 후 지역 선택 팝업
	@UI ID : UI-PCLI-0101P10
	@작성일 : 2022. 3. 20.
	@작성자 : JIHUN
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
	var popGridID;

	$(document).ready(function(){
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.        
        
	 	AUIGrid.bind(popGridID, "selectionChange", function(event) {
			$.successDialog("<c:out value='${param.id}'/>", event.primeCell.item);
			closePop();
	 	})   
    });

	// AUIGrid 를 생성합니다.
    function createAUIGrid() {
        // 그리드 속성 설정
        var gridPros = {
			headerHeight : 30,
			rowHeight : 30,
			editable : false,
			enterKeyColumnBase : true,
			selectionMode : "singleRow",
			useContextMenu : true,
			enableFilter : true,
			useGroupingPanel : false,
			showRowCheckColumn : false,
			displayTreeOpen : true,
			noDataMessage : "출력할 데이터가 없습니다.",
			groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
			rowNumColumnWidth : 50,
        };

        // 실제로 #grid_wrap3 에 그리드 생성
        popGridID = AUIGrid.create("#grid_wrap3", columnLayout, gridPros);
    }

    var columnLayout = [{
			dataField : "areaSeq",
			headerText : "지역코드",
            width : "25%" ,
            style : "auiLink"           	
        },{
			dataField : "areaNm",
			headerText : "지역명",
            style : "auiLeft"
		},{
			dataField : "emplSeq",
			headerText : "직원코드",
            width : "20%",
            style : "auiLink"
        },{
			dataField : "emplNm",
			headerText : "직원명",
            width : "20%",
        }
	];

	// events

	function closePop() {
		AUIGrid.destroy(popGridID)
		$.closeDialog("<c:out value='${param.id}'/>")
	}

	// api

	function searchAreaList() {
		var data = {};

		var flag = $('#searchFlag').val();
		var keyword = $('#searchKeyword').val();
		if(flag !== 'areaNm') {
			data.emplNm = keyword;
		}
		if (flag !== 'emplNm') {
			data.areaNm = keyword;
		}

		$.ajax({
			url: "/cst/searchAftAgenAreaList.do",
			type: 'POST',
			data: data,
			success: function(data) {
				AUIGrid.setGridData(popGridID, data);
			}
		})
	}

</script>
<div class="popArea">
	<div class="popWrap mideum modal_wrap h500" data-popup="modalAgencyViews03">
        <header>
            <h3>지역선택</h3>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>지역선택</h3>
                <div class="popBtnArea">
                <!--<button type="button" name="" class="inquBtn">저장</button>-->
                <button type="button" name="" class="comBtn modalCloseBtn" id="modalCloseBtn" onclick = 'closePop()'>닫기</button>                   
            </div>
            </div>

            <!-- 조회 -->
            <div class="inquiryBox mb14">
                <dl>
                    <dt>구분</dt>
                    <dd>
                        <div class="formWrap">
                            <select name="" class="sel w120 mr10" id="searchFlag">
                                <option>전체</option>
                                <option value="areaNm">지역명</option>
                                <option value="emplNm">직원명</option>
                            </select>                            
                        </div>
                    </dd>
                    
                    <dd>
                        <div class="formWrap">
                            <input type="text" id="searchKeyword" class="inp w160 mr7" value="" name="">
                            <button type="button" name="" class="comBtn" id="searchBtn" onclick = 'searchAreaList()'>조회</button>
                        </div>
                    </dd>
                </dl>
            </div>
            <!-- 조회 -->
            
            <div class="titleArea">
                <p class="numState">
                    <em>총 <span class="pColor01 fb" id="areaListCnt">0</span></em> 건 이 조회되었습니다.
                </p>
            </div>
        
            <!-- grid -->
            <div class="girdBox">
                <div id="grid_wrap3"></div>
            </div>
            <!-- grid -->
        </div>
        <!-- popCon -->
    </div>
</div>