<!-- 
	@File Name: prmtAgenMng.jsp
	@File 설명 : 판촉물 입고 관리
	@UI ID : UI-PPRO-0201.html
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
    var selRowIndex;
    var addedRowCount = 0;
	var popupTitle = '판촉물 입고 관리';
    
   	$(document).ready(function(){

   	    createAUIGrid(columnLayout);

        fnSearchList();

        //바인딩
        $("#selectBtn").on("click", fnSearchList);
        $("#addRowBtn").on("click", addRow);        

        let popupObjRemRow = {};
        popupObjRemRow.title = popupTitle;
        popupObjRemRow.message = '<spring:message code="alert.prmtAgenMng3" />';        
        popupObjRemRow.showBtn1 = 'Y';
        popupObjRemRow.btn1Func = removeRow;        
        popupObjRemRow.showBtn2 = 'Y';        
        $("#removeRowBtn").on("click", popupObjRemRow, layerAlert);
        
        $("#saveBtn").on("click", fnSavePrmtAgenMng);
        $("#excelBtn").on("click", fnExcelDown);
        AUIGrid.bind(myGridID, "cellEditEnd", auiCellEditingHandler);

        AUIGrid.bind(myGridID, "cellClick", function(event) {
			if((event.dataField == "prdCd" || event.dataField == "prdNm") 
					&& (event.item.prmtAgenSeq == 0)
					&& (event.item.crudMode == "C"))
			{
				selRowIndex = event.rowIndex;
				fnprmtRegPop();
			}
		});
   	});
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid(columnLayout) {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 29,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : true,

				rowIdField : "rnum",
				showRowCheckColumn : true, // 체크박스 사용 
				wrapSelectionMove : true,
				editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
                
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
                    if(item.prmtAgenMngSeq != 0 && item.diffQty != 0) {
                        return "dataChange";
                    }
                    return "";                    
                }, 

        		// 엑스트라 체크박스 disabled 함수
        		rowCheckDisabledFunction : function(rowIndex, isChecked, item) {
        			if(item.othComPrmtSeq == "0") {	// 행추가로 추가된 행만 삭제가능하도록 체크박스 활성화여부 처리
        				return false; // false 반환하면 disabled 처리됨
        			}
        			return true;
        		},
                
                // 삭제 행 표시 기능 없이 삭제와 동시에 그리드에서 제거할때 (기본값:true)
                softRemoveRowMode: false,
                
                /*********************************/ 
                /* 행삭제할때 체크박스 사용 관련 추가 시작 */
                /*********************************/

         		// 엑스트라 체크박스 표시 설정
         		showRowCheckColumn : true,
         		
         		// 엑스트라 체크박스에 shiftKey + 클릭으로 다중 선택 할지 여부 (기본값 : false)
         		//enableRowCheckShiftKey : true,
         		
         		// 전체 체크박스 표시 설정
         		showRowAllCheckBox : true, 

         		/*********************************/
         		/* 행삭제할때 체크박스 사용 관련 추가 종료 */
         		/*********************************/
        };
    
        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        
    }

    var columnLayout = [
        {
			dataField : "crudMode",
			visible:false
		}, {
			dataField : "prmtAgenSeq",
			visible:false
		}, {
			dataField : "prmtAgenMngSeq",
			visible:false
		}, {
			dataField : "puchSeq",
			visible:false
		}, {
			dataField : "prdSeq",
			visible:false			
		}, {
			dataField : "othComPrmtSeq",
			visible:false
		}, {
			dataField : "prdDtlSeq",
			visible:false
		}, {
            dataField : "prdCd",
			headerText : "제품코드",
			width : "6%",
			renderer : { // HTML 템플릿 렌더러 사용
			    type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
                if(item.prdCd){
                    var template = item.prdCd;
                }else{
                    var template = '<div class="searchWrap">';
                    template += '<span class="my_div_text_box"><a href="#" class="serach"></a></span>';
                    template += '</div>';
                }
                return template;
            }
		},{
			dataField : "prdNm",
			headerText : "제품명",
            style : "auiLeft",
			renderer : {
			    type : "TemplateRenderer"
            },
            labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
                if(item.prdNm){
                    var template = item.prdNm
                }else{
                    var template = '<div class="searchWrap">';
                    template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews"></a></span>';
                    template += '</div>';
                }
                return template;
            }
		},{
			dataField : "freeYn",
			headerText : "유상여부",
            dataType : "numeric",
			width : "5%"
		},{
			dataField : "faltQty",
			headerText : "입수량",
			width : "5%",
            style: "auiRight"
		},{
			dataField : "iddyOrdYn",
			headerText : "낱봉<br/>주문",
            width : "5%",
        },{
			dataField : "agenQty",
			headerText : "요청<br/>수량",
            width : "5%",
            style: "auiRight"
        },{
			dataField : "hoffQty",
			headerText : "확정<br/>수량",
            width : "5%",
            style: "auiRight"
        },{
			dataField : "myQuantity",
			headerText : "내 입력수량",
                children : [{
                    dataField : "wrhsBoxQty",
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
                    dataField : "wrhsIddyQty",
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
                    	var template = '';
                        if(item.iddyOrdYn == '불가'){
                            template = '';
                        }else{
                        	template = '<div class="my_div">';
                            template += '<span class="my_div_text_box center">' + value + '</span>';
                            template += '</div>';
                        }
                        return template;
                    }
                }, {
                    dataField : "wrhsQty",
                    headerText : "총수량",
                    width : "3.5%",
                    style: "auiRight"
                
                }]
		},{
			dataField : "untpc",
			headerText : "매입단가",
			dataType : "numeric",
			formatString : "#,###",
			width : "5%",
            style: "auiRight"
        },{
			dataField : "orderTotal",
			headerText : "합계",
                children : [{
                    dataField : "totCt",
                    headerText : "금액",
					dataType : "numeric",
					formatString : "#,###",
                    width : "6%",
                    style: "auiRight"
                }, {
                    dataField : "totVatCt",
                    headerText : "VAT",
					dataType : "numeric",
					formatString : "#,###",
                    width : "6%",
                    style: "auiRight"
				}, {
                    dataField : "totAmount",
                    headerText : "計",
					dataType : "numeric",
					formatString : "#,###",
                    width : "6%",
                    style: "auiRight"
                }]
        },{
            dataField : "diffQty",
			headerText : "차이수량<br/>(입력-확정)",
			width : "6%",
            style: "auiRight"
		},{
			dataField : "wrhsDt",
			headerText : "입고일자",
			editable : true,
            style: "auiLeft",
			width : "8%",
			dataType : "date",
			dateInputFormat : "yyyymmdd", // 실제 데이터의 형식 지정
			formatString : "yyyy - mm - dd", // 실제 데이터 형식을 어떻게 표시할지 지정
			renderer : {
				type : "IconRenderer",
				iconWidth : 24, // icon 사이즈, 지정하지 않으면 rowHeight에 맞게 기본값 적용됨
				iconHeight : 24,
				iconPosition : "aisleRight",
				iconTableRef :  { // icon 값 참조할 테이블 레퍼런스
					"default" : "../images/AUIGrid/calendar-icon.png" // default
				},
				onClick : function(event) {
					// 달력 아이콘 클릭하면 실제로 달력을 띄움.
					// 즉, 수정으로 진입함.
					AUIGrid.openInputer(event.pid);
				}
			},
			editRenderer : {
				type : "CalendarRenderer",
				defaultFormat : "yyyymmdd", // 달력 선택 시 데이터에 적용되는 날짜 형식
				showEditorBtn : false,
				showEditorBtnOver : false, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			}
		}
	];


 	function fnSearchList(){

 		$.ajax({
			url : "/prmt/selectPrmtAgenMngList.do", 
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

	function fnExcelDown(){
		AUIGrid.exportToXlsx(myGridID, {
		      // 스타일 상태 유지 여부(기본값:true)
		      exportWithStyle : true,
		      fileName : "판촉물 입고 관리"
		   });
	} 

    //행추가
    function addRow(rowPos) {

		if(addedRowCount > 4)
		{
			layerAlert1('<spring:message code="alert.commMsgRowAddLimit" />', popupTitle);
			return;
		}
        
        var item = new Object();
        item.crudMode = "C";
        item.prmtAgenSeq = 0;
        item.wrhsDt = fnGetToDay().replaceAll('-', '');
        AUIGrid.addRow(myGridID, item, rowPos);		
        addedRowCount++;
    }
    
    // 행 삭제
    function removeRow() {

		var checkedItems = AUIGrid.getCheckedRowItems(myGridID);
		if(checkedItems.length <= 0) {
			// 체크박스 선택여부 확인하기
			layerAlert1('<spring:message code="alert.prmtAgenMng2" />', popupTitle);
		}

		var rowItem;
		for(var i=checkedItems.length-1; i>=0; i--) {
			rowItem = checkedItems[i];
			AUIGrid.removeRow(myGridID, rowItem.rowIndex);
		}
    }
    
	function fnSavePrmtAgenMng(){

		var dateChkErr = 0;
		
		var now = new Date();	// 현재 날짜 및 시간
		var oneMonthAgo = new Date(now.setMonth(now.getMonth() - 1));	// 한달 전

		var saveData = new Array();
		$.each(AUIGrid.getGridData(myGridID), function(idx,item){	
			// 추가, 수정할 데이터
			var wrhsDt = null;

			if(item.wrhsDt == null){
				wrhsDt = fnGetToDay().replaceAll('-', '');
				item.wrhsDt = wrhsDt;
			} else {
				wrhsDt = item.wrhsDt;
			}	
			wrhsDt = new Date(wrhsDt.substring(0, 4), Number(wrhsDt.substring(4, 6)) -1, wrhsDt.substring(6, 8), 0, 0, 0);
			
			//입고일자가 현재일자에서 1개월이내가 아닐 경우 저장불가함
			if(wrhsDt < oneMonthAgo){
				dateChkErr++;
				return false;
			}

			item.reqYm = $("#monthPicker").val().replaceAll('-', '');
			item.freeYn = (item.freeYn == '무상'? 'Y' : 'N');
			item.iddyOrdYn = (item.iddyOrdYn == '가능'? 'Y' : 'N');
			item.wrhsBoxQty = (item.wrhsBoxQty == null ? 0 : item.wrhsBoxQty);
			item.wrhsIddyQty = (item.wrhsIddyQty == null ? 0 : item.wrhsIddyQty);
			saveData.push(item);				
		});

		if(dateChkErr > 0){
			layerAlert1('<spring:message code="alert.prmtAgenMng4" />', popupTitle);
			return;
		}

        $.each(AUIGrid.getRemovedItems(myGridID), function(idx,item){	
			// 삭제할 데이터
			item.crudMode = "D";
			item.reqYm = $("#monthPicker").val().replaceAll('-', '');
			saveData.push(item);
		});

        /*
		if(!saveData.length > 0){
			alert("저장정보가 없습니다.\r\n다시 확인해 주세요.");
			return;
		}
		*/
		
		$.ajax({
			url : "/prmt/savePrmtAgenMng.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(saveData),
			success : function(data) {
				//리스트 조회
				fnSearchList();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 
	}
	
	function auiCellEditingHandler(event){
		/* if(event.type == "cellEditEnd") { */
			var item = event.item;

	 		var faltQty =  0;		//입수량
	     	var wrhsBoxQty = 0;		//대리점 입고 box
	 		var wrhsIddyQty = 0;	//대리점 입고 낱봉
	 		var wrhsQty = 0;		//대리점 입고 총수량
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
	 		if(event.dataField == "wrhsBoxQty" || event.dataField == "wrhsIddyQty")
	 		{
	 			wrhsBoxQty = (Number(item.wrhsBoxQty)) ? Number(item.wrhsBoxQty) : 0;		
	 			wrhsIddyQty = (Number(item.wrhsIddyQty)) ? Number(item.wrhsIddyQty) : 0;		
	 			faltQty = ( Number(item.faltQty) ) ? Number(item.faltQty) : 0;				
	 			wrhsQty = Number( (faltQty * wrhsBoxQty) + wrhsIddyQty);

	 			spprc = (Number(item.spprc) ) ? Number(item.spprc) : 0;
	 			vatSpprc = (Number(item.vatSpprc) ) ? Number(item.vatSpprc) : 0;
	 			
	 			totCt = Number(wrhsQty * spprc);
	 			totVatCt = Number(wrhsQty * vatSpprc);
	 			totAmount = totCt + totVatCt;

	 			hoffQty = (Number(item.hoffQty)) ? Number(item.hoffQty) : 0;

	 			diffQty = (wrhsQty - hoffQty);
	 			
	 			AUIGrid.updateRow(myGridID, {'wrhsQty': wrhsQty}, event.rowIndex);
	 			AUIGrid.updateRow(myGridID, {'totCt': totCt}, event.rowIndex);
	 			AUIGrid.updateRow(myGridID, {'totVatCt': totVatCt}, event.rowIndex);
	 			AUIGrid.updateRow(myGridID, {'totAmount': totAmount}, event.rowIndex);
	 			AUIGrid.updateRow(myGridID, {'diffQty': diffQty}, event.rowIndex);
	 		}
		/* } */
	}

	//판촉물 등록 팝업
   	function fnprmtRegPop(){
		$.ajaxDialog({
			id: "prmtRegPop",
			ajax: {
				url: "/prmt/prmtRegPop.do",
			},
			success: function(data) {
				fnSetRowData(data);
			},			
			dialog: {
				width:800,
				height:560
			}
		});
	}

	function fnSetRowData(gridData){
		var iCnt = 0;

 		// 행추가-선택한 제품이 기존 그리드에 존재하는지 체크하기
		$.each(AUIGrid.getGridData(myGridID), function(idx,item){
			if(item.prdDtlSeq == gridData.prdDtlSeq){
				iCnt++;
			}
		});

		if(iCnt > 0){
			layerAlert1('<spring:message code="alert.prmtAgenMng1" />', popupTitle);
		}else{
			var item = new Object();
			item = {
						'puchSeq': gridData.puchSeq
						, 'prdSeq': gridData.prdSeq
						, 'prdDtlSeq': gridData.prdDtlSeq
						, 'prdCd': gridData.prdDtlCd
						, 'prdNm': gridData.prdNm
						, 'freeYn': gridData.freeYn
						, 'faltQty': gridData.faltQty
						, 'iddyOrdYn': gridData.iddyOrdYn
						, 'totCt': 0
						, 'totVatCt': 0
						, 'totAmount': 0
						, 'untpc': gridData.untpc
						, 'spprc': gridData.spprc
						, 'vatSpprc': gridData.vatSpprc
					};
			AUIGrid.updateRow(myGridID, item, selRowIndex);
		}
	}			
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />
	<form id="frm">
		<!-- 조회 -->
		<div class="inquiryBox">
			<dl>
				<dt>납품요청월</dt>
				<dd>
					<div class="dateWrap">
						<input type="text" name="reqYm" value="" class="inp monthPicker"	id="monthPicker" readonly>
						<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="monthPicker"></button>
					</div>
				</dd>
				<dt>판촉물</dt>
				<dd>
					<div class="formWrap">
						<input type="text" name="searchPrdCd" id="inp_name01" class="inp w120 mr10" value="" title="제품 입력" placeholder="제품코드"> 
						<input type="text" name="searchPrdNm" id="inp_name01" class="inp w160" value="" title="제품 입력" placeholder="제품명">
						<button type="button" name="" class="comBtn" id="selectBtn">조회</button>
					</div>
				</dd>
			</dl>

			<div class="btnGroup right">
				<button type="button" name="" class="comBtn small" id="addRowBtn">행추가</button>
            	<button type="button" name="" class="comBtn small" id="removeRowBtn">행삭제</button>
				<button type="button" name="" class="comBtn" id="excelBtn">엑셀다운</button>
				<button type="button" name="" class="inquBtn" id="saveBtn">저장</button>
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
