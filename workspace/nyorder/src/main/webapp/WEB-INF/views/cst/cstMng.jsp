<!--
	@File Name: cstMng
	@File 설명 : 애음자 관리 - 배달정보(탭)
	@UI ID : UI-PCLI-0101T1
	@작성일 : 2022.02.10
	@작성자 : 김동주
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<code:getCommCode commGrpCd="CNTR_CST_CD" var="cntrCstCd" />
<code:getCommCode commGrpCd="SBSCRB_COS_CD" var="sbscrbCosCd" />
<script type="text/javascript">

var myGridID1;
var myGridID2;
var myGridID3;
var myGridID4;
var myGridID5;
var myGridID6;
var myGridID7;
var dlvInfoData;
var nowTabId;

var gridPros = {
	headerHeight : 29,
	rowHeight : 29,
	// 편집 가능 여부 (기본값 : false)
	editable : true,
	autoGridHeight : false,
	showRowCheckColumn : true, // 체크박스 사용 	
	// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
	enterKeyColumnBase : true,
	// 셀 선택모드 (기본값: singleCell)
	selectionMode : "singleRow",
	// 컨텍스트 메뉴 사용 여부 (기본값 : false)
	useContextMenu : true,
	// 필터 사용 여부 (기본값 : false)
	enableFilter : true,
	// 그룹핑 패널 사용
	useGroupingPanel : false,
	showRowNumColumn : false,
	// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
	displayTreeOpen : true,
	noDataMessage : "출력할 데이터가 없습니다.",
	groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
	// row Styling 함수
	rowStyleFunction : function(rowIndex, item) {
	    if(item.country == "") {
	        return "rowColor01";
	    }
	    return "";
	}
};

var gridPros3 = {
    headerHeight : 29,
    rowHeight : 29,
    editable : true,
    showRowNumColumn : true,
    editingOnKeyDown : true,
    enterKeyColumnBase : true,
    selectionMode : "singleRow",
};

var gridPros4 = {
    headerHeight : 29,
    rowHeight : 29,
    showRowCheckColumn : true,
    showRowNumColumn : true,
    selectionMode : "singleRow",
};

var gridPros5 = {
    headerHeight : 29,
    rowHeight : 29,
    showRowNumColumn : true,
    showFooter : true,
    selectionMode : "singleRow",
};

var gridPros6 = {
    headerHeight : 29,
    rowHeight : 29,
    editable : true,
    showRowNumColumn : true,
    selectionMode : "singleRow",
};

var gridPros7 = {
    headerHeight : 29,
    rowHeight : 29,
    editable : true,
    showRowNumColumn : true,
    selectionMode : "singleRow",
};

	var columnLayout1 = [{dataField : "areaNm", headerText : "지역",	width : "7%",}
		,{dataField : "ordr", headerText : "배송순서", 	width : "5%",}
		,{dataField : "cstAgenCd", headerText : "애음자코드", width : "6%"}
		,{dataField : "cstNm", headerText : "성명", width : "6%"}
		,{dataField : "mobNo", headerText : "휴대폰번호", width : "10%"}
		,{dataField : "dlvAddr", headerText : "배달주소", style : "auiLeft"}
		,{dataField : "sbscrbCosStr", headerText : "가입경로", width : "7%"}
		,{dataField : "cntrCstStr", headerText : "계약상태", width : "7%"}
		,{dataField : "badnYnStr", headerText : "수금상태", width : "7%"}
		,{dataField : "appctNm", headerText : "신청인", width : "7%"}
		,{dataField : "updEmplNm", headerText : "작업자", width : "7%"}
		,{dataField : "updDtm", headerText : "작업일시", width : "8%",}
		,{dataField : "areaSeq", headerText : "areaSeq", width : "20%", visible: false,}
		,{dataField : "cstSeq", headerText : "areaSeq", width : "20%", visible: false,}
	];

	var columnLayout2 = [
		{dataField : "prdNm", headerText : "제품명", style : "auiLeft"
			, styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
				if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
					return "pColor02";
				}
				return null;
			}
		}
		,{dataField : "regDtm", headerText : "가입일", width : "6%"
			,styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
				if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
					return "pColor02";
				}
				return null;
			}
		}
		,{
		dataField : "statDt",
		headerText : "투입일",
		width : "6%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "untpc",
		headerText : "단가",
	    dataType : "numeric",
		width : "6%",
	    style : "auiRight",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "pttnStr",
		headerText : "패턴",
		width : "7%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "monQty",
		headerText : "월",
		width : "3%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "tueQty",
		headerText : "화",
		width : "3%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "wedQty",
		headerText : "수",
		width : "3%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "thuQty",
		headerText : "목",
		width : "3%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "friQty",
		headerText : "금",
	    width : "3%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "satQty",
		headerText : "토",
	    headerStyle : "hColor01",
	    width : "3%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "sunQty",
		headerText : "일",
	    headerStyle : "hColor02",
	    width : "3%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "dayTotQty",
		headerText : "총수량",
	    width : "6%",
	    style : "auiRight",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "chgSecCdStr",
		headerText : "투입상태",
	    width : "6%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "endDt",
		headerText : "종료일",
	    width : "6%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "sbscrbCosStr",
		headerText : "가입경로",
	    width : "6%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "prmtEmplNm",
		headerText : "판촉사원",
	    width : "5%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "hop",
		headerText : "홉수",
	    width : "5%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "hopUntpc",
		headerText : "홉단가",
	    dataType : "numeric",
		width : "6%",
	    style : "auiRight",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "priodDt",
		headerText : "계약기간",
	    width : "6%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "conLevy",
		headerText : "소비자부담금",
	    dataType : "numeric",
		width : "6%",
	    style : "auiRight",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "promoPrice",
		headerText : "판촉사원부담금",
	    dataType : "numeric",
		width : "6%",
	    style : "auiRight",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "stopDate",
		headerText : "중지일",
		width : "6%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "stopReason",
		headerText : "중지사유",
		width : "8%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "holdDate",
		headerText : "보류일",
		width : "6%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "remPeriod",
		headerText : "잔여기간",
		width : "4%",
		styleFunction :function(rowIndex, columnIndex, value, headerText, item, dataField) {
			if(item.poseAlert == "Y" || item.endAlert == "Y" ) {
				return "pColor02";
			}
			return null;
		}
	},{
		dataField : "prmtView",
		headerText : "판촉물지급정보",
		width : "6%",
		style : "moBtn",	
		value : "상세보기",
	    renderer : {
	        type : "ButtonRenderer",
	        onClick : function(event) {
	        	openPrmtPymInfoPop(event);	            
	        },
	    }
	},{
		dataField : "chgSecCd",
		headerText : "구분",
		visible: false
    }
	];	
	
	var columnLayoutAdd3 = [{
		dataField : "numeric",
		headerText : "수량",
		width : "4%",
	    style: "auiRight"
	},{
		dataField : "price",
		headerText : "단가",
	    dataType : "numeric",
		width : "5%",
	    style: "auiRight"
	},{
		dataField : "totalPrice",
		headerText : "총액",
	    dataType : "numeric",
		width : "6%",
	    style: "auiRight"
	},{
		dataField : "beforePrice",
		headerText : "전월미수",
	    dataType : "numeric",
		width : "6%",
	    style: "auiRight"
	},{
		dataField : "totalBill",
		headerText : "청구합계",
	    dataType : "numeric",
		width : "6%",
	    style: "auiRight"
	},{
		dataField : "priceInfo01",
		headerText : "단가정보1",
	        children : [{
	            dataField : "priceInfo01",
	            headerText : "시작일",
	            width : "3.5%",
	        }, {
	            dataField : "priceInfo02",
	            headerText : "단가",
	            dataType : "numeric",
	            width : "3.5%",
	            style: "auiRight"
	        }, {
	            dataField : "priceInfo03",
	            headerText : "수량합",
	            dataType : "numeric",
	            width : "3.5%",
	            style: "auiRight"
	        }]
	    },{
		dataField : "priceInfo11",
		headerText : "단가정보2",
	        children : [{
	            dataField : "priceInfo11",
	            headerText : "시작일",
	            width : "3.5%",
	        }, {
	            dataField : "priceInfo12",
	            headerText : "단가",
	            dataType : "numeric",
	            width : "3.5%",
	            style: "auiRight"
	        }, {
	            dataField : "priceInfo13",
	            headerText : "수량합",
	            dataType : "numeric",
	            width : "3.5%",
	            style: "auiRight"
	        }]
	},{
		dataField : "cstPrdSeq",
		headerText : "구분",
		visible: false
    }
	];

	var columnLayout4 = [
		{dataField : "workDate", headerText : "작업일시",width : "10%"}
		,{dataField : "worker", headerText : "작업자", width : "4%",}
		,{dataField : "chHistory", headerText : "변동내역", width : "5%"}
		,{dataField : "sec", headerText : "구분", width : "6%"}
		,{dataField : "chSubject", headerText : "변경대상",}
		,{dataField : "rePath", headerText : "요청경로", width : "5%"}
		,{dataField : "manager", headerText : "담당자", width : "7%"}
		,{dataField : "exCon", headerText : "기존내용", width : "7%"}
		,{dataField : "chCon", headerText : "변경내용", width : "7%"}
		,{dataField : "startDate", headerText : "적용시작일", width : "7%"}
		,{dataField : "endDate", headerText : "적용종료일", width : "7%"}
		,{dataField : "print", headerText : "출고증인쇄", width : "7%",}
		,{dataField : "notice", headerText : "전달사항", width : "12%"}
	];

	var columnLayout5 = [
		{dataField : "billMonth", headerText : "청구월", width : "10%",}
		,{dataField : "curMonth", headerText : "당월애음", dataType : "numeric", width : "10%", style: "auiRight"}
		,{dataField : "curClaim", headerText : "당월청구", dataType : "numeric", width : "10%", style: "auiRight"}
		,{dataField : "sec", headerText : "구분", width : "10%"}
		,{dataField : "collDay", headerText : "수금일", width : "10%"}
		,{dataField : "collPrice", headerText : "수금금액", dataType : "numeric", width : "10%", style: "auiRight"}
		,{dataField : "recePrice", headerText : "미수잔액", dataType : "numeric", width : "10%", style: "auiRight"}
		,{dataField : "etc", headerText : "비고"}
	];

	var columnLayout6 = [
		{dataField : "collDate", headerText : "수금일자", width : "10%"}
		,{dataField : "collMethod", headerText : "수금방법", width : "10%" }
		,{dataField : "billMonth", headerText : "청구월", width : "10%",}
		,{dataField : "colprice", headerText : "수금액", dataType : "numeric", width : "10%", style: "auiRight"}
		,{dataField : "fee", headerText : "수수료", dataType : "numeric", width : "10%", style: "auiRight"}
		,{dataField : "etc", headerText : "비고"}
		,{dataField : "worker", headerText : "작업자", width : "10%"}
		,{dataField : "workDate", headerText : "작업일시", width : "10%"}
	];

	var columnLayout7 = [
		{dataField : "prdNm", headerText : "제품명", style : "auiLeft"}
		,{dataField : "regiDate", headerText : "가입일", width : "6%"}
		,{dataField : "inputDate", headerText : "투입일", width : "6%"}
		,{dataField : "price", headerText : "단가", dataType : "numeric", width : "6%", style : "auiRight"}
		,{
		dataField : "numeric",
		headerText : "수량",
	    width : "4%",
	    style : "auiRight"
	},{
		dataField : "pattern",
		headerText : "패턴",
		width : "7%"
	},{
		dataField : "month",
		headerText : "월",
		width : "3%"
	},{
		dataField : "Tues",
		headerText : "화",
		width : "3%"
	},{
		dataField : "Wednes",
		headerText : "수",
		width : "3%"
	},{
		dataField : "Thurs",
		headerText : "목",
		width : "3%"
	},{
		dataField : "Fri",
		headerText : "금",
	    width : "3%"
	},{
		dataField : "Satur",
		headerText : "토",
	    headerStyle : "hColor01",
	    width : "3%"
	},{
		dataField : "Sun",
		headerText : "일",
	    headerStyle : "hColor02",
	    width : "3%"
	},{
		dataField : "totalQan",
		headerText : "총수량",
	    width : "6%",
	    style : "auiRight"
	},{
		dataField : "inputState",
		headerText : "투입상태",
	    width : "6%",
	},{
		dataField : "endDate",
		headerText : "종료일",
	    width : "6%",
	},{
		dataField : "regiPath",
		headerText : "가입경로",
	    width : "6%",
	},{
		dataField : "salesPerson",
		headerText : "판촉사원",
	    width : "5%",
	},{
		dataField : "numHops",
		headerText : "홉수",
	    width : "5%",
	},{
		dataField : "numHopsPri",
		headerText : "홉단가",
	    dataType : "numeric",
		width : "6%",
	    style : "auiRight"
	},{
		dataField : "term",
		headerText : "계약기간",
	    width : "6%",
	},{
		dataField : "conLevy",
		headerText : "소비자부담금",
	    dataType : "numeric",
		width : "6%",
	    style : "auiRight"
	},{
		dataField : "promoPrice",
		headerText : "판촉사원부담금",
	    dataType : "numeric",
		width : "6%",
	    style : "auiRight"
	},{
		dataField : "stopDate",
		headerText : "중지일",
		width : "6%",
	},{
		dataField : "stopReason",
		headerText : "중지사유",
		width : "10%",
	    style : "auiLeft"
	},{
		dataField : "holdDate",
		headerText : "보류일",
		width : "6%",
	},{
		dataField : "remPeriod",
		headerText : "잔여기간",
		width : "6%",
	},{
		dataField : "promoMa01",
		headerText : "판촉물1",
		width : "6%",
	},{
		dataField : "payDate01",
		headerText : "지급일",
		width : "6%",
	},{
		dataField : "payPerson01",
		headerText : "지급인",
		width : "6%",
	},{
		dataField : "promoMa02",
		headerText : "판촉물2",
		width : "6%",
	},{
		dataField : "payDate02",
		headerText : "지급일",
		width : "6%",
	},{
		dataField : "payPerson02",
		headerText : "지급인",
		width : "6%",
	},{
		dataField : "promoMa03",
		headerText : "판촉물3",
		width : "6%",
	},{
		dataField : "payDate03",
		headerText : "지급일",
		width : "6%",
	},{
		dataField : "payPerson03",
		headerText : "지급인",
		width : "6%",
	}
	];


	// 푸터 설정
	var footerLayout5 = [{
	labelText : "∑",
	positionField : "#base"
	}, {
	    dataField : "billMonth",
	    positionField : "billMonth",
	    operation : "SUM",
	    colSpan : 1, // 자신을 포함하여 3개의 푸터를 가로 병합함.
	    labelFunction : function(value, columnValues, footerValues) {
	        //return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
	        return "합계 : "
	    }
	}, {
	    dataField : "curMonth",
	    positionField : "curMonth",
	    operation : "SUM",
	    style : "auiRight",
	    colSpan : 1, 
	    labelFunction : function(value, columnValues, footerValues) {
	        return " " + AUIGrid.formatNumber(value, "#,##0");
	    }
	}, {
	    dataField : "collPrice",
	    positionField : "collPrice",
	    operation : "SUM",
	    style : "auiRight",
	    colSpan : 1, 
	    labelFunction : function(value, columnValues, footerValues) {
	        return " " + AUIGrid.formatNumber(value, "#,##0");
	    }
	}, {
	    dataField : "recePrice",
	    positionField : "recePrice",
	    operation : "SUM",
	    style : "auiRight",
	    colSpan : 1, 
	    labelFunction : function(value, columnValues, footerValues) {
	        return " " + AUIGrid.formatNumber(value, "#,##0");
	    }
	}];

	gTabGridFunc = [{"target": "tab01", "tarFunc": setTabResize }, {"target": "tab02", "tarFunc": setTabResize }, {"target": "tab03", "tarFunc": setTabResize }];

$(document).ready(function() {
	createAUIGrid();
	resizeGrid();
	
	setTab();
	$("#cntrCstType option[value='BEF']").remove();	/*불필요 삭제*/
	

	//지역 조회 팝업
	$("#btnAreaSrhPop").click(function(){
		
		$.ajaxDialog({
			id: "areaSrhPop",
			visibility: "visible", 
			openComplete: function() {
				//$("#testValue").focus();
			},
			success: function(data) {
				//$("#testValue").val(data.value);
			},
			ajax: {
				url: "/cst/areaSrhPop.do",
				method: "get",
				async: false,
			},
			dialog: {
				modal: true,
				width:800,
				height:600
			}
		});

		
		
		$("#targetArea").val("");
		$("#targetAreaSeq").val("");
		
		resizeGrid();	
	});

	//지역별 애음자 가져오기
	$("#btnSrhCstArea").click(function(){
		
		fnSrhCstArea();
	});
	
	$("#btnNewPrdPop, #btnFreeDsctPop, #btnInptChgPop, #btnPdRervPop, #btnPosePop, #btnReDlvPop, #btnCntrEndPop, #btnGetDlvyDtls").click(function(){
		
		if(fnIsEmpty($("#targetCstSeq").val())){						
			let data = {};	        
			data.title = "";
			data.message = '<spring:message code="alert.cstMng1" />';	   
			data.showBtn2 = 'N';
	        let popupObj = {"data" : data}
	        layerAlert(popupObj);
	        return false
		}
		
		if(this.id == 'btnNewPrdPop'){		
			
			console.log("btnNewPrdPop start");
			
			$.ajaxDialog({
				id: "newPrdPop",
				visibility: "visible",
				openComplete: function() {		
					
					$("#prdFrm > input[name='cstSeq']").val($("#targetCstSeq").val());
					let rowItem = AUIGrid.getGridData(myGridID2);
					$("#prdFrm > input[name='areaSeq']").val(rowItem[0].areaSeq);		
										
					console.log("openComplete areaSeq  : " +$("#areaSeq").val());
				},
				success: function(data) {					
					console.log("success cstSeq   : " +$("#cstSeq").val());
					
				},
				ajax: {
					url: "/cst/newPrdPop.do",
					method: "get",
					async: false,
				},
				dialog: {
					modal: true,
					width:1600,
					height:970
				}
			});

			//getComPop("/cst/newPrdPop.do", "modalAgencyViews");	
		}else if(this.id == 'btnFreeDsctPop'){
			var data = {"parentWinNm":"dlvInfo", "targetCstSeq": $("#targetCstSeq").val()};
						
			$.ajaxDialog({
				id: "freeDsctPop",
				visibility: "visible", 
				openComplete: function() {		
					//$("#callPopCos").val("dlvInfo");
				},
				success: function(data) {					
					//$("#callPopCos").val("dlvInfo");
				},
				ajax: {
					url: "/cst/freeDsctPop.do",
					method: "get",
					async: false,
					data : data
				},
				dialog: {
					modal: true,
					width:1600,
					height:876
				}
			});
			
			//getComPop("/cst/freeDsctPop.do", "modalAgencyViews");	
		}else if(this.id == 'btnInptChgPop'){
			
			$.ajaxDialog({
				id: "inptChgPop",
				visibility: "visible", 
				openComplete: function() {		
					//$("#callPopCos").val("dlvInfo");
				},
				success: function(data) {					
					//$("#callPopCos").val("dlvInfo");
				},
				ajax: {
					url: "/cst/inptChgPop.do",
					method: "get",
					async: false,
				},
				dialog: {
					modal: true,
					width:1600,
					height:800
				}
			});
			
		}else if(this.id == 'btnPdRervPop' || this.id == 'btnPosePop'){
			
			var pageNm = "pdRervPop";
			if(this.id == 'btnPosePop'){
				pageNm = "posePop";
			}
			var data = {"pageNm": pageNm, "targetCstSeq": $("#targetCstSeq").val()};
			
			$.ajaxDialog({
				id: "pdRervPop",
				visibility: "visible", 
				openComplete: function() {		
					//$("#callPopCos").val("dlvInfo");
				},
				success: function(data) {					
					//$("#callPopCos").val("dlvInfo");
				},
				ajax: {
					url: "/cst/pdRervPop.do",
					method: "get",
					async: false,
					data : data
				},
				dialog: {
					modal: true,
					width:1600,
					height:744
				}
			});
			
		}else if(this.id == 'btnReDlvPop'){
			
			var list = AUIGrid.getCheckedRowItems(myGridID2);
			
			if(list.length == 0){
				layerAlert1('<spring:message code="alert.noSelect" arguments="${\'제품\'}" />');   		
				return false;
			}
			
			if(list.length > 1){
				layerAlert1('<spring:message code="alert.cstMng11" />');
				return false;
			}
			
			if(list[0].item.chgSecCd != 'RERV' && list[0].item.chgSecCd != 'POSE'){
				layerAlert1('<spring:message code="alert.cstMng12" />');
				return false;
			}
			
			var data = {"targetCstSeq": $("#targetCstSeq").val(), "targetCstPrdSeq": list[0].item.cstPrdSeq
					,"prdNm" : list[0].item.prdNm, "untpc" : list[0].item.untpc, "chgSecCd" : list[0].item.chgSecCd};
			
			$.ajaxDialog({
				id: "reDlvPop",
				visibility: "visible", 
				openComplete: function() {		
					//$("#callPopCos").val("dlvInfo");
				},
				success: function(data) {					
					//$("#callPopCos").val("dlvInfo");
				},
				ajax: {
					url: "/cst/reDlvPop.do",
					method: "get",
					async: false,
					data: data
				},
				dialog: {
					modal: true,
					width:1600,
					height:648
				}
			});
			
		}else if(this.id == 'btnCntrEndPop'){
			
			var data = {"targetCstSeq": $("#targetCstSeq").val()};
			
			$.ajaxDialog({
				id: "cntrEndPop",
				visibility: "visible", 
				openComplete: function() {		
					//$("#callPopCos").val("dlvInfo");
				},
				success: function(data) {					
					//$("#callPopCos").val("dlvInfo");
				},
				ajax: {
					url: "/cst/cntrEndPop.do",
					method: "get",
					async: false,
					data : data
				},
				dialog: {
					modal: true,
					width:1600,
					height:620
				}
			});			
		}else if(this.id == 'btnGetDlvyDtls'){
			fnGetDlvyDtls();
		}
				
	});
	
	$("#btnOpenSelAreaPop").click(function(){
		getComPop("/cst/areaChoicePop.do", "modalAgencyViews03");		
	});
	
	$("#btnDlvAddrPop").click(function(){
		fnSetPostcode('#zipCd', '#addr1');
	});
	
	$("#btnAddrPop").click(function(){
		fnSetPostcode('#zipCd', '#addr1');
	});

	$("#btnAddCst").click(function(){
		$("#frm").attr("action", "${request.contextPath}/cst/addCstMng.do");
		$("#frm").submit();
	});
	
	//월변경 이벤트
	$("#dlvyMonth").on("change",function(){
		
		console.log("dlvyMonth  change val : " + $(this).val());
		//변경할 날짜 ex.2022-02
		var date = new Date( $(this).val() );
		fnChangeMonth( date );		
	});
	
	fnChangeMonth(new Date());
	
});

function fnChangeMonth(date){
	
	console.log("fnChangeMonth  date : " + date + ", :: " + date.getMonth());
	
	var nowYear = date.getFullYear();
	var nowMonth = date.getMonth();

	var lastDate = new Date(nowYear, nowMonth+1,0).getDate();
	
	var columnLayoutFirst = {
	    dataField : "shtnNm",
		headerText : "제품명",
		width : "10%",
	    style: "auiLeft"
	};
		
	var columnArr = [];
	columnArr.push(columnLayoutFirst);

	//윤년 적용
	if( ( nowYear%4===0 && nowYear % 100 !==0 ) || nowYear%400===0 ){
		lastDate=29;
	}
	
	var days = ["일", "월", "화", "수", "목", "금", "토"];
	
	for( var i = 1; i <= lastDate; i++ ){
		var plusDate = new Date( nowYear, nowMonth, i ).getDay();
	
		var day = days[plusDate];
		var dateStr = i;
		if(i < 10){
			dateStr = '0' + i;
		}
	
		//레이아웃데이터 set
		calendarLayout = {
				dataField : dateStr,
				headerText : day,
				width : "5%",
			    editable : true,
			    children : [{
		            dataField : dateStr,
		            headerText : i,
		            width : "3%",
		            renderer : {
		                type : "TemplateRenderer"
		            },
		            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
		                var template = '<div class="my_div">';
		                template += '<span class="my_div_text_box center">' + value + '</span>';
		                template += '</div>';
		                return template;
		            },
		        }],
		}		
		columnArr.push(calendarLayout);		
	}
	var finalColumnLayout3 = [...columnArr, ...columnLayoutAdd3];	
	createAUIGrid3(finalColumnLayout3);
	
}

function createAUIGrid3(columnLayoutObj){
	
	console.log("createAUIGrid3  columnLayoutObj : " + JSON.stringify(columnLayoutObj));
	
	if(AUIGrid.isCreated(myGridID3)){
    	AUIGrid.destroy(myGridID3);        	
    }
	
	myGridID3 = AUIGrid.create("#grid_wrap3", columnLayoutObj, gridPros3);	
}



function openPrmtPymInfoPop(info){
	
	//prmtPymInfo = info.item.prmtInfo;
	
	
	//getComPop("/cst/prmtPymInfoPop.do", "modalAgencyViews03");
	
	$.ajaxDialog({
		id: "prmtPymInfo",
		visibility: "visible", 
		ajax: {
			url: "/cst/prmtPymInfoPop.do",
		},
		dialog: {
			width:1500,
			height:100,
			modal: true,
			draggable: true,
			resizable: true
		},
		success: function(data) {				
		}
	});
	
	
}

function setTabResize(tabId){
	
	console.log("setTabResize start nowTabId :: "+ nowTabId );
	
	if(fnIsEmpty($("#targetCstSeq").val())){	
        layerAlert('<spring:message code="alert.cstMng1" />');
        return false
	}	
	
	if(tabId == "tab01"){
		nowTabId = "tab01";
		fnGetCstCont();
	}else if(tabId == "tab02"){
		getCstInfo();		
        nowTabId = "tab02";
        
	}else if(tabId == "tab03"){			
		nowTabId = "tab03";
	}else if(tabId == "tab04"){			
		nowTabId = "tab04";
	}else if(tabId == "tab05"){			
		nowTabId = "tab05";
	}		
	
}

function getCstInfo(){
	$.ajax({
		url : "/cst/selectBasicCstInfo.do", 
		type : 'POST', 
		data : {"cstSeq": $("#targetCstSeq").val()},
		success : function(data) {
			
			console.log("getCstInfo data :: "+ data );
			
			$("#infoAreaNm").val(data.areaNm);
			$("#infoAreaSeq").val(data.areaSeq);
			$("#infoCstNm").text(data.cstNm);
			$("#infoCstSeq").text(data.cstSeq);
			$("#infoSbscrbCosStr").text(data.sbscrbCosStr);
			
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 
	
	
}
function addPrdGrid(data){
	
	AUIGrid.addRow(myGridID2, data, 0);
}


//계약 정보
function fnGetCstCont(){
	
	let param = {"cstSeq" : $("#targetCstSeq").val()};
	
	$.ajax({
		url : "/cst/selectCstContract.do", 
		type : 'POST', 
		//data : JSON.stringify(param),
		data : param,
		//contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		//contentType : "application/json; charset=utf-8",
		success : function(data) {
			
			$.each(data, function(index, item){				
				item.prmtView = "상세보기";				
			});
			
			dlvInfoData = data;
			AUIGrid.setGridData(myGridID2, data);
			//$("#areaCstCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
	
}

function fnGetDlvyDtls(){
	let param = {"cstSeq" : $("#targetCstSeq").val(), "dlvyMonth" : $("#dlvyMonth").val().replace("-","")};
	
	$.ajax({
		url : "/cst/selectDlvyDtls.do", 
		type : 'POST', 
		//data : JSON.stringify(param),
		data : param,
		//contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		//contentType : "application/json; charset=utf-8",
		success : function(data) {

			AUIGrid.setGridData(myGridID3, data);
			//$("#areaCstCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});
}

//지역별 애음자 가져오기
function fnSrhCstArea(){
	
	var data = $("#frm").serialize()
	console.log("selectCstArea data :: "+ data );
	$.ajax({
		url : "/cst/selectCstArea.do", 
		type : 'POST', 
		data : data,
		success : function(data) {
			AUIGrid.setGridData(myGridID1, data);
			$("#areaCstCnt").html(data.length);
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 
	
}


// 지역 검색후 선택된 지역을 가져온다.
function fnSetArea(){
	
	var list	= AUIGrid.getCheckedRowItems(myGridIDPop);
	var length	= AUIGrid.getCheckedRowItems(myGridIDPop).length;
	var seq		= ""; 
	var tagArea	= "";
	var rowIndex;
	var befRowIndex	= 0;
		
	list.forEach(function(item,index){ 
		seq	= seq+item.item.areaSeq+",";

		rowIndex	= item.rowIndex;
		if( index == 0 ){
			tagArea	= item.item.areaNm;
		}
		else{
			if( rowIndex <= befRowIndex ){
				tagArea	= item.item.areaNm;
			}
		}

		befRowIndex	= rowIndex;
	});

	if( length > 1 ){
		var num	= length-1;
		tagArea	+= " 외 "+num+"건";
	}

	seq = seq.slice(0, -1);

	$("#targetArea").val(tagArea);
	$("#targetAreaSeq").val(seq);

	AUIGrid.destroy("#grid_wrap_pop");            
	//myPopGridID1 = null;
	
	
	//debugger;
	$.closeDialog("areaSrhPop");
}

function createAUIGrid(){
	myGridID1 = AUIGrid.create("#grid_wrap", columnLayout1, gridPros);
	
	//애음자 클릭시 -> 계약정보
	AUIGrid.bind(myGridID1, "cellClick", function(event) {		
		console.log("cellClick item :: " + JSON.stringify(event.item));		
		var cstSeq	= event.item.cstSeq;
		$("#targetCstSeq").val(cstSeq);
		fnGetCstCont();
	});
	
	myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros);
	
	myGridID4 = AUIGrid.create("#grid_wrap4", columnLayout4, gridPros4);
	myGridID5 = AUIGrid.create("#grid_wrap5", columnLayout5, gridPros5);
	myGridID6 = AUIGrid.create("#grid_wrap6", columnLayout6, gridPros6);
	myGridID7 = AUIGrid.create("#grid_wrap7", columnLayout7, gridPros7);
	
}

function resizeGrid(_obj, _ele){
	AUIGrid.resize(myGridID1, $("#content").width());
	AUIGrid.resize(myGridID2, $("#content").width());
	AUIGrid.resize(myGridID3, $("#content").width());
	AUIGrid.resize(myGridID4, $("#content").width());
	AUIGrid.resize(myGridID5, $("#content").width());
	AUIGrid.resize(myGridID6, $("#content").width());
	AUIGrid.resize(myGridID7, $("#content").width());	
}



</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />

	<!-- tabs -->
	<div class="tabsWrap">

		<!-- 조회 -->
		<form id="frm">
			<div class="inquiryBox">
				<dl>
					<dt>지역</dt>
					<dd>
						<div class="searchWrap">
							<input type="text" id="targetArea" class="inp w160">
							<input type="hidden" id="targetAreaSeq"  name="targetAreaSeq">
							<input type="hidden" id="targetCstSeq"   name="targetCstSeq">
							<input type="hidden" name="callPopCos" id="callPopCos" value="" />
							<button type="button" data-id="modalAgencyViews03" id="btnAreaSrhPop" class="postBtn" title="지역 찾기"></button>
						</div>
					</dd>
					<dt>상태</dt>
					<dd>
						<select name="cntrCstType" class="sel" id="cntrCstType" name="cntrCstType">
							<option>전체</option>
							<c:forEach items="${cntrCstCd}" var="i" >
								<option value="${i.commCd}">${i.commNm}</option>
							</c:forEach>			
						</select>
					</dd>
					<dt>구분</dt>
					<dd>
						<div class="formWrap">
							<select name="sbscrbCosType" class="sel mr10" id="sbscrbCosType" name="sbscrbCosType">
								<option>전체</option>
								<c:forEach items="${sbscrbCosCd}" var="i" >
									<option value="${i.commCd}">${i.commNm}</option>
								</c:forEach>	
							</select> 
							<input type="text" id="iptSearch" class="inp w140" value=""title="구분 입력">
							<button type="button" id="btnSrhCstArea" class="comBtn">조회</button>
						</div>
					</dd>
				</dl>
				<div class="btnGroup right">					
					<button type="button" name="" class="comBtn">전체변동사항</button>
					<button type="button" name="" class="inquBtn" id="btnAddCst" >등록</button>
					<button type="button" name="" class="cancelBtn">삭제</button>
				</div>
			</div>
			<!-- 조회 -->

			<div class="titleArea">
				<p class="numState">
					<em>총 <span id="areaCstCnt" class="pColor01 fb">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="girdBox type04">
				<div id="grid_wrap"></div>
			</div>
			<!-- grid -->
			<div class="tabsWrap">
				<ul class="tabs">
					<li class="active" rel="tab01">배달정보</li>
					<li class="" rel="tab02">기본정보</li>
					<li class="" rel="tab03">변동사항</li>
					<li class="" rel="tab04">수금내역</li>
					<li class="" rel="tab05">재계약내역</li>
				</ul>

				<!-- tab01 tabContent 배달정보 -->
				<div id="tab01" class="tabContent">
					<div class="titleArea right">
						<h3 class="tit01">계약정보</h3>

						<div class="btnGroup">
							<button type="button" name="" class="inquBtn small" id="btnNewPrdPop">제품추가</button>
							<button type="button" name="" class="cancelBtn small">제품삭제</button>
							<button type="button" name="" class="comBtn small" id="btnFreeDsctPop">무료/할인</button>
							<button type="button" name="" class="comBtn small" id="btnInptChgPop">투입변경</button>
							<button type="button" name="" class="comBtn small" id="btnPdRervPop">기간보류</button>
							<button type="button" name="" class="comBtn small" id="btnPosePop">일시중지</button>
							<button type="button" name="" class="comBtn small" id="btnReDlvPop">재배달</button>
							<button type="button" name="" class="comBtn small" id="btnCntrEndPop">계약종료</button>
						</div>
					</div>

					<!-- grid -->
					<div class="girdBox type04">
						<div id="grid_wrap2"></div>
					</div>
					<!-- grid -->

					<div class="titFormWrap">
						<div class="titleArea">
							<h3 class="tit01">투입내역</h3>
							<div class="formWrap">
								<div class="dateWrap mr20">
									<input type="text" name="dlvyMonth" value="2022-05" class="inp monthPicker" id="dlvyMonth" readonly>
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="dlvyMonth"></button>
								</div>

								<input type="checkbox" id="stop1" class="type01" checked=""><label
									for="stop1"><span>중지표시</span></label>
								<button type="button" name="" class="comBtn small" id="btnGetDlvyDtls">조회</button>
							</div>

							<div class="btnGroup right">
								<button type="button" name="" class="comBtn small">임시제품</button>
								<button type="button" name="" class="inquBtn full small">저장</button>
							</div>
						</div>
					</div>

					<!-- grid -->
					<div class="girdBox type04">
						<div id="grid_wrap3"></div>
					</div>
					<!-- grid -->
				</div>
				<!--// tab01 tabContent 배달정보 -->

				<!-- tab02 tabContent 기본정보 -->
				<div id="tab02" class="tabContent" style="display: none;">
					<div class="btnGroup ar">
						<button type="button" name="" class="inquBtn full small">저장</button>
						<button type="button" name="" class="inquBtn full small">이사고객전송</button>
					</div>

					<div class="titleArea right">
						<h3 class="tit01">기본정보</h3>
						<p class="txt01">
							<i class="icoRequir"></i>필수 입력 항목입니다.
						</p>
					</div>
					
					<form name="infoFrm" id="infoFrm">
					<input type="hidden" name="infoAreaSeq" value="" id="infoAreaSeq">
					<div class="tblWrap">
						<table class="tbl">
							<caption>애음자 기본정보</caption>
							<colgroup>
								<col style="width: 170px;">
								<col>
								<col style="width: 170px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">애음자 코드</th>
									<td>
										<p id=infoCstAgenCd>0001</p>
									</td>
									<th scope="row"><label for="infoAreaNm" class="required" title="필수입력">지역/배달순서</label></th>
									<td>
										<div class="formWrap type02">
											<div class="searchWrap w160 mr10">
												<input type="text" name="" value="" class="inp"	id="infoAreaNm">
												<button type="button" class="postBtn" name="" id="btnOpenSelAreaPop" title="검색하기"></button>
											</div>

											<span id="infoOrdr">/ 5</span>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="inp_accName" class="required" title="필수입력">성명/신청인</label></th>
									<td>
										<p id="infoCstNm">김남양 /</p>
									</td>
									<th scope="row"><label for="inp_accName" class="required" title="필수입력">가입경로</label></th>
									<td>
										<p id="infoSbscrbCosStr">판촉 / 홍남양</p>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="sel_handPhone01"
										class="required" title="필수입력">휴대폰번호</label></th>
									<td>
										<div class="formWrap">
											<select name="infoMobNo1" class="sel" id="infoMobNo1">
												<option value="010">010</option>
												<option value="011">011</option>
											</select> 
											<span class="dash"></span> 
											<input type="text" id="infoMobNo2" class="inp" value="" name="infoMobNo2" maxlength="4"> 
											<span class="dash"></span> 
											<input type="text" id="infoMobNo3" class="inp" value="" name="infoMobNo3" maxlength="4">
										</div>
									</td>
									<th scope="row"><label for="inp_phone01">전화번호</label></th>
									<td>
										<div class="formWrap">
											<input type="text" id="infoTelNo1" class="inp" value="" name="infoTelNo1" maxlength="3"> 
											<span class="dash"></span> 
											<input type="text" id="infoTelNo2" class="inp" value="" name="infoTelNo2" maxlength="4"> 
											<span class="dash"></span> 
											<input type="text" id="infoTelNo3" class="inp" value="" name="infoTelNo3" maxlength="4">
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row" rowspan="2"><label for="inp_delAddress"
										class="required" title="필수입력">배달주소</label></th>
									<td>
										<div class="formWrap">
											<div class="searchWrap w160">
												<input type="text" name="dlvZipCd" value="" class="inp" id="dlvZipCd">
												<button type="button" class="postBtn" name="" id="btnDlvAddrPop" title="검색하기"></button>
											</div>
										</div>
									</td>
									<th scope="row"><label for="datepicker02">이사날짜</label></th>
									<td>
										<div class="formWrap type02">
											<div class="dateWrap w160 mr20">
												<input type="text" name="date" value="10/24/1984"
													class="inp" id="datepicker02" readonly="">
												<button type="button" class="datepickerBtn" title="날짜입력"
													data-target-id="datepicker02"></button>
											</div>

											<input type="checkbox" id="etcArea" class="type01" checked=""><label
												for="etcArea"><span>타지역 이사</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<td><input type="text" name="dlvAddr1" id="dlvAddr1" class="inp">
									</td>
									<th scope="row"><label for="dlvAddr2" class="required" title="필수입력">상세주소</label></th>
									<td><input type="text" name="dlvAddr2" id="dlvAddr2" class="inp">
									</td>
								</tr>
								<tr>
									<th scope="row" rowspan="2"><label for="inp_post_num02">우편주소</label>
									</th>
									<td colspan="3">
										<div class="formWrap type02">
											<div class="postWrap w200 mr20">
												<input type="text" id="reptZipCd" class="inp" name="reptZipCd">
												<button type="button" class="postBtn"  id="btnAddrPop" title="우편번호 찾기">
											</div>

											<input type="checkbox" id="addSame" class="type01" checked=""><label
												for="addSame"><span>배달주소와 동일</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<td><input type="text" name="reptAddr1" id="reptAddr1" class="inp">
									</td>
									<th scope="row"><label for="reptAddr2">상세주소</label>
									</th>
									<td><input type="text" name="reptAddr2" id="reptAddr2" class="inp">
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="inptLc">투입위치</label></th>
									<td colspan="3"><input type="text" id="inptLc" name="inptLc" class="inp"></td>
								</tr>
								<tr>
									<th scope="row"><label for="tex_etc">메모</label></th>
									<td colspan="3"><textarea id="rmk" name="rmk" rows="15" class="h70" id="tex_etc"></textarea></td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="titleArea">
						<h3 class="tit01">결제정보</h3>
					</div>

					
					<div class="tblWrap">
						<table class="tbl">
							<caption>애음자 결제정보</caption>
							<colgroup>
								<col style="width: 170px;">
								<col>
								<col style="width: 170px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="sel_collMethod"
										class="required" title="필수입력">수금방법</label></th>
									<td><select name="" class="sel w160" id="sel_collMethod">
											<option>CMS</option>
											<option>계좌번호</option>
									</select></td>
									<th scope="row"><label for="inp_accountNm"
										class="required" title="필수입력">예금주명</label></th>
									<td><input type="text" name="" value="" class="inp"
										id="inp_accountNm"></td>
								</tr>
								<tr>
									<th scope="row"><label for="sel_bankInfo" class="required"
										title="필수입력">은행정보</label></th>
									<td>
										<div class="formWrap">
											<select name="" class="sel w160 mr10" id="sel_bankInf">
												<option>국민은행</option>
												<option>NH 농협은행</option>
											</select> <input type="text" id="inp_bankInfo" class="inp" value=""
												name="">
										</div>
									</td>
									<th scope="row"><label for="sel_identi" class="required"
										title="필수입력">신분확인</label></th>
									<td>
										<div class="formWrap">
											<select name="" class="sel w160 mr10" id="sel_identi">
												<option>법정생년월일</option>
											</select> <input type="text" id="inp_identi" class="inp" value=""
												name="">
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="sel_agreeDate"
										class="required" title="필수입력">이체 시작일</label></th>
									<td>
										<div class="dateWrap w160">
											<input type="text" name="date" value="10/24/1984" class="inp"
												id="datepicker03" readonly="">
											<button type="button" class="datepickerBtn" title="날짜입력"
												data-target-id="datepicker03"></button>
										</div>
									</td>
									<th scope="row"><label for="inp_phone01" class="required"
										title="필수입력">이체 약정일</label></th>
									<td>
										<div class="formWrap type02">
											<span class="sTit">매월</span> <select name=""
												class="sel w160 mr10" id="sel_identi">
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
											</select> <span>일</span>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="inp_delAddress"
										class="required" title="필수입력">현금영수증 발행</label></th>
									<td colspan="3">
										<div class="formWrap type02">
											<input type="radio" name="pub" id="pub1" class="type01"
												checked=""><label for="pub1"><span>미발행</span></label>
											<input type="radio" name="pub" id="pub2" class="type01"><label
												for="pub2"><span>발행</span></label> <input type="checkbox"
												id="cashReceipts" class="type01" checked=""><label
												for="cashReceipts" class="ml40"><span>현금영수증
													일괄발행</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="sel_category01"
										class="required" title="필수입력">발행 구분</label></th>
									<td><select name="" class="sel w160 mr10"
										id="sel_category01">
											<option>대리점</option>
									</select> <select name="" class="sel w160" id="sel_category02">
											<option>소득공제용</option>
									</select></td>
									<th scope="row"><label for="sel_identifi01"
										class="required" title="필수입력">신분확인</label></th>
									<td>
										<div class="formWrap">
											<select name="" class="sel mr10" id="sel_identifi01">
												<option>휴대폰번호</option>
											</select> <select name="" class="sel" id="sel_identifi02">
												<option>010</option>
											</select> <span class="dash"></span> <input type="text"
												id="inp_phone01" class="inp" value="" name=""> <span
												class="dash"></span> <input type="text" id="inp_phone02"
												class="inp" value="" name="">
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="tblWrap">
						<table class="tbl">
							<caption>CMS / 가상계좌 정보</caption>
							<colgroup>
								<col style="width: 170px;">
								<col>
								<col style="width: 170px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">작업자</th>
									<td>이남양</td>
									<th scope="row">작업일시</th>
									<td>2021.12.12. 12:12:12</td>
								</tr>
							</tbody>
						</table>
					</div>
					</form>
				</div>
				<!--// tab02 tabContent 기본정보 -->

				<!-- tab03 tabContent 변동사항 -->
				<div id="tab03" class="tabContent" style="display: none;">
					<!-- 조회 -->
					<div class="inquiryBox type02">
						<dl>
							<dt>기준</dt>
							<dd>
								<div class="formWrap type02">
									<select name="" class="sel w140 mr20">
										<option>전체</option>
										<option>구분</option>
										<option>변경대상</option>
										<option>요청경로</option>
									</select> <input type="radio" name="listOr" id="listOr1" class="type01"
										checked=""><label for="listOr1"><span>작업일시
											순서</span></label> <input type="radio" name="listOr" id="listOr2"
										class="type01"><label for="listOr2"><span>적용시작일
											순서</span></label>

									<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
								</div>
							</dd>
						</dl>

						<div class="btnGroup right">
							<button type="button" name="" class="cancelBtn">삭제</button>
						</div>
					</div>
					<!-- 조회 -->

					<div class="titleArea">
						<p class="numState">
							<em>총 <span class="pColor01 fb">24</span></em> 건 이 조회되었습니다.
						</p>
					</div>

					<!-- grid -->
					<div class="girdBox type04">
						<div id="grid_wrap4"></div>
					</div>
					<!-- grid -->
				</div>
				<!--// tab03 tabContent 변동사항 -->

				<!-- tab04 tabContent 수금내역 -->
				<div id="tab04" class="tabContent" style="display: none;">
					<div class="titFormWrap">
						<div class="titleArea">
							<h3 class="tit01">월별 수금 현황</h3>

							<div class="stateView">
								<ul>
									<li class="active"><span>양호</span></li>
									<li><span>불량</span></li>
								</ul>
							</div>

							<div class="btnGroup right">
								<button type="button" name="" class="comBtn small">OCR
									관리</button>
								<button type="button" name="" class="comBtn small">수금
									관리</button>
								<button type="button" name="" class="comBtn small">인쇄</button>
							</div>
						</div>
					</div>

					<div class="titleArea">
						<p class="numState">
							<em>총 <span class="pColor01 fb">0</span></em> 건 이 조회되었습니다.
						</p>
					</div>

					<!-- grid -->
					<div class="girdBox type04">
						<div id="grid_wrap5"></div>
					</div>
					<!-- grid -->

					<div class="titleArea right">
						<h3 class="tit01">일별 수금 상세 현황</h3>

						<div class="btnGroup">
							<button type="button" name="" class="inquBtn full small">등록</button>
						</div>
					</div>

					<!-- grid -->
					<div class="girdBox type04">
						<div id="grid_wrap6"></div>
					</div>
					<!-- grid -->
				</div>
				<!--// tab04 tabContent 수금내역 -->

				<!-- tab05 tabContent 재계약내역 -->
				<div id="tab05" class="tabContent" style="display: none;">
					<div class="titleArea right">
						<h3 class="tit01">재계약 내역</h3>
					</div>

					<div class="titleArea">
						<p class="numState">
							<em>총 <span class="pColor01 fb">100</span></em> 건 이 조회되었습니다.
						</p>
					</div>

					<!-- grid -->
					<div class="girdBox type03">
						<div id="grid_wrap7"></div>
					</div>
					<!-- grid -->

				</div>
				<!--// tab05 tabContent 재계약내역 -->
			</div>
		</form>
		<!-- //tabContent 일일 배달명단 -->
	</div>
</div>
