<!-- 
	@File Name: invryMst.jsp
	@File 설명 : 재고 관리
	@UI ID : UI-PORD-0801.html
	@작성일 : 2022.02.14
	@작성자 : 김정애
	
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------

 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="/css/lib/MonthPicker.min.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="https://cdn.rawgit.com/digitalBush/jquery.maskedinput/1.4.1/dist/jquery.maskedinput.min.js"></script>
<script src="/js/lib/MonthPicker.min.js"></script>
<script type="text/javascript" src="/js/lib/daterangepicker.js"></script>
<script type="text/javascript">
    var myGridID;

    $(document).ready(function(){

     	/* 월달력 미래일자 선택 막기, 적용하면 디자인 변경됨  */
     	var options = {
    			MonthFormat: 'yy-mm',
    			SelectedMonth: new Date().getFullYear() + '-' + (new Date().getMonth()+1),
    			ShowIcon: false,
    			MaxMonth: 0,
    			i18n: {
    				year: '년도',
    				prevYear: '이전년도',
    				nextYear: '다음년도',
    				next12Years: '다음 12년',
    				prev12Years: '이전 12년',
    				nextLabel: '다음',
    				prevLabel: '이전',
    				buttonText: 'Open Month Chooser',
    				jumpYears: '년도로 이동',
    				backTo: '뒤로',
    				months: ['1 월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    			}
    	};
    	$('#monthPicker').MonthPicker(options);
    	
        createAUIGrid(columnLayout);
        
        fnSearchList();
	    AUIGrid.setFooter(myGridID, footerLayout);	    

	    $("#selectBtn").on("click", fnSearchList);
	    $("#excelBtn").on("click", fnExcelDown);

		let popupObjSave = {};
        popupObjSave.title = "크레이트 반납 관리";
        popupObjSave.message = '<spring:message code="alert.msgInvryMst1" />';        
        popupObjSave.showBtn1 = 'Y';
        popupObjSave.btn1Func = fnSaveCrtbRtgd;        
        popupObjSave.showBtn2 = 'Y';
		$("#saveBtn").on("click", popupObjSave, layerAlert);
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid(columnLayout) {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 29,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : true,
                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,

				showRowNumColumn : false, 
                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "singleRow",
                showFooter : true,
                
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
    
        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        
    }

    var columnLayout = [{
            dataField : "day",
			headerText : "일자",
			width : "5%",
		},
		<c:forEach var="crtbCd" items="${crtbCdList}" varStatus="status">	
		{
            dataField : "${crtbCd.prdNm}", 
            headerText : "${crtbCd.prdNm}",        
            children : [
            	{
                    dataField : "crtbRtgdSeq${status.index+1}",
                    headerText : "시퀀스",
                    visible:false
            	}, {
                    dataField : "crtbCd${status.index+1}",
                    headerText : "크레이트코드",
                    visible:false                       
            	}, {
                    dataField : "selDt${status.index+1}",
                    headerText : "일시",
                    visible:false                          
            	}, {
                    dataField : "rtgdDt${status.index+1}",
                    headerText : "수령반납일시",
                    visible:false                    
                }, {
                    dataField : "yestdQty${status.index+1}",
                    headerText : "전일재고",
                    visible:false
                }, {
                    dataField : "invryQty${status.index+1}",
                    headerText : "현재고",
                    visible:false
                }, {
                    dataField : "dlvyQty${status.index+1}",
                    headerText : "물류출고",
                    width:"7%",
					style: "auiRight",
					styleFunction :  function(rowIndex, columnIndex, value, headerText, item, dataField) {
						if((item.day != '이월') 
								&& (item.dlvyQty${status.index+1} != item.reptQty${status.index+1})) {
							return "dataChange";
						}
						return null;
					}
                }, {
                    dataField : "reptQty${status.index+1}",
                    headerText : "수령",
					width:"6%",
                    style: "auiRight",
                    editable : true,
                    dataType : "numeric",
                    editRenderer : {
                           type : "InputEditRenderer",
                           allowNegative: true, // 음수 부호 입력(-) 허용 여부
                           onlyNumeric : true, // 0~9 까지만 허용
    				},
					renderer : { 
						type : "TemplateRenderer"
					},
					labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
						var template = '';
						if(item.day != '이월'){
							template = '<div class="my_div">';
							template += '<span class="my_div_text_box right">' + value + '</span>';
							template += '</div>';
						}else{
							template += value;
						}
						return template;
					},
					styleFunction :  function(rowIndex, columnIndex, value, headerText, item, dataField) {
						if((item.day != '이월') 
								&& (item.dlvyQty${status.index+1} != item.reptQty${status.index+1})) {
							return "dataChange";
						}
						return null;
					}
                }, {
                    dataField : "coletQty${status.index+1}",
                    headerText : "물류회수",
					width:"7%",
                    style: "auiRight",
					styleFunction :  function(rowIndex, columnIndex, value, headerText, item, dataField) {
						if((item.day != '이월') 
								&& (item.coletQty${status.index+1} != item.rtgdQty${status.index+1})) {
							return "dataChange";
						}
						return null;
					}
                }, {
                    dataField : "rtgdQty${status.index+1}",
                    headerText : "반납",
					width:"6%",
                    style: "auiRight",
                    editable : true,
                    dataType : "numeric",
                    editRenderer : {
                           type : "InputEditRenderer",
                           allowNegative: true, // 음수 부호 입력(-) 허용 여부
                           onlyNumeric : true, // 0~9 까지만 허용
    				},
					renderer : { 
						type : "TemplateRenderer"
					},
					labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
						var template = '';
						if(item.day != '이월'){
							template = '<div class="my_div">';
							template += '<span class="my_div_text_box right">' + value + '</span>';
							template += '</div>';
						}else{
							template += value;
						}
						return template;
					},
					styleFunction :  function(rowIndex, columnIndex, value, headerText, item, dataField) {
						if((item.day != '이월') 
								&& (item.coletQty${status.index+1} != item.rtgdQty${status.index+1})) {
							return "dataChange";
						}
						return null;
					}
            }]
        },
        </c:forEach>
	];

    // 푸터 설정
    var footerLayout = [{
        labelText : "∑",
        positionField : "#base"
        }, {
            dataField : "day",
            positionField : "day",
            operation : "SUM",
            colSpan : 5, // 자신을 포함하여 4개의 푸터를 가로 병합함.
            labelFunction : function(value, columnValues, footerValues) {
               return "재고 : " 
            }
        },
        <c:forEach var="crtbCd" items="${crtbCdList}" varStatus="status">
        {
        	dataField : "reptQty${status.index+1}",
        	operation : "SUM"
        },{
        	positionField : "rtgdQty${status.index+1}",
        	dataField : "rtgdQty${status.index+1}",
        	operation : "SUM"
        },{
        	positionField : "rtgdQty${status.index+1}",
        	dataField : "invryQty${status.index+1}",
        	style: "auiRight",
        	formatString : "#,##0",
        	/* value : operation 지정 한 경우 계산된 값,
        	* columnValues : dataField 에 해당되는 모든 칼럼의 값들(Array),
        	* footerValues : 푸터 전체 operation 수행된 값 또는 labelText 값 (Array)
        	*/
        	labelFunction : function(value, columnValues, footerValues) {
            	var prevMonthQty = AUIGrid.getCellValue(myGridID, 0, "rtgdQty${status.index+1}");
        		var footerValuesIndex = 2 + (3*${status.index});
        		        		
        		// 이월 row에서 이전달 재고수량을 [반납]컬럼 위치에 표시되어 sum이 계산되어서, 아래 수식으로 처리했음 
        		var newValue = prevMonthQty + (footerValues[footerValuesIndex] - (footerValues[footerValuesIndex + 1] - prevMonthQty));
        		return newValue;
        	},
        },        	
		</c:forEach>
	];


 	function fnSearchList(){
 	 	
		$.ajax({
			url : "/agn/selectCrtbRtgdList.do", 
			type : 'POST', 
			data : $("#frm").serialize(),
			success : function(data) {
				
				AUIGrid.setGridData(myGridID, data.list);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}

 	// 저장
 	function fnSaveCrtbRtgd(){

		/* 저장 이벤트 호출시 날짜 체크 시작 */
		var now = new Date();	
		var oneMonthAgo = new Date(now.setMonth(now.getMonth() - 1));
		var oneMonthMonth = ("0" + (1 + oneMonthAgo.getMonth())).slice(-2);
	    var oneMonthAgoYm = oneMonthAgo.getFullYear() + oneMonthMonth;

	    var selYm = $("#monthPicker").val().replaceAll("-","");
		selYm = new Date(selYm.substring(0, 4), Number(selYm.substring(4, 6)) -1, 1);
		var selYmMonth = ("0" + (1 + selYm.getMonth())).slice(-2);
	    var selYm = selYm.getFullYear() + selYmMonth;

		if(oneMonthAgoYm > selYm){
			alert("저장은 이전달까지만 가능합니다.");
			return;
		}
		/* 저장 이벤트 호출시 날짜 체크 종료 */

 		var today = new Date();
 		var year = today.getFullYear();
 		var month = ('0' + (today.getMonth() + 1)).slice(-2);
 		var day = ('0' + today.getDate()).slice(-2);
 		var dateString = year + month + day;

		var saveData = new Array();
		<c:forEach var="crtbCd" items="${crtbCdList}" varStatus="status">	
		$.each(AUIGrid.getGridData(myGridID), function(idx,item){
			if((item.selDt${status.index+1} <= dateString) // 미래일자는 갱신하지 않도록 날짜 체크함
					&& (item.reptQty${status.index+1} > 0 || item.rtgdQty${status.index+1} > 0)){
				saveData.push({
					"crtbRtgdSeq" : item.crtbRtgdSeq${status.index+1},
					"crtbCd" : item.crtbCd${status.index+1},
					"rtgdDt" : item.selDt${status.index+1},
					"reptQty" : item.reptQty${status.index+1},
					"rtgdQty" : item.rtgdQty${status.index+1}
				});				
			}
		});
		</c:forEach>

		$.ajax({
			url : "/agn/saveCrtbRtgd.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(saveData),
			success : function(data) {
				//alert( data );
				alert("저장되었습니다.");
				/* popupParam.data = {
					title : "반품 등록",
			 	 	message : "<spring:message code='alert.msgRtgdReg7' />",
			 	 	showBtn2 : 'N'
				};
		 		layerAlert(popupParam); */
				
				//리스트 조회
				fnSearchList();
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	 	
	}	

	function fnExcelDown(){
		AUIGrid.exportToXlsx(myGridID, {
		      // 스타일 상태 유지 여부(기본값:true)
		      exportWithStyle : true,
		      fileName : "크레이트 반납"
		   });
	}
	
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />
	
	<!-- 조회 -->
	<form id="frm">
		<div class="inquiryBox">
			<dl>
				<dt>조회월</dt>
				<dd>
					<div class="formWrap">
						<div class="dateWrap">
							<input type="text" name="reqYm" value="" class="inp monthPicker" id="monthPicker" readonly>
							<button type="button" class="datepickerBtn" title="날짜입력"
								data-target-id="monthPicker"></button>
						</div>
	
						<button type="button" name="" class="comBtn" id="selectBtn">조회</button>
					</div>
				</dd>
			</dl>
	
			<div class="btnGroup right">
				<button type="button" name="" class="comBtn" id="excelBtn">엑셀다운</button>
				<button type="button" name="" class="inquBtn" id="saveBtn">저장</button>
			</div>
		</div>
	</form>		
	<!-- 조회 -->

	<div class="txtInfo pColor02">※ 대리점에서 파악하고 있는 수량과 조회되는 수량이 다른
		크레이트는 음영으로 표시됩니다. / 수령 : 물류센터 → 대리점 / 반납 : 대리점 → 물류센터</div>

	<!-- grid -->
	<div class="girdBox">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->

</div>
