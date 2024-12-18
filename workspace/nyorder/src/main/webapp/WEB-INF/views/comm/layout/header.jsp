<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="users" property="principal" />
</sec:authorize>
<header>
	<h1><a href="/comm/main.do" class="logo" title="남양유업"></a></h1>
	<div class="logInfo">
		<ul>
			<li><span class="user"><sec:authorize access="isAuthenticated()"><sec:authentication var="emplNm" property="principal.emplNm"/>${emplNm}</sec:authorize></span> 님 을 환영합니다.</li>
			<li>최근접속일시 : <span class="date"><fmt:formatDate value="${lastLogin}" pattern="yyyy-MM-dd HH:mm:ss"/></span></li>
			<li><a href="${request.contextPath}/logout" class="logOut"><span>로그아웃</span></a></li>
		</ul>
	</div>
</header>
