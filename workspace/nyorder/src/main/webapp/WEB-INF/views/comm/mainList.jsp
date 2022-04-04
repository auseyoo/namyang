<!-- 
	@File Name: mainList
	@File 설명 : 메인
	@UI ID : UI-PHOM-0101.html
	@작성일 : 2022.01.03
	@작성자 : 누군가
	
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 28.	JUNGAE	 공지사항조회, 여신조회 추가 	
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<link rel="stylesheet" type="text/css" href="/css/main.css" />
<script type="text/javascript" src="/js/lib/Chart.min.js"></script>
<!--ver 3.6.2 -->

<script type="text/javascript">
    var gridDlvy;
    var gridNotice;
    /* var gridData = [
        {"id":"#Cust0","ordDate":"2022-08-11","delDate":"2022-08-11","ordQan":"555","ordPrice":"50000","delQan":"185","delPrice":"58000"},
        {"id":"#Cust1","ordDate":"2022-08-11","delDate":"2022-08-11","ordQan":"555","ordPrice":"50000","delQan":"185","delPrice":"58000"}
    ]; */
   
   $(document).ready(function(){
        
        createAUIGrid();

		$("#btnNotice").on("click", function(){
			document.location.href = '/cmmc/notibod.do'; 	
		});
		$("#btnOrdrDly").on("click", function(){
			document.location.href = '/agn/ordrDcsnDly.do'; 	
		});
		$("#btnCredit").on("click", fnCredit);
		
        /* AUIGrid.setGridData(gridDlvy, gridData); */

        fnOrdrDly();
        fnCredit();
        fnNotice();        

        //요일별 매출현황
        fnSelectMnthWeekSaleStts();
    });
    
 
    // AUIGrid 를 생성합니다.
    function createAUIGrid() {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 59,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : false,
                showRowNumColumn : false, 
                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
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

        var gridPros2 = {
            headerHeight : 59,
            rowHeight : 29,
            rowNumColumnWidth : 100,
            selectionMode : "singleRow"
        }
    
        // 실제로 #grid_wrap 에 그리드 생성
        gridDlvy = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        gridNotice = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
    }

    var columnLayout = [{
            dataField : "untpc", 
            visible:false
		},{
            dataField : "faltQty", 
            visible:false
		},{
            dataField : "totalReqBoxQty",
            visible:false
		},{
            dataField : "totalReqIddyQty",
            visible:false
		},{
            dataField : "ordDt",
			headerText : "주문일자",
            width : "17%",
		},{
			dataField : "cosDt",
			headerText : "배송일자",
			width : "17%",
		},{
			dataField : "ordQan",
			headerText : "주문수량",
			width : "15%",
            style : "auiRight",
            expFunction : function(  rowIndex, columnIndex, item, dataField ) {
            	//입수량
				var faltQty = item.faltQty;
				//주문량 BOX
				var totalReqBoxQty = ( Number(item.totalReqBoxQty) ) ? Number(item.totalReqBoxQty) : 0;
				//주문량 낱봉
				var totalReqIddyQty = ( Number(item.totalReqIddyQty) ) ? Number(item.totalReqIddyQty) : 0;
				
				return Number( (faltQty * totalReqBoxQty) + totalReqIddyQty );
			}
		},{
			dataField : "ordPrice",
			headerText : "주문금액",
            dataType : "numeric",
            style : "auiRight",
            expFunction : function(  rowIndex, columnIndex, item, dataField ) {
				//매입가
				var untpc = ( Number(item.untpc) ) ? Number(item.untpc) : 0;
				//입수량
				var faltQty = item.faltQty;
				//주문량 BOX
				var totalReqBoxQty = ( Number(item.totalReqBoxQty) ) ? Number(item.totalReqBoxQty) : 0;
				//주문량 낱봉
				var totalReqIddyQty = ( Number(item.totalReqIddyQty) ) ? Number(item.totalReqIddyQty) : 0;
				
				return Number( ( (faltQty * totalReqBoxQty) + totalReqIddyQty ) * untpc );
			}
		},{
			dataField : "delQan",
			headerText : "배송수량",
			width : "15%",
            style : "auiRight"
		},{
			dataField : "delPrice",
			headerText : "배송금액",
            dataType : "numeric",
			width : "17%",
            style : "auiRight"
		}
	];

    var columnLayout2 = [{
	        dataField : "nttSeq",
			visible:false
	    },{
            dataField : "nttSub",
			headerText : "제목",
            style : "auiLeft",
        },{
			dataField : "new",
			headerText : "",
			width : "10%",
            style : "auiLeft",
            prefix : "../images/new.png",
            renderer : {
                type : "ImageRenderer",
                imgHeight : 18, // 이미지 높이, 지정하지 않으면 rowHeight에 맞게 자동 조절되지만 빠른 렌더링을 위해 설정을 추천합니다.
                //altField : "country" // alt(title) 속성에 삽입될 필드명, 툴팁으로 출력됨
            }
		},{
			dataField : "regDtm",
			headerText : "날짜",
			dataType : "date",
			formatString : "yyyy - mm - dd",
			width : "30%",
		}
	];

    function fnNotice(){
 		$.ajax({
			url : "/comm/selectMainNotice.do", 
			type : 'POST', 
			data : null,
			success : function(data) {
				AUIGrid.setGridData(gridNotice, data);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 
   	}

    function fnCredit(){

 		$.ajax({
			url : "/comm/selectMainCredit.do", 
			type : 'POST', 
			data : null,
			success : function(data) {

				$("#reloadTime").html(data.reloadTime + " <em>기준</em>");
				
				// 현재 여신 금액
				var creditLimit = data.creditLimit;
				creditLimit = setComma( creditLimit ) + " <span>원</span>";
				$("#creditLimit").html(creditLimit);

				// 현재 여신 금액
				var ordTotAmount = data.ordTotAmount;
				ordTotAmount = setComma( ordTotAmount ) + " <span>원</span>";
				$("#ordTotAmount").html(ordTotAmount);

				// 여신 부족 금액
				var lackCredit = (data.creditLimit - data.ordTotAmount);
				lackCredit = setComma( lackCredit ) + " <span>원</span>";
				$("#lackCredit").html(lackCredit);
				
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 
   	}

   	/*
   	요일별 매출현황
   	: 매출분석 > 매출 분석 > 월별판매현황  화면내에 [요일별 매출 현황] 차트 처리소스와 동일함
   	: 시판일때 조회 쿼리 변경해야함!!
   	*/
	function fnSelectMnthWeekSaleStts(){
		
		$.ajax({
			url : "/sel/selectMnthWeekSaleSttsList.do",
			type : 'POST',
			data : null,//$("#frm").serialize(),
			success : function(data) {
				bindChart2(data);
			}, // success
			error : function(xhr, status) {
				alert(xhr + " : " + status);
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

	//배송조회 
	function fnOrdrDly(){
		
		$.ajax({
			url : "/comm/selectMainDly.do",  
			type : 'POST',
			data : null,
			success : function(data) {
				var listData = new Array();
				$.each(data.list, function(idx,item){	
					if(idx < 5)	//5개만 보이기
						listData.push(item);
				});
				AUIGrid.setGridData(gridDlvy, listData);
			}, // success
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
</script>
<div class="mContent main">
	<!-- 여신조회 -->
	<div class="mConBox">
		<div class="mTitArea">
			<h2>여신조회</h2>

			<div class="dateInfo">
				<span class="date" id="reloadTime">2021.12.10 09:30:00 <em>기준</em></span>
				<button type="button" name="" class="reSetBtn" title="reset" id="btnCredit"></button>
			</div>
		</div>

		<div class="creInquiry">
			<div class="crePrice">
				<p>현재 여신 금액</p>
				<p class="num" id="creditLimit">
					0 <span>원</span>
				</p>
			</div>

			<div class="creTotal">
				<p>현재 주문 합계</p>
				<p class="num" id="ordTotAmount">
					0 <span>원</span>
				</p>
			</div>

			<div class="creShortPrice">
				<p>여신 부족 금액</p>
				<p class="num" id="lackCredit">
					0 <span>원</span>
				</p>
			</div>
		</div>
	</div>
	<!-- 여신조회 -->

	<!-- 요일별 매출현황 -->
	<div class="mConBox">
		<div class="mTitArea type02">
			<h2>요일별 매출현황</h2>
			<span class="unit">(단위:만원)</span>
		</div>

		<div class="byDaySale">
			<canvas id="myChart" style="width: 100%; height: 245px"></canvas>

			<ul class="state">
				<li>첫째주</li>
				<li>둘째주</li>
				<li>셋째주</li>
				<li>넷째주</li>
				<li>다섯째주</li>
				<li>여섯째주</li>
			</ul>
		</div>
	</div>
	<!-- 요일별 매출현황 -->

	<!-- 배송조회 / 공지사항 -->
	<div class="mConWrap">
		<div class="mConBox">
			<div class="mTitArea type02">
				<h2>배송조회</h2>

				<button type="button" name="" class="comBtn" id="btnOrdrDly">더보기</button>
			</div>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap"></div>
			</div>
			<!-- grid -->
		</div>

		<div class="mConBox">
			<div class="mTitArea type02">
				<h2>공지사항</h2>

				<button type="button" name="" class="comBtn" id="btnNotice">더보기</button>
			</div>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap2"></div>
			</div>
			<!-- grid -->
		</div>
	</div>
	<!-- 배송조회 / 공지사항 -->
</div>

<script>
/*
        const ctx = document.getElementById('myChart'); 
        Chart.defaults.font.size = 16;
        const chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ["월요일","화요일","수요일","목요일","금요일","토요일","일요일"],
                datasets: [{
                    label: '첫째주',
                    data: [100, 190, 140, 500, 230, 620, 800],
                    barPercentage: 0.56,
                    categoryPercentage: 0.41,
                    //barThickness: 6,
                    //maxBarThickness: 8,
                    //minBarLength: 2,
                    backgroundColor: "#ff8800",
                    borderColor: "#ff8800",
                    borderSkipped: false,
                    borderRadius: {
                        topLeft: 10,
                        topRight: 0,
                        bottomLeft: 0,
                        bottomRight: 10
                    },
                },{
                    label: '둘째주',
                    data: [720, 140, 430, 150, 200, 300, 500],
                    barPercentage: 0.56,
                    categoryPercentage: 0.41,
                    backgroundColor: "#b5268f",
                    borderColor: "#b5268f",
                    borderSkipped: false,
                    borderRadius:{
                        topLeft: 10,
                        topRight: 0,
                        bottomLeft: 0,
                        bottomRight: 10
                    }
                },{
                    label: '셋째주',
                    data: [320, 490, 530, 350, 720, 610, 404],
                    barPercentage: 0.56,
                    categoryPercentage: 0.41,
                    backgroundColor: "#0596b9",
                    borderColor: "#0596b9",
                    borderSkipped: false,
                    borderRadius:{
                        topLeft: 10,
                        topRight: 0,
                        bottomLeft: 0,
                        bottomRight: 10
                    }
                },{
                    label: '넷째주',
                    data: [100, 190, 450, 500, 230, 520, 15],
                    barPercentage: 0.56,
                    categoryPercentage: 0.41,
                    backgroundColor: "#3cb24a",
                    borderColor: "#3cb24a",
                    borderSkipped: false,
                    borderRadius:{
                        topLeft: 10,
                        topRight: 0,
                        bottomLeft: 0,
                        bottomRight: 10
                    }
                },{
                    label: '다섯째주',
                    data: [120, 190, 720, 550, 320, 330, 500],
                    barPercentage: 0.56,
                    categoryPercentage: 0.41,
                    backgroundColor: "#544397",
                    borderColor: "#544397",
                    borderSkipped: false,
                    borderRadius:{
                        topLeft: 10,
                        topRight: 0,
                        bottomLeft: 0,
                        bottomRight: 10
                    }
                },{
                    label: '여섯째주',
                    data: [120, 190, 720, 550, 320, 330, 500],
                    barPercentage: 0.56,
                    categoryPercentage: 0.41,
                    backgroundColor: "#f20c00",
                    borderColor: "#f20c00",
                    borderSkipped: false,
                    borderRadius:{
                        topLeft: 10,
                        topRight: 0,
                        bottomLeft: 0,
                        bottomRight: 10
                    }
                }, 
            ]},
            options: {
                //responsive: true,
                //maintainAspectRatio: true,
                plugins: {
                    legend: {
                        display: false,                         
                    },
                    scales: {
                        y: {
                            ticks: {
                                callback: (label) => `$ ${label}`,
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
        */
   </script>

