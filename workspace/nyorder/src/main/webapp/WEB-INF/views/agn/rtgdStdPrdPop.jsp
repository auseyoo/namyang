<!-- 
	@File Name: rtgdStdPrdPop
	@File 설명 : 제품 등록 팝업
	@UI ID : UI-PCLI-0101P1.html
	@작성일 : 2022.02.04
	@작성자 : 김정애
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
    var myGridIDPrd;    
   
   $(document).ready(function(){

		// 화면에서 팝업을 두번째 오픈할때 비정상동작되어 그리드 삭제 코드 추가함
		AUIGrid.destroy("#grid_wrap_popup");
		myGridIDPrd = null;

        createAUIGridPopup();        
        
        $("#selectPrdBtn").on("click", fnPrdList);

		AUIGrid.bind(myGridIDPrd, "cellClick", function(event) {
			$.successDialog("<c:out value='${param.id}'/>", event.item);
			$.closeDialog("<c:out value='${param.id}'/>");
		});

		$("#closeBtn").click(function() {
			$.closeDialog("<c:out value='${param.id}'/>");
		});

        fnPrdList();
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGridPopup() {
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

        // 실제로 #grid_wrap_popup 에 그리드 생성
        myGridIDPrd = AUIGrid.create("#grid_wrap_popup", columnLayoutPopup, gridPros);
    }

    var columnLayoutPopup = [
        {
			dataField : "prdDtlSeq",
			headerText : "prdDtlSeq",
			visible:false,
        },{
			dataField : "prdDtlCd",
			headerText : "제품코드",
            width : "15%" ,
            style : "auiLink",
            renderer : { // HTML 템플릿 렌더러 사용
        		type : "TemplateRenderer"
             },
             // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
/*              labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
            	 var template = '';
            	 template += '<a href="javascript:void(0)" class="serach popBtn" data-id="popupStdPrdSel" onclick="GetSelectedRowData()">'+ value +'</a>';
                 template += '';
                 return template;
             } */           	
        },{
			dataField : "prdNm",
			headerText : "제품명",
			/* width : "20%", */
            style : "auiLink",
            renderer : { // HTML 템플릿 렌더러 사용
        		type : "TemplateRenderer"
             },
             // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
/*              labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
                 var template = '';
                 template += '<a href="javascript:void(0)" class="serach popBtn" data-id="popupStdPrdSel" onclick="GetSelectedRowData()">'+ value +'</a>';
                 template += '';
                 return template;
             } */
		},{
			dataField : "faltQty",
			headerText : "입수량",
			width : "0%",	
        },{
			dataField : "taxtCd",
			headerText : "과/면세",
			width : "0%",	
        }		/* ,{
			dataField : "cstUntpc",
			headerText : "애음자단가",
        } */
	];

	function resizeGrid(){
		AUIGrid.resize(myGridIDPrd, $("#grid_wrap_popup").width());
	}

 	function fnPrdList(){
		$.ajax({
			url : "/agn/selectPrdList.do", 
			type : 'POST', 
			data : $("#frmPop").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridIDPrd, data.list);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}
</script>	


<!-- layerPopup -->
    <div class="modal_bg"></div> <!-- modal 배경 -->
    <!-- 제품 등록 -->
    <div class="popWrap mideum modal_wrap" data-popup="popupStdPrdSel">
        <header>
            <h3>제품 등록</h3>
            <button type="button" name="modalCloseBtn" class="closeBtn" id="modalCloseBtn" data-target="popupStdPrdSel" onclick="closePop('popupStdPrdSel')"></button>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3>제품 등록</h3>
            </div>

            <!-- 조회 -->
            <form id="frmPop">	
	            <div class="inquiryBox dtShort">
	                <dl>
	                    <dt>구분</dt>
	                    <dd>
	                        <div class="formWrap">
	                            <select name="searchPart" id="searchPart" class="sel w120 mr10">
	                                <option>전체</option>
	                                <option value="SHTN_NM">제품명</option>
	                                <option value="PRD_DTL_CD">제품코드</option>
	                            </select>                            
	                        </div>
	                    </dd>
	                    
	                    <dd>
	                        <div class="formWrap">
	                            <input type="text" id="searchTxt" class="inp w160 mr7" value="" name="searchTxt">
	                            <button type="button" name="" class="comBtn" id="selectPrdBtn">조회</button>
	                        </div>
	                    </dd>
	                </dl>
	            </div>
			</form>	            
            <!-- 조회 -->

            <div class="girdBoxGroup" style="height:300px">
                <!-- grid -->
                <div class="girdBox" style="height:300px">
                    <div id="grid_wrap_popup"></div>
                </div>
                <!-- grid -->
            </div>

        </div>
        <!-- popCon -->
    </div>
    <!-- 제품 등록 -->
    <!--// layerPopup -->