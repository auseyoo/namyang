<!--
	@File Name: ordrDcsnDly
	@File 설명 : 주문확정/배송 조회
	@UI ID : 	UI-PORD-0201.html
	@작성일 : 2022.02.15
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style type="text/css">
/* 커스컴 disable 스타일*/
.mycustom-disable-color {
	color : #cccccc;
}
</style>
<script type="text/javascript">
	var myGridID;
	
	$(document).ready(function(){
		//datepicker 달력
		$("#datepicker").daterangepicker({
			"singleDatePicker": true,
			"showDropdowns": true,
			"changeMonth": true,
			"showMonthAfterYear": true,
			"locale": {
				"format": "YYYY-MM-DD",
				"separator": " - ",
				"applyLabel": "Apply",
				"cancelLabel": "Cancel",
				"fromLabel": "From",
				"toLabel": "To",
				"customRangeLabel": "Custom",
				"weekLabel": "W",
				"applyLabel": "확인",
				"cancelLabel": "취소", 
				"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
				"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				"firstDay": 1
			},
			"showCustomRangeLabel": false,
			}, function(start, end, label) {
				$("#changeDt").val( start.format('YYYYMMDD') );
		});
		
		//초기진입시 날짜 설정
		var stdrDate = $("#datepicker").val().replace('-','').replace('-','');
		$("#stdrDate").val( stdrDate );
		
		// AUIGrid 생성 후 반환 ID
		createAUIGrid(columnLayout);
		
		// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
		searchList();
		
		AUIGrid.setFooter(myGridID, footerLayout);

		//조회버튼 클릭
		$("#searchBtn").on("click",function(){
			var changeDt = $("#changeDt").val();
			if( changeDt ){
				$("#stdrDate").val( changeDt );
			}
			
			searchList();
		});
	});

	/* 주문/확정 배송 - 리스트 조회 */
	function searchList(){
		$.ajax({
			url : "/agn/selectOrdrDcsnDlyList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridID, data.list);
				$("#searchCnt").html(data.list.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	};
	
	// AUIGrid 를 생성합니다.
	function createAUIGrid(columnLayout) {
		// 그리드 속성 설정
		var gridPros = {
				headerHeight : 29,
				rowHeight : 29,
				// 편집 가능 여부 (기본값 : false)
				editable : false,
				// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
				enterKeyColumnBase : true,
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
				groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
				rowStyleFunction : function(rowIndex, item) {
					//주문량 BOX
					var totalReqBoxQty = ( item.totalReqBoxQty ) ? item.totalReqBoxQty : 0;
					//주문량 낱봉
					var totalReqIddyQty = ( item.totalReqIddyQty ) ? item.totalReqIddyQty : 0;
					var shipQuan01 = ( item.shipQuan01 ) ? item.shipQuan01 : 0;
					var shipQuan02 = ( item.shipQuan02 ) ? item.shipQuan02 : 0;
					var deliveryQuan01 = ( item.deliveryQuan01 ) ? item.deliveryQuan01 : 0;
					var deliveryQuan02 = ( item.deliveryQuan02 ) ? item.deliveryQuan02 : 0;
					
					if( totalReqBoxQty != shipQuan01 || totalReqBoxQty != deliveryQuan01 ) return "mycustom-disable-color";
					if( totalReqIddyQty != shipQuan02 || totalReqIddyQty != deliveryQuan02 ) return "mycustom-disable-color";
					return null;
				}
		};
		
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
	}
	
	var columnLayout = [{
			dataField : "prdSapCd",
			headerText : "제품코드",
			width : "7%",
		},{
			dataField : "prdNm",
			headerText : "제품명",
			style : "auiLeft",
			width : "15%",
		},{
			dataField : "ordDt",
			headerText : "주문일자",
			width : "7%",
		},{
			dataField : "cosDt",
			headerText : "배송일자",
			width : "7%"
		},{
			dataField : "faltQty",
			headerText : "입수량",
			width : "4%",
			style : "auiRight"
		},{
			dataField : "orderQuan",
			headerText : "주문량",
				children : [{
					dataField : "totalReqBoxQty",
					headerText : "BOX",
					width : "4%",
					style : "auiRight"
				}, {
					dataField : "totalReqIddyQty",
					headerText : "낱봉",
					headerStyle : "auiBorR",
					width : "4%",
					style : "auiRight"
				}]
		},{
			dataField : "shipQuan",
			headerText : "확정수량",
				children : [{
					dataField : "shipQuan01",
					headerText : "BOX",
					width : "4%",
					style : "auiRight"
				}, {
					dataField : "shipQuan02",
					headerText : "낱봉",
					headerStyle : "auiBorR",
					width : "4%",
					style : "auiRight"
				}]
		}, {
			dataField : "deliveryQuan",
			headerText : "배송수량",
				children : [{
					dataField : "deliveryQuan01",
					headerText : "BOX",
					width : "4%",
					style : "auiRight"
				}, {
					dataField : "deliveryQuan02",
					headerText : "낱봉",
					headerStyle : "auiBorR",
					width : "4%",
					style : "auiRight"
				}]
		} , {
			dataField : "untpc",
			headerText : "매입가",
			dataType : "numeric",
			width : "4%",
			style: "auiRight",
			expFunction : function(  rowIndex, columnIndex, item, dataField ) {
				//매입가
				var untpc = ( Number(item.untpc) ) ? Number(item.untpc) : 0;
				
				return Number( untpc );
			}
		},{
			dataField : "total",
			headerText : "합계",
				children : [{
					dataField : "totalSpprc",
					headerText : "공급가",
					dataType : "numeric",
					width : "5%",
					style: "auiRight",
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
				}, {
					dataField : "vatSpprc",
					headerText : "VAT",
					dataType : "numeric",
					width : "5%",
					style: "auiRight",
					expFunction : function( rowIndex, columnIndex, item, dataField ) {
						var vatSpprc = 0;
						var totalSpprc = ( item.totalSpprc ) ? Number(item.totalSpprc) : 0 ;
						if( item.taxtCd == 'TAXT' ){//과세
							vatSpprc = Number( ( totalSpprc * 10 / 100 ) );
						}
						return Number(vatSpprc);
					}
				}, {
					dataField : "sumSpprc",
					headerText : "計",
					dataType : "numeric",
					width : "5%",
					style: "auiRight",
					expFunction : function(  rowIndex, columnIndex, item, dataField ) {
						var sumSpprc = 0;
						var totalSpprc = ( Number(item.totalSpprc) ) ? Number(item.totalSpprc) : 0;
						var vatSpprc = ( Number(item.vatSpprc) ) ? Number(item.vatSpprc) : 0;
						
						if( item.taxtCd == 'TAXT' ){
							sumSpprc = totalSpprc + vatSpprc;
						}else{
							sumSpprc = totalSpprc;
						}
						return Number( sumSpprc);
					}
				}]
		} ,{
			dataField : "delivery",
			headerText : "배송 정보",
				children : [{
					dataField : "carNo",
					headerText : "차량번호",
					width : "5%",
					style: "auiRight"
				} , {
					dataField : "drivNm",
					headerText : "기사명",
					width : "5%",
					style: "auiRight"
				} , {
					dataField : "telNo",
					headerText : "기사 연락처",
					width : "7%",
					style: "auiRight"
				} , {
					dataField : "startTm",
					headerText : "출발시각",
					width : "5%",
					style: "auiRight"
				} , {
					dataField : "pratTm",
					headerText : "예정시간",
					width : "5%",
					style: "auiRight"
				}]
		}
	];

	// 푸터 설정
	var footerLayout = [{
			labelText : "∑",
			positionField : "#base"
		}, {
			dataField : "prdSapCd",
			positionField : "prdSapCd",
			operation : "SUM",
			colSpan : 5, // 자신을 포함하여 4개의 푸터를 가로 병합함.
			labelFunction : function(value, columnValues, footerValues) {
				//return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
				return "합계 : ";
			}
		}, {
			dataField : "totalReqBoxQty",
			positionField : "totalReqBoxQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "totalReqIddyQty",
			positionField : "totalReqIddyQty",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "shipQuan01",
			positionField : "shipQuan01",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "shipQuan02",
			positionField : "shipQuan02",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}, {
			dataField : "deliveryQuan01",
			positionField : "deliveryQuan01",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		} , {
			dataField : "deliveryQuan02",
			positionField : "deliveryQuan02",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		} , {
			dataField : "untpc",
			positionField : "untpc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		} , {
			dataField : "totalSpprc",
			positionField : "totalSpprc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		} , {
			dataField : "vatSpprc",
			positionField : "vatSpprc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		} , {
			dataField : "sumSpprc",
			positionField : "sumSpprc",
			operation : "SUM",
			style : "auiRight",
			colSpan : 1, 
			labelFunction : function(value, columnValues, footerValues) {
				return " " + AUIGrid.formatNumber(value, "#,##0");
			}
		}
	];
</script>

<!-- content -->
<div class="rContentBox">
	<div class="content">
		<tiles:insertAttribute name="body.breadcrumb"/>
		<form id="frm">
			<input type="hidden" name="ordType" id="ordType" value="GNRL">
			<!-- 조회 -->
			<div class="inquiryBox type03">
				<dl>
					<dt>기준일자</dt>
					<dd>
						<div class="formWrap">
							<div class="dateWrap">
								<input type="text" value="" class="inp" id="datepicker">
								<input type="hidden" name="stdrDate" id="stdrDate">
								<input type="hidden" id="changeDt">
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>
							</div>
							<div class="checkGroup">
								<input type="radio" name="searchType" value="delivery" id="type1"  class="type01" checked><label for="type1"><span>배송일</span></label>
								<input type="radio" name="searchType" value="order" id="type2" class="type01"><label for="type2"><span>주문일</span></label>
							</div>
							<button type="button" class="comBtn" id="searchBtn">조회</button>
						</div>
					</dd>
				</dl>
			</div>
			<!-- 조회 -->
		</form>
		
		<!-- 상태정보 -->
		<div class="txtInfo">
			※ “주문량” 대비 “확정 수량”이나 “배송 수량”이 달라진 제품은 음영으로 표시됩니다.
		</div>
		<!-- 상태정보 -->
		
		<div class="titleArea right">
			<p class="numState">
				<em>총 <span class="pColor01 fb" id="searchCnt">0</span></em> 건 이 조회되었습니다.
			</p>
		</div>
		
		<!-- grid -->
		<div class="girdBox">
			<div id="grid_wrap"></div>
		</div>
		<!-- grid -->
	</div>
</div>
<!-- content -->