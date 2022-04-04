<!--
	@File Name: searchBcncPrdPop
	@File 설명 : 거래처 제품 등록 (팝업)
	@UI ID :
	@작성일 : 2022. 2. 6.
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script>

var popGrid ;

$(document).ready(function(){

	if(AUIGrid.isCreated(popGrid) ){
		AUIGrid.destroy(popGrid);
	}
	popGrid = AUIGrid.create("#pop_grid_wrap", popColumnLayout, popGridPros);

	AUIGrid.bind(popGrid, "selectionChange", function(event) {
		var primeCell = event.primeCell;
		var rowItem = primeCell.item;
		if(confirm("해당거래처를 선택하시겠습니까?")){
			AUIGrid.updateRow(mGrid,
			{
				'vendSeq':rowItem.vendSeq,
				'vendCd':rowItem.vendCd,
				'vendNm':rowItem.vendNm
			}, 0);
			closePop();
		}

	});
});
var popGridPros = {
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
	showRowCheckColumn : false,
	// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
	displayTreeOpen : true,
	noDataMessage : "출력할 데이터가 없습니다.",
	groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
};
var popColumnLayout = [{
    dataField: "vendSeq",
    visible: false,
    editable: false
},{
	dataField : "vendCd",
	headerText : "거래처코드",
    width : "15%" ,
    style : "auiLink"
},{
	dataField : "vendNm",
	headerText : "거래처명",
	 width : "85%" ,
    style : "auiLink",
}
];

function searchBcncList() {
    $.ajax({
        url: "/sale/selectBcncMngList.do",
        type: 'POST',
        data: {
			"schType" :$("#schType").val(),
			"schTxt"  :$("#schTxt").val()
		},
        success: function(data) {
            console.log(data);
            AUIGrid.setGridData(popGrid, data);
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}

function closePop() {
    $.closeDialog("<c:out value='${param.id}'/>")
}
</script>
<div class="popArea">
	<%-- 제품 등록 레이어 S --%>
	<div class="popWrap mideum modal_wrap" data-popup="srcBcncReg" style="left:0; right:0;">
		<header>
			<h3>거래처 등록</h3>
			<%-- <button type="button" name="" class="closeBtn" onclick = 'closePop()'></button> --%>
		</header>

		<!-- popCon -->
		    <div class="popCon">
        <div class="popTitArea">
            <h3>거래처 등록</h3>

            <div class="popBtnArea">
					<button type="button" name="" class="comBtn" onclick = 'closePop()'>닫기</button>
			</div>
        </div>

        <!-- 조회 -->
        <div class="inquiryBox dtShort">
            <dl>
                <dt>구분</dt>
                <dd>
                    <div class="formWrap">
                        <select name="schType" class="sel w120 mr10" id="schType">
                            <option value ="">전체</option>
                            <option value ="vendCd">거래처코드</option>
                            <option value ="vendNm">거래처명</option>
                        </select>
                    </div>
                </dd>

                <dd>
                    <div class="formWrap">
                        <input type="text" id="schTxt" class="inp w160 mr7" value="" name="schTxt">
                        <button type="button" name="" class="comBtn" id="inp_name01" onclick ="searchBcncList();">조회</button>
                    </div>
                </dd>
            </dl>
        </div>
        <!-- 조회 -->

        <div class="girdBoxGroup" style="height:300px">
            <!-- grid -->
            <div class="girdBox" style="height:300px">
                <div id="pop_grid_wrap"></div>
            </div>
            <!-- grid -->
        </div>

    	</div>
		<!-- popCon -->
	</div>
	<%-- 제품 등록 레이어 E --%>
</div>
<script>

</script>