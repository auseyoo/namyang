<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<script type="text/javascript" src="/js/lib/Chart.min.js"></script>
<script type="text/javascript">
	var myGridID;
	var myGridID2;
	var ctx;
	var ctx2;

	function searchList(){
		
		$.ajax({
			url : "/sel/selectMnthSaleSttsList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data);
				bindChart(data);
			}, // success
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	function searchList2(){
		
		$.ajax({
			url : "/sel/selectMnthWeekSaleSttsList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID2, data);
				bindChart2(data);
			}, // success
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}

	$(document).ready(function(){
		// AUIGrid 생성 후 반환 ID
		createAUIGrid();
		// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.		
		createChart();
		
		searchList();
		searchList2();

		$("#excelDonw").click(function(){
			AUIGrid.exportToXlsx(myGridID, {
				// 스타일 상태 유지 여부(기본값:true)
				exportWithStyle : true,
				fileName : "월별 매출 현황"
			});
		});
		$("#excelDonw2").click(function(){
			AUIGrid.exportToXlsx(myGridID2, {
				// 스타일 상태 유지 여부(기본값:true)
				exportWithStyle : true,
				fileName : "요일별 매출 현황"
			});
		});
		
		AUIGrid.setFooter(myGridID, footerLayout);
		AUIGrid.setFooter(myGridID2, footerLayout2);		
	});
	
 
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
				headerHeight : 29,
				rowHeight : 29,
				// 편집 가능 여부 (기본값 : false)
				editable : false,
				showRowNumColumn : true, 
				// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
				enterKeyColumnBase : true,
				showFooter : true,
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

		var gridPros2 = {
			headerHeight : 29,
			rowHeight : 29,
			showFooter : true,  
		}
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
		myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
	}

	function createChart(){
		//월별
		ctx = document.getElementById('myChart');
		ctx2 = document.getElementById('myChart2'); 
	};

	function bindChart(data){
		var year = new Array();
		$.each(data, function (i){	year.push(data[i].year);	});
		year = $.unique(year);

		var chartColor = ["#ff8800","#0696b9"];
		var chartData = new Array();

		// Label 설정
		$.each(year, function(i){
			$("#yearList").append("<li>"+year[i]+"</li>");
			var saleAmtlist = new Array(12);
			saleAmtlist.fill(0);
			$.each(data, function(idx, v){
				if (v.year == year[i]){
					saleAmtlist[v.num-1] = v.saleAmt;
				}
			});
			
			var yearData = {
				label: year[i],
				data: saleAmtlist,
				barPercentage: 0.66,
				categoryPercentage: 0.51,
				backgroundColor: chartColor[i],
				borderColor: chartColor[i],
				borderSkipped: false,
				borderRadius: {
					topLeft: 10,
					topRight: 0,
					bottomLeft: 0,
					bottomRight: 10
				}
			}
			chartData.push(yearData);
		});
		const Chart2 = new Chart(ctx2, {
			type: 'bar',
			data: {
				labels: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
				datasets: chartData 
			},
			options: {
				//responsive: true,
				//maintainAspectRatio: true,
				plugins: {
					legend: {
						display: false,						 
					},
					scales: {
						x: {
							ticks: {
							
							},
						},
						y: {
							grid: {
								drawBorder: false
							}
						}
					},
				}
				
			}
		});
	}
		 
	function bindChart2(data){
		const ctx = document.getElementById('myChart'); 
		Chart.defaults.font.size = 14;

		var chartColor = ["#ff8800","#b5268f","#0596b9","#3cb24a","#544397","#544397"];
		var chartLabel = ["첫째주","둘째주","셋째주","넷째주","다섯째주","여섯째주"];
		var chartData = new Array();
		
		// Label 설정
		for(var i=0; i < chartLabel.length; i++){
			var saleAmtlist = new Array(6);
			saleAmtlist.fill(0);
			
			$.each(data, function(idx, v){
				saleAmtlist[v.saleWeek-1] = eval("v.week" +(i+1));
			});
			
			var weekData = {
				label: chartLabel[i],
				data: saleAmtlist,
				barPercentage: 0.66,
				categoryPercentage: 0.51,
				backgroundColor: chartColor[i],
				borderColor: chartColor[i],
				borderSkipped: false,
				borderRadius: {
					topLeft: 10,
					topRight: 0,
					bottomLeft: 0,
					bottomRight: 10
				}
			}
			chartData.push(weekData);
		};
		
		const chart = new Chart(ctx, {
			type: 'bar',
			data: {
				labels: ["월요일","화요일","수요일","목요일","금요일","토요일","일요일"],
				datasets: chartData
			},
			options: {
				//responsive: true,
				//maintainAspectRatio: true,
				plugins: {
					legend: {	display: false	},
					scales: {
						y: {
							grid: {
								drawBorder: false
							}
						}
					},
				}
				
			}
		});
	}
	
var columnLayout = [{
		dataField : "saleDt",
		headerText : "판매월",
	},{
		dataField : "type",
		headerText : "유형",
		children : [{
				dataField : "saleQty",
				headerText : "판매",
				formatString : "#,##0",
				width:"10%",
				dataType : "numeric",
				style: "auiRight",
			}, {
				dataField : "rtgdQty",
				headerText : "반품",
				formatString : "#,##0",
				width:"10%",
				dataType : "numeric",
				style: "auiRight"
			}, {
				dataField : "prsntQty",
				headerText : "증정",
				formatString : "#,##0",
				width:"10%",
				dataType : "numeric",
				style: "auiRight"
			}, {
				dataField : "exchgQty",
				headerText : "교환",
				formatString : "#,##0",
				headerStyle : "auiRightBorR",
				width:"10%",
				dataType : "numeric",
				style: "auiRight"
		}]
	},{
		dataField : "amount",
		headerText : "매출금액",
		children : [{
				dataField : "suCt",
				headerText : "공급가",
				width:"14%",
				dataType : "numeric",
				formatString : "#,##0",
				style: "auiRight"
			}, {
				dataField : "vatCt",
				headerText : "VAT",
				width:"14%",
				dataType : "numeric",
				formatString : "#,##0",
				style: "auiRight"
			}, {
				dataField : "saleAmt",
				headerText : "計",
				formatString : "#,##0",
				dataType : "numeric",
				width:"14%",
				style: "auiRight"
		}]
	}
];

var columnLayout2 = [{
		dataField : "saleWeekKr",
		headerText : "요일",
	},{
		dataField : "amount",
		headerText : "매출금액 計",
		children : 
		[{
			dataField : "week1",
			headerText : "첫째주",
			formatString : "#,##0",
			dataType : "numeric",
			width:"12%",
			style: "auiRight"
		}, {
			dataField : "week2",
			headerText : "둘째주",
			formatString : "#,##0",
			dataType : "numeric",
			width:"12%",
			style: "auiRight"
		}, {
			dataField : "week3",
			headerText : "셋째주",
			formatString : "#,##0",
			dataType : "numeric",
			width:"12%",
			style: "auiRight"
		}, {
			dataField : "week4",
			headerText : "넷째주",
			formatString : "#,##0",
			dataType : "numeric",
			width:"12%",
			style: "auiRight"
		}, {
			dataField : "week5",
			headerText : "다섯째주",
			formatString : "#,##0",
			dataType : "numeric",
			width:"12%",
			style: "auiRight"
		}, {
			dataField : "week6",
			headerText : "여섯째주",
			formatString : "#,##0",
			dataType : "numeric",
			width:"12%",
			style: "auiRight"
		}
		]
	},{
		dataField : "saleAmt",
		headerText : "합계",
		formatString : "#,##0",
		width:"15%",
		dataType : "numeric",
		style: "auiRight"
	}
];

// 푸터 설정
var footerLayout = [{
	labelText : "∑",
	positionField : "#base"
	}, {
		dataField : "code",
		positionField : "code",
		operation : "SUM",
		colSpan : 1, // 자신을 포함하여 4개의 푸터를 가로 병합함.
		formatString : "#,##0"
	}, {
		dataField : "saleQty",
		positionField : "saleQty",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "rtgdQty",
		positionField : "rtgdQty",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "prsntQty",
		positionField : "prsntQty",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "exchgQty",
		positionField : "exchgQty",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "suCt",
		positionField : "suCt",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "vatCt",
		positionField : "vatCt",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "saleAmt",
		positionField : "saleAmt",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}];


var footerLayout2 = [{
	labelText : "∑",
	positionField : "#base"
	}, {
		dataField : "code",
		positionField : "code",
		operation : "SUM",
		colSpan : 1, // 자신을 포함하여 4개의 푸터를 가로 병합함.
		labelFunction : function(value, columnValues, footerValues) {
		   // return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
		   return "합계 : " 
		}
	}, {
		dataField : "week1",
		positionField : "week1",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "week2",
		positionField : "week2",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "week3",
		positionField : "week3",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "week4",
		positionField : "week4",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "week5",
		positionField : "week5",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "week6",
		positionField : "week6",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}, {
		dataField : "saleAmt",
		positionField : "saleAmt",
		operation : "SUM",
		style : "auiRight",
		colSpan : 1, 
		formatString : "#,##0"
	}];



function resizeGrid(){
	AUIGrid.resize(myGridID, $(".monthWrap").width());
	AUIGrid.resize(myGridID2, $(".byDayWrap").width());
}
</script>
<div class="mContent submain">
	<tiles:insertAttribute name="body.breadcrumb"/>
	<div class="subConWrap">
		<!-- 월별 매출 현황 -->
		<div class="subConBox">
			<form id="frm"></form>
			<div class="subTitArea">
				<h2>월별 매출 현황</h2>
				<span class="unit">(단위:만원)</span>
			</div>
			
			<div class="monthWrap">
				<div class="monthSale">							
					<canvas id="myChart2" style="width:100%; height:225px"></canvas>
				</div>

				<ul class="state" id="yearList">
				</ul>
			</div>

			<div class="btnGroup ar">
				<button type="button" name="" class="comBtn small" id="excelDonw">액셀다운</button>
			</div>

			<!-- grid -->
			<div class="girdBox h270">
				<div id="grid_wrap"></div>
			</div>
			<!-- grid -->
		</div>
		<!--월별 매출 현황 -->

		<!--요일별 매출 현황 -->
		<div class="subConBox">
			<div class="subTitArea">
				<h2>요일별 매출 현황</h2>
				<span class="unit">(단위:만원)</span>
			</div>

			<div class="byDayWrap">
				<div class="byDaySale">							
					<canvas id="myChart" style="width:100%; height:225px"></canvas>								
				</div>
				
				<ul class="state">
					<li>첫째주</li>
					<li>둘째주</li>
					<li>셋째주</li>
					<li>넷째주</li>
					<li>다섯째주</li>
					<li>여섯째주</li>
				</ul>
			</div>

			<div class="btnGroup ar">
				<button type="button" name="" class="comBtn small" id="excelDonw2">액셀다운</button>
			</div>

			<!-- grid -->
			<div class="girdBox h270">
				<div id="grid_wrap2"></div>
			</div>
			<!-- grid -->
		</div>
		<!--요일별 매출 현황 -->
	</div>
</div>