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
    
    var myPopGridID5;
    var myPopGridID6;
    
    var parentWinNm = '${param.parentWinNm}';
    var freeDsctData = '${param.freeDsctData}';
    var targetCstSeq = '${param.targetCstSeq}';
        
    var columnLayoutPop5 = [{
		dataField : "prdNm",
		headerText : "제품명",            
        style : "auiLeft",
        editable : false,
    },{
		dataField : "statDt",
		headerText : "투입일",
        editable : false,
        width : "10%",
    },{
		dataField : "untpc",
		headerText : "기존단가",
		width : "5%",
        style : "auiRight",
        editable : false,
    },{
		dataField : "applUntpc",
		headerText : "적용단가",
		width : "5%",
        style : "auiRight",
        editable : true,
    },{
		dataField : "dayTotQty",
		headerText : "수량",
        width : "10%",
        editable : false,
	},{
		dataField : "pttnStr",
		headerText : "패턴",
        width : "10%",
        editable : false,
	},{
		dataField : "monQty",
		headerText : "월",
        width : "5%",
        editable : false,
	},{
		dataField : "tueQty",
		headerText : "화",
        width : "5%",
        editable : false,
	},{
		dataField : "wedQty",
		headerText : "수",
        width : "5%",
        editable : false,
	},{
		dataField : "thuQty",
		headerText : "목",
        width : "5%",
        editable : false,
	},{
		dataField : "friQty",
		headerText : "금",
        width : "5%",
        editable : false,
	},{
		dataField : "satQty",
		headerText : "토",
        width : "5%",
        headerStyle : "hColor01",
        editable : false,
	},{
		dataField : "sunQty",
		headerText : "일",
        width : "5%",
        headerStyle : "hColor02",
        editable : false,         
	},{
		dataField : "cstPrdSeq",
		headerText : "일",        
        visible: false         
	},{
		dataField : "areaSeq",
		headerText : "일",        
        visible: false         
	},{
		dataField : "cstSeq",
		headerText : "일",        
        visible: false         
	},{
		dataField : "prdSeq",
		headerText : "일",        
        visible: false         
	},{
		dataField : "applDt",
		headerText : "일",        
        visible: false         
	},{
		dataField : "endDt",
		headerText : "일",        
        visible: false         
	},{
		dataField : "prmtSecCd",
		headerText : "일",        
        visible: false         
	},{
		dataField : "prmtMonth",
		headerText : "일",        
        visible: false         
	},{
		dataField : "prmtRate",
		headerText : "일",        
        visible: false         
	},{
		dataField : "puchSeq",
		headerText : "일",        
        visible: false         
	}
];

var columnLayoutPop6 = [{
		dataField : "prdNm",
		headerText : "제품명",            
	    style : "auiLeft",
	    editable : false,
	},{
		dataField : "statDt",
		headerText : "투입일",
	    editable : false,
	    width : "17%",
	},{
		dataField : "untpc",
		headerText : "기존단가",
		width : "17%",
	    style : "auiRight",
	    editable : false,
	},{
		dataField : "applUntpc",
		headerText : "적용단가",
		width : "17%",
	    style : "auiRight",
	    editable : true,
	},{
		dataField : "applDt",
		headerText : "일",        
	    visible: false         
	},{
		dataField : "endDt",
		headerText : "일",        
	    visible: false         
	},{
		dataField : "prmtSecCd",
		headerText : "일",        
	    visible: false         
	},{
		dataField : "prmtMonth",
		headerText : "일",        
	    visible: false         
	},{
		dataField : "prmtRate",
		headerText : "일",        
	    visible: false         
	}
];
 


   $(document).ready(function(){

	   callPopCos = $("#callPopCos").val();
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();
        //debugger;
        setDaterangepicker();
        
        console.log("targetCstSeq  : " + targetCstSeq);
        
        $("#selPopCntrMonth").on("change", function(){
    		
			if(this.value != ""){
				
				let date = new Date($("#popdatepicker05").val());
				console.log('기준일자 : ' + date + '<br>');

				date.setDate(date.getDate() + Number(this.value) *30);
				
				$('#popdatepicker06').data('daterangepicker').setStartDate(date);
				    				
			}
		});
        
        if(parentWinNm == 'dlvInfo'){        	
        	$.ajax({
        		url : "/cst/selectCstPrmtList.do", 
        		type : 'POST', 
        		data : {"cstSeq": targetCstSeq},
        		success : function(data) {
        			
        			$.each(data, function(index, item){				
        				item.prmtView = "상세보기";				
        			});
        			
        			dlvInfoData = data;
        			AUIGrid.setGridData(myPopGridID5, dlvInfoData);
        			//$("#areaCstCnt").html(data.length);
        		}, // success 
        		error : function(xhr, status) {
        			alert(xhr + " : " + status);
        		}
        	}); 
        	
        	$("input[name=selprmtSecCd]").on("change", function(){
        		
    			if(this.value == "FREE"){
    				$("#dsctRow").hide();    				
    			}else{
    				$("#dsctRow").show();
    			}
    		});
        	
        	$("#radioFree").prop('checked', true);
        	$("#dsctRow").hide();    	
    		
    			
        }else{
        	
        	if($("#prmtSecCd").val() == 'free'){
            	$("#radioFree").prop('checked', true);
            	$("#radioDsct").addClass('disabled');
            	$("#radioDsct").attr("disabled", true); //비활성화
            	$("#dsctRow").hide();    	
            }else{
            	$("#radioDsct").prop('checked', true);
            	$("#radioFree").addClass('disabled');
            	$("#radioFree").attr("disabled", true); //비활성화
            	$("#dsctRow").show();
            	
            }
        	var obj = { "prdNm" : $("#prdNm").val() , "statDt" : $("#inptDt").val() , "untpc" : $("#untpc").val() , "applUntpc" : "" 
        			, "applDt" : "", "endDt" : "", "prmtSecCd" : $("#prmtSecCd").val(), "prmtMonth" : "", "prmtRate" : ""};
        	
        	console.log("freeDsctData  : " + JSON.stringify(freeDsctData));
        	
    		//그리드 행추가
    		AUIGrid.addRow(myPopGridID5, freeDsctData, "first");
    		
    		AUIGrid.setAllCheckedRows(myPopGridID5, true);
        }
        
        
		$("#freeModalCloseBtn").on("click", function(){
        	//debugger;        	
        	$.closeDialog("<c:out value='${param.id}'/>");
        });
		
		$("#freeDsctPopSave").on("click", function(){
			saveFreeDsctPop();
		});
		
		$("#btnApplUntpc").on("click", function(){
			fnApplUntpc()
		})
	});
   
   	function fnApplUntpc(){
   		
   		let prmtRate = $("#prmtRate").val();
   		
   		var checkRowItem = AUIGrid.getCheckedRowItems(myPopGridID5);
   		
   		if(fnIsEmpty(prmtRate) || prmtRate == 0){
   			
   			if(checkRowItem.length > 1){
   				layerAlert1('<spring:message code="alert.noSelect" arguments="${\'할인율\'}" />');   			
   	   			return false;
   			}else if(checkRowItem.length == 1){
   				if(!fnIsEmpty(checkRowItem.item.applUntpc)){
   					
   					let prmtRate = checkRowItem.item.untpc / checkRowItem.item.applUntpc;
   					$("#prmtRate").val();
   				}
   			}
   		}else {
   			var selUnit = $("#selUnit option:selected").val();
   	   		
   	   		$.each(checkRowItem, function(index, row){
   	   			var obj = row.item;   			
   	   			var applUntpc = obj.untpc * ((100-prmtRate)/100);
   	   			
   	   			if(selUnit == 1){
   	   				applUntpc = Math.floor(applUntpc);	
   	   				
   	   			}else if(selUnit == 2){
   	   				applUntpc = Math.floor(applUntpc / 10) * 10;
   	   			}else if(selUnit == 3){
   	   				applUntpc = Math.floor(applUntpc / 100) * 100;
   	   			}else if(selUnit == 4){
   	   				applUntpc = Math.floor(applUntpc / 1000) * 1000;
   	   			}
   	   			
   	   			AUIGrid.setCellValue(myPopGridID5, row.rowIndex, AUIGrid.getColumnIndexByDataField(myPopGridID5, "applUntpc"), applUntpc);
   	   			
   	   		});
   		}
   	}
   
	function saveFreeDsctPop(){
		
		console.log("parentWinNm  : " + parentWinNm);
		
		var rowList = new Array();
		var checkRowItem = AUIGrid.getCheckedRowItems(myPopGridID5);
	   
		var prmtSecCd = $(":radio[name=selprmtSecCd]:checked").val();
		var prmtRate="";
		var prmtMonth="";
		var applDt = $("#popdatepicker05").val();
		var endDt = $("#popdatepicker06").val();
		
		var parentGridData;
	   
	   $.each(checkRowItem, function(index, row){
		   var obj = row.item
		   
		   if(prmtSecCd == "FREE"){
			   
			   	console.log('applDt ##: ' + applDt);
			   	console.log('new Date(applDt).getDate() ##: ' + new Date(applDt).getTime() + ", :: " + new Date(endDt).getTime());			   	
				prmtMonth = (new Date(endDt).getTime() - new Date(applDt).getTime()) / (1000 * 3600 * 24 * 30) ;
				obj.prmtMonth = prmtMonth;
				obj.applUntpc = 0;
			}else{
				obj.prmtRate = $("#prmtRate").val();
			}
		   
		   	obj.prmtLngtrCd = "";
		   	obj.prmtSecCd = prmtSecCd;
		   	delete obj.applDt;
		   	delete obj.endDt;
		   	obj["applDt"] = applDt.replace(/\-/g,'');
		   	obj["endDt"] = endDt.replace(/\-/g,'');
		   
		   	//debugger;
		   	rowList.push(obj);
		   	parentGridData = obj;
	   	});
	   
	   	if(parentWinNm == 'dlvInfo'){
	   
		   	$.ajax({
			   	contentType: 'application/json',
				url : "/cst/saveFreeDsctPop.do", 
				type : 'POST', 
				data : JSON.stringify(rowList),
				//dataType:"json",
				success : function(data) {
					console.log('save : ' + data );
					
				}, // success 
				error : function(xhr, status) {
					alert(xhr + " : " + status);
				}
			}); 
	   	}else{	   	
	   		if(prmtSecCd == "FREE"){
	   			parentGridData.prmtDetail = prmtMonth + "개월";
	   			parentGridData.prmtSecNm = "무료";
	   			parentGridData.prmtSecCd = "FREE";
	   			
	   			
	   		}else{
	   			parentGridData.prmtDetail = $("#prmtRate").val() + "%";
	   			parentGridData.prmtSecNm = "할인";
	   			parentGridData.prmtSecCd = "DSCT";
	   		}	   				
	   		console.log('parentGridData : ' + JSON.stringify(parentGridData));
	   		
	   		if(parentWinNm == 'addCstMng'){
	   			AUIGrid.addRow(mGrid3, parentGridData, "last");
	   			
	   		}else if(parentWinNm == 'newPrdPop'){
	   			
	   			
	   			$.successDialog("<c:out value='${param.id}'/>", parentGridData);
	   			//AUIGrid.addRow(myPopGridID4, parentGridData, "last");
	   			
	   			//$("#cstApplUnptc").val(parentGridData.applUntpc);
	   		}
	   	}
	   	$.closeDialog("<c:out value='${param.id}'/>");
	   
   	}
       
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 30,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : true,                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "singleRow",
                //showFooter : true,                
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
        
        if(AUIGrid.isCreated(myPopGridID5)){
        	AUIGrid.destroy(myPopGridID5);        	
        }
        
        if(parentWinNm == 'dlvInfo'){
        	// 실제로 #grid_wrap 에 그리드 생성
            myPopGridID5 = AUIGrid.create("#grid_wrap5_pop", columnLayoutPop5, gridPros);
        }else{
        	// 실제로 #grid_wrap 에 그리드 생성
            myPopGridID5 = AUIGrid.create("#grid_wrap5_pop", columnLayoutPop6, gridPros);	
        }
        
        AUIGrid.bind(myPopGridID5, "rowCheckClick", function( event ) {        
        	
        	console.log("selprmtSecCd   ::" + $("input[name=selprmtSecCd]").val());
        	
        	if($(":radio[name=selprmtSecCd]:checked").val() == "FREE"){      
        		
        		AUIGrid.setCellValue(myPopGridID5, event.rowIndex, AUIGrid.getColumnIndexByDataField(myPopGridID5, "applUntpc"), "0");        		
        	}
        	
    	});
        
        
    }
    
    // 전체 체크 설정/ 해제
    function checkAll(checked) {
        var rowCount = AUIGrid.getRowCount(myGridID);
        if(checked) {
            // 전체 데이터를 대상으로 isActive 필드를 "Active" 값으로 변경
            AUIGrid.updateRowBlockToValue(myGridID, 0, rowCount-1, "isActive", "Active");
        } else {
            // 전체 데이터를 대상으로 isActive 필드를 "Inactive" 값으로 변경
            AUIGrid.updateRowBlockToValue(myGridID, 0, rowCount-1, "isActive", "Inactive");
        }
    };
</script>
<body>

	<!-- 무료/할인 적용 -->
    <div class="modal_bg" ></div> <!-- modal 배경 -->
    <div class="popWrap large modal_wrap h776" data-popup="modalAgencyViews" > <!-- small 사이즈 600px * 370px -->
        <header>
            <h3>무료/할인 적용</h3>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3 class="pb10">무료/할인 적용</h3>
    
                <div class="popBtnArea">
                    <button type="button" name="" class="comBtn" id="freeModalCloseBtn">닫기</button>
                    <button type="button" name="" class="inquBtn" id="freeDsctPopSave">저장</button>
                </div>
            </div>
            <div class="conBox">
            	<input type="hidden" name="cntrMonth" value="" id="cntrMonth" value=""/>            	
            	<input type="hidden" name="parentWinNm" value="" id="parentWinNm" value=""/>
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
                            <tr>
                                <th scope="row">
                                    <label for="memo01" class="required" title="필수입력">구분</label>
                                </th>
                                <td colspan="3">
                                    <div class="formWrap">
                                        <div class="checkGroup">
                                            <input type="radio" name="selprmtSecCd" value="FREE" id="radioFree" class="type01" ><label for="radioFree"><span>무료애음</span></label>
                                            <input type="radio" name="selprmtSecCd" value="DSCT" id="radioDsct" class="type01"><label for="radioDsct"><span>가격할인</span></label>
                                            
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="datepicker" class="required" title="필수입력">시작일자</label>
                                </th>
                                <td colspan="3">
                                    <div class="formWrap">
                                        <div class="dateWrap">
                                            <input type="text" name="applDt" value="10/24/1984" class="inp w160 datepicker" id="popdatepicker05" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="popdatepicker05"></button>
                                        </div>
                                        <!-- disable 일때 -->
                                            <!-- <input type="text" name="date" value="10/24/1984" class="inp w160" id="datepicker" disabled> -->
                                        <!--// disable 일때 -->
                                    </div>
                                </td>
                                
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="datepicker" class="required" title="필수입력">종료일자</label>
                                </th>
                                <td colspan="3">
                                    <div class="formWrap jStart alignCenter">
                                        <div class="dateWrap">
                                            <input type="text" name="endDt" value="10/24/1984" class="inp w160 datepicker" id="popdatepicker06" >
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="popdatepicker06"></button>
                                        </div>
                                        <select name="selPopCntrMonth" class="sel w160 ml30" id="selPopCntrMonth" value="">
                                        	<option value="" selected>종료일 선택</option>
                                            <option value="1" >1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                            
                                        </select>
                                        <!-- disabled일때 -->
                                        <!-- <select name="" class="sel w160 ml30" id="inp_prDt" value="" disabled>
                                            <option selected>선택</option>
                                            <option></option>
                                            <option></option>
                                            <option></option>
                                        </select> -->
                                        <!--// disabled일때 -->
                                        <span class="ml5">개월</span>
                                    </div>
                                    
                                </td>
                            </tr>
                            <!-- <tr>
                                <th scope="row">
                                    <label for="inp_rgPrice">정상단가</label>
                                </th>
                                <td colspan="3">
                                    <input type="text" id="inp_rgPrice" class="inp w160 bg_gray ar pColor01" value="800" name="" disabled>
                                    <span class="ml5 vaMd">원</span>
                                </td>
                            </tr> -->
                            <tr id="dsctRow">
                                <th scope="row">
                                    <label for="inp_rgPrice">할인율</label>
                                </th>
                                <td colspan="3">
                                    <!-- <input type="text" id="inp_rgPrice" class="inp w160 ar" value="500" name="">
                                    <span class="ml5 vaMd">원</span> -->
                                    
                                    <div class="formWrap jStart alignCenter">
                                        <input type="text" id="prmtRate" class="inp w160 ar" value="0" name="prmtRate">
                                        <span class="ml5 mr30 vaMd">%</span>
                                        <label for="selUnit" class="mr10">단가절삭방식</label>
                                        <select name="selUnit" class="sel w160 mr20" id="selUnit" value="">
                                            <option value="1" selected="">원단위</option>
                                            <option value="2">십원단위</option>
                                            <option value="3">백원단위</option>
                                            <option value="4">천원단위</option>
                                        </select>
                                        <button type="button" name="" class="comBtn small" id="btnApplUntpc">적용</button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="titleArea right">
                <h3 class="tit01">계약 정보</h3>       
                <p class="txt01">* 적용할 상품을 선택하세요.</p>
            </div>

            <!-- grid -->
            <div class="girdBox">
                <div id="grid_wrap5_pop"></div>                
            </div>
            <!-- grid -->
        </div>
        <!-- popCon -->
    </div>
    <!--// 무료/할인 적용 -->
</body>
</html>