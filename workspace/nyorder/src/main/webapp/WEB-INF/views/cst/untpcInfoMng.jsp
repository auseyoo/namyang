<!-- 
	@File Name: UntpcMng.jsp
	@File 설명 : 지역 / 애음자 단가 관리 페이지
	@UI ID : 
	@작성일 : 2022. 1. 26.
	@작성자 : JIHUN
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
	var myGridID;
    var myGridID2;
	var myGridID3;
    var myGridID4; 

	var searchRowIdx; // 제품 검색시 변경될 row의 rowid

	$(document).ready(function(){
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();

		searchAgenAreaList('', 'empl');
		searchAgenAreaList('' ,'cst');

		init();
    });
    
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
        // 그리드 속성 설정
        var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			editable : false,
			enterKeyColumnBase : true,
			selectionMode : "multipleCells",
			useContextMenu : true,
			enableFilter : true,
			useGroupingPanel : false,
			showRowCheckColumn : false,
			displayTreeOpen : true,
			noDataMessage : "출력할 데이터가 없습니다.",
			groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
			editableOnFixedCell : true,
			enableSorting : false,
			selectionMode : "multipleCells",
			rowIdField : "areaSeq",
			editableOnFixedCell : true, 
			triggerSelectionChangeOnCell : true, 
			softRemovePolicy :"exceptNew",
			wrapSelectionMove : true,
			simplifySelectionEvent : true        
		}

        var gridPros2 = {
			headerHeight : 29,
            rowHeight : 29,
            editable : true,
            enterKeyColumnBase : true,
            selectionMode : "multipleCells",
            useContextMenu : true,
            enableFilter : true,
            useGroupingPanel : false,
            showRowCheckColumn : true,
            displayTreeOpen : true,
            noDataMessage : "출력할 데이터가 없습니다.",
            groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
            editableOnFixedCell : true,
            enableSorting : false,
            selectionMode : "multipleCells",
            rowIdField : "prdDtlSeq",
            editableOnFixedCell : true, 
            triggerSelectionChangeOnCell : true,
			softRemoveRowMode: false,
            softRemovePolicy :"exceptNew",
            wrapSelectionMove : true,
            simplifySelectionEvent : true    
		}

        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);

		myGridID3 = AUIGrid.create("#grid_wrap3", columnLayout3, gridPros);
        myGridID4 = AUIGrid.create("#grid_wrap4", columnLayout4, gridPros2);

    }

	var regex = new RegExp(/[a-zA-Z]/g);

    var columnLayout = [{
            dataField : "areaSeq",
			headerText : "지역코드",
            width : "38%",
            style: "auiLink"
		},{
			dataField : "areaNm",
			headerText : "지역명",
		}
	];

	var columnLayout2 = [{
			dataField: "areaPrdSeq",
			visible: false,
			editable: false,
		},{
			dataField: "areaSeq",
			visible: false
		},{
			dataField: "prdDtlCd",
			headerText: "제품코드",
			editable: false,
			width: "10%",
			renderer: { // HTML 템플릿 렌더러 사용
				type: "TemplateRenderer"
			},
			labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
				if(item.prdDtlCd){
					var template = item.prdDtlCd
				}else{
					var template = '<div class="searchWrap">';
					template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop(' + rowIndex + '); \'></a></span>';
					template += '</div>';
				}
				return template;
			}
		}, {
			dataField: "prdNm",
			headerText: "제품명",
			style: "auiLeft",
			editable: false,
			renderer: { // HTML 템플릿 렌더러 사용
				type: "TemplateRenderer"
			},
			labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
				if(item.prdNm){
					var template = item.prdNm
				}else{
					var template = '<div class="searchWrap">';
					template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop(' + rowIndex + '); \'></a></span>';
					template += '</div>';
				}
				return template;
			}
		}, {
			dataField: "pchaUntpc",
			headerText: "매입<br>단가",
			dataType: "numeric",
			editable: false,
			width: "9%"
		}, {
			// dataField: "untpc",
			headerText: "판매원단가",
			children: [{
				dataField: "spprc",
				headerText : "공급가",
				dataType : "numeric",
				width : "7%",
				style : "auiRight",
				editable : false
			}, {
				dataField: "vatCt",
				headerText : "VAT",
				dataType : "numeric",
				width : "7%",
				style : "auiRight",
				editable : false
			}, {
				dataField: "untpc",
				headerText : "計",
				dataType : "numeric",
				width : "7%",
				style : "auiRight",
				editable : false
			}]
		}, {
			dataField: "mrgnCt",
			headerText : "대리점<br/>마진",
			dataType : "numeric",
			width : "7%",
			editable : false
		}, {
			dataField: "mrgnRate",
			headerText : "마진율<br/>(%)",
			dataType : "numeric",
			width : "7%",
			editable : false  
		}, {
			dataField: "chgUntpc",
			headerText: "변경<br/>단가",
			editable: true,
			dataType: "numeric",
			formatString: "#,##0",
			width: "7%",
			editable: true,
			renderer: { // HTML 템플릿 렌더러 사용
				type: "TemplateRenderer"
			},
			// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
			labelFunction: function(rowIndex, columnIndex, value, headerText, item) { // HTML 템플릿 작성
				var template = '<div class="my_div">';
				template += '<span class="my_div_text_box center">'+ value +'</span>';
				template += '</div>';
				return template;
			}
		},{
			dataField: "puchSeq",
			visible: false,
		},{
			dataField: "chgMrgnCt",
			headerText: "변경<br/>마진",
			width: "8%",
			style: "auiRight",
			editable: false,
		}, {
			dataField: "chgMrgnRate",
			headerText: "변경<br/>마진율",
			width: "7%",
			style: "auiRight",
			editable: false,
		}, {
			dataField: "chgApplDt",
			headerText: "적용<br/>일자",
			editable: true,
			width: "12%",
			dataType: "date",
			dateInputFormat: "yyyy/mm/dd", // 실제 데이터의 형식 지정
			formatString: "yyyy - mm - dd", // 실제 데이터 형식을 어떻게 표시할지 지정
			renderer: {
				type: "IconRenderer",
				iconWidth: 24, // icon 사이즈, 지정하지 않으면 rowHeight에 맞게 기본값 적용됨
				iconHeight: 24,
				iconPosition: "aisleRight",
				iconTableRef: { // icon 값 참조할 테이블 레퍼런스
					"default": "../images/AUIGrid/calendar-icon.png" // default
				},
				onClick: function(event) {
					// 달력 아이콘 클릭하면 실제로 달력을 띄움.
					// 즉, 수정으로 진입함.
					console.log(event);
					AUIGrid.openInputer(event.pid);
				}
			},
			editRenderer: {
				type: "CalendarRenderer",
				defaultFormat: "yyyymmdd", // 달력 선택 시 데이터에 적용되는 날짜 형식
				showEditorBtn: false,
				showEditorBtnOver: false, // 마우스 오버 시 에디터버턴 출력 여부
				// showPlaceholder:true,
				onlyCalendar: true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays: true // 지난 달, 다음 달 여분의 날짜(days) 출력
			}
		}
	];

	var columnLayout3 = [{
			dataField : "areaSeq",
			headerText : "지역코드",
			width : "38%",
			style: "auiLink"
		},{
			dataField : "areaNm",
			headerText : "지역명",
		}
	];

	var columnLayout4 = [
		{
			dataField : "cstSpprcSeq",
			visible: false,
		}, {
			dataField : "prdDtlCd",
			headerText : "제품코드",
			width : "10%",
			renderer : { // HTML 템플릿 렌더러 사용
				type : "TemplateRenderer"
			},
			// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
			labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
				if(item.prdDtlCd){
					var template = item.prdDtlCd
				}else{
					var template = '<div class="searchWrap">';
					template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop(' + rowIndex + '); \' ></a></span>';
					template += '</div>';
				}
				return template;
			}
		},{
			dataField : "prdNm",
			headerText : "제품명",
			style:"auiLeft",
			renderer : { // HTML 템플릿 렌더러 사용
				type : "TemplateRenderer"
			},
			// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
			labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
				if(item.prdNm){
					var template = item.prdNm
				}else{
					var template = '<div class="searchWrap">';
					template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop(' + rowIndex + '); \' ></a></span>';
					template += '</div>';
				}
				return template;
			}
		},{
			dataField : "pchaUntpc",
			headerText : "매입<br>단가",
			width : "9%",
			editable : false,
		},{
			dataField : "emplUntpc",
			headerText : "판매원<br>단가",
			width : "9%",
			editable : false,
		},{
			headerText : "애음자단가",
			children : [{
				dataField : "spprc",
				headerText : "공급가",
				dataType : "numeric",
				width : "7%",
				style : "auiRight",
				editable : false
			}, {
				dataField : "vatCt",
				headerText : "VAT",
				dataType : "numeric",
				width : "7%",
				style : "auiRight",
				editable : false
			}, {
				dataField : "untpc",
				headerText : "計",
				dataType : "numeric",
				width : "7%",
				style : "auiRight",
				editable : false
			}]  
        },{
            dataField : "mrgnCt",
            headerText : "판매원<br>마진",
            dataType : "numeric",
            width : "7%",
            editable : false
        },{
            dataField : "mrgnRate",
            headerText : "마진율<br/>(%)",
            dataType : "numeric",
            width : "7%",
            editable : false                
        },{
            dataField : "chgUntpc",
            headerText : "변경<br/>단가",
            dataType : "numeric",
            width : "7%",
            style : "auiRight",
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
            dataField : "chgMrgnCt",
            headerText : "변경<br/>마진",
            width : "8%",
            style : "auiRight",
            editable : false                     
        },{
            dataField : "chgMrgnRate",
            headerText : "변경<br/>마진율",
            width : "7%",
            style : "auiRight",
            editable : false
        },{
            dataField : "chgApplDt",
            headerText : "적용<br/>일자",
            width : "12%",
            dataType : "date",
            dateInputFormat : "yyyy/mm/dd", // 실제 데이터의 형식 지정
            formatString : "yyyy - mm - dd", // 실제 데이터 형식을 어떻게 표시할지 지정
            renderer : {
                type : "IconRenderer",
                iconWidth : 24, 
                iconHeight : 24,
                iconPosition : "aisleRight",
                iconTableRef :  { 
                    "default" : "../images/AUIGrid/calendar-icon.png"
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
        }
    ];

	// methods

	function init() {
		AUIGrid.bind(myGridID, "selectionChange", function(event) {
			var cell = event.primeCell;
			var rowItem = cell.item;
			var areaSeq = rowItem.areaSeq;

			var prdDtlCd = $("#emplPrdDtlCd").val();
			var prdNm = $("#emplPrdNm").val();

			var param = {
				prdDtlCd,
				prdNm,
				areaSeq
			};
			searchUntpcList(param);
		});

		AUIGrid.bind(myGridID3, "selectionChange", function(event) {
			var cell = event.primeCell;
			var rowItem = cell.item;
			var areaSeq = rowItem.areaSeq;

			var prdDtlCd = $("#cstPrdDtlCd").val();
			var prdNm = $("#cstPrdNm").val();

			var param = {
				prdDtlCd,
				prdNm,
				areaSeq
			};
			searchCstAreaUntpcList(param);
		})

		var today = fnGetToDay().replace(/-/g, '');

		AUIGrid.bind(myGridID2, "cellEditEnd", function(event) {
			if(event.dataField === 'chgUntpc') {
				var chgUntpc = event.value;
				
				if(chgUntpc === 0 || chgUntpc === null) {
					AUIGrid.setCellValue(myGridID2, event.rowIndex, "chgUntpc", null);
					return;
				}
				var pchaUntpc = event.item.pchaUntpc;

				var data = spprcCalc(pchaUntpc, chgUntpc);
				var param = {
					chgMrgnCt: data.mrgnCt,
					chgMrgnRate: data.mrgnRate
				};

				AUIGrid.updateRow(myGridID2, param, event.rowIndex);
			}

			if(event.dataField === 'chgApplDt') {
				var chgApplDt = event.value;

				if(typeof chgApplDt === 'undefined' || chgApplDt === '') {
					AUIGrid.updateRow(myGridID2, { chgApplDt : fnGetToDay() }, event.rowIndex);
				} else if (chgApplDt < today) {
					alert('적용일자는 당일 기준 미래날짜만 입력 가능합니다.\n날짜를 확인해주세요.');
					AUIGrid.updateRow(myGridID2, { chgApplDt : fnGetToDay() }, event.rowIndex);
				}
			}
		})

		AUIGrid.bind(myGridID4, "cellEditEnd", function(event) {
			if(event.dataField === 'chgUntpc') {
				var chgUntpc = event.value;
				
				if(chgUntpc === 0 || chgUntpc === null) {
					AUIGrid.setCellValue(myGridID4, event.rowIndex, "chgUntpc", null);
					return;
				}
				var emplUntpc = event.item.emplUntpc;

				var data = spprcCalc(emplUntpc, chgUntpc);
				var param = {
					chgMrgnCt: data.mrgnCt,
					chgMrgnRate: data.mrgnRate
				};

				AUIGrid.updateRow(myGridID4, param, event.rowIndex);
			}

			if(event.dataField === 'chgApplDt') {
				var chgApplDt = event.value;

				if(typeof chgApplDt === 'undefined' || chgApplDt === '') {
					AUIGrid.updateRow(myGridID2, { chgApplDt : fnGetToDay() }, event.rowIndex);
				} else if (chgApplDt < today) {
					alert('적용일자는 당일 기준 미래날짜만 입력 가능합니다.\n날짜를 확인해주세요.');
					AUIGrid.updateRow(myGridID2, { chgApplDt : fnGetToDay() }, event.rowIndex);
				}
			}
		})
		
		setTab();
	}

	// 변경된 단가로 마진 / 공급단가 계산
	function spprcCalc(pchaUntpc, chgUntpc) {
		var spprc, vatCt, mrgnCt, mrgnRate;

		// VAT 계산시 원 단위 아래는 절삭
		vatCt = parseInt(Math.floor(((chgUntpc / 1.1) * 0.1)));
		spprc = chgUntpc - vatCt;
		mrgnCt = chgUntpc - pchaUntpc;
		mrgnRate = (mrgnCt / chgUntpc * 100).toFixed(1);
		
		return {
			spprc,
			vatCt,
			mrgnCt,
			mrgnRate
		};
	}

	function getActivedMygridID() {
		return $(".content .tabsWrap .tabs li[class='active']").index() == 0 ? myGridID2 : myGridID4;
	}

	// event
	function openHistoryPop() {
		$.ajaxDialog({
			id: "areaUntpcChgHisPop",
			ajax: {
				url: "/comm/pop/areaUntpcChgHisPop.pop",
			},
			dialog: {
				width: 1500,
				height: 540
			},			
		});
	}

	function openSearchPrdPop(rowIndex) {
		searchRowIdx = rowIndex;

		$.ajaxDialog({
			id: "searchAreaPrdPop",
			ajax: {
				url: "/comm/pop/searchAreaPrdPop.pop",
			},
			dialog: {
				width: 600,
				height: 470,
			},
			success: function(item) {
				var gridID = getActivedMygridID();
				var returnYn = false;
				AUIGrid.getGridData(gridID).forEach(function(data) {
					if(data.prdDtlSeq == item.prdDtlSeq) {
						returnYn = true;
						return;
					}
				});
				if(returnYn) {
					alert("이미 등록된 제품이 존재합니다.");
					return;
				}

				var data = spprcCalc(gridID === myGridID2 ? item.pchaUntpc : item.emplUntpc, item.untpc);

				AUIGrid.updateRow(getActivedMygridID(), {
					prdDtlSeq : item.prdDtlSeq,
					prdNm : item.prdNm,
					pchaUntpc : item.pchaUntpc,
					spprc : data.spprc,
					vatCt : data.vatCt,
					untpc : item.untpc,
					mrgnCt : data.mrgnCt,
					mrgnRate : data.mrgnRate,
					puchSeq : item.puchSeq,
					prdDtlCd : item.prdDtlCd,
					prdSeq : item.prdSeq,
					emplUntpc : item.emplUntpc,
				}, searchRowIdx)

				searchRowIdx = null;
			}
		})
	}

	// 마진율 일괄적용
	function mrgnApply() {
		var gridID = getActivedMygridID();
		var mrgnRateId = gridID == myGridID2 ? '#emplMrgnRate' : '#cstMrgnRate';
		var cutUntpcId = gridID == myGridID2 ? '#emplSelUnit' : '#cstSelUnit';

		var mrgnRate = $(mrgnRateId).val();
		var cutUntpc = $(cutUntpcId).val();

		if(mrgnRate === '') return;

		var rowCount = AUIGrid.getRowCount(gridID);
		var items = [];

		var rowIdField = 'prdDtlSeq';
		var pchaUntpcId = gridID == myGridID2 ? 'pchaUntpc' : 'emplUntpc';

		for(var i = 0; i < rowCount; i++) {
			var rowId = AUIGrid.getCellValue(gridID, i, rowIdField);
			if(rowId) {
				var pchaUntpc = AUIGrid.getCellValue(gridID, i, pchaUntpcId);
				
				var chgUntpc = parseInt(pchaUntpc / (1 - (mrgnRate / 100)) / cutUntpc) * cutUntpc;
				var data = spprcCalc(pchaUntpc, chgUntpc);
				items.push({
					[rowIdField]: rowId,
					chgUntpc,
					chgSpprc: data.spprc || 0,
					chgVatCt: data.vatCt || 0,
					chgMrgnCt: data.mrgnCt || 0,
					chgMrgnRate: data.mrgnRate || 0
				});
			}
		}
		
		AUIGrid.updateRowsById(gridID, items)
	}

	function addRow(pos) {
		var item = new Object();
		
		AUIGrid.addRow(getActivedMygridID() ,item, pos);
	}

	function removeRow(pos) {
		var gridID = getActivedMygridID();
		var areaGridID = gridID == myGridID2 ? myGridID : myGridID3;
		var list = AUIGrid.getCheckedRowItems(gridID);

		if(list.length < 1) {
			alert('삭제할 데이터를 선택해주세요');
			return;
		}

		var mrgnPrdCd = gridID === myGridID2 ? 'EMPL' : 'CST';
		var data = list.reduce(function(acc, cur, idx) {
			var item = cur.item;
			if(item.prdDtlSeq) {
				if(acc.prdDtlSeq) {
					acc.prdDtlSeq.push(item.prdDtlSeq)
				} else {
					acc.prdDtlSeq = [item.prdDtlSeq]
				}
			}

			if (item.prdSeq) {
				if(acc.prdSeq) {
					acc.prdSeq.push(item.prdSeq)
				} else {
					acc.prdSeq = [item.prdSeq];
				}
			}
			return acc;
		}, {});
		var prdDtlSeq = '|' + data.prdDtlSeq.join('|') + '|';
		var prdSeq = '|' + data.prdSeq.join('|') + '|';

		var areaSeq = AUIGrid.getCellValue(areaGridID, AUIGrid.getSelectedIndex(areaGridID)[0], 'areaSeq');
		var param = { mrgnPrdCd, prdDtlSeq, prdSeq, areaSeq };

		$.ajax({
			url : "/cst/deleteAbleCheck.do",
			type : 'POST',
			data : param,
			success : function(data) {
				if(data === 'PRD') {
					alert("제품 일괄 변경 대기 중인 제품은 삭제할 수 없습니다.\n다시 확인해 주세요.");
					return;
				} else if (data === 'CST') {
					alert("애음자가 애음 중인 제품의 단가는 삭제할 수 없습니다.\n다시 확인해 주세요.");
					return;
				}

				AUIGrid.removeRow(gridID, list.map(item => item.rowIndex));
			}
		})
	}

	function exportToXlsx() {
		AUIGrid.exportToXlsx(getActivedMygridID(), {
			exportWithStyle : true,
			fileName : "지역별 단가관리 리스트"
		})
	}

	function searchList() {
		var tabNm = getActivedMygridID() === myGridID2 ? 'empl' : 'cst';
		var areaNm = $('#' + tabNm + 'AreaNm').val();

		searchAgenAreaList(areaNm, tabNm);
	}

	function copyAreaUntpcList() {
		var activeTab = getActivedMygridID() == myGridID2 ? 'empl' : 'cst'
		var areaGridID = activeTab === 'empl' ? myGridID : myGridID3;

		var areaSeq = $('#'+ activeTab +'AreaSeq').val();
		var targetAreaSeq = AUIGrid.getCellValue(areaGridID, AUIGrid.getSelectedIndex(areaGridID)[0], 'areaSeq');
		
		if(activeTab === 'empl') {
			searchUntpcList({ areaSeq, targetAreaSeq });
		} else if (activeTab === 'cst') {
			searchCstAreaUntpcList({ areaSeq, targetAreaSeq });
		}
	}

	function resizeGrid() {
		AUIGrid.resize(myGridID3);
		AUIGrid.resize(myGridID4);
	}

	function copyUntpc(data) {
		var items = [];
		data.forEach(function(d) {
			var item = {};
			item.chgUntpc = d.untpc;
			item.chgMrgnCt = d.mrgnCt;
			item.chgMrgnRate = d.mrgnRate;
			item.prdDtlSeq = d.prdDtlSeq;
			items.push(item);
		});

		AUIGrid.updateRowsById(getActivedMygridID(), items);
	}

	/* api */

	function saveUntpcList() {
		var gridID = getActivedMygridID();
		var areaGridID = gridID === myGridID2 ? myGridID : myGridID3;

		var data = fnGetGridListCRUD(gridID);
		
		if(data.length === 0) {
			alert('수정 데이터가 없습니다.');
			return;
		}
		var areaSeq = AUIGrid.getCellValue(myGridID, AUIGrid.getSelectedIndex(areaGridID)[0], "areaSeq");
		var today = fnGetToDay().replace(/-/g, '');
		data.map(function(item) {
			if(item.crudMode === 'D') {
				item.removeYn = 'Y'
			} else {
				item.removeYn = 'N'
			}

			if(item.chgApplDt === null || typeof item.chgApplDt === 'undefined') {
				item.chgApplDt = today;
				item.lastYn = 'Y';
			} else if (item.chgApplDt != today) {
				item.lastYn = 'N';
			}

			if(item.crudMode === 'C') {
				if(typeof item.chgUntpc === 'undefined' || item.chgUntpc === '0') {
					item.chgUntpc = item.untpc;
					item.chgMrgn = item.mrgn;
					item.chgMrgnRate = item.mrgnRate;
				}
			}
			item.mrgnPrdCd = gridID === myGridID2 ? 'EMPL' : 'CST'
			item.areaSeq = areaSeq;
			item.chgType = "UNTPC_CHG";
			item.befPrdDtlSeq = item.prdDtlSeq;
			item.aftPrdDtlSeq = item.prdDtlSeq;
			
			return item;
		});

		$.ajax({
			url : "/cst/saveAreaUntpcList.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			success : function(data) {
				window.location.reload();
			},
			error : function() {}
		});
	}

	function searchAgenAreaList(areaNm, tabNm) {
		var gridID = getActivedMygridID();
		var areaGridID = tabNm === 'empl' ? myGridID : myGridID3;
		
		var prdDtlCd = $('#' + tabNm + 'PrdDtlCd').val();
		var prdNm = $('#' + tabNm + 'PrdNm').val();

		$.ajax({
			url : '/cst/selectAreaList.do',
			type : 'POST',
			data : {
				"prdDtlCd" : prdDtlCd,
				"prdNm"    : prdNm,
				"areaNm"  : areaNm,
				"mrgnPrdCd" : tabNm
			},
			success: function (data) {
				AUIGrid.setGridData(areaGridID, data);

				$('#' + tabNm + 'ListCnt').html(data.length)

				if(data.length > 0) {
					AUIGrid.selectRowsByRowId(areaGridID, data[0].areaSeq);
				} else {
					AUIGrid.setGridData(gridID, []);
					$('#' + tabNm + 'ListCnt2').html(0);
				}

				var areaSelector = document.querySelector('#' + tabNm + 'AreaSeq');
				if(areaSelector.options.length === 0) {
					data.forEach(function(d) {
						var el = document.createElement('option');
						el.text = d.areaNm;
						el.value = d.areaSeq;
						areaSelector.options.add(el);
					})
				}

			},
			error: function (xhr, status) {}
		})
	}


	function searchUntpcList(param) {
		$.ajax({
			url : '/cst/selectUntpcList.do',
			type : 'POST',
			data : param,
			success: function (data) {
				if(typeof param.targetAreaSeq !== 'undefined' && data) { // 지역 단가복사
					copyUntpc(data);
				} else {
					AUIGrid.setGridData(myGridID2, data);
					$('#emplListCnt2').html(data.length)
				}
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		})
	}

	function searchCstAreaUntpcList(param) {
		$.ajax({
			url : "/cst/selectCstAreaUntpcList.do",
			type : 'POST',
			data : param,
			success: function(data) {
				if(typeof param.targetAreaSeq !== 'undefined' && data) {
					copyUntpc(data);
				} else {
					AUIGrid.setGridData(myGridID4, data);
					$('#cstListCnt2').html(data.length);
				}
			},
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		})
	}

</script>
<style>
    .tabs li {width:auto; min-width: 124px; padding: 0 10px;}
</style>
<div class="content">
<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- tabs -->
	<div class="tabsWrap">
		<ul class="tabs">
			<li class="active" rel="tab01">지역별 판매원 단가</li>
			<li class="" rel="tab02">지역별 애음자(소비자) 단가</li>
		</ul>

		<!-- tab01 S -->
		<div id="tab01" class="tabContent">
			<div class="inquiryBox type02">
				<dl>
					<dt>지역명</dt>
					<dd>
						<input type ="text" name ="areaNm" class="inp w120" id = "emplAreaNm"/>
					</dd>
					<dt>제품</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="emplPrdDtlCd" class="inp w120 mr10" value="" title="제품 입력" placeholder="제품코드"> 
							<input type="text" id="emplPrdNm" class="inp w120 mr10" value="" title="제품코드 입력" placeholder="제품명">
							<button type="button" name="" class="comBtn" id="inp_name01" onclick = 'searchList()' >조회</button>
						</div>
					</dd>
				</dl>
				<div class="btnGroup right">
					<button type="button" name="" class="comBtn" onclick="addRow('first')">행추가</button>
					<button type="button" name="" class="comBtn" onclick="removeRow('first')">행삭제</button>
					<button type="button" name="" class="comBtn" onclick = 'exportToXlsx();'>엑셀다운</button>
					<button type="button" name="" class="comBtn" onclick = 'openHistoryPop()'>이력보기</button>
					<button type="button" name="" class="inquBtn" onclick ='saveUntpcList();'>저장</button>
				</div>


			</div>

			<div class="gridSBox">
				<div class="gridItem w25per">
					<div class="titleArea">
						<h3 class="tit01">지역 정보</h3>
						<p class="numState">
							<em>총 <span class="pColor01 fb" id="emplListCnt">0</span></em> 건 이 조회되었습니다.
						</p>
					</div>
					<div id="grid_wrap"></div>
				</div>

				<div class="gridItem">
					<div class="titleArea">
						<h3 class="tit01">지역별 단가 정보</h3>
						<p class="numState">
							<em>총 <span class="pColor01 fb" id="emplListCnt2">0</span></em> 건 이 조회되었습니다.
						</p>
					</div>
					<div id="grid_wrap2"></div>
					
					<div class="conBox">
						<div class="inquiryBox type04 dtShort">
							<dl>
								<dt>기준지역</dt>
								<dd>
									<select name="" class="sel w100" id="emplAreaSeq"></select>
									<button type="button" name="" class="comBtn small" onclick= 'copyAreaUntpcList()'>단가복사</button>
								</dd>
								<dt class="line">
									<label for="inp_name01">마진율(%)</label>
								</dt>
								<dd>
									<input type="text" id="emplMrgnRate" class="inp" value=""
										title="마진율">
								</dd>
								<dt>
									<label for="sel_unit">단가절삭방식</label>
								</dt>
								<dd>
									<select name="" class="sel w100" id="emplSelUnit">
										<option value="1">원단위</option>
										<option value="10">십원단위</option>
										<option value="100">백원단위</option>
										<option value="1000">천원단위</option>
									</select>
								</dd>
							</dl>
							<div class="btnGroup right">
								<button type="button" name="" class="comBtn small" onclick = 'mrgnApply()'>적용</button>
							</div>
						</div>

					</div>
				</div>

			</div>
			
		</div>
		<!-- tab01 E -->

		<!-- tab02 S -->
		<div id="tab02" class="tabContent">
			<!-- 조회 -->
			<div class="inquiryBox type02">
				<dl>
					<dt>지역명</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="cstAreaNm" class="inp w120" value="" name="" placeholder="지역명">
						</div>
					</dd>
					<dt>제품</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="cstPrdDtlCd" class="inp w120 mr10" value="" name="" placeholder="제품코드">
							<input type="text" id="cstPrdNm" class="inp w120 mr10" value="" name="" placeholder="제품명">
							<button type="button" name="" class="comBtn" id="inp_name01" onclick = 'searchList()'>조회</button>
						</div>
					</dd>
				</dl>
				
				<div class="btnGroup right">
					<button type="button" name="" class="comBtn" onclick="addRow('first')">행추가</button>
					<button type="button" name="" class="comBtn" onclick="removeRow('first')">행삭제</button>
					<button type="button" name="" class="comBtn" onclick = 'exportToXlsx();'>엑셀다운</button>
					<button type="button" name="" class="comBtn" onclick = 'openHistoryPop()'>이력보기</button>
					<button type="button" name="" class="inquBtn" onclick ='saveUntpcList();'>저장</button>
				</div>
			</div>
			<!--// 조회 -->

			<div class="gridSBox">
				<div class="gridItem w25per">
					<div class="titleArea">
						<h3 class="tit01">지역 정보</h3>
						<p class="numState">
							<em>총 <span class="pColor01 fb" id="cstListCnt"></span></em> 건 이 조회되었습니다.
						</p>
					</div>
					<div id="grid_wrap3"></div>
				</div>
				<div class="gridItem">
					<div class="titleArea right">
						<div class="titleArea">
							<h3 class="tit01">지역별 단가 정보</h3>
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="cstListCnt2"></span></em> 건 이 조회되었습니다.
							</p>
						</div>
					</div>
					<div id="grid_wrap4"></div>

					<div class="conBox">
						<div class="inquiryBox type04 dtShort">
							<dl>
								<dt>기준지역</dt>
								<dd>
									<select name="" class="sel w100" id="cstAreaSeq"></select>
									<button type="button" name="" class="comBtn small">단가복사</button>
								</dd>
								<dt class="line"><label for="cstMrgnRate">마진율(%)</label></dt>
								<dd>
									<input type="text" id="cstMrgnRate" class="inp w100" value="" title="성명 입력">
								</dd>
								<dt><label for="sel_unit">단가절삭방식</label></dt>
								<dd>
									<select name="" class="sel w100" id="cstSelUnit">
										<option value="1">원단위</option>
										<option value="10">십원단위</option>
										<option value="100">백원단위</option>
										<option value="1000">천원단위</option>
									</select>
								</dd>
							</dl>
							<div class="btnGroup right">
								<button type="button" name="" class="comBtn small" onclick = 'mrgnApply()'>적용</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		<!-- tab02 E -->
	</div>

</div>