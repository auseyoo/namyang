<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"  %>
<spring:eval expression="@environment.getProperty('grid.type')" var="gridType"/>
<!DOCTYPE html>

<html lang="ko">
  <head>
	<meta charset="UTF-8">
	<title>namyang</title>
	<!--<meta name="viewport" content="width=device-width, initial-scale=1.0">-->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<link rel="stylesheet" type="text/css" href="/css/lib/MonthPicker.min.css"/>
	<link rel="stylesheet" type="text/css" href="/css/lib/daterangepicker.css"/>
	<link rel="stylesheet" type="text/css" href="/css/AUIGrid/grid_custom.css"/>
	<link rel="stylesheet" type="text/css" href="/css/lib/yearpicker.css"/>
	<link rel="stylesheet" type="text/css" href="/css/layout.css"/>
		
	<script type="text/javascript" src="/js/lib/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="/js/lib/jquery-ui.js"></script>
	
	<script type="text/javascript" src="/js/AUIGrid/AUIGridLicense.js"></script>
	<script type="text/javascript" src="/js/AUIGrid/AUIGrid.js"></script>
	<script type="text/javascript" src="/js/AUIGrid/FileSaver.min.js"></script>
	
	
	<script type="text/javascript" src="/js/lib/moment.min.js"></script>
	<script type="text/javascript" src="/js/datepicker.js"></script>
	<script type="text/javascript" src="/js/lib/daterangepicker.js"></script>
	<script type="text/javascript" src="/js/datepicker_custom.js"></script>
	
	<script type="text/javascript" src="/js/lib/MonthPicker.min.js"></script>
	<script type="text/javascript" src="/js/datepicker_month_custom.js"></script>
	
	<script type="text/javascript" src="/js/lib/yearpicker.js"></script>
	<script type="text/javascript" src="/js/yearpicker_custom.js"></script>
	
	<script type="text/javascript" src="/js/common.js"></script>
	<script type="text/javascript" src="/js/commonObj.js"></script>
	
	<script type="text/javascript" src="/js/jquery.tmpl.js"></script>
	<script type="text/javascript" src="/js/lib/Lodash.4.17.15.js"></script>
	<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=375b9772107b2e804f178e4af54e08da&libraries=services,clusterer,drawing"></script>
</head>
<script type="text/javascript">
	var ajaxDialog = new Array();
</script>
<body>
<!-- 로딩바 -->
<div class="loadBox" style="display: none">
	<div class="loading">
		<img src="../images/loading.png" alt="loading">
	</div>		
</div>
<!-- 로딩바 -->
	<div class="allWrap">
		<tiles:insertAttribute name="header"/>
		<div class="contentWrap">
			<tiles:insertAttribute name="left"/>
			<div class="rContentBox" id="bodyTile">
				<tiles:insertAttribute name="body"/>
				<tiles:insertAttribute name="footer"/>
			</div>
		</div>
		<div>
			<!-- modal 배경 -->
			<div class="modal_bg"></div> 
			
			<!-- Alert03 -->
			<div class="alertWrap small" data-popup="modalAlert">
				<header>
					<h3 id="alertTitle">주문등록</h3>
					<button type="button" name="" class="closeBtn modalCloseBtn"></button>
				</header>
				<div class="alertCon">
					<p id="alertMessage">
					주문정보가 전송되었습니다.<br/>
					주문은 [전송]으로 최종 확정됩니다.
					</p>
					<div class="popBtnArea">
						<button type="button" name="" class="inquBtn modalCloseBtn" id="alertBtn1">확인</button>
						<button type="button" name="" class="comBtn modalCloseBtn" id="alertBtn2">취소</button>
					</div>
				</div>
			</div>
			<!--// Alert03 -->
		</div>
		<div id="comPopArea">			
		</div>
		
		
	</div>

</body>
