<!-- 
	@File Name: 
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 3. 15.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="code"  uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
    var prmtPymGridID;
    
    var emplList = [];
    
    <c:forEach var="empl" items="${emplList}" varStatus="status">
    	emplList.push({"code": "${empl.emplSeq}", "value" : "${empl.emplNm}"});		
	</c:forEach>
	
    $(document).ready(function(){
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.        
        
        console.log("emplList  :: " + JSON.stringify(emplList));
        AUIGrid.setGridData(prmtPymGridID, prmtPymInfoData);
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
    	
        var columnLayout = [{
				dataField : "prmtSecNm",
				headerText : "구분",
	            width : "10%" ,
	        },{
				dataField : "prmtDetail",
				headerText : "상세",
	            style : "auiLeft"         	
	        },{
				dataField : "applUntpc",
				headerText : "단가",
	            style : "auiRight",
	            width : "9%"	
	        },{
				dataField : "applDt",
				headerText : "적용시작일",
	            width : "12%",
			},{
				dataField : "endDt",
				headerText : "적용종료일",
	            width : "12%",
			},{
				dataField : "prmtCt",
				headerText : "소비자부담금",
	            dataType : "numeric",
	            style : "auiRight",
	            width : "12%",
	        },{
				dataField : "prmtCstCt",
				headerText : "판촉사원부담금",
	            dataType : "numeric",
	            style : "auiRight",
	            width : "15%",            
	        },{
				dataField : "prmtPymDt",
				headerText : "지급일",
	            width : "10%",
	            dataType : "date",
                dateInputFormat : "yyyy/mm/dd", // 실제 데이터의 형식 지정
                formatString : "yyyy - mm - dd", // 실제 데이터 형식을 어떻게 표시할지 지정
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
                    defaultFormat : "yyyy/mm/dd", // 달력 선택 시 데이터에 적용되는 날짜 형식
                    showEditorBtn : false,
                    showEditorBtnOver : false, // 마우스 오버 시 에디터버턴 출력 여부
                    onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
                    showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
                }
	        },{
				dataField : "prmtPymNm",
				headerText : "지급인",
	            style : "auiLeft",
	            width : "9%",
	            renderer : {
				    type : "DropDownListRenderer",
	                list : emplList,               
	                keyField : "code", // key 에 해당되는 필드명
	    			valueField : "value", // value 에 해당되는 필드명
	    			multipleMode : true, // 다중 선택 모드(기본값 : false)
	    			showCheckAll : true // 다중 선택 모드에서 전체 체크 선택/해제 표시(기본값:false);
	    			
	            }
	        },{
	    		dataField : "prmtPymSeq",
	    		headerText : "판촉정보",
	    		visible: false
	    	}
		];
    	
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 29,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : true,
                
                rowIdField : "id",
				showStateColumn : false,
				wrapSelectionMove : true,
				editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
                enterKeyColumnBase : true,
                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "singleRow",
                
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
                
        };
    
        if(AUIGrid.isCreated(prmtPymGridID)){
        	AUIGrid.destroy(prmtPymGridID);        	
        }
        
        // 실제로 #grid_wrap 에 그리드 생성
        prmtPymGridID = AUIGrid.create("#prmt_pym_grid_wrap", columnLayout, gridPros);
        
    }

   
</script>
<body>
	<!-- layerPopup -->
    <div class="modal_bg" style="display:block"></div> <!-- modal 배경 -->

    <!-- 판촉물 지급 정보 조회 팝업 -->
    <div class="popWrap large modal_wrap h520" data-popup="modalAgencyViews03">
        <header>
            <h3>판촉물 지급 정보 조회</h3>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>판촉물 지급 정보 조회</h3>
                <div class="popBtnArea">
                    <button type="button" name="" class="comBtn modalCloseBtn" id="modalCloseBtn">닫기</button>                   
                    <button type="button" name="" class="inquBtn">저장</button>
                </div>
            </div>
            
            <div class="titleArea">
                <p class="numState">
                    <em>총 <span class="pColor01 fb">123</span></em> 건 이 조회되었습니다.
                </p>
            </div>
            
            <!-- grid -->
            <div class="girdBox">
                <div id="prmt_pym_grid_wrap"></div>
            </div>
            <!-- grid -->
            

        </div>
        <!-- popCon -->
    </div>
    <!-- 조회할 지역선택 팝업 -->
    <!--// layerPopup -->
</body>
</html>