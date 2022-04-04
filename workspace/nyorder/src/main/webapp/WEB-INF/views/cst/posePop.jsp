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
    var posePopGridID;
    var gridData = [
        {"id":"#Cust01","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"월수금","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust02","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust03","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust04","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
		{"id":"#Cust05","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust06","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust07","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust08","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust09","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
        {"id":"#Cust09","prdNm":"GT프리미엄930","inptDt":"2021-01-03","unitPrice":"100","quantity":"1,000","pattern":"화수목금일","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1"},
    ];
    
    // AUIGrid 를 생성합니다.
    function poseCreateAUIGrid(){
    	
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
                headerHeights : 30,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : false,
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
        
        if(AUIGrid.isCreated(posePopGridID)){
        	AUIGrid.destroy(posePopGridID);        	
        }
    
        // 실제로 #grid_wrap 에 그리드 생성
        posePopGridID = AUIGrid.create("#posePop_grid_wrap", columnLayout, gridPros);
    }
    
   
    $(document).ready(function(){
    	
    	$("#poseCloseBtn").on("click", function(){
        	$.closeDialog("<c:out value='${param.id}'/>");
        });
    	setDaterangepicker();
        // AUIGrid 생성 후 반환 ID
        poseCreateAUIGrid();
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.        
        
        //AUIGrid.setGridData(posePopGridID, gridData);
    });
    
   


    
</script>
<body>
<!-- 팝업 -->
	<div class="modal_bg" style="display:block;"></div> <!-- modal 배경 -->
	<!-- 일시중지 -->
    <div class="popWrap large modal_wrap h644" data-popup="modalAgencyViews">
        <header>
            <h3>일시중지</h3>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>일시중지</h3>
    
                <div class="popBtnArea">
                    <button type="button" name="" class="comBtn" id="poseCloseBtn">닫기</button>                   
                    <button type="button" name="" class="inquBtn">저장</button>
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
                                <!-- <th scope="row">
                                    <label for="datepicker" class="required" title="필수입력">구분</label>
                                </th>
                                <td colspan="3">
                                    <div class="checkGroup">
                                        <input type="radio" name="date" id="stpg1" class="type01" checked=""><label for="stpg1"><span>일시중지</span></label>
                                        <input type="radio" name="date" id="stpg2" class="type01"><label for="stpg2"><span>중지</span></label>
                                    </div>
                                </td> -->
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
                                            <input type="text" name="date" value="10/24/1984" class="inp w160 datepicker" id="datepicker" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
                                        </div>
                                    </div>
                                </td>
                                <th scope="row">
                                    <label for="datepicker02" class="required" title="필수입력">출력일자</label>
                                </th>
                                <td>
                                    <div class="formWrap" style="justify-content: flex-start; align-items: center;">
                                        <div class="dateWrap">
                                            <input type="text" name="date" value="10/24/1984" class="inp w160 datepicker" id="datepicker02" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker02"></button>
                                        </div>
                                        <div class="checkGroup ml20">
                                            <input type="checkbox" id="stdPrdNm01" class="type01"><label for="stdPrdNm01"><span>출고증 인쇄 안함</span></label>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!--// 적용 일정 -->
            </div>

            <div class="titleArea mt20">
                <h3 class="tit01">계약 정보</h3>
            </div>

            <!-- grid -->
            <div class="girdBox">
                <div id="posePop_grid_wrap"></div>
            </div>
            <!-- grid -->
        </div>
        <!-- popCon -->
    </div>
    <!--// 기간 보류 -->
    
</body>
</html>