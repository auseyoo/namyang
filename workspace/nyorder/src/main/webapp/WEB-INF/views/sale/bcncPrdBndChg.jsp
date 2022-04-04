<!--
	@File Name: bcncPrdBndChg
	@File 설명 : 판매제품 일괄변경
	@UI ID : UI-PSAL-0801.html
	@작성일 : 2022.02.16
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
var mGrid;
var chgSec;

var targetNotGrid = false;
var untpcPage = false;
var prdBndChg = true;
$(document).ready(function() {
    createAUIGrid(columnLayout);
    AUIGrid.setGridData(mGrid, {});

});

var gridPros = {
    headerHeight: 29,
    showEditedCellMarker:false,
    rowHeight: 29,
    // 편집 가능 여부 (기본값 : false)
    editable: true,
    enableCellMerge: true, // 셀 병합 실행
    // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
    enterKeyColumnBase: false,
    // 셀 선택모드 (기본값: singleCell)
    selectionMode: "singleCell",
    showFooter: false,
    // 컨텍스트 메뉴 사용 여부 (기본값 : false)
    useContextMenu: true,
    // 필터 사용 여부 (기본값 : false)
    enableFilter: true,
    // 그룹핑 패널 사용
    useGroupingPanel: false,
    // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
    displayTreeOpen: true,
    noDataMessage: "출력할 데이터가 없습니다.",
    groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};
// AUIGrid 를 생성합니다.
function createAUIGrid(columnLayout) {
    mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
}

var columnLayout = [{
    dataField: "beforeCh",
    headerText: "변경 전",
    headerStyle: "auiRightBorR",
    children: [ {
        dataField: "aftPrdDtlSeq",
        cellMerge: true,
        visible: false

    },{
        dataField: "befPrdCd",
        headerText: "제품코드",
        width: "8%",
        style: "auiRightBorR",
        cellMerge: true,
        renderer: { // HTML 템플릿 렌더러 사용
            type: "TemplateRenderer"
        },
        // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
        labelFunction: function(rowIndex, columnIndex, value, headerText, item, dataField, cItem) {
            var template = '<div class="searchWrap">';
            template += '<span class="my_div_text_box">' + value + '<a class="serach popBtn"   onclick =\'chgSec="bef"; openSearchPrdPop(); \'></a></span>';
            template += '</div>';
            return template;
        }
    }, {
        dataField: "befPrdNm",
        headerText: "제품명",
        width: "13%",
        style: "auiLeft auiRightBorR",
        cellMerge: true,
        renderer: { // HTML 템플릿 렌더러 사용
            type: "TemplateRenderer"
        },
        // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
        labelFunction: function(rowIndex, columnIndex, value, headerText, item, dataField, cItem) {
            var template = '<div class="searchWrap">';
            template += '<span class="my_div_text_box">' + value + '<a class="serach popBtn"   onclick =\'chgSec="bef"; openSearchPrdPop(); \'></a></span>';
            template += '</div>';
            return template;
        }
    }, {
        dataField: "vendCd",
        headerText: "거래처코드",
        width: "8%",
        style: "auiLeft auiRightBorR"
    }, {
        dataField: "vendNm",
        headerText: "거래처명",

        width: "13%",
        style: "auiLeft auiRightBorR"
    }, {
        dataField: "befSaleUntpc",
        headerText: "판매단가",
        headerStyle: "auiRightBorR",
        dataType: "numeric",
        formatString: "#,##0",
        style: "auiRight auiRightBorR",
        width: "8%"
    }]
}, {
    dataField: "afterCh",
    headerText: "변경 후",
    children: [ {
        dataField: "aftPrdDtlSeq",
        cellMerge: true,
        visible: false

    }, {
        dataField: "puchSeq",
        cellMerge: true,
        visible: false

    },{
        dataField: "aftPrdCd",
        headerText: "제품코드",
        width: "8%",
        style: "auiRightBorR",
        cellMerge: true,
        renderer: { // HTML 템플릿 렌더러 사용
            type: "TemplateRenderer"
        },
        // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
        labelFunction: function(rowIndex, columnIndex, value, headerText, item, dataField, cItem) {
            var template = '<div class="searchWrap">';
            template += '<span class="my_div_text_box">' + value + '<a class="serach popBtn" onclick =\'chgSec="aft"; openSearchPrdPop(); \'></a></span>';
            template += '</div>';
            return template;
        }

    }, {
        dataField: "aftPrdNm",
        headerText: "제품명",
        width: "13%",
        style: "auiLeft auiRightBorR",
        cellMerge: true,
        renderer: { // HTML 템플릿 렌더러 사용
            type: "TemplateRenderer"
        },
        // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
        labelFunction: function(rowIndex, columnIndex, value, headerText, item, dataField, cItem) {
            var template = '<div class="searchWrap">';
            template += '<span class="my_div_text_box">' + value + '<a class="serach popBtn" onclick =\'chgSec="aft"; openSearchPrdPop(); \'></a></span>';
            template += '</div>';
            return template;
        }
    }, {
        dataField: "vendCd",
        headerText: "거래처코드",
        width: "8%",
        style: "auiLeft auiRightBorR",
    }, {
        dataField: "vendNm",
        headerText: "거래처명",
        width: "13%",
        style: "auiLeft auiRightBorR",
    }, {
        dataField: "chgSaleUntpc",
        headerText: "판매단가",
        width: "8%",
        style: "auiRight",
        dataType: "numeric",
        editable: true,
        renderer: {
            type: "TemplateRenderer"
        },
        labelFunction: function(rowIndex, columnIndex, value, headerText, item) {
            value =  value || 0;
            var template = '<div class="my_div">';
            template += '<span class="my_div_text_box center">' + value + '</span>';
            template += '</div>';
            return template;
        }
    }]
}];

var isMerged = true; // 최초에는 merged 상태


function setCellMerge() {
    isMerged = !isMerged;

    AUIGrid.setCellMerge(mGrid, isMerged);
}
var ddd;
function selectAllBcncUntpc(prdData) {
    $.ajax({
        url: "/sale/selectAllBcncUntpc.do",
        type: 'POST',
        data: {"prdDtlSeq": prdData.prdDtlSeq,
			   "applDt" : $("#datepicker").val()
            },
        success: function(data) {
			$("#listCnt").val(data.length);

			var tData = AUIGrid.getGridData(mGrid) ;
			if(AUIGrid.getCellValue(mGrid,0,'vendSeq')==null){
				tData =  data;
			}
			$.each(data, function(idx,item){
				tData[idx][chgSec+'PrdDtlSeq']= prdData.prdDtlSeq;
				tData[idx][chgSec+'PrdCd']= prdData.prdDtlCd;
				tData[idx][chgSec+'PrdNm']= prdData.prdNm;
				if(chgSec =='aft'){
					tData[idx]['puchSeq'] = prdData.puchSeq;
					tData[idx]['chgApplDt'] =$("#datepicker").val();
					tData[idx]['chgType'] ='BND';
					tData[idx]['chgSaleUntpc']= data[idx].saleUntpc;
				}else{
					tData[idx]['befSaleUntpc']= data[idx].saleUntpc;
				}
			});
			AUIGrid.setGridData(mGrid, tData);

            console.log(data);
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}

function savePrdBndChg(){

	var  saveData = AUIGrid.getGridData(mGrid);
	$.each(saveData, function(idx,item){
		saveData[idx]['chgApplDt'] = $("#datepicker").val();
	});
	 $.ajax({
        url: "/sale/saveAgenVendUntpc.do",
        type: 'POST',
        contentType : "application/json; charset=utf-8",
        data:JSON.stringify (saveData),
        success: function(data) {
           //
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
	});

}
function openSearchPrdPop(){
	$.ajaxDialog({
		id: "searchBcncPrdPop",
		ajax: {
			url: "/sale/searchBcncPrdPop.do",
		},
		dialog: {
			width:860,
			height:560
		},
		success: function(data) {

		}
	});
}
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />
	<div class="inquiryBox">
	    <dl>
	        <dt>적용일자</dt>
	        <dd>
	            <div class="formWrap">
	                <div class="dateWrap">
	                    <input type="text" name="date" value="10/24/1984" class="datepicker" id="datepicker" readonly="">
	                    <button type="button" class="datepickerBtn" title="날짜입력"></button>

	                </div>
	                <button type="button" name="" class="comBtn" id="">조회</button>
	            </div>
	        </dd>

	    </dl>

	    <div class="btnGroup right">
	        <button type="button" name="" class="inquBtn" id="" onclick ="savePrdBndChg();">저장</button>
	    </div>
	</div>
	<!-- 조회 -->

	<div class="titleArea">
	    <p class="numState">
	        <em>총 <span class="pColor01 fb" id ="listCnt">0</span></em> 건 이 조회되었습니다.
	    </p>
	</div>

	<!-- grid -->
	<div class="girdBox">
	    <div id="grid_wrap"></div>
	</div>
	<!-- grid -->
</div>


