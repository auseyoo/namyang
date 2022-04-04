<!-- 
	@File Name: 
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 2. 22.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
    var myGridID;
    var myGridID2;
    var myGridID3;

    var gridData = [
        {"id":"#Cust01","cstSecCd":"1주","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust02","cstSecCd":"2주","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust03","cstSecCd":"3주","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust04","cstSecCd":"4주","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust05","cstSecCd":"5주","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust06","cstSecCd":"6주","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"}
    ];
    var gridData2 = [
        {"id":"#Cust01","prdCd":"00720","prdNm":"자연불가리스사과150ml","pttnUntpc":"500888"},
		{"id":"#Cust02","prdCd":"00720","prdNm":"자연불가리스사과150ml","pttnUntpc":"500"},
        {"id":"#Cust03","prdCd":"00720","prdNm":"자연불가리스사과150ml","pttnUntpc":"500888"},
		{"id":"#Cust04","prdCd":"00720","prdNm":"자연불가리스사과150ml","pttnUntpc":"500"},
        {"id":"#Cust05","prdCd":"00720","prdNm":"자연불가리스사과150ml","pttnUntpc":"500888"}
    ];
    var gridData3 = [
        {"id":"#Cust01","cstSecCd":"1주","numeric":"1","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust02","cstSecCd":"2주","numeric":"1","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust03","cstSecCd":"3주","numeric":"1","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust04","cstSecCd":"4주","numeric":"1","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
		{"id":"#Cust05","cstSecCd":"5주","numeric":"1","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"},
        {"id":"#Cust06","cstSecCd":"6주","numeric":"1","month":"1","tuesday":"1","Wed":"2","Thursday":"2","Friday":"1","Saturday":"1","Sunday":"1","totalQuant":"3"}
    ];
   
   $(document).ready(function(){
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.        
        
        AUIGrid.setGridData(myGridID, gridData);
        AUIGrid.setGridData(myGridID2, gridData2);
        AUIGrid.setGridData(myGridID3, gridData3);
	    //AUIGrid.setFooter(myGridID, footerLayout);
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 30,
                rowHeight : 29,
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

                showRowNumColumn : false,
                width: `100%`

                
                
        };

        var gridPros2 = {
            headerHeight : 30,
			rowHeight : 30,
			showRowCheckColumn : true, // 체크박스 사용
            showRowNumColumn : false,
            rowCheckToRadio : true,
            rowNumColumnWidth : 80,
            enterKeyColumnBase : true,
            editingOnKeyDown : true,
		}

        var gridPros3 = {
            headerHeight : 30,
			rowHeight : 30,
            showRowNumColumn : false,
            rowCheckToRadio : true,
            enterKeyColumnBase : true,
            editingOnKeyDown : true,
            editable : true,
		}
        
        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
        myGridID3 = AUIGrid.create("#grid_wrap3", columnLayout3, gridPros3);
    }

    var columnLayout = [{
			dataField : "cstSecCd",
			headerText : "구분",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter"

        },{
			dataField : "month",
			headerText : "월",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter"
		},{
			dataField : "tuesday",
			headerText : "화",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter"
		},{
			dataField : "Wed",
			headerText : "수",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter"
		},{
			dataField : "Thursday",
			headerText : "목",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter"
		},{
			dataField : "Friday",
			headerText : "금",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter"
		},{
			dataField : "Saturday",
			headerText : "토",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter, hColor01"
		},{
			dataField : "Sunday",
			headerText : "일",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter hColor02",          
		},{
			dataField : "totalQuant",
			headerText : "총수량",
            style: "auiCenter",
            headerStyle : "auiCenter"
		}
	];

    var columnLayout2 = [{
			dataField : "prdCd",
			headerText : "제품코드",
            width : "25%",
            style: "auiCenter",
            headerStyle : "auiCenter"
        },{
			dataField : "prdNm",
			headerText : "제품명",
            style: "auiLeft",
            headerStyle : "auiCenter"
        },{
			dataField : "pttnUntpc",
			headerText : "지역 애음자단가",
            width : "25%",
			formatString : "#,##0",
            style: "auiRight",
            headerStyle : "auiCenter"
            
        }
	];

    var columnLayout3 = [{
			dataField : "cstSecCd",
			headerText : "구분",
            width : "10%",
            style: "auiCenter",
            headerStyle : "auiCenter",
            editable : false,
        },{
			dataField : "numeric",
			headerText : "수량",
            width : "9.2%",
            style: "auiCenter",
            headerStyle : "auiCenter",
            editable : true,
            renderer : {
                type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                var template = '<div class="my_div">';
                template += '<span class="my_div_text_box center">' + value + '</span>';
                template += '</div>';
                return template;
            }
        },{
			dataField : "month",
			headerText : "월",
            width : "9.2%",
            style: "auiCenter",
            headerStyle : "auiCenter",
            editable : true,
            headerRenderer : {
                type : "CheckBoxHeaderRenderer",
                dependentMode : true, 			
                position : "left" // 기본값 "bottom"
            },
            renderer : {
                type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                var template = '<div class="my_div">';
                template += '<span class="my_div_text_box center">' + value + '</span>';
                template += '</div>';
                return template;
            }
		},{
			dataField : "tuesday",
			headerText : "화",
            width : "9.2%",
            style: "auiCenter",
            editable : true,
            headerStyle : "auiCenter",
            headerRenderer : {
                type : "CheckBoxHeaderRenderer",
                dependentMode : true, 			
                position : "left" // 기본값 "bottom"
            },
            renderer : {
                type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                var template = '<div class="my_div">';
                template += '<span class="my_div_text_box center">' + value + '</span>';
                template += '</div>';
                return template;
            }
		},{
			dataField : "Wed",
			headerText : "수",
            width : "9.2%",
            style: "auiCenter",
            editable : true,
            headerStyle : "auiCenter",
            headerRenderer : {
                type : "CheckBoxHeaderRenderer",
                dependentMode : true, 			
                position : "left" // 기본값 "bottom"
            },
            renderer : {
                type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                var template = '<div class="my_div">';
                template += '<span class="my_div_text_box center">' + value + '</span>';
                template += '</div>';
                return template;
            }
		},{
			dataField : "Thursday",
			headerText : "목",
            width : "9.2%",
            style: "auiCenter",
            editable : true,
            headerStyle : "auiCenter",
            headerRenderer : {
                type : "CheckBoxHeaderRenderer",
                dependentMode : true, 			
                position : "left" // 기본값 "bottom"
            },
            renderer : {
                type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                var template = '<div class="my_div">';
                template += '<span class="my_div_text_box center">' + value + '</span>';
                template += '</div>';
                return template;
            }
		},{
			dataField : "Friday",
			headerText : "금",
            width : "9.2%",
            style: "auiCenter",
            editable : true,            
            headerStyle : "auiCenter",
            headerRenderer : {
                type : "CheckBoxHeaderRenderer",
                dependentMode : true, 			
                position : "left" // 기본값 "bottom"
            },
            renderer : {
                type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                var template = '<div class="my_div">';
                template += '<span class="my_div_text_box center">' + value + '</span>';
                template += '</div>';
                return template;
            }
		},{
			dataField : "Saturday",
			headerText : "토",
            width : "9.2%",
            style: "auiCenter",
            editable : true,
            headerStyle : "auiCenter hColor01",
            headerRenderer : {
                type : "CheckBoxHeaderRenderer",
                dependentMode : true, 			
                position : "left" // 기본값 "bottom"
            },
            renderer : {
                type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                var template = '<div class="my_div">';
                template += '<span class="my_div_text_box center">' + value + '</span>';
                template += '</div>';
                return template;
            }
		},{
			dataField : "Sunday",
			headerText : "일",
            width : "9.2%",
            style: "auiCenter",
            editable : true,
            headerStyle : "auiCenter hColor02",
            headerRenderer : {
                type : "CheckBoxHeaderRenderer",
                dependentMode : true, 			
                position : "left" // 기본값 "bottom"
            },
            renderer : {
                type : "TemplateRenderer"
            },
            // dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
            labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
                var template = '<div class="my_div">';
                template += '<span class="my_div_text_box center">' + value + '</span>';
                template += '</div>';
                return template;
            }    
		},{
			dataField : "totalQuant",
			headerText : "총수량",
            style: "auiCenter",
            editable : false,
            headerStyle : "auiCenter"
		}
	];

    


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
    <!-- 투입 변경 -->
    <div class="modal_bg" style="display:block"></div> <!-- modal 배경 -->
    <div class="popWrap large modal_wrap h942" data-popup="modalAgencyViews" style="display:block; left:0; right:0; margin:62px auto; overflow: auto;"> <!-- small 사이즈 600px * 370px -->
        <header>
            <h3>투입 변경</h3>
        </header>  

        <!-- popCon -->
        <div class="popCon">
            <div class="popTitArea">
                <h3 class="pb10">투입 변경</h3>
    
                <div class="popBtnArea">
                    <button type="button" name="" class="comBtn" id="modalCloseBtn">닫기</button>
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
                                <th scope="row">
                                    <label for="datepicker" class="required" title="필수입력">시작일자</label>
                                </th>
                                <td>
                                    <div class="formWrap">
                                        <div class="dateWrap">
                                            <input type="text" name="date" value="10/24/1984" class="inp w160" id="datepicker" readonly="">
                                            <button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
                                        </div>
                                    </div>
                                </td>
                                <th>
                                     <label for="datepicker" class="required" title="필수입력">출력일자</label>
                                </th>
                                <td>
                                    <div class="formWrap" style="justify-content: flex-start; align-items: center;">
                                        <div class="dateWrap">
                                            <input type="text" name="date" value="10/24/1984" class="inp w160" id="datepicker02" readonly="">
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

                <!-- 변경 전 -->
                <div class="tblWrap">
                    <div class="titleArea">
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
                                <th scope="row">
                                    <label for="check_packPd01">제품명</label>
                                </th>
                                <td>
                                    <div class="formWrap jStart alignCenter">
                                        <span>깜유홈 900ml</span>
                                        <!-- <div class="checkGroup ml20">
                                            <input type="checkbox" id="check_packPd01" class="type01"><label for="check_packPd01"><span>패키지제품</span></label>
                                        </div> -->
                                    </div>
                                </td>
                                <th>
                                     <label for="datepicker">단가/수량</label>
                                </th>
                                <td>
                                   <p>700원 / 1개</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="memo01" class="required" title="필수입력">투입패턴</label>
                                </th>
                                <td colspan="3">
                                    <!-- grid -->
                                    <div class="girdBox mt8">
                                        <div id="grid_wrap" style="width: 536px; height: 215px;"></div>
                                    </div>
                                    <!-- grid -->
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                 <!--// 변경 전 -->

                <!-- 변경 후 -->
                <div class="tblWrap">
                    <div class="titleArea right">
                        <h3 class="tit01">변경 후</h3>
                        <p class="txt01"><i class="icoRequir"></i>필수 입력 항목입니다.</p>
                    </div>
                    <table class="tbl">
                        <caption>변경 후</caption>
                        <colgroup>
                            <col style="width:164px;">
                            <col>
                            <col style="width:164px;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">
                                    <label for="inp_prDt" class="required" title="필수입력">변경항목</label>
                                </th>
                                <td colspan="3">
                                    <select name="" class="sel w160" id="inp_prDt" value="제품">
                                        <option selected>제품</option>
                                        <option>단가</option>
                                        <option>투입패턴</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="inp_prNm02" class="required" title="필수입력">제품명</label>
                                </th>
                                <td>
                                    <div class="formWrap jStart alignCenter">
                                        <div class="postWrap w160">
                                            <input type="text" id="inp_prNm02" class="inp">
                                            <button type="button" class="postBtn" title="찾기"></button>
                                        </div>
                                        <!-- <div class="checkGroup ml20">
                                            <input type="checkbox" id="check_packPd02" class="type01"><label for="check_packPd02"><span>패키지제품</span></label>
                                        </div> -->
                                    </div>    
                                    
                                    <!-- grid -->
                                    <div class="girdBox mt14 mb20">
                                        <div id="grid_wrap2" style="width: 100%; height: 185px;"></div>
                                    </div>
                                    <!-- grid -->
                                </td>
                                <th scope="row" rowspan="2">
                                    <label for="memo01" class="required" title="필수입력">투입패턴</label>
                                </th>
                                <td rowspan="2">
                                    <div class="checkGroup mtmt25">
                                        <input type="checkbox" id="inp_check_same" class="type01"><label for="inp_check_same"><span>변경 전과 동일</span></label>
                                    </div>
                                        
                                    <!-- grid -->
                                    <div class="girdBox mt10">
                                        <div id="grid_wrap3" style="width: 100%; height: 215px;"></div>
                                    </div>
                                    <!-- grid -->
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <label for="inp_rgPrice" class="required" title="필수입력">지역 애음자단가</label>
                                </th>
                                <td colspan="3">
                                    <div class="formWrap jStart alignCenter">
                                        <input type="text" id="inp_rgPrice" class="inp w160 bg_gray ar pColor01" value="800" name="" readonly>
                                        <span class="ml5 vaMd">원</span>
                                    </div>
                                </td>
                            </tr>
                             <tr>
                                <th scope="row">
                                    <label for="sel_prDt" class="required" title="필수입력">무료/할인</label>
                                </th>
                                <td>
                                    <select name="" class="sel w160 mr20" id="sel_prDt" value="할인">
                                        <option>무료</option>
                                        <option selected>할인</option>
                                    </select>
                                    <button type="button" name="" class="comBtn small">추가</button>
                                </td>
                                <th scope="row">
                                    <label for="inp_rgPrice" class="required" title="필수입력">적용단가<br/>(애음자 개별단가)</label>
                                </th>
                                <td>
                                    <div class="formWrap jStart alignCenter">
                                        <input type="text" id="inp_rgPrice" class="inp w160 bg_gray ar pColor01 ml20" value="800" name="" readonly>
                                        <span class="ml5 vaMd">원</span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!--// 변경 후 -->
            </div>
        </div>
        <!-- popCon -->
    </div>
    <!--// 투입 변경 -->
</body>
</html>