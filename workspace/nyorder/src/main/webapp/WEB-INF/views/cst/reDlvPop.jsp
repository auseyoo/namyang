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
    var reDlvGridID;
    var targetCstSeq = '${param.targetCstSeq}';
    var targetCstPrdSeq = '${param.targetCstPrdSeq}';
    var targetPrdNm = '${param.prdNm}';
    var targetUntpc = '${param.untpc}';
    var targetChgSecCd = '${param.chgSecCd}';
    
    var reDlvGridData = [
        {"id":"#Cust01","weeks" : "1","cstSecCd":"1주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
    	{"id":"#Cust02","weeks" : "2","cstSecCd":"2주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
    	{"id":"#Cust03","weeks" : "3","cstSecCd":"3주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
    	{"id":"#Cust04","weeks" : "4","cstSecCd":"4주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
    	{"id":"#Cust05","weeks" : "5","cstSecCd":"5주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""},
    	{"id":"#Cust06","weeks" : "6","cstSecCd":"6주","qty":"1", "monQty":"0","tueQty":"0","wedQty":"0","thuQty":"0","friQty":"0","satQty":"0","sunQty":"0","totQty":""}
    ];
    
 // AUIGrid 를 생성합니다.
    function createReDlvAUIGrid(){
    	
        var columnLayout = [{
				dataField : "cstSecCd",
				headerText : "구분",
	            width : "9.5%",
	            style: "auiCenter",
	            headerStyle : "auiCenter"
	        },{
				dataField : "monQty",
				headerText : "월",
	            width : "9.5%",
	            style: "auiCenter",
	            headerStyle : "auiCenter"
			},{
				dataField : "tueQty",
				headerText : "화",
	            width : "9.5%",
	            style: "auiCenter",
	            headerStyle : "auiCenter"
			},{
				dataField : "wedQty",
				headerText : "수",
	            width : "9.5%",
	            style: "auiCenter",
	            headerStyle : "auiCenter"
			},{
				dataField : "thuQty",
				headerText : "목",
	            width : "9.5%",
	            style: "auiCenter",
	            headerStyle : "auiCenter"
			},{
				dataField : "friQty",
				headerText : "금",
	            width : "9.5%",
	            style: "auiCenter",
	            headerStyle : "auiCenter"
			},{
				dataField : "satQty",
				headerText : "토",
	            width : "9.5%",
	            style: "auiCenter",
	            headerStyle : "auiCenter hColor01",
			},{
				dataField : "sunQty",
				headerText : "일",
	            width : "9.5%",
	            style: "auiCenter",
	            headerStyle : "auiCenter hColor02",         
			},{
				dataField : "totQty",
				headerText : "총수량",
	            style: "auiCenter",
	            headerStyle : "auiCenter",
	            editable: false,
	            expFunction : function(  rowIndex, columnIndex, item, dataField ) { // 여기서 실제로 출력할 값을 계산해서 리턴시킴.			
	    			return ( Number(item.monQty) + Number(item.tueQty) + Number(item.wedQty) + Number(item.thuQty) + Number(item.friQty) + Number(item.satQty) + Number(item.sunQty) ); 
	    		},
	        },{
	            dataField : "weeks",
	            headerText : "주차",
	            visible: false
	        }			
		];    	
        // 그리드 속성 설정
        var gridPros = {
                headerHeights : 30,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : false,
                autoGridHeight : true,
                // 체크박스 사용 
	            showRowCheckColumn : false,
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
    
        if(AUIGrid.isCreated(reDlvGridID)){
        	AUIGrid.destroy(reDlvGridID);        	
        }   
        
        // 실제로 #grid_wrap 에 그리드 생성
        reDlvGridID = AUIGrid.create("#reDlvPop_grid_wrap", columnLayout, gridPros);
        
        //AUIGrid.setGridData(reDlvGridID, reDlvGridData);
        
    }
   
    $(document).ready(function(){
    	$("#reDlvCloseBtn").on("click", function(){
        	$.closeDialog("<c:out value='${param.id}'/>");
        });
    	
    	$("#targetPrdNm").text(targetPrdNm);
    	$("#targetUntpc").text(targetUntpc);
    	
    	$("#btnSaveReDlv").on("click", function(){
    		saveReDlv();
      	});
    	
        // AUIGrid 생성 후 반환 ID
        createReDlvAUIGrid();
        setDaterangepicker();
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
        AUIGrid.setGridData(reDlvGridID, reDlvGridData);
        
        
        getCstPttn();
                
    });
    
    function saveReDlv(){
    	
    	let prtYn = "Y";
    	if($('#prtYn').is(':checked')){    			
			prtYn = "N";	
		}
    	
    	var reDlvStatDt = new Date($("#reDlvStatDt").val());      		
    	reDlvStatDt.setDate(reDlvStatDt.getDate() -1);
  		let endDt = fnConvertDate(reDlvStatDt).replace(/-/gi, "");
    	
    	let param = {"cstPrdSeq" : targetCstPrdSeq, "endDt" : endDt, "prtDt" : $("#prtDt").val()
    			, "prtYn" : prtYn, "chgSecCd" : targetChgSecCd };
    	
    	console.log("JSON.stringify(param),   : " + JSON.stringify(param));
    	
    	$.ajax({
		   	contentType: 'application/json',
			url : "/cst/saveReDlvPop.do", 
			type : 'POST', 
			data : JSON.stringify(param),
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
    
    function getCstPttn(){
    	
    	console.log("getCstPttn  targetCstPrdSeq : " + targetCstPrdSeq );
    	
    	$.ajax({
			url : "/cst/selectCstPttn.do", 
			type : 'POST', 
			data : {"cstPrdSeq": targetCstPrdSeq},
			success : function(data) {
								
				let rowCount = AUIGrid.getRowCount(reDlvGridID);
				let rowIndexes = [];
				for(let i = 0; i < rowCount ; i++){
					rowIndexes.push(i);
				}
				
				AUIGrid.updateRows(reDlvGridID, data, rowIndexes); 
				
				
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});    	
    	
    }
   
    


</script>
<body>
<!-- 팝업 -->
	<div class="modal_bg" style="display:block;"></div> <!-- modal 배경 -->
    <!-- 재배달 -->
    <div class="popWrap large modal_wrap h548" data-popup="modalAgencyViews">
        <header>
            <h3>재배달</h3>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>재배달</h3>
    
                <div class="popBtnArea">
                    <button type="button" name="" class="comBtn" id="reDlvCloseBtn">닫기</button>                   
                    <button type="button" name="" class="inquBtn" id="btnSaveReDlv">저장</button>
                </div>
            </div>

            <div class="conBox mt5">
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
                            <tr>
                                <th scope="row">
                                    <label for="datepicker" class="required" title="필수입력">시작일자</label>
                                </th>
                                <td>
                                    <div class="formWrap">
                                        <div class="dateWrap">
                                            <input type="text" name="reDlvStatDt" value="10/24/1984" class="inp w160 datepicker" id="reDlvStatDt" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="reDlvStatDt"></button>
                                        </div>
                                    </div>
                                </td>
                                <th>
                                    <label for="datepicker02" class="required" title="필수입력">출력일자</label>
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
                        </tbody>
                    </table>
                </div>
                <!--// 적용 일정 -->

                <!-- 변경 전 -->
                <div class="tblWrap">
                    <div class="titleArea right">
                        <h3 class="tit01">변경 전</h3>
                    </div>
                    
                    <table class="tbl">
                        <caption>변경 전</caption>
                        <colgroup>
                            <col style="width:164px;">
                            <col>
                            <col style="width:164px;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr> 
                                <th scope="row">제품명</th>
                                <td>
                                    <div class="formWrap jStart alignCenter">
                                        <p id="targetPrdNm"></p>
                                    </div>
                                </td>
                                <th>단가</th>
                                <td>
                                <p id="targetUntpc">0원</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">투입패턴</th>
                                <td colspan="3">
                                    <!-- grid -->
                                    <div class="girdBox type07 mt20 mb20" style="width: 536px;">
                                        <div id="reDlvPop_grid_wrap" style="width: 100%;"></div>
                                    </div>
                                    <!-- grid -->
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <!--// 변경 전 -->
            </div>

        </div>
        <!-- popCon -->
    </div>
    <!--// 기간 보류 -->
</body>
</html>