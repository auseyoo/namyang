<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"  %>
<spring:eval expression="@environment.getProperty('grid.type')" var="gridType"/>
<script type="text/javascript" src="/js/lib/jquery-3.6.0.min.js"></script>	
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/commonObj.js"></script>

<tiles:insertAttribute name="body"/>
