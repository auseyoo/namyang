<!-- 
	@File Name: 
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 3. 2.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    var myGridIDPop;    
    var gridData = [
        {"id":"#Cust01","areaCd":"0072221","areaNm":"논현1동","emCd":"0000200","emNm":"홍길일"},
		{"id":"#Cust02","areaCd":"0072221","areaNm":"학동","emCd":"0000200","emNm":"홍길이"},
		{"id":"#Cust03","areaCd":"0072221","areaNm":"논현1동","emCd":"0000200","emNm":"홍길삼"},
		{"id":"#Cust04","areaCd":"0072221","areaNm":"논현1동","emCd":"0000200","emNm":"홍길사"},
    ];
    
	var columnLayoutPop = [{
			dataField : "agenAreaCd",
			headerText : "지역코드",
			width : "25%",
			style : "auiLink"
		}, {
			dataField : "areaNm",
			headerText : "지역명",
			style : "auiLeft"
		}, {
			dataField : "emplCd",
			headerText : "직원코드",
			width : "20%",
		}, {
			dataField : "emplNm",
			headerText : "직원명",
			width : "20%",
		}, {
			dataField : "areaSeq",
			headerText : "areaSeq",
			width : "20%",
			visible: false,
		}
	];	
   
   	$(document).ready(function(){
	   
		$("#selAreaSrh option:eq(0)").attr("selected","selected");
		$("#inptSrhArea").val("");
	   
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();
        
    	//지역 검색 팝업 
    	$("#btnAreaSrh").click(function(){
    		fnGetArea();
    	});
    	//지역 조회 조건 설정(저장)
    	$("#btnPopAreaSave").click(function(){
    		fnSetArea();
    	});
        
        
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.        
        
        //AUIGrid.setGridData(myGridID, gridData);
	    //AUIGrid.setFooter(myGridID, footerLayout);
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
        // 그리드 속성 설정
		var gridProsPop = {
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
			showRowCheckColumn : true,
			// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
			displayTreeOpen : true,
			noDataMessage : "출력할 데이터가 없습니다.",
			groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
			rowNumColumnWidth : 50,
		
			};

        myGridIDPop = AUIGrid.create("#grid_wrap_pop", columnLayoutPop, gridProsPop);
        
    }


    
  //지역 가져오는 팝업
    function fnGetArea(){
    	var params	= {"selAreaSrh": $("#selAreaSrh option:selected").val(), "inptSrhArea":$("#inptSrhArea").val() };
    	$.ajax({
    		url : "/cst/selectArea.do", 
    		type : 'POST', 
    		data : params,
    		success : function(data) {
    			AUIGrid.setGridData(myGridIDPop, data);
    			$("#areaCnt").html(data.length);
    		}, // success 
    		error : function(xhr, status) {
    			alert(xhr + " : " + status);
    		}
    	}); 
    }
  
</script>  
<body>
    <!-- layerPopup -->
    <div class="modal_bg" style="display:block"></div> <!-- modal 배경 -->
    <!-- 조회할 지역선택 팝업 -->
    <div class="popWrap mideum modal_wrap" data-popup="modalAgencyViews03">
        <header>
            <h3>조회할 지역선택</h3>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>조회할 지역선택</h3>
                <div class="popBtnArea">
				<button type="button" name="" class="comBtn modalCloseBtn" id="modalCloseBtn">닫기</button>                   
				<button type="button" name="" class="inquBtn" id="btnPopAreaSave">저장</button>
            </div>
            </div>

            <!-- 조회 -->
            <div class="inquiryBox mb14">
                <dl>
                    <dt>구분</dt>
                    <dd>
                        <div class="formWrap">
                            <select name="selAreaSrh" class="sel w120 mr10" id="selAreaSrh">                               
                                <option value="areaNm">지역명</option>
                                <option value="emplNm">직원명</option>
                            </select>                            
                        </div>
                    </dd>
                    
                    <dd>
                        <div class="formWrap">
                            <input type="text" id="inptSrhArea" class="inp w160 mr7" value="" name="inptSrhArea">
                            <button type="button" name="" class="comBtn" id="btnAreaSrh">조회</button>
                        </div>
                    </dd>
                </dl>
            </div>
            <!-- 조회 -->
            
            <div class="titleArea">
                <p class="numState">
                    <em>총 <span class="pColor01 fb" id="areaCnt"></span></em> 건 이 조회되었습니다.
                </p>
            </div>
            
            <!-- grid -->
            <div class="girdBox">
                <div id="grid_wrap_pop"></div>
            </div>
            <!-- grid -->
            

        </div>
        <!-- popCon -->
    </div>
    <!-- 조회할 지역선택 팝업 -->
    <!--// layerPopup -->
</body>
</html>