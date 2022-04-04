<!-- 
	@File Name: areaChoicePop.jsp
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 2. 15.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

	var popGridID;
	
    // AUIGrid 를 생성합니다.
    function createPopAUIGrid() {
    	
    	console.log("createPopAUIGrid start  ####################################");
    	
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 30,
                rowHeight : 30,
                // 편집 가능 여부 (기본값 : false)
                editable : false,
                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,
                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "multipleCells",
                //showFooter : true,
                
                // 컨텍스트 메뉴 사용 여부 (기본값 : false)
                useContextMenu : true,
                
                // 필터 사용 여부 (기본값 : false)
                enableFilter : true,
            
                // 그룹핑 패널 사용
                useGroupingPanel : false,

                // 체크박스 사용 
	            showRowCheckColumn : false,
                
                
                // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
                displayTreeOpen : true,
                
                noDataMessage : "출력할 데이터가 없습니다.",
                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
                rowNumColumnWidth : 50,
                
        };
        
        var popColumnLayout = [{
				dataField : "agenAreaCd",
				headerText : "지역코드",
	            width : "25%" ,
	            style : "auiLink"           	
	        },{
				dataField : "areaNm",
				headerText : "지역명",
	            style : "auiLeft"
			},{
				dataField : "emplCd",
				headerText : "직원코드",
	            width : "20%",
	            style : "auiLink"
	        },{
				dataField : "emplNm",
				headerText : "직원명",
	            width : "20%",
	        },{
				dataField : "areaSeq",
				headerText : "지역코드",
				visible : false
				
			}
		];
        
        if(AUIGrid.isCreated(popGridID)){
        	AUIGrid.destroy(popGridID);        	
        }

        // 실제로 #grid_wrap 에 그리드 생성
        popGridID = AUIGrid.create("#pop_grid_wrap", popColumnLayout, gridPros);
        
		AUIGrid.bind(popGridID, "cellClick", function(event) {
			
			let areaSeq = AUIGrid.getCellValue(popGridID, event.rowIndex, "areaSeq");
			let agenAreaCd = AUIGrid.getCellValue(popGridID, event.rowIndex, "agenAreaCd");
			let areaNm = AUIGrid.getCellValue(popGridID, event.rowIndex, "areaNm");
			
			paramObj = {"areaSeq" : areaSeq, "agenAreaCd" : agenAreaCd, "areaNm": areaNm};			
			setAreaCd(paramObj);			
			$.closeDialog("<c:out value='${param.id}'/>");

		});
    }
    
   	$(document).ready(function(){
        // AUIGrid 생성 후 반환 ID
        createPopAUIGrid();
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.   
        
        $("#modalCloseBtn").on("click", function(){        	
        	 		
        	$.closeDialog("<c:out value='${param.id}'/>");
        	
        });
    });
   	
   	function resizeGrid(){
   		
   		AUIGrid.resize(popGridID, $("#pop_grid_wrap").width());
   		AUIGrid.clearGridData(popGridID);
   	}
    
       

	//지역 리스트
	function gettPopAreaList(){
		
		let param = $("#popSearchFrm").serialize();
		console.log("param ::", JSON.stringify(param));
		
		$.ajax({
			url : "/cst/selectPopAreaList.do", 
			type : 'POST', 
			data : param,
			success : function(data) {
				
				console.log("data", data);				
				$("#popListCnt").text(data.length);
				AUIGrid.setGridData(popGridID, data);

			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	} 
    
    
</script>
</head>
<body>
    <!-- layerPopup -->
    <div class="modal_bg" ></div> <!-- modal 배경 -->
    <!-- 지역선택 -->
    <div class="popWrap mideum modal_wrap h480" data-popup="modalAgencyViews03">
        <header>
            <h3>지역선택</h3>            
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>지역선택</h3>
                <div class="popBtnArea">
				<!--<button type="button" name="" class="inquBtn">저장</button>-->
				<button type="button" name="" class="comBtn modalCloseBtn" id="modalCloseBtn">닫기</button>                   
			</div>
            </div>

            <!-- 조회 -->
            <div class="inquiryBox mb14">
                <dl>
                    <dt>구분</dt>
                    <dd>
                        <div class="formWrap">
                            <select name="popSearchSec" class="sel w120 mr10" id="sel_class01">
                                <option value="all">전체</option>
                                <option value="area">지역명</option>
                                <option value="empl">직원명</option>
                            </select>                            
                        </div>
                    </dd>
                    
                    <dd>
                        <div class="formWrap">
                            <input type="text" id="searchVal" class="inp w160 mr7" value="" name="searchVal">
                            <button type="button" name="" class="comBtn" id="inp_name01" onclick="gettPopAreaList();">조회</button>
                        </div>
                    </dd>
                </dl>
            </div>
            <!-- 조회 -->
            
            <div class="titleArea">
                <p class="numState">
                    <em>총 <span class="pColor01 fb" id="popListCnt">0</span></em> 건 이 조회되었습니다.
                </p>
            </div>
           
            <!-- grid -->
            <div class="girdBox">
                <div id="pop_grid_wrap"></div>
            </div>
            <!-- grid -->
        </div>
        <!-- popCon -->
    </div>
    <!-- 지역선택 -->
    <!--// layerPopup -->

</body>
</html>