<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">
	var myGridID;

	$(document).ready(function () {
		createAUIGrid(columnLayout);

		init();
	});


	// AUIGrid 를 생성합니다.
	function createAUIGrid(columnLayout) {
		// 그리드 속성 설정
		var gridPros = {
			headerHeights : [29, 50],
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : true,
			enableCellMerge : true,  // 셀 병합 실행
			
			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase : false,
			
			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "multipleCells",
			showFooter : false,
			
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

			rowIdField : 'areaSeq'
		};

		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);

	}

	function init() {
		AUIGrid.setGridData(myGridID, new Object());

		$("#datepicker1").daterangepicker({
			singleDatePicker: true,
			minDate : new Date(),
			showDropdowns: true,
			changeMonth: true,
			showMonthAfterYear: true,
			locale: {
				format: "YYYY-MM-DD",
			    separator: " - ",
			    applyLabel: "Apply",
			    cancelLabel: "Cancel",
			    fromLabel: "From",
			    toLabel: "To",
			    customRangeLabel: "Custom",
			    weekLabel: "W",
			    applyLabel: "확인",
			    cancelLabel: "취소",
			    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
			    monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월",],
			    firstDay: 1,
			  },
			});
		
		AUIGrid.bind(myGridID, 'cellEditEnd', function(event) {
			if(event.dataField === 'aftEmplUntpc' || event.dataField === 'aftCstUntpc') {
				AUIGrid.setCellValue(myGridID, event.rowIndex, event.dataField, onlyNumber(event.value))
			}
		})
	}

	var columnLayout = [{
		dataField : 'pchaUntpc',
		visible : false,
	}, {
		dataField : "emplMrgnCt",
		visible : false,
	}, {
		dataField : "emplMrgnRate",
		visible : false,
	}, {
		dataField : "cstMrgnCt",
		visible : false,
	}, {
		dataField : "cstMrgnRate",
		visible : false,
	}, {
		dataField : "puchSeq",
		visible : false,
	}, {
		dataField : "prdSeq",
		visible : false,
	},{
		headerText : "변경 전",
		headerStyle : "auiRightBorR",    
		children : [
			{
				dataField : "befPrdDtlSeq",
				headerText : "제품코드",
				rospan: "5",
				width:"8%",
				style: "auiRightBorR",
				cellMerge : true,
				editable : false,
				renderer: { // HTML 템플릿 렌더러 사용
					type: "TemplateRenderer"
				},
				labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
					if(item.befPrdDtlSeq) {
						var template = item.befPrdDtlSeq;
					} else {
						var template = '<div class="searchWrap">';
						template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop("bef"); \'></a></span>';
						template += '</div>';
					}
					
					return template;
				}
			}, {
				dataField : "befPrdNm",
				headerText : "제품명",
				style: "auiLeft auiRightBorR",
				cellMerge : true,
				editable : false,
				renderer: { // HTML 템플릿 렌더러 사용
					type: "TemplateRenderer"
				},
				labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
					if(item.befPrdNm) {
						var template = item.befPrdNm;
					} else {
						var template = '<div class="searchWrap">';
						template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop("bef"); \'></a></span>';
						template += '</div>';
					}
					
					return template;
				}
			}, {
				dataField : "areaSeq",
				headerText : "지역코드",
				width:"6%",
				style: "auiRightBorR",
				editable : false,
			}, {
				dataField : "areaNm",
				headerText : "지역명",
				width:"10%",
				style: "auiLeft auiRightBorR",
				editable : false,
			}, {
				dataField : "befEmplUntpc",
				headerText : "지역별<br/>판매원 단가",
				headerStyle : "auiRightBorR",
				dataType : "numeric",
				formatString : "#,##0",
				style: "auiRight auiRightBorR",
				width:"8%",
				editable : false,
			}, {
				dataField : "befCstUntpc",
				headerText : "지역별<br/>애음자(소비자) 단가",
				headerStyle : "auiRightBorR",
				dataType : "numeric",
				formatString : "#,##0",
				style: "auiRight auiRightBorR",
				width:"8%",
				editable : false,
			}, {
				dataField : "befPrdSeq",
				visible : false,
			}]
		},{
			headerText : "변경 후",        
			children : [{
				dataField : "aftPrdDtlSeq",
				headerText : "제품코드",
				width:"8%",
				style: "auiRightBorR",
				cellMerge : true,
				editable : false,
				renderer: { // HTML 템플릿 렌더러 사용
					type: "TemplateRenderer"
				},
				labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
					if(item.aftPrdDtlSeq) {
						var template = item.aftPrdDtlSeq;
					} else {
						var template = '<div class="searchWrap">';
						template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop("aft"); \'></a></span>';
						template += '</div>';
					}
					
					return template;
				}
				}, {
					dataField : "aftPrdNm",
					headerText : "제품명",
					width:"10%",
					style: "auiLeft auiRightBorR",
					cellMerge : true,
					editable : false,
					renderer: { // HTML 템플릿 렌더러 사용
						type: "TemplateRenderer"
					},
					labelFunction: function (rowIndex, columnIndex, value, headerText, item, dataField, cItem ) {
						if(item.aftPrdNm) {
							var template = item.aftPrdNm;
						} else {
							var template = '<div class="searchWrap">';
							template += '<span class="my_div_text_box"><a href="#" class="serach" data-id="modalAgencyViews" onclick =\'openSearchPrdPop("aft"); \'></a></span>';
							template += '</div>';
						}
						
						return template;
					}
				}, {
					dataField : "areaSeq",
					headerText : "지역코드",
					width:"6%",
					style: "auiRightBorR",
					editable : false,
				}, {
					dataField : "areaNm",
					headerText : "지역명",
					width:"10%",
					style: "auiLeft auiRightBorR",
					editable : false,
				}, {
					dataField : "aftEmplUntpc",
					headerText : "판매원단가",
					width:"8%",
					style: "auiRight",
					dataType : "numeric",
					editable : true,
					renderer : {
						type : "TemplateRenderer"
					},
					labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
						var template = '<div class="my_div">';
						template += '<span class="my_div_text_box center">' + value + '</span>';
						template += '</div>';
						return template;
					}
				},{
					dataField : "aftCstUntpc",
					headerText : "지역별<br/>애음자(소비자) 단가",
					width:"8%",
					style: "auiRight",
					dataType : "numeric",
					editable : true,
					renderer : {
						type : "TemplateRenderer"
					},
					labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
						var template = '<div class="my_div">';
						template += '<span class="my_div_text_box center">' + value + '</span>';
						template += '</div>';
						return template;
					}
				}, {
					dataField : "aftPrdSeq",
					visible : false,
				}
			]
		}
	];

	// events

	function openSearchPrdPop(pos) {
		if(pos === 'aft' && CommUtil.isEmpty(AUIGrid.getCellValue(myGridID, 0, 'befPrdDtlSeq'))) {
			alert('변경 전 제품을 먼저 선택해주세요.');
			return;
		}

		$.ajaxDialog({
			id: "searchPrdPop",
			ajax: {
				url: "/comm/pop/searchAreaPrdPop.pop",
			},
			dialog: {
				width: 600,
				height: 470,
			},
			success: function(item) {
				searchPrdAreaUntpcList(item , pos);
			}
		})
	}

	// methods

	function mrgnCalc(pchaUntpc, saleUntpc) {
		var chgMrgnCt, chgMrgnRate;
		chgMrgnCt = saleUntpc - pchaUntpc;
		chgMrgnRate = (chgMrgnCt / saleUntpc * 100).toFixed(1);
		return { chgMrgnCt, chgMrgnRate };
	}

	function onlyNumber(str) {
		return !CommUtil.isEmpty(str) && typeof str === 'string' ? str.replace(/[^0-9]/g, '') : str;
	}

	// api

	function searchPrdAreaUntpcList(item, pos) {
		var prdNm = item.prdNm;
		var prdDtlSeq = item.prdDtlSeq;
		
		$.ajax({
			url : '/cst/searchPrdAreaUntpcList.do',
			type : 'POST',
			data : item,
			success : function(data) {
				var items = [];
				data.forEach(function(d) {
					var item = {};
					item[pos+'PrdDtlSeq'] = d.prdDtlSeq;
					item[pos+'PrdDtlSeq'] = prdDtlSeq;
					item[pos+'PrdNm'] = prdNm;
					item['areaSeq'] = d.areaSeq;
					item['areaNm'] = d.areaNm;
					item[pos+'EmplUntpc'] = d.emplUntpc;
					item[pos+'CstUntpc'] = d.cstUntpc;
					item.pchaUntpc = d.pchaUntpc;
					item.areaSeq = d.areaSeq;
					item.puchSeq = d.puchSeq;
					item.prdSeq = d.prdSeq;
					item[pos+'PrdSeq'] = d.prdSeq;

					items.push(item);
				});

				if(pos === 'bef') {
					AUIGrid.setGridData(myGridID, items);
				} else if (pos === 'aft') {
					AUIGrid.updateRowBlockToValue(myGridID, 0, AUIGrid.getRowCount(myGridID), ["aftPrdDtlSeq", "aftPrdNm"], [prdDtlSeq, prdNm])
					AUIGrid.updateRowsById(myGridID, items);
				}
			}
		})
	}

	function savePrdBndChg() {
		var applDt = $("#datepicker1").val().replace(/-/g, '');
		var today = fnGetToDay().replace(/-/g, '');
		var isDelete = applDt === today;

		var message = '';

		var data = AUIGrid.getGridData(myGridID).reduce(function(acc, cur, idx) {
			if(message !== '') return;

			if(isDelete) {
				var data = {};
				data.areaSeq = cur.areaSeq;
				data.prdDtlSeq = cur.befPrdDtlSeq;
				data.chgType = "BND_CHG";
				data.removeYn = 'Y';

				acc.push({ ...data , mrgnPrdCd : "EMPL"});
				acc.push({ ...data , mrgnPrdCd : "CST"});
			}

			if(CommUtil.isEmpty(cur.aftPrdDtlSeq)) {
				message = '변경 후 제품을 입력해 주세요';
			} else if (CommUtil.isEmpty(cur.aftEmplUntpc) || Number(cur.aftEmplUntpc) === 0) {
				message = '변경 후 지역별 판매원 단가를 모두 입력해주세요.';
			} else if (CommUtil.isEmpty(cur.aftCstUntpc) || Number(cur.aftCstUntpc) === 0) {
				message = '변경 후 지역별 애음자(소비자) 단가를 모두 입력해주세요.';
			}


			var data = {};
			data.areaSeq = cur.areaSeq;
			data.prdDtlSeq = cur.aftPrdDtlSeq;
			data.befPrdDtlSeq = cur.befPrdDtlSeq;
			data.aftPrdDtlSeq = cur.aftPrdDtlSeq;
			data.befPrdSeq = cur.befPrdSeq;
			data.aftPrdSeq = cur.aftPrdSeq;
			data.chgApplDt = applDt;
			data.prdSeq = cur.prdSeq;
			data.puchSeq = cur.puchSeq;
			data.chgType = "BND_CHG";
			data.lastYn = isDelete ? 'Y' : 'N';
			data.removeYn = 'N';

			acc.push({ 
				...data, 
				chgUntpc: cur.aftCstUntpc,
				...mrgnCalc(cur.aftEmplUntpc, cur.aftCstUntpc),
				mrgnPrdCd: "CST"
			});
			acc.push({ 
				...data, 
				chgUntpc: cur.aftEmplUntpc,
				...mrgnCalc(cur.pchaUntpc, cur.aftEmplUntpc),
				mrgnPrdCd: "EMPL"
			});

			return acc;
		}, []);

		if(message !== '') {
			alert(message);
			return;
		}

		$.ajax({
			url : "/cst/saveAreaUntpcList.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			success : function(data) {
				window.location.reload();
			},
			error : function() {},
		});
	}

	function openPrdBndChgHisPop() {
		$.ajaxDialog({
			id: "prdBndChgHisPop",
			ajax: {
				url: "/comm/pop/agenAreaPrdBndChgHisPop.pop"
			},
			dialog: {
				width: 1600,
				height: 740
			}
		})
	}

	//keepEditing 토글
	function toggleKeepEditing() {
		var chkbox = document.getElementById("chkbox");
		AUIGrid.setProp(myGridID, "keepEditing", chkbox.checked);
	}

	function toggleEditMode() {
		var editBeginMode = AUIGrid.getProp(myGridID, "editBeginMode");

		if (editBeginMode == "doubleClick") {
			AUIGrid.setProp(myGridID, "editBeginMode", "click");
			document.getElementById("status").innerHTML = "click";
		} else {
			AUIGrid.setProp(myGridID, "editBeginMode", "doubleClick");
			document.getElementById("status").innerHTML = "doubleClick";
		}
	};
</script>

<div class="content">
<tiles:insertAttribute name="body.breadcrumb"/>

	<form id="frm">
		<div class="inquiryBox dtShort">
			<dl>
				<dt>적용일자</dt>
				<dd>
					<div class="formWrap">
						<div class="dateWrap">
							<input type="text" name="date" value="" class="inp datepicker" id="datepicker1" readonly>
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker1" ></button>
						</div>
						 <button type="button" name="" class="comBtn" id="changeBtn" onclick = 'savePrdBndChg()'>변경</button>
					</div>
				</dd>
				<div class="btnGroup right">
					<button type="button" name="" class="comBtn" id="viewHistoryBtn" onclick = 'openPrdBndChgHisPop()'>이력보기</button>
				</div>
			</dl>

		   
		</div>
	</form>
	
	<!-- grid -->
	<div class="girdBox">
		<div id="grid_wrap"></div>
	</div>
	<!-- grid -->
</div>

