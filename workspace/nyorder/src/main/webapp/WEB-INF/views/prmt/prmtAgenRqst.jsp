<!-- 
	@File Name: prmtAgenRqst.jsp
	@File 설명 : 판촉물 소요량 요청 관리
	@UI ID : UI-PPRO-0101.html
	@작성일 : 2022. 2. 21.
	@작성자 : JUNGAE
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
    var myGridID;
    var popupTitle = '판촉물 소요량 요청 관리';

   	$(document).ready(function(){

   		$('#monthPicker').MonthPicker({ 
   		    OnAfterChooseMonth: function() { 
   		        fnSearchRqstMonth();
   		    } 
   		});
   		
   		createAUIGrid(columnLayout);

   		fnSearchRqstMonth();
        fnSearchList();
	    AUIGrid.setFooter(myGridID, footerLayout);

	    $("#selectBtn").on("click", fnSearchList);
	    $("#saveBtn").on("click", fnSaveprmtAgenRqst);
	    $("#excelBtn").on("click", fnExcelDown);

		let popupObjSend = {};
        popupObjSend.title = popupTitle;
        popupObjSend.message = '<spring:message code="alert.prmtAgenRqst3" />';        
        popupObjSend.showBtn1 = 'Y';
        popupObjSend.btn1Func = fnSendprmtAgenRqst;        
        popupObjSend.showBtn2 = 'Y';
		$("#sendBtn").on("click", popupObjSend, layerAlert);  

	    AUIGrid.bind(myGridID, "cellEditEnd", auiCellEditingHandler);
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid(columnLayout) {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 29,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : true,
                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,

				showRowNumColumn : true, 
                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "singleRow",
                showFooter : true,
                
                // 컨텍스트 메뉴 사용 여부 (기본값 : false)
                useContextMenu : true,
                
                // 필터 사용 여부 (기본값 : false)
                enableFilter : true,
            
                // 그룹핑 패널 사용
                useGroupingPanel : false,
                
                
                // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
                displayTreeOpen : true,
                
                noDataMessage : "출력할 데이터가 없습니다.",
                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",

                // row Styling 함수
                rowStyleFunction : function(rowIndex, item) {
                    if(item.diffQty != 0) {
                        return "dataChange";
                    }
                    return "";                    
                }, 
        };
    
        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        
    }

    var columnLayout = [{
            dataField : "crudMode",
            visible:false
		},{
            dataField : "prmtAgenSeq",
            visible:false
		},{
            dataField : "prdSapCd",
			headerText : "제품코드",
			width : "6%",
		},{
			dataField : "prdNm",
			headerText : "제품명",
            style : "auiLeft",
        },{
			dataField : "freeYn",
			headerText : "유상여부",
            dataType : "numeric",
			width : "5%"		
		},{
			dataField : "faltQty",
			headerText : "입수량",
			width : "4.5%",
            style: "auiRight"
		},{
			dataField : "iddyOrdYn",
			headerText : "낱봉<br/>주문",
            width : "5%",                   
        },{
			dataField : "myQuantity",
			headerText : "내 입력수량",
                children : [{
                    dataField : "agenBoxQty",
                    headerText : "BOX",                    
                    width : "4%",
                    style: "auiRight",
                    editable : true,
                    dataType : "numeric",
                    editRenderer : {
                           type : "InputEditRenderer",
                           onlyNumeric : true, // 0~9 까지만 허용
    				},
                    renderer : {
                        type : "TemplateRenderer"
                    },
                    // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
                    labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                        var template = '<div class="my_div">';
                        template += '<span class="my_div_text_box center">' + value + '</span>';
                        template += '</div>';
                        return template;
                    }
                }, {
                    dataField : "agenIddyQty",
                    headerText : "낱봉",
                    width : "4%",
                    style: "auiRight",
                    editable : true,
                    dataType : "numeric",
                    editRenderer : {
                           type : "InputEditRenderer",
                           onlyNumeric : true, // 0~9 까지만 허용
    				},
                    renderer : {
                        type : "TemplateRenderer"
                    },
                    labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                    	var template = ''
                    	if(item.iddyOrdYn == '불가' || '<c:out value='${agenSaleCd}'/>' == 'SI')	// 시판일때는 낱봉 불필요
						{
                            template = ''
                        }else{
                        	template = '<div class="my_div">';
                            template += '<span class="my_div_text_box center">' + value + '</span>';
                            template += '</div>';
                        }
                        return template;
                    }
                }, {
                    dataField : "agenQty",
                    headerText : "총수량",
                    width : "3.5%",
                    style: "auiRight"
                
                }]
		},{
			dataField : "untpc",
			headerText : "매입단가",
			dataType : "numeric",
			width : "5%",
            style: "auiRight"
		},{
			dataField : "spprc",
			headerText : "공급가",
			visible:false
		},{
			dataField : "vatSpprc",
			headerText : "공급가(VAT)",
			visible:false                
        },{
			dataField : "orderTotal",
			headerText : "합계",
                children : [{
                    dataField : "totCt",
                    headerText : "금액",
					dataType : "numeric",
                    width : "6%",
                    style: "auiRight"
                }, {
                    dataField : "totVatCt",
                    headerText : "VAT",
					dataType : "numeric",
                    width : "6%",
                    style: "auiRight"
				}, {
                    dataField : "totAmount",
                    headerText : "計",
					dataType : "numeric",
                    width : "6%",
                    style: "auiRight"
                }]
        },{
            dataField : "hoffQty",
			headerText : "확정수량",
			width : "6%",
            style: "auiRight"
		},{
            dataField : "hoffAmount",
			headerText : "확정금액",
			dataType : "numeric",
			width : "6%",
            style: "auiRight"
        },{
            dataField : "diffQty",
			headerText : "차이수량<br/>(입력-확정)",
			width : "6%",
            style: "auiRight"
		},{
			dataField : "hoffDcsnDtm",
			headerText : "확정일자",
			dataType : "date",
			formatString : "yyyy-mm-dd",
			width : "8%",
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
            	var template = ''
            	if(value == null || value == '')
				{
                    template = ''
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
            dataField : "day",
            positionField : "day",
            operation : "SUM",
            colSpan : 5, // 자신을 포함하여 4개의 푸터를 가로 병합함.
            labelFunction : function(value, columnValues, footerValues) {
               // return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
               return "재고 : " 
            }
        }, {
            dataField : "agenQty",
            positionField : "agenQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }
        }, {
            dataField : "hoffQty",
            positionField : "hoffQty",
            operation : "SUM",
            style : "auiRight",
            colSpan : 1, 
            labelFunction : function(value, columnValues, footerValues) {
                return " " + AUIGrid.formatNumber(value, "#,##0");
            }

        }];

 	function fnSearchList(){
 		$("#lastSend").text('');
 		
		$.ajax({
			url : "/prmt/selectPrmtAgenRqstList.do", 
			type : 'POST', 
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#listCnt").text(data.cnt);
				if(data.lastSend != null){
					$("#lastSend").text(data.lastSend.agenOrdDtm);
				}
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}

 	function fnSearchRqstMonth(){
 	 	
		$.ajax({
			url : "/prmt/selectDvyfgRqstMonth.do", 
			type : 'POST', 
			data : $("#frm").serialize(),
			success : function(data) {
				if(data.list != null){
					$("#prmtRqstSeq").val(data.list.prmtRqstSeq);
					$("#dvyfgRqstMonth").val(data.list.dvyfgRqstMonth);
					$("#agenClsDt").val(data.list.agenClsDt);

					var selAgenClsDt = data.list.agenClsDt;
				    selAgenClsDt = new Date(selAgenClsDt.substring(0, 4), Number(selAgenClsDt.substring(4, 6)) -1, Number(selAgenClsDt.substring(6, 8)));

				    var now = new Date();
			 		var year = now.getFullYear();
			 		var today = new Date(year, Number(now.getMonth()), Number(now.getDate()), 0, 0, 0);

			 		if(today > selAgenClsDt){
			 			$("#saveBtn").attr("disabled",true);
						$("#sendBtn").attr("disabled",true);
					}else{
						$("#saveBtn").attr("disabled",false);
						$("#sendBtn").attr("disabled",false);						
					}
				}else{
					$("#prmtRqstSeq").val('');
					$("#dvyfgRqstMonth").val('');
					$("#agenClsDt").val('');

					$("#saveBtn").attr("disabled",true);
					$("#sendBtn").attr("disabled",true);
					layerAlert1('<spring:message code="alert.prmtAgenRqst5" />', popupTitle);
				}				
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}

 	function fnSaveprmtAgenRqst(){

		var saveData = new Array();
		var prmtRqstSeqValue = $("#prmtRqstSeq").val();
		
		$.each(AUIGrid.getGridData(myGridID), function(idx,item){	
			if((item.crudMode == 'M') 
					|| (item.agenBoxQty > 0 || item.agenIddyQty > 0))
			{
				// 추가, 수정할 데이터
				item.prmtRqstSeq = prmtRqstSeqValue;
				saveData.push(item);
			}	
		});
        
		if(!saveData.length > 0){
			layerAlert1('<spring:message code="alert.prmtAgenRqst4" />', popupTitle);
			return;
		}

		/* 저장 이벤트 호출시 날짜 체크 시작 */
		
		var now = new Date();
 		var year = now.getFullYear();
 		var month = ('0' + (now.getMonth() + 1)).slice(-2);
 		var nowYMFistDay = new Date(year, Number(now.getMonth()), 1);
 		var today = new Date(year, Number(now.getMonth()), Number(now.getDate()), 0, 0, 0);
 		
	    var selYm = $("#monthPicker").val().replaceAll("-","");
	    var selYmd = new Date(selYm.substring(0, 4), Number(selYm.substring(4, 6)) -1, 1);

	    var selAgenClsDt = $("#agenClsDt").val();
	    selAgenClsDt = new Date(selAgenClsDt.substring(0, 4), Number(selAgenClsDt.substring(4, 6)) -1, Number(selAgenClsDt.substring(6, 8)));

		/* 
	    // 현재 연월 요청만 저장/전송 가능함
		if($("#monthPicker").val().replace('-','') != (year+month)){
			alert("이전 연월은 반품등록 불가합니다.");
			return;
		}
		
		// 과거 연월은 저장/전송 불가하도록 체크
		if(selYmd < nowYMFistDay){
			alert("지난 월은 저장/전송 불가합니다.");
			return;
		}
		 */
		 		
		// 선택한 연월 체크 - 저장/전송이 가능한 연월인지 체크
		if($("#prmtRqstSeq").val() == ''){
			layerAlert1('<spring:message code="alert.prmtAgenRqst2" />', popupTitle);
			return;
		}

		/*
		// 저장/전송 가능한 날짜인지 체크 - 선택한 월의 최대 대리점주문일과 현재 날짜 비교하기
		if(today > selAgenClsDt){
			alert("저장/전송 가능일자가 경과되어 불가합니다.");
			return;
		}
		*/
		
		/* 저장 이벤트 호출시 날짜 체크 종료 */
		
		$.ajax({
			url : "/prmt/savePrmtAgenRqst.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(saveData),
			success : function(data) {
				layerAlert1('<spring:message code="alert.prmtAgenRqst1" />', popupTitle);
				fnSearchList();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	 	
	}

 	function fnSendprmtAgenRqst(){

		/* 전송 이벤트 호출시 날짜 체크 시작 */
		
		var now = new Date();
 		var year = now.getFullYear();
 		var month = ('0' + (now.getMonth() + 1)).slice(-2);
 		var nowYMFistDay = new Date(year, Number(now.getMonth()), 1);
 		var today = new Date(year, Number(now.getMonth()), Number(now.getDate()), 0, 0, 0);
 		
	    var selYm = $("#monthPicker").val().replaceAll("-","");
	    var selYmd = new Date(selYm.substring(0, 4), Number(selYm.substring(4, 6)) -1, 1);

	    var selAgenClsDt = $("#agenClsDt").val();
	    selAgenClsDt = new Date(selAgenClsDt.substring(0, 4), Number(selAgenClsDt.substring(4, 6)) -1, Number(selAgenClsDt.substring(6, 8)));

		/* 
	    // 현재 연월 요청만 저장/전송 가능함
		if($("#monthPicker").val().replace('-','') != (year+month)){
			alert("이전 연월은 반품등록 불가합니다.");
			return;
		}

		// 과거 연월은 저장/전송 불가하도록 체크
		if(selYmd < nowYMFistDay){
			alert("지난 월은 저장/전송 불가합니다.");
			return;
		}
		 */
		 
		// 선택한 연월 체크 - 저장/전송이 가능한 연월인지 체크
		if($("#prmtRqstSeq").val() == ''){
			layerAlert1('<spring:message code="alert.prmtAgenRqst2" />', popupTitle);
			return;
		}

		/*		 
		// 저장/전송 가능한 날짜인지 체크 - 선택한 월의 최대 대리점주문일과 현재 날짜 비교하기
		if(today > selAgenClsDt){
			alert("저장/전송 가능일자가 경과되어 불가합니다.");
			return;
		}
		*/
		
		/* 저장 이벤트 호출시 날짜 체크 종료 */
		
		// 저장된 데이터 존재 여부 조회
 		var savedYn = null;
 	 	$.ajax({
			url : "/agn/selectSavedYn.do",
			type : 'POST',
			data : $("#frm").serialize(),
			async:false,
			success : function(data) {
				savedYn = data;
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
		if(savedYn == 'N'){
			layerAlert1('<spring:message code="alert.prmtAgenRqst2" />', popupTitle);
			return;
		}
		
		$.ajax({
			url : "/prmt/sendPrmtAgenRqst.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {				
				//리스트 조회
				fnSearchList();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	 	
	}
	
 	
 	// 수량변경 계산 처리
 	function auiCellEditingHandler(event) {
		var item = event.item;

 		var faltQty =  0;		//입수량
     	var agenQtyBox = 0;		//대리점 주문 box
 		var agenQtyIddy = 0;	//대리점 주문 낱봉
 		var agenQty = 0;		//대리점 주문 총수량
 		var untpc = 0;			//단가
 		var totAmount = 0;		//합계
 		var totCt = 0;			//금액
 		var totVatCt = 0;		//VAT	
 		var spprc = 0;			//공급가
 		var vatSpprc = 0;		//공급가VAT
 		var hoffQtyBox = 0;		//본사 확정 box
 		var hoffQtyIddy = 0;	//본사 확정 낱봉
 		var hoffQty = 0;		//본사 확정 총수량
 		var diffQty = 0;		//차이수량

 		// box/낱봉 수량변경에 따른 총수량 변경  
 		if(event.dataField == "agenBoxQty" || event.dataField == "agenIddyQty")
 		{
 			agenQtyBox = (Number(item.agenBoxQty)) ? Number(item.agenBoxQty) : 0;		
 			agenQtyIddy = (Number(item.agenIddyQty)) ? Number(item.agenIddyQty) : 0;		
 			faltQty = ( Number(item.faltQty) ) ? Number(item.faltQty) : 0;				
 			agenQty = Number( (faltQty * agenQtyBox) + agenQtyIddy);

 			spprc = (Number(item.spprc) ) ? Number(item.spprc) : 0;
 			vatSpprc = (Number(item.vatSpprc) ) ? Number(item.vatSpprc) : 0;
 			
 			totCt = Number(agenQty * spprc);
 			totVatCt = Number(agenQty * vatSpprc);
 			totAmount = totCt + totVatCt;

 			hoffQtyBox = (Number(item.hoffBoxQty)) ? Number(item.hoffBoxQty) : 0;		
 			hoffQtyIddy = (Number(item.hoffIddyQty)) ? Number(item.hoffIddyQty) : 0;	
 			hoffQty = Number((faltQty * hoffQtyBox) + hoffQtyIddy);

 			diffQty = (agenQty - hoffQty);
 			
 			AUIGrid.updateRow(myGridID, {'agenQty': agenQty}, event.rowIndex);
 			AUIGrid.updateRow(myGridID, {'totCt': totCt}, event.rowIndex);
 			AUIGrid.updateRow(myGridID, {'totVatCt': totVatCt}, event.rowIndex);
 			AUIGrid.updateRow(myGridID, {'totAmount': totAmount}, event.rowIndex);
 			AUIGrid.updateRow(myGridID, {'diffQty': diffQty}, event.rowIndex);
 		}	
 	}

	function fnExcelDown(){
		AUIGrid.exportToXlsx(myGridID, {
		      // 스타일 상태 유지 여부(기본값:true)
		      exportWithStyle : true,
		      fileName : "판촉물 소요량 요청 관리"
		   });
	} 		
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />
	<form id="frm">
		<input type="hidden" name="prmtRqstSeq" id="prmtRqstSeq" value="${rqstMonth.prmtRqstSeq}">
		<input type="hidden" name="dvyfgRqstMonth" id="dvyfgRqstMonth" value="${rqstMonth.dvyfgRqstMonth}">
		<input type="hidden" name="agenClsDt" id="agenClsDt" value="${rqstMonth.agenClsDt}">	
		<!-- 조회 -->
		<div class="inquiryBox">
			<dl>
				<dt>납품요청월</dt>
				<dd>
					<div class="dateWrap">
						<input type="text" name="reqYm" value="" class="inp monthPicker" id="monthPicker" readonly>
						<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="monthPicker"></button>
					</div>
				</dd>
				<dt>판촉물</dt>
				<dd>
					<div class="formWrap">
						<input type="text" name="searchPrdCd" id="inp_name01" class="inp w120 mr10" value="" title="제품 입력" placeholder="제품코드"> 
						<input type="text" name="searchPrdNm" id="inp_name01" class="inp w160" value="" title="제품 입력" 	placeholder="제품명">
						<button type="button" name="selectBtn" class="comBtn" id="selectBtn">조회</button>
					</div>
				</dd>
			</dl>

			<div class="btnGroup right">
				<span class="mr20">최종 전송시각 :</span><span class="mr20" id="lastSend"></span>
				<button type="button" name="" class="comBtn" id="excelBtn">엑셀다운</button>
				<button type="button" name="" class="inquBtn" id="saveBtn">저장</button>
				<button type="button" name="" class="inquBtn" id="sendBtn">전송</button>
			</div>
		</div>
		<!-- 조회 -->
	</form>

	<div class="titleArea">
		<p class="numState">
			<em>총 <span class="pColor01 fb" id="listCnt"></span></em> 건 이 조회되었습니다.
		</p>
	</div>

	<!-- grid -->
	<div class="girdBox">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->

</div>
