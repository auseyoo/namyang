<!-- 
	@File Name: 
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 2. 22.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
    $(function(){	
        $('.modal_wrap').on('.open', function(e){
            //-- 그리드 생성되지 않았다면...생성하기
            if(!AUIGrid.isCreated('#grid_wrap2')) {
                var $body = $('.modal_wrap .popCon');
                createAUIGrid('#grid_wrap2', $body.width(), 300);
            }
            
            // 데이터 요청
            requestData("./data/schedule_tree.json");
        });
    });

    var cntrEndGridID;
    var targetCstSeq = '${param.targetCstSeq}';
    var gridData = [
        {"id":"#Cust01","prdNm":"GT프리지엄930","joinDt":"2021-01-03","endDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"월수금","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust02","prdNm":"깜유홈900ml","joinDt":"2021-01-03","endDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust03","prdNm":"GT프리지엄930","joinDt":"2021-01-03","endDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"월수금","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust03","prdNm":"GT프리지엄930","joinDt":"2021-01-03","endDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"월수금","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust03","prdNm":"GT프리지엄930","joinDt":"2021-01-03","endDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"월수금","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
    ];
   
    // AUIGrid 를 생성합니다.
    function createCntrEndAUIGrid() {
        var columnLayout = [{
				dataField : "prdNm",
				headerText : "제품명",
	            style : "auiLeft",
	            editable: false,
	        },{
				dataField : "inptDt",
				headerText : "투입일",
	            editable: false,
	            width : "10%",
	        },{
				dataField : "cntrEndDt",
				headerText : "종료일",
	            dataType : "date",
	            width : "10%",
	            dataType : "date",
                dateInputFormat : "yyyy-mm-dd", // 실제 데이터의 형식 지정
                formatString : "yyyy-mm-dd", // 실제 데이터 형식을 어떻게 표시할지 지정
                renderer : {
                    type : "IconRenderer",
                    iconWidth : 24, 
                    iconHeight : 24,
                    iconPosition : "aisleRight",
                    iconTableRef :  { 
                        "default" : "/images/AUIGrid/calendar-icon.png"
                    },
                    onClick : function(event) {
                        AUIGrid.openInputer(event.pid);
                    }
                },
                editRenderer : {
                    type : "CalendarRenderer",
                    defaultFormat : "yyyy-mm-dd", // 달력 선택 시 데이터에 적용되는 날짜 형식
                    showEditorBtn : false,
                    showEditorBtnOver : false, // 마우스 오버 시 에디터버턴 출력 여부
                    onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
                    showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
                }
	        },{
				dataField : "untpc",
				headerText : "단가",
				width : "5%",
	            style : "auiRight",
	            editable: false,
	        },{
				dataField : "pttnStr",
				headerText : "패턴",
	            width : "10%",
	            editable: false,
			},{
				dataField : "monQty",
				headerText : "월",
	            width : "6%",
	            editable: false,
			},{
				dataField : "tueQty",
				headerText : "화",
	            width : "6%",
	            editable: false,
			},{
				dataField : "wedQty",
				headerText : "수",
	            width : "6%",
	            editable: false,
			},{
				dataField : "thuQty",
				headerText : "목",
	            width : "6%",
	            editable: false,
			},{
				dataField : "friQty",
				headerText : "금",
	            width : "6%",
	            editable: false,
			},{
				dataField : "satQty",
				headerText : "토",
	            width : "6%",
	            editable: false,
	            headerStyle : "hColor01",
			},{
				dataField : "sunQty",
				headerText : "일",
	            width : "6%",
	            editable: false,
	            headerStyle : "hColor02",         
			},{
				dataField : "cstPrdSeq",
				headerText : "일",
				visible: false	                     
			},{
				dataField : "cstSeq",
				headerText : "일",
				visible: false	                     
			},{
				dataField : "prdDtlSeq",
				headerText : "일",
				visible: false	               
			},{
				dataField : "areaSeq",
				headerText : "일",
				visible: false	                     
			},{
				dataField : "puchSeq",
				headerText : "일",
				visible: false	               
			},{
				dataField : "agenSeq",
				headerText : "일",
				visible: false	               
			},{
				dataField : "endDt",
				headerText : "일",
				visible: false	               
			}
		];
    	
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 30,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : true,                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "multipleCells",
                // 컨텍스트 메뉴 사용 여부 (기본값 : false)
                useContextMenu : true,                
                // 필터 사용 여부 (기본값 : false)
                enableFilter : true,            
                // 그룹핑 패널 사용
                useGroupingPanel : false,
                // 체크박스 사용 
	            showRowCheckColumn : true,
                // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
                displayTreeOpen : true,                
                noDataMessage : "출력할 데이터가 없습니다.",                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
                showRowNumColumn : false,
                
        };
        
        if(AUIGrid.isCreated(cntrEndGridID)){
        	AUIGrid.destroy(cntrEndGridID);        	
        }  

        // 실제로 #grid_wrap 에 그리드 생성
        cntrEndGridID = AUIGrid.create("#cntrEndPop_grid_wrap", columnLayout, gridPros);
    }

    $(document).ready(function(){
    	$("#cntrEndCloseBtn").on("click", function(){
        	$.closeDialog("<c:out value='${param.id}'/>");
        });
    	
    	console.log("CNTR_END START ");
        createCntrEndAUIGrid();        
        getCstPrdList();
        
    	$("#btnSaveCntrEnd").on("click", function(){
    		saveCntrEndPop();
        });
        
        
    });

    
    function getCstPrdList(){
    	
    	//let targetCstSeq = $("#targetCstSeq").val();
    	
    	$.ajax({
			url : "/cst/selectCstPrmtList.do", 
			type : 'POST', 
			data : {"cstSeq": targetCstSeq},
			success : function(data) {
				AUIGrid.setGridData(cntrEndGridID, data);
				//$("#areaCstCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 
    }

    function saveCntrEndPop(){
    	
    	var checkRowItem = AUIGrid.getCheckedRowItems(cntrEndGridID);
    	    	    	
    	if(checkRowItem.length ==0){    		
    		layerAlert1('<spring:message code="alert.noSelect" arguments="${\'제품\'}" />');
    		return false;
    	}
    	
    	var paramList = [];
    	var errorMsg = '<spring:message code="alert.cstMng13" />';
    	$.each(checkRowItem, function(index, row){
    		
    		var item = row.item;
    		
    		item.cntrEndDt = item.cntrEndDt.replace(/(-)/g, "");
    		
    		var cntrEndDt = item.cntrEndDt;
    		var endDt = item.endDt;
    		var toDay = fnGetToDay().replace(/(-)/g, "");
    		
    		console.log("toDay ::" + toDay + ",  : " + endDt + ", :: " + cntrEndDt);
    		
   			if(toDay > cntrEndDt){
   				errorMsg = '<spring:message code="alert.cstMng14" />';
   				paramList = [];
   				return false;
   			}else if(cntrEndDt > endDt){
   				
   				var textEndDt = fnConvertDate2(endDt);
   				
   				//errorMsg = '<spring:message code="alert.cstMng15" />';
   				//errorMsg = errorMsg.replace("{0}", textEndDt);
   				
   				errorMsg = "<spring:message code='alert.cstMng15' arguments=" + textEndDt +" />";
   				
   				paramList = [];
   				return false;
   			}else{
    			paramList.push(item);	
    		}    		
    		
    	});
    	
    	console.log("JSON.stringify(checkRowItem)  ::" + JSON.stringify(paramList));
    	
    	if(paramList.length > 0 ){
    		$.ajax({
    		   	contentType: 'application/json',
    			url : "/cst/saveCntrEndPop.do", 
    			type : 'POST', 
    			data : JSON.stringify(paramList),
    			//dataType:"json",
    			success : function(data) {
    				
    				console.log('save : ' + data );
    				if(!fnIsEmpty(data.success) && data.success){					
    					layerAlert1('<spring:message code="alert.save" />');	
    				}else{
    					layerAlert1('<spring:message code="alert.admin" />');
    					
    				}
    				$.closeDialog("<c:out value='${param.id}'/>");
    				
    			}, // success 
    			error : function(xhr, status) {
    				alert(xhr + " : " + status);
    			}
    		});
    	}else{
    		if(checkRowItem.length > 1){
    			layerAlert1('<spring:message code="alert.cstMng13" />');
    		}else{
    			
    			layerAlert1(errorMsg);
    		}
    		
    	}
    	
    }

</script>
<body>
    <!-- 
    <div class="modal_bg" ></div> <!-- modal 배경 -->
 	<!-- 계약종료 -->
        <div class="popWrap large modal_wrap h520" data-popup="modalAgencyViews">
            <header>
                <h3>계약종료</h3>
            </header>  

            <!-- popCon -->
            <div class="popCon">
                <div class="popTitArea">
                    <h3 class="pb10">계약종료</h3>
        
                    <div class="popBtnArea">
                        <button type="button" name="" class="comBtn" id="cntrEndCloseBtn">닫기</button>
                        <button type="button" name="" class="inquBtn" id="btnSaveCntrEnd">저장</button>
                    </div>
                </div>
                <div class="titleArea right mt5">
                    <h3 class="tit01">계약 정보</h3>       
                    <p class="txt01">* 계약종료할 제품의 종료일을 입력하세요.</p>
                </div>

                <!-- grid -->
                <div class="girdBox">                
                    <div id="cntrEndPop_grid_wrap"></div>
                </div>
                <!-- grid -->
            </div>
            <!-- popCon -->
        </div>
        <!--// 계약종료 -->
</body>
</html>