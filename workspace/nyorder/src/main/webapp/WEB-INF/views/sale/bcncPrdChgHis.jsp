<!--
	@File Name: bcncPrdChgHis.jsp
	@File 설명 : 거래처 판매제품 및 단가변경 이력
	@UI ID : UI-PSAL-0901.html
	@작성일 : 2022.02.25
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
var mGrid;
$(document).ready(function() {
    // AUIGrid 생성 후 반환 ID
    createAUIGrid(columnLayout);
    selectBcncPrdChgHis();
});
function createAUIGrid(columnLayout) {
    mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
}
var gridPros = {
	headerHeight: 29,
	rowHeight: 29,
	editable: false,
	enableCellMerge: true,
	enterKeyColumnBase: false,
	selectionMode: "singleRow",
	showFooter: false,
	useContextMenu: true,
	enableFilter: true,
	useGroupingPanel: false,
	displayTreeOpen: true,
	noDataMessage: "출력할 데이터가 없습니다.",
	groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};

var columnLayout = [{
    dataField: "beforeCh",
    headerText: "변경 전",
    children: [{
        dataField: "befPrdCd",
        headerText: "제품코드",
        rospan: "5",
        width: "4%",
    }, {
        dataField: "befPrdNm",
        headerText: "제품명",
        width: "8%",
        style: "auiLeft",
    }, {
        dataField: "vendCd",
        headerText: "거래처코드",
        width: "6%",
    }, {
        dataField: "vendNm",
        headerText: "거래처명",
        style: "auiLeft",
        width: "8%",
    }, {
        dataField: "befMrgnRate",
        headerText: "마진율",
        style: "auiRight",
        width: "3%",
    }, {
        dataField: "befSaleUntpc",
        headerText: "판매단가",
        headerStyle: "auiRightBorR",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight",
        width: "6%",
    }]
}, {
    dataField: "afterCh",
    headerText: "변경 후",
    children: [{
        dataField: "aftPrdCd",
        headerText: "제품코드",
        width: "4%",
    }, {
        dataField: "aftPrdNm",
        headerText: "제품명",
        width: "8%",
        style: "auiLeft",
    }, {
        dataField: "vendCd",
        headerText: "거래처코드",
        width: "5%",
    }, {
        dataField: "vendNm",
        headerText: "거래처명",
        style: "auiLeft",
    }, {
        dataField: "aftMrgnRate",
        headerText: "마진율",
        style: "auiRight",
        width: "3%",
    }, {
        dataField: "aftSaleUntpc",
        headerText: "판매단가",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight",
        width: "6%",
    }]
}, {
    dataField: "chgTypeNm",
    headerText: "구분",
    width: "4%",
}, {
    dataField: "speclUntpcYn",
    headerText: "특별단가",
    style: "auiRight",
    width: "6%",
}, {
    dataField: "applDt",
    headerText: "적용일자",
    width: "6%",
}, {
    dataField: "applYn",
    headerText: "적용여부",
    width: "4%",
}, {
    dataField: "emplNm",
    headerText: "작업자",
    width: "4%",
}, {
    dataField: "regDtm",
    headerText: "작업시간",
    width: "9%",
}];
var isMerged = true; // 최초에는 merged 상태

function setCellMerge() {
    isMerged = !isMerged;
    AUIGrid.setCellMerge(mGrid, isMerged);
}


function selectBcncPrdChgHis(){
	$.ajax({
		url : "/sale/selectBcncPrdChgHis.do",
		type : 'POST',
// 		data : $("#frm").serialize(),
		success : function(data) {
			console.log(data);
			AUIGrid.setGridData(mGrid, data);
			$("#listCnt").html(data.length);
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}
</script>


<div class="content">
    <tiles:insertAttribute name="body.breadcrumb"/>
    <div class="inquiryBox">
        <dl>
            <dt>적용일자</dt>
			<dd>
				<div class="formWrap">
					<div class="dateWrap">
						<input type="text" name="date" value="10/24/1984" class="inp datepicker" id="datepicker" readonly="">
						<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
					</div>
					<span class="divi02">-</span>

					<div class="dateWrap">
						<input type="text" name="date" value="10/24/1984" class="inp datepicker" id="datepicker02" readonly="">
						<button type="button" class="datepickerBtn02" title="날짜입력" data-target-id="datepicker02"></button>
					</div>
				</div>
			</dd>
			<dt>구분</dt>
			<dd>
				<select name="" class="sel w120" id="sel_purchase">
					<option value="">전체</option>
					<option value="BND">일괄</option>
					<option value="NORM">개별</option>
				</select>
			</dd>
			<dt>제품</dt>
			<dd>
				<div class="formWrap">
					<input type="text" id="inp_product01" class="inp w120 mr10" value="" name="prdCd" placeholder="제품코드">
					<input type="text" id="inp_product02" class="inp w160 mr7" value="" name="prdNm" placeholder="제품명">
				</div>
			</dd>
            <dt>거래처명</dt>
            <dd>
                 <div class="formWrap">
                     <input type="text" id="inp_product01" class="inp w120" value="" name="vendNm" placeholder="거래처명">

                     <button type="button" name="" class="comBtn" id="inp_name01">조회</button>
                 </div>
            </dd>
        </dl>
    </div>
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
