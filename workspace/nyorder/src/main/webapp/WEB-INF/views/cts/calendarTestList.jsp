<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">

	var calendarMyGridID;

	var gridData = [
		{ "goodsName" : "GT프리미엄930" } ,
		{ "goodsName" : "깜유홈900ml" }
	];
	
	function fnCalendarGrid ( obj ){
		if( !obj ) return;
		
		var calData = obj;
		
		this.init = function(){
			//월 데이터 셋팅
			this.settingMonth();
			//그리드 생성
			this.create();
		}
		this.create = function(){
			// 이미 생성되어 있는 경우
			/* if(AUIGrid.isCreated("#"+calData.tagetId)) {
				return;
			} */
			
			//calendarLayout 생성
			var calendarLayout = this.calLayoutCreate();
			// 실제로 tagetId 에 그리드 생성 (생성할 태그 ID , 레이아웃Data , 그리드옵션)
			calData.calendarMyGridID = AUIGrid.create( "#"+calData.tagetId, calendarLayout , calData.gridPros );
		
			//footerLayout 생성
			var footerLayout = this.footerLayoutCreate();
			//footer 그리드 생성
			AUIGrid.setFooter(calData.calendarMyGridID, footerLayout);
		
			//그리드 새로고침
			AUIGrid.refresh( calData.calendarMyGridID );
		}
		this.settingMonth = function(){
			
			calData.nowYear = calData.today.getFullYear();
			calData.nowMonth = calData.today.getMonth();
		
			var lastDate = new Date(calData.nowYear,calData.nowMonth+1,0).getDate();
		
			//윤년 적용
			if( ( calData.nowYear%4===0 && calData.nowYear % 100 !==0 ) || calData.nowYear%400===0 ) lastDate[1]=29;
		
			calData.lastDate = lastDate;
			
		}
		//캘린더 레이아웃 생성
		this.calLayoutCreate = function(){
			var calendarLayout = [];
		
			var days = ["일", "월", "화", "수", "목", "금", "토"];
		
			for( var i = 1; i <= calData.lastDate; i++ ){
				plusDate = new Date( calData.nowYear , calData.nowMonth , i ).getDay();
			
				var day = days[plusDate];
			
				//레이아웃데이터 set
				calendarLayout[i-1] = {
					dataField : "day" + i,
					headerText : day,
					width : "5%",
					children : [
						{
							dataField : calData.fieldId + i ,
							headerText : i ,
							width : "5%"
						}
					]
				}
			}
			//컬럼 추가 데이터 있는경우 추가
			if( calData.calendarColumn ) calData.calendarColumn.forEach(function (item, idx){ calendarLayout.unshift( item ) });
		
			return calendarLayout;
		}
		this.footerLayoutCreate = function(){
			var footerLayout = [{
					labelText : "∑",
					positionField : "#base"
				}];
			for( var i = 1; i <= calData.lastDate; i++ ){
				//레이아웃데이터 set
				footerLayout[i] = {
					dataField : calData.fieldId + i,
					positionField : calData.fieldId + i,
					operation : "SUM",
					style : "auiRight",
					colSpan : 1, 
					labelFunction : function(value, columnValues, footerValues) {
						return " " + AUIGrid.formatNumber(value, "#,##0");
					}
				}
			}
			//컬럼 추가 데이터 있는경우 추가
			if( calData.footerColumn ) calData.footerColumn.forEach(function (item){ footerLayout.unshift( item ) });

			return footerLayout;
		}
		this.changeMonth = function( date ){
			//변경할 월 데이터없으면 리턴
			if( !date ) return;
		
			//월 데이터 셋팅
			calData.today = date;
			this.settingMonth();
			//그리드 초기화
			this.reset();
			//그리드 생성
			this.create();
		}
		this.reset = function(){
			calData.calendarMyGridID = null;
			//그리드 초기화
			AUIGrid.destroy("#"+calData.tagetId);
		}
		this.getGridId = function(){
			// AUIGrid 생성 후 반환 ID
			return calData.calendarMyGridID;
		}
		
		//달력 생성
		this.init();
	}

	$(document).ready(function(){
	
		var calGrid = new fnCalendarGrid({
			gridPros : {editable:true,showFooter:true,enableFilter:true} ,//그리드 옵션
			tagetId : "grid_calendar" ,//그리드를 생성할 마크업 ID
			today : new Date() ,//월 데이터
			fieldId : "week" ,//그리드 dataField ID
			calendarColumn : [{//그리드 추가컬럼 데이터
				dataField : "goodsName" ,
				headerText : "제품명" ,
				width : "8%"
			}] ,
			footerColumn : [{//그리드 풋터 추가컬럼 데이터
				dataField : "goodsName" ,
				positionField : "goodsName"
			}]
		});

		// AUIGrid 생성 후 반환 ID
		calendarMyGridID = calGrid.getGridId();
		
		//그리드 데이터set
		AUIGrid.setGridData( calendarMyGridID , gridData );

		//월변경 이벤트
		$("#calSelect").on("change",function(){
			//변경할 날짜 ex.2022-02
			var date = new Date( $(this).val() );
			calGrid.changeMonth( date );
			AUIGrid.setGridData( calendarMyGridID , gridData );
		});
		
	});
	
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>
	<!-- grid -->
	<div class="girdBox">
		<select id="calSelect" style="width: 100px;">
			<option value="2022-01">2022-01</option>
			<option value="2022-02">2022-02</option>
			<option value="2022-03">2022-03</option>
			<option value="2022-04">2022-04</option>
		</select>
		<div id="grid_calendar"></div>
	</div>
	<!-- grid -->
</div>
<!-- content -->

