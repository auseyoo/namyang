<!-- 
	@File Name: 
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 3. 10.
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

	var popMyGridID;    
    
   	$(document).ready(function(){
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.        
        $("#newModalCloseBtn").on("click", function(){
        	$.closeDialog("<c:out value='${param.id}'/>");
        });
        
        $("#btnPopPrdSrch").click(function(){
        	console.log("btnPopPrdSrch start : ");
        	getSearchPrdList();
        });
        
	    //AUIGrid.setFooter(myGridID, footerLayout);
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 30,
                rowHeight : 30,
                // 편집 가능 여부 (기본값 : false)
                editable : false,
                
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
	            showRowCheckColumn : false,
                
                
                // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
                displayTreeOpen : true,
                
                noDataMessage : "출력할 데이터가 없습니다.",
                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
                
        };
        
        var columnLayout = [{
				dataField : "prdDtlCd",
				headerText : "제품코드",
	            width : "40%" ,
	            style : "auiLink"           	
	        },{
				dataField : "shtnNm",
				headerText : "제품명",            
			},{
				dataField : "prdSeq",
				headerText : "제품Seq", 
				visible: false
			},{
				dataField : "prdDtlSeq",
				headerText : "제품Seq",
				visible: false
			},{
				dataField : "untpc",
				headerText : "제품단가",
				visible: false
			}
		];
        if(AUIGrid.isCreated(popMyGridID)){
        	AUIGrid.destroy(popMyGridID);        	
        }

        // 실제로 #grid_wrap 에 그리드 생성
        popMyGridID = AUIGrid.create("#grid_wrap_pop", columnLayout, gridPros);
        
		AUIGrid.bind(popMyGridID, "cellClick", function(event) {
			
			let prdDtlCd = AUIGrid.getCellValue(popMyGridID, event.rowIndex, "prdDtlCd");
			let shtnNm = AUIGrid.getCellValue(popMyGridID, event.rowIndex, "shtnNm");
			let prdSeq = AUIGrid.getCellValue(popMyGridID, event.rowIndex, "prdSeq");
			let prdDtlSeq = AUIGrid.getCellValue(popMyGridID, event.rowIndex, "prdDtlSeq");
			let untpc = AUIGrid.getCellValue(popMyGridID, event.rowIndex, "untpc");
			
			$("#prdNm").val(shtnNm);
			$("#prdSeq").val(prdSeq);
			$("#prdDtlSeq").val(prdDtlSeq);
			$("#untpc").val(untpc);
						
			$.closeDialog("<c:out value='${param.id}'/>");

		});
    }

    function getSearchPrdList(){
    	
    	console.log("getSearchPrdList start : ");
    	
    	$.ajax({
    		url : "/cst/selectPopPrdSearchList.do", 
    		type : 'POST', 
    		data : {"prdSearchValue" : $("#prdSearchValue").val(), "selPrdSearch" : $("#selPrdSearch").val()},
    		success : function(data) {
    			
    			console.log("selectPopPrdSearchList data : " + JSON.stringify(data));
    			
    			AUIGrid.setGridData(popMyGridID, data);
    			   				
    		}, // success 
    		error : function(xhr, status) {
    			console.log(xhr + " : " + status);
    		}
    	});
    }
    
</script>
<body>
<!-- layerPopup -->
    <div class="modal_bg" ></div> <!-- modal 배경 -->

    <!-- 제품 등록 -->
    <div class="popWrap small modal_wrap h560" data-popup="modalAgencyViews03">
        <header>
            <h3>제품 등록</h3>            
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>제품 등록</h3>

                <div class="popBtnArea">
                    <button type="button" name="" class="comBtn" id="newModalCloseBtn">닫기</button>
                </div>
            </div>

            <!-- 조회 -->
            <div class="inquiryBox">
                <dl>
                    <dt>구분</dt>
                    <dd>
                        <div class="formWrap">
                            <select name="selPrdSearch" class="sel w120 mr10" id="selPrdSearch">
                                <option value="all">전체</option>
                                <option value="PRD">제품명</option>
                                <option value="CODE">제품코드</option>
                            </select>                            
                        </div>
                    </dd>
                    
                    <dd>
                        <div class="formWrap">
                            <input type="text" id="prdSearchValue" class="inp w160 mr7" value="" name="prdSearchValue">
                            <button type="button" name="" class="comBtn" id="btnPopPrdSrch">검색</button>
                        </div>
                    </dd>
                </dl>
            </div>
            <!-- 조회 -->

            <!-- grid -->
            <div class="girdBox">
                <div id="grid_wrap_pop"></div>
            </div>
            <!-- grid -->

        </div>
        <!-- popCon -->
    </div>
    <!-- 제품 등록 -->
    <!--// layerPopup -->
</body>
</html>