<!-- 
	@File Name: invryMst.jsp
	@File 설명 : 재고 관리
	@UI ID : UI-PORD-0801.html
	@작성일 : 2022.02.14
	@작성자 : 김정애
	
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------

 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
	var gridPuch;
	var gridInvry;
   
   $(document).ready(function(){

	   	// 미래일자 선택 불가하도록 달력 재설정
		$("#datepicker").daterangepicker({
			singleDatePicker: true,
			maxDate : new Date(),
			showDropdowns: true,
			changeMonth: true,
			showMonthAfterYear: true,
			locale: {
				format: "YYYY-MM-DD",
			    separator: " - ",
			    applyLabel: "Apply",
			    cancelLabel: "Cancel",
			    fromLabel: "From",
			    toLabel: "To",
			    customRangeLabel: "Custom",
			    weekLabel: "W",
			    applyLabel: "확인",
			    cancelLabel: "취소",
			    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
			    monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월",],
			    firstDay: 1,
			  },
			})
	   
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();

		// 바인딩
		AUIGrid.bind(gridPuch, "cellClick", fnSelectPuch);		
		AUIGrid.bind(gridInvry, "cellEditEnd", auiCellEditingHandler);
		AUIGrid.setFooter(gridInvry, footerLayout);
		
		$("#selectBtn").on("click", fnSearchList);

		let popupObjSave = {};
        popupObjSave.title = "재고 관리";
        popupObjSave.message = '<spring:message code="alert.msgInvryMst1" />';        
        popupObjSave.showBtn1 = 'Y';
        popupObjSave.btn1Func = fnSaveInvry;        
        popupObjSave.showBtn2 = 'Y';
		$("#saveBtn").on("click", popupObjSave, layerAlert);  


		$(".content .tabsWrap ul.tabs li").click(function (){
	        $(".content .tabsWrap ul.tabs li").removeClass("active");
	        $(this).addClass("active");
	        var activeTab = $(this).attr("rel");

	        $("#searchPart").val('');
			if($(this).parent().children("li").eq(1).hasClass("active") == true)
				$("#searchPart").val("PRD");
			else if($(this).parent().children("li").eq(2).hasClass("active") == true)
				$("#searchPart").val("PRMT");
			
	        fnSearchList();
	    });


		fnSelectPuchList();
    });
    

    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
        // 그리드 속성 설정
        var gridProsPuch = {
                headerHeight : 58,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : false,
                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,
                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "singleRow",
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
                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
                
        }
        var gridProsInvry = {
            headerHeights : [58, 29],
			rowHeight : 29,
            showRowNumColumn : true,
            rowNumColumnWidth : 50,
            enterKeyColumnBase : true,
            editingOnKeyDown : true,
            showFooter : true,
            editable : true,
            enableFilter : true,
            useGroupingPanel : false,
            selectionMode : "singleRow",
            displayTreeOpen : true,
            noDataMessage : "출력할 데이터가 없습니다.",
            groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
		}
    
        // 실제로 #grid_wrap 에 그리드 생성
        gridPuch 	= AUIGrid.create("#grid_wrap", columnLayoutPuch, gridProsPuch);
        gridInvry 	= AUIGrid.create("#grid_wrap2", columnLayoutInvry, gridProsInvry);
    }

    var columnLayoutPuch = [{
	    	dataField : "puchNm",
			headerText : "매입처명",
	        style : "auiLeft"
		},{
	        dataField : "puchSeq",
	        headerText : "매입처시퀀스",
	        visible:false,
	    }
	];

    var columnLayoutInvry = [{
        dataField : "invrySeq",
        visible:false,
    },{
        dataField : "prdDtlSeq",
        visible:false,
    },{
        dataField : "prdSapCd",
        headerText : "제품<br/>코드",
        width : "8%",
    },{
        dataField : "prdNm",
        headerText : "제품명",
        style : "auiLeft",
    },{
        dataField : "faltQty",
        headerText : "입수량",
        width : "5%",
        style: "auiRight",
        dataType : "numeric",
        formatString : "#,##0",
    },{
        dataField : "stockToday",
        headerText : "전일재고",
        style: "auiRightBorR",
            children : [{
                dataField : "yestdBoxQty",
                headerText : "BOX",
                width : "4.5%",
                style: "auiRight"
            }, {
                dataField : "yestdIddyQty",
                headerText : "낱봉",
                width : "4.5%",
                style: "auiRight"
            }]
    },{
        dataField : "enter",
        headerText : "입고(+)",
        style: "auiRightBorR",
            children : [{
                dataField : "wrhsBoxQty",
                headerText : "BOX",
                width : "4.5%",
                style: "auiRight"
            }, {
                dataField : "wrhsIddyQty",
                headerText : "낱봉",
                width : "4.5%",
                style: "auiRight"
            }]
    },{
        dataField : "sale",
        headerText : "판매(-)",
        style: "auiRightBorR",
            children : [{
                dataField : "saleBoxQty",
                headerText : "BOX",
                width : "4.5%",
                style: "auiRight"
            }, {
                dataField : "saleIddyQty",
                headerText : "낱봉",
                width : "4.5%",
                style: "auiRight"
            }]
    },{
        dataField : "return",
        headerText : "반품(-)",
        style: "auiRightBorR",
            children : [{
                dataField : "rtgdBoxQty",
                headerText : "BOX",
                width : "4.5%",
                style: "auiRight"
            }, {
                dataField : "rtgdIddyQty",
                headerText : "낱봉",
                width : "4.5%",
                style: "auiRight"
            }]
    },{
        dataField : "gift",
        headerText : "증정(-)",
            children : [{
                dataField : "prsntBoxQty",
                headerText : "BOX",
                width : "4.5%",
                style: "auiRight"
            }, {
                dataField : "prsntIddyQty",
                headerText : "낱봉",
                width : "4.5%",
                style: "auiRight",
                headerStyle: "auiBorR",
            }]
    },{
        dataField : "exchange",
        headerText : "교환",
            children : [{
                dataField : "exchgBoxQty",
                headerText : "BOX",
                width : "4.5%",
                style: "auiRight"
            }, {
                dataField : "exchgIddyQty",
                headerText : "낱봉",
                width : "4.5%",
                style: "auiRight",
                headerStyle: "auiBorR",
            }]
    },{
        dataField : "invryAdj",
        headerText : "재고조정(+-)",
            children : [{
                dataField : "invryChgBoxQty",
                headerText : "BOX",                    
                width : "4.5%",
                style: "auiRight",
                editable : true,
                dataType : "numeric",
                editRenderer : {
                       type : "InputEditRenderer",
                       allowNegative: true, // 음수 부호 입력(-) 허용 여부
                       onlyNumeric : true, // 0~9 까지만 허용
				},
                renderer : {
                    type : "TemplateRenderer"
                },
                // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
                labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                    var template = '<div class="my_div">';
                    template += '<span class="my_div_text_box">' + value + '</span>';
                    template += '</div>';
                    return template;
                }
            }, {
                dataField : "invryChgIddyQty",
                headerText : "낱봉",
                width : "4.5%",
                style: "auiRight",
                editable : true,
                dataType : "numeric",
                editRenderer : {
                       type : "InputEditRenderer",
                       allowNegative: true, // 음수 부호 입력(-) 허용 여부
                       onlyNumeric : true, // 0~9 까지만 허용
				},
                renderer : {
                    type : "TemplateRenderer"
                },
                labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                    var template = '<div class="my_div">';
                    template += '<span class="my_div_text_box">' + value + '</span>';
                    template += '</div>';
                    return template;
                }
            }]
        },{
    dataField : "invry",
    headerText : "현재고",
        children : [{
            dataField : "invryBoxQty",
            headerText : "BOX",
            width : "4.5%",
            style: "auiRight"
        },{
            dataField : "invryIddyQty",
            headerText : "낱봉",
            width : "4.5%",
            style: "auiRight"
        }]
    }];

    // 푸터 설정
    var footerLayout = [{
        labelText : "∑",
        positionField : "#base"
        }, {
            dataField : "yestdBoxQty",
            positionField : "yestdBoxQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1,
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "yestdIddyQty",
            positionField : "yestdIddyQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "wrhsBoxQty",
            positionField : "wrhsBoxQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "wrhsIddyQty",
            positionField : "wrhsIddyQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "saleBoxQty",
            positionField : "saleBoxQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "saleIddyQty",
            positionField : "saleIddyQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "rtgdBoxQty",
            positionField : "rtgdBoxQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "rtgdIddyQty",
            positionField : "rtgdIddyQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "prsntBoxQty",
            positionField : "prsntBoxQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }        
        }, {
            dataField : "prsntIddyQty",
            positionField : "prsntIddyQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "exchgBoxQty",
            positionField : "exchgBoxQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }        
        }, {
            dataField : "exchgIddyQty",
            positionField : "exchgIddyQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "invryChgBoxQty",
            positionField : "invryChgBoxQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "invryChgIddyQty",
            positionField : "invryChgIddyQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "invryBoxQty",
            positionField : "invryBoxQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "invryIddyQty",
            positionField : "invryIddyQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }];

    // 매입처 리스트 조회
  	function fnSelectPuchList(){
 		$.ajax({
 			url : "/agn/selectPuchList.do", 
 			type : 'POST', 
 			success : function(data) {
 				AUIGrid.setGridData(gridPuch, data.list);

 				AUIGrid.setSelectionByIndex(gridPuch, 0);
 				var gridData = AUIGrid.getSelectedRows(gridPuch);
 				$("#searchPuchSeq").val(gridData[0].puchSeq);
 			}, // success 
 			error : function(xhr, status) {
 				alert(xhr + " : " + status);
 			}
 		}); 	
 	}

  	// 재고 데이터 조회
 	function fnSearchList(){

  		if($("#searchPuchSeq").val() == ''){
  			alert('매입처를 선택하세요.');
  			return;
  		}
 	 	
		$.ajax({
			url : "/agn/selectInvryMstList.do", 
			type : 'POST', 
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(gridInvry, data.list);
				$("#listCnt").text(data.cnt);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}

 	// 재고 저장
 	function fnSaveInvry(){

 		/* 저장 이벤트 호출시 날짜 체크 시작 */
		var now = new Date();	
		var oneMonthAgo = new Date(now.setMonth(now.getMonth() - 1));
		
		var selDt = $("#datepicker").val().replaceAll("-","");
		selDt = new Date(selDt.substring(0, 4), Number(selDt.substring(4, 6)) -1, selDt.substring(6, 8));

		if(oneMonthAgo > selDt){
			alert("저장은 1개월 이내만 가능합니다.");
			return;
		}
		/* 저장 이벤트 호출시 날짜 체크 종료 */
		
		$.ajax({
			url : "/agn/saveInvryMst.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(AUIGrid.getGridData(gridInvry)),
			success : function(data) {
				//alert( data );
				alert("저장되었습니다.");
				/* popupParam.data = {
					title : "반품 등록",
			 	 	message : "<spring:message code='alert.msgRtgdReg7' />",
			 	 	showBtn2 : 'N'
				};
		 		layerAlert(popupParam); */
				
				//리스트 조회
				fnSearchList();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	 	
	}	

 	// 매입처 선택 이벤트
	function fnSelectPuch(event){
		$("#searchPuchSeq").val(event.item.puchSeq);
		fnSearchList();
	}

	// 재고 변경 계산 처리
 	function auiCellEditingHandler(event) {
		var item = event.item;
     	var faltQty = 0;
     	var yestdQty = 0;
    	var wrhsQty = 0;
    	var saleQty = 0;
    	var rtgdQty = 0;
    	var prsntQty = 0;
    	var exchgQty = 0;
    	var invryChgQty = 0;
    	var invryQty = 0;
    	var invryBoxQty = 0;
    	var invryIddyQty = 0;
    	
 		// 현재 재고 변경  
 		if(event.dataField == "invryChgBoxQty" || event.dataField == "invryChgIddyQty")
 		{
 			faltQty = (Number(item.faltQty)) ? Number(item.faltQty) : 0;

 			yestdQty = (Number(item.yestdBoxQty) * faltQty) + Number(item.yestdIddyQty);
 			wrhsQty = (Number(item.wrhsBoxQty) * faltQty) + Number(item.wrhsIddyQty);
 			saleQty = (Number(item.saleBoxQty) * faltQty) + Number(item.saleIddyQty);
 			rtgdQty = (Number(item.rtgdBoxQty) * faltQty) + Number(item.rtgdIddyQty);
 			prsntQty = (Number(item.prsntBoxQty) * faltQty) + Number(item.prsntIddyQty);
 			exchgQty = (Number(item.exchgBoxQty) * faltQty) + Number(item.exchgIddyQty);
 			invryChgQty = (Number(item.invryChgBoxQty) * faltQty) + Number(item.invryChgIddyQty);

 			// 총 재고
 			invryQty = yestdQty + wrhsQty - saleQty - rtgdQty - prsntQty + invryChgQty;
 			
 			invryBoxQty = (faltQty != 0 ? Math.floor(Number(invryQty / faltQty)) : 0);		
 			invryIddyQty = (faltQty != 0 ? Number(invryQty % faltQty) : 0);			
 			
 			AUIGrid.updateRow(gridInvry, {'invryBoxQty': invryBoxQty}, event.rowIndex); 			
 			AUIGrid.updateRow(gridInvry, {'invryIddyQty': invryIddyQty}, event.rowIndex);
 		}		
 	}

</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	<!-- 조회 -->
	<form id="frm">
		<input type="hidden" name="searchPart" id="searchPart" />
		<input type="hidden" name="searchPuchSeq" id="searchPuchSeq" />	
		<div class="inquiryBox dtShort">
	        <dl>
	            <dt>기준일</dt>
	            <dd>
	                <div class="formWrap">            
	                    <div class="dateWrap">
	                        <input type="text" name="stdrDt" value="" class="datepicker" id="datepicker">
	                        <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
	                    </div>
	                    <button type="button" name="" class="comBtn" id="selectBtn">조회</button>
	                </div>
	            </dd>
	        </dl>
	        <div class="btnGroup right">
	            <button type="button" name="" class="inquBtn" id="saveBtn">저장</button>
	        </div>
	    </div>
	</form>
	<!-- 조회 -->

	<!-- tabs -->
	<div class="tabsWrap">
		<ul class="tabs mb10">
			<li class="active" rel="tab01">전체</li>
			<li class="" rel="tab02">제품</li>
			<li class="" rel="tab03">판촉물</li>
		</ul>

		<!-- tabContent 전체 -->
		<div><!--  id="tab01" class="tabContent" -->
			<!-- grid -->
			<div class="girdBoxGroup">
				<div class="girdBox topBlank w20per">
					<div id="grid_wrap"></div>
				</div>
				<div class="girdBox">
					<div class="titleArea right">
						<p class="numState">
							<em>총 <span class="pColor01 fb" id="listCnt">24</span></em> 건 이 조회되었습니다.
						</p>
					</div>
					<div id="grid_wrap2"></div>
				</div>
			</div>
			<!-- grid -->
		</div>
		<!-- tabContent 전체 -->

	</div>
	<!-- tabs -->

</div>
