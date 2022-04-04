<!-- 
	@File Name: bodyContecnt.jsp
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 2. 11.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"  %>
<spring:eval expression="@environment.getProperty('grid.type')" var="gridType"/>
    
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
	
	<script type="text/javascript" src="/js/common.js"></script>
	<script type="text/javascript" src="/js/commonObj.js"></script>
	
	<script type="text/javascript" src="/js/jquery.tmpl.js"></script>
	<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=375b9772107b2e804f178e4af54e08da&libraries=services,clusterer,drawing"></script>
<body>
<tiles:insertAttribute name="content"/> <!-- body -->
<tiles:insertAttribute name="footer"/>

</body>
</html>