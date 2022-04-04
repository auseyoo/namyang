<!-- 
	@File Name: rtngudList
	@File 설명 : 반품/반송 조회
	@UI ID : UI-PORD-0301.html
	@작성일 : 2022.01.11
	@작성자 : 윤이준
	
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
  * 2022. 1. 26.    JUNGAE     반품/반송조회 그리드 데이터 조회
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
    var myGridID;
   
   $(document).ready(function(){
	   
        createAUIGrid(columnLayout);

		// 바인딩
		$("#regBtn").on("click", fnPageMove);
		$("#selectBtn").on("click", fnSearchList);
		$("#printBtn").on("click", fnRtgdConfmPop);

		$("#chkRtgd").on("click", fnChkRtnPart);
		$("#chkRet").on("click", fnChkRtnPart);
		fnChkRtnPart();

		// 데이터 조회
		fnSearchList();
	    AUIGrid.setFooter(myGridID, footerLayout);		
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid(columnLayout) {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 29,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : false,
                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,
                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "singleRow",
                showFooter : true,
                
                // 컨텍스트 메뉴 사용 여부 (기본값 : false)
                useContextMenu : true,
                
                // 필터 사용 여부 (기본값 : false)
                enableFilter : true,
            
                // 그룹핑 패널 사용
                useGroupingPanel : false,

                // row Styling 함수
                rowStyleFunction : function(rowIndex, item) {
                    // 반품일때 - 의뢰, 확정수량 상이할때 음영처리하기
                	if((item.rtgdSec == '반품') && (item.reqQty != item.dcsnQty)) {
                        return "dataChange";
                    }
                    return "";                    
                },                
              
                // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
                displayTreeOpen : true,
                
                noDataMessage : "출력할 데이터가 없습니다.",
                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
                
        };
    
        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        
    }

    var columnLayout = [{
	        dataField : "prdDtlCd",
			headerText : "제품코드",
			width : "5%",
		},{
			dataField : "prdNm",
			headerText : "제품명",
	        style : "auiLeft"			
	    },{
			dataField : "rtgdSecTxt",
			headerText : "유형",
			width : "6%",
	    },{
			dataField : "inPath",
			headerText : "입력경로",
			width : "6%"
		},{
			dataField : "faltQty",
			headerText : "입수량",
	        width : "4%",
	        style : "auiRight"
		},{
			dataField : "orderQuan",
			headerText : "의뢰수량",
	            children : [{
	                dataField : "reqBoxQty",
	                headerText : "BOX",
	                width : "5%",
	                style : "auiRight"
	            }, {
	                dataField : "reqIddyQty",
	                headerText : "낱봉",
	                width : "5%",
	                style : "auiRight",
	            }, {
	                dataField : "reqQty",
	                headerText : "합계",
	                headerStyle : "auiRightBorR",
	                width : "5%",
	                style : "auiRight"
	            }]
		},{
			dataField : "conQuan",
			headerText : "확정수량",
	            children : [{
	                dataField : "dcsnBoxQty",
	                headerText : "BOX",
	                width : "5%",
	                style : "auiRight"
	            }, {
	                dataField : "dcsnIddyQty",
	                headerText : "낱봉",
	                width : "5%",
	                style : "auiRight",
	            }, {
	                dataField : "dcsnQty",
	                headerText : "합계",
	                width : "5%",
	                style : "auiRight"
	            }]
	    },{
			dataField : "untpc",
			headerText : "단가",
	        dataType : "numeric",
			width : "5%",
	        style : "auiRight"
	    },{
			dataField : "total",
			headerText : "합계",
	            children : [{
	                dataField : "spprc",
	                headerText : "공급가",
	                dataType : "numeric",
	                width : "5%",
	                style : "auiRight"
	            }, {
	                dataField : "vatSpprc",
	                headerText : "VAT",
	                dataType : "numeric",
	                width : "5%",
	                style : "auiRight",
	            }, {
	                dataField : "totAmount",
	                headerText : "計",
	                dataType : "numeric",
	                width : "5%",
	                style : "auiRight"
	            }]
	    },{
			dataField : "reqDt",
			headerText : "의뢰일자",
			dataType : "date",		
			formatString: "yyyy-mm-dd",
			width : "6%",
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				var template = ''
					if(value == null || value == '')
				{
                    template = '-'
                }else{
                	template = AUIGrid.formatDate(value, "yyyy-mm-dd")
                }
                return template;
			}  
	    },{
			dataField : "dcsnDt",
			headerText : "확정일자",
			dataType : "date",		
			formatString: "yyyy-mm-dd",			
	        width : "6%",
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				var template = ''
					if(value == null || value == '')
				{
                    template = '-'
                }else{
                	template = AUIGrid.formatDate(value, "yyyy-mm-dd")
                }
                return template;
			}  
		}
	];
	
	// 푸터 설정
	var footerLayout = [{
			labelText : "∑",
			positionField : "#base"
		}, {
			dataField : "code",
			positionField : "code",
			operation : "SUM",
			colSpan : 5, // 자신을 포함하여 4개의 푸터를 가로 병합함.
			labelFunction : function(value, columnValues, footerValues) {
				// return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
				return "합계 : " 
			}
		}, {
			dataField : "reqBoxQty",
			positionField : "reqBoxQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "reqIddyQty",
			positionField : "reqIddyQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "reqQty",
			positionField : "reqQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "dcsnBoxQty",
			positionField : "dcsnBoxQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "dcsnIddyQty",
			positionField : "dcsnIddyQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "dcsnQty",
			positionField : "dcsnQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "untpc",
			positionField : "untpc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "spprc",
			positionField : "spprc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "vatSpprc",
			positionField : "vatSpprc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "totAmount",
			positionField : "totAmount",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}];

	function fnSearchList(){
		$.ajax({
			url : "/agn/selectRtngudList.do", 
			type : 'POST', 
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#listCnt").text(data.cnt);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}

	function fnPageMove(){
		document.location.href = '/agn/rtngudReg.do'; 	
	}

	function fnChkRtnPart(){
		if(($("#chkRtgd").is(":checked") == true && $("#chkRet").is(":checked") == true)
				|| ($("#chkRtgd").is(":checked") == false && $("#chkRet").is(":checked") == false))
			$("#ordStusCd").val('');
		else
		{
			if($("#chkRtgd").is(":checked") == true)
				$("#ordStusCd").val('RTGD');

			if($("#chkRet").is(":checked") == true)
				$("#ordStusCd").val('RET');
		}
	}

	function fnRtgdConfmPop(){
		var params = null;

		params = '?reqYm=' + $("#monthPicker").val().replace('-','');
		params += '&ordStusCd=' + $("#ordStusCd").val();
		params += '&prdDtlCd=' + $("#prdDtlCd").val();
		params += '&prdNm=' + $("#prdNm").val();
		params += '&inPath=' + $("#inPath").val();
		
		var url = '${request.contextPath}/agn/rtgdConfmPop.do' + params;
		var popup = window.open(url, '', 'width=830px,height=880px,scrollbars=yes');
	}
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	<!-- 조회 -->
	<form id="frm">
		<input type="hidden" name="ordStusCd" id="ordStusCd" value="">
		<div class="inquiryBox type03">
	        <dl>
	            <dt>조회월</dt>
	            <dd>
	                <div class="formWrap">            
	                    <div class="dateWrap">
	                        <input type="text" name="reqYm" value="" class="inp monthPicker" id="monthPicker">
	                        <button type="button" class="datepickerBtn" title="날짜입력"></button>
	                    </div>                        
	                                                     
	                    <div class="checkGroup">
	                        <input type="checkbox" id="chkRtgd" class="type01" checked=""><label for="chkRtgd"><span>반품 정보</span></label>
	                        <input type="checkbox" id="chkRet" class="type01" checked=""><label for="chkRet"><span>반송 정보</span></label>
	                    </div>
	                </div>
	            </dd>
	            <dt>제품</dt>
	            <dd>
	                <div class="formWrap">
	                    <input type="text" name="prdDtlCd" id="prdDtlCd" class="inp w120 mr10" value="" title="제품 입력" placeholder="제품코드" maxlength=8>
	                    <input type="text" name="prdNm" id="prdNm" class="inp w160" value="" title="제품 입력" placeholder="제품명">                                    
	                </div>
	            </dd>
	            <dt>입력경로</dt>
	            <dd>
	                <div class="formWrap">
	                    <select name="" class="sel w120" name="inPath" id="inPath">
							<option value=''>전체</option>
							<option value='1'>주문시스템</option>
							<option value='2'>ERP</option>
							<option value='3'>영업모바일</option>
	                    </select>
	
	                    <button type="button" name="" class="comBtn" id="selectBtn">조회</button>
	                </div>
	            </dd>
	        </dl>
	
	        <div class="btnGroup right">
	            <button type="button" id="regBtn" class="inquBtn">반품등록</button>
	        </div>
	    </div>
	</form>
	<!-- 조회 -->
	
    <div class="txtInfo">
        ※ “의뢰수량” 대비 “확정수량”이 달라진 제품은 음영으로 표시됩니다.
    </div>

    <div class="titleArea right">
        <p class="numState">
            <em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
        </p>

        <button type="button" name="" class="comBtn small" id="printBtn">인쇄</button>
    </div>

    <!-- grid -->
    <div class="girdBox">
        <div id="grid_wrap"></div>
    </div>
    <!-- grid -->
	
</div>
