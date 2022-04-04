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
    var pdRervPopGridID;
    var pageNm = "<c:out value='${param.pageNm}'/>";
    var gridData = [
        {"id":"#Cust01","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"월수금","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust02","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust03","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust04","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust05","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust06","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"월수금","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust07","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust08","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust09","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust10","prdNm":"GT프리미엄930","joinDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"}
    ];
    
	function createpdRervAUIGrid(){    	
        var columnLayout = [{
				dataField : "prdNm",
				headerText : "제품명",
	            style : "auiLeft"
	        },{
				dataField : "inptDt",
				headerText : "투입일",
	            width : "13%",
	        },{
				dataField : "untpc",
				headerText : "단가",
				width : "5%",
	            style : "auiRight"
	        },{
				dataField : "pttnStr",
				headerText : "패턴",
	            width : "10%"
			},{
				dataField : "monQty",
				headerText : "월",
	            width : "6.5%"
			},{
				dataField : "tueQty",
				headerText : "화",
	            width : "6.5%"
			},{
				dataField : "wedQty",
				headerText : "수",
	            width : "6.5%"
			},{
				dataField : "thuQty",
				headerText : "목",
	            width : "6.5%"
			},{
				dataField : "friQty",
				headerText : "금",
	            width : "6.5%"
			},{
				dataField : "satQty",
				headerText : "토",
	            width : "6.5%",
	            headerStyle : "hColor01",
			},{
				dataField : "sunQty",
				headerText : "일",
	            width : "6.5%",
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
			}
			
		];
        // 그리드 속성 설정
        var gridPros = {
                //headerHeight : 29,
                headerHeights : 30,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : true,
                autoGridHeight : true,
                // 체크박스 사용 
	            showRowCheckColumn : true,
                showRowNumColumn : false,                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,
                editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
                wrapSelectionMove : true,                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "singleRow",
                showFooter :  false,                
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
                rowCheckColumnWidth : 60,
                
        };
    
        if(AUIGrid.isCreated(pdRervPopGridID)){
        	AUIGrid.destroy(pdRervPopGridID);        	
        }    
        // 실제로 #grid_wrap 에 그리드 생성
        pdRervPopGridID = AUIGrid.create("#pdRervPop_grid_wrap", columnLayout, gridPros);
    }
   
    $(document).ready(function(){
    	$("#pdRervCloseBtn").on("click", function(){
        	$.closeDialog("<c:out value='${param.id}'/>");
        });
    	
    	if(pageNm == 'pdRervPop'){
    		
    		$("#srhRow1").hide();
    		$("#srhRow2").show();
    		$("#popTitleNm").val("기간보류");
    	}else{
    		$("#srhRow1").show();
    		$("#srhRow2").hide(); 
    		$("#popTitleNm").val("일시중지");
    	}
    	
        // AUIGrid 생성 후 반환 ID
        createpdRervAUIGrid();
        
        setDaterangepicker();
        getpdRervList();
        
        $("#btnSetPdRervDate").on("click", function(){
        	setPdRervDate();
      	});
        
        $("#btnSavePdRerv").on("click", function(){
        	savePdRerv();
      	});
        
        
    });
    
    function savePdRerv(){
    	
    	var checkRowItem = AUIGrid.getCheckedRowItems(pdRervPopGridID);
    	var statDt = $("#statDt").val().replace(/(-)/g, "");;
    	var endDt = $("#endDt").val().replace(/(-)/g, "");;
    	
    	if(checkRowItem.length ==0){    		
    		layerAlert1('<spring:message code="alert.noSelect" arguments="${\'제품\'}" />');
    		return false;
    	}
    	
    	var paramList = [];
    	$.each(checkRowItem, function(index, row){
    		
    		var item = row.item;
    		
    		if(pageNm == 'pdRervPop'){        		
    			item.endDt = endDt;
    			item.chgSecCd = "RERV";
        	}else{
        		item.chgSecCd = "POSE";
        	}
    		
    		item.statDt = statDt;    		  		
    		item.prtDt = $("#prtDt").val().replace(/(-)/g, "");
    		
    		
    		if($('#prtYn').is(':checked')){    			
    			item.prtYn = "N";	
    		}else{
    			item.prtYn = "Y";    			
    		}
    		
    		paramList.push(item);
    	});
    	
    	console.log("JSON.stringify(checkRowItem)  ::" + JSON.stringify(paramList));
    	
    	$.ajax({
		   	contentType: 'application/json',
			url : "/cst/savePdRervPop.do", 
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
    }
    
    function setPdRervDate(){
    	
    	var statDt = $("#statDt").val();
    	var endDt = $("#endDt").val();
    	
    	console.log("setPdRervDate statDt  : " + statDt + ", :: " + endDt);
    	
    	if(fnIsEmpty($("#pdRervDate").val())){
    		
    		var time = new Date(endDt).getTime() - new Date(statDt).getTime();
    		var pdRervDate = time / (1000 * 3600 *24);
    		$("#pdRervDate").val(pdRervDate);
    		
    	}else{
    		
    		let date = new Date(statDt);
			date.setDate(date.getDate() + Number($("#pdRervDate").val()) );
			$('#endDt').data('daterangepicker').setStartDate(date);
    	}
    }
    
    function getpdRervList(){
    	
    	let targetCstSeq = $("#targetCstSeq").val();
    	
    	$.ajax({
			url : "/cst/selectCstPrmtList.do", 
			type : 'POST', 
			data : {"cstSeq": targetCstSeq},
			success : function(data) {
				AUIGrid.setGridData(pdRervPopGridID, data);
				//$("#areaCstCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 
    }
   
    // AUIGrid 를 생성합니다.
    


</script>
<body>
<!-- 실제 개발시 style 모두 지워주세요 (style 퍼블용 preview 입니다.) - 가로사이즈 1500px -->

    <div class="modal_bg" ></div> <!-- modal 배경 -->

       <!-- 기간 보류 -->
       <div class="popWrap large modal_wrap h644" data-popup="modalAgencyViews">
           <header>
               <h3 id="popTitleNm">기간 보류</h3>
           </header>  

           <!-- popCon -->
           <div class="popCon">
               <div class="popTitArea">
                   <h3>기간 보류</h3>
       
                   <div class="popBtnArea">
                       <button type="button" name="" class="comBtn" id="pdRervCloseBtn">닫기</button>                   
                       <button type="button" name="" class="inquBtn" id="btnSavePdRerv">저장</button>
                   </div>
               </div>

               <div class="conBox mt5">
               
					<form name="pdRervFrm" id="pdRervFrm">
                   <!-- 적용 일정 -->
                   <div class="tblWrap">
                       <div class="titleArea right">
                           <h3 class="tit01">적용 일정</h3>
                           <p class="txt01"><i class="icoRequir"></i>필수 입력 항목입니다.</p>
                       </div>
                       
                       <table class="tbl">
                           <caption>적용 일정</caption>
                           <colgroup>
                               <col style="width:164px;">
                               <col>
                               <col style="width:164px;">
                               <col>
                           </colgroup>
                           <tbody>
								<tr id="srhRow1">
                                
	                                <th>
	                                    <label for="datepicker" class="required" title="필수입력">중지사유</label>
	                                </th>
	                                <td colspan="3">
	                                    <select name="" class="sel w160" id="inp_prDt" value="직원명">
	                                            <option selected="">선택</option>
	                                            <option>기타</option>
	                                            <option>다른동 이사</option>
	                                            <option>재계약</option>
	                                        </select>
	                                </td>
                            	</tr>
                               <tr>
                                   <th scope="row">
                                       <label for="datepicker" class="required" title="필수입력">시작일자</label>
                                   </th>
                                   <td>
                                       <div class="formWrap">
                                           <div class="dateWrap">
                                               <input type="text" name="statDt" value="10/24/1984" class="inp w160 datepicker" id="statDt" readonly="">
                                               <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="statDt"></button>
                                           </div>
                                       </div>
                                   </td>
                                   <th scope="row">
                                       <label for="datepicker" class="required" title="필수입력">출력일자</label>
                                   </th>
                                   <td>
                                       <div class="formWrap" style="justify-content: flex-start; align-items: center;">
                                           <div class="dateWrap">
                                               <input type="text" name="prtDt" value="10/24/1984" class="inp w160 datepicker" id="prtDt" readonly="">
                                               <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="prtDt"></button>
                                           </div>
                                           <div class="checkGroup ml20">
                                               <input type="checkbox" id="prtYn" class="type01"><label for="prtYn"><span>출고증 인쇄 안함</span></label>
                                           </div>
                                       </div>
                                   </td>
                               </tr>
                               <tr id="srhRow2">
                                   <th scope="row">
                                       <label for="datepicker03" class="required" title="필수입력">종료일자</label>
                                   </th>
                                   <td colspan="3">
                                       <div class="formWrap jStart alignCenter">
                                           <div class="dateWrap">
                                               <input type="text" name="endDt" value="10/24/1984" class="inp w160 datepicker" id="endDt" readonly="">
                                               <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="endDt"></button>
                                           </div>
                                           <input type="text" id="pdRervDate" class="inp w160 ml30" value="" name="pdRervDate">
                                           <span class="ml5 mr20 vaMd">일간</span>
                                           <button type="button" name="" class="comBtn small" id="btnSetPdRervDate">적용</button>                                           
                                       </div>
                                   </td>
                               </tr>
                           </tbody>
                       </table>
                   </div>
                   </form>
                   <!--// 적용 일정 -->
               </div>

               <div class="titleArea">
                   <h3 class="tit01">계약 정보</h3>
               </div>
               
               <!-- grid -->
               <div class="girdBox">
                   <div id="pdRervPop_grid_wrap"></div>
               </div>
               <!-- grid -->

           </div>
           <!-- popCon -->
       </div>
       <!--// 기간 보류 -->
    
</body>
</html>