<!-- 
	@File Name: dailyDlvPrintPop.jsp
	@File 설명 : 일일 배달 명단	
	@File Id : 	PR-F-012.html
	@작성일 : 2022. 3. 28.
	@작성자 : YESOL
 -->
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<title>남양유업 대리점 주문시스템 - 출고증</title>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
	body,html{margin:0; padding:0; height:100%; font-size:12pt;}
	* {color-adjust: exact!important; -webkit-print-color-adjust: exact!important; print-color-adjust:exact !important; box-sizing:border-box; -moz-box-sizing: border-box}
	.header{display:flex; position:absolute; width:19.8cm; height:30px;}
	.header h2{width:50%; margin:0}
    .page {display:flex; width:21cm; min-height:29.7cm; padding:1cm 0.6cm 0.5cm; margin:1cm auto; background:#fff; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}
	.page h2{width:50%; left:0}
	.page .leftWrap{position:relative; border-right:1px dashed #000; margin-top:30px;}
	.page .rightWrap{position:relative; margin-top:30px;}
	/*.page .leftWrap .list:not(:first-child) .header{position:relative; left:90px; width:10cm; height:30px;}
	.page .rightWrap .list:not(:first-child) .header{position:relative; left:90px; width:10cm; height:30px;}*/
	.page .leftWrap .list:not(:first-child) .header{position:relative; left:90px; width:10cm; height:30px;}
	.page .rightWrap .list:not(:first-child) .header{position:relative; width:10cm; height:30px; padding-left:110px;}
	.page .left{width:9.9cm; padding-right:20px}
	.page .right{width:9.9cm; padding-left:20px}

	.page .leftWrap .list:not(:first-child){page-break-before:always;} 
	.page .rightWrap .list:not(:first-child){page-break-before:always;} 

	.leftWrap .notice{font-size:9pt; text-align:left; padding:10px 0 0 15px;}
	.rightWrap .notice{font-size:9pt; text-align:left; padding:10px 0 0 30px;}
	.notice li{line-height:8px;}
	.notice li div{border:1px solid #fff}

	.info{padding:0; margin:0;}
	.info p{padding:0; margin:10px 0 0;}
	.info p:nth-child(1){font-size:11pt;}
	.info p:nth-child(2){text-align:left; font-size:9pt; font-weight:bold; margin:10px 0 0;} 


	@page {
		/*size: A4 landscape;*/    /*Portrait*/
		size: A4 Portrait;
		margin:10px 0 10px;
		/*size: landscape;*/
	}
	@media print {
		html, body {width:210mm; height:297mm;}
		.page {margin:0; border:initial; border-radius:initial; width:initial; min-height:initial; box-shadow:initial; background:initial;}
		.tbl tbody th {background:#f5f5f5 !important;}
		/*.page .leftWrap{width:11cm; border:1px solid red}*/
	}

	/*table, img, svg {break-inside:avoid;}*/
	.printWrap{text-align:center; margin:0;}
	.printWrap h2{font-size:25px;}

	.tblWrap{height:100%;}
	table[class*="tbl"] {table-layout:fixed; width:100%; height:100%; clear:both; border-collapse:collapse; margin-top:-15px;}
	table[class*="tbl"] tr > * {vertical-align:middle;}
	.tbl {border:1px solid #dedede;}
	/*.tbl tbody th, .tbl tbody td{white-space:nowrap;}*/
	.tbl thead th {font-size:8.5pt; font-weight:bold; height:20px; line-height:20px; background:#f5f5f5; border-right:1px solid #dedede; border-bottom:1px solid #dedede; padding:0 5px; color:#000;}
	.tbl tbody td {font-size:8.5pt; text-align:left; border-right:1px solid #dedede; border-bottom:1px solid #dedede; padding:4px 5px 4px 5px; height:24px;}
	.tbl tbody td p{margin:0; word-break:break-all;}
	.tbl tbody td.ac{text-align:center;}
	.tbl tbody td.ar{text-align:right;}
	caption,legend{visibility:hidden;}

	.ac{text-align:center;}
	.ar{text-align:right;}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$(".weekDay").html(fnGetWeekDay("${param.srcDate}"));
})

</script>
</head>
<body>
	<div class="printWrap">
		<div class="page">
			<div class="header">
				<h2>출고증</h2>
				<h2>출고증</h2>
			</div>
			<!--left-->
			<div class="leftWrap">
				<!-- list -->
				<div class="list">
					<div class="left">
						<div class="info">
							<p>${param.srcDate} <span class="ml10 weekDay"></span></p>
							<p>지역명 : ${param.areaNm}</p>
						</div>
						
						<c:choose>
							<c:when test="${param.blankYn eq 'N' }">
								<c:set var="prdCnt" value="${fn:length(prdList)/20}"/>
								<c:forEach begin="0" step="1" end="${prdCnt}" varStatus="r">
								<c:set var="totCnt" value="0"/>
									<div class="tblWrap">
										<table class="tbl">
											<caption>출고증</caption>
											<colgroup>
												<col style="width:35%;">
												<col>
												<col style="width:35%;">
												<col style="width:15%;">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">제품</th>
													<th scope="col">수량</th>
													<th scope="col">제품</th>
													<th scope="col">수량</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach begin="${r.index*19}" step="1" end="${r.index*19+19}" varStatus="s">
													<c:if test="${fn:length(prdList) > (s.index+r.index) }">
														<c:if test="${(s.index+r.index) % 2 eq 0}">
															<tr>
														</c:if>
														<td><p>${prdList[s.index+r.index].prdNm}</p></td>
														<td class="ar">${prdList[s.index+r.index].prdQty}</td>
														<c:set var="totCnt" value="${totCnt + prdList[s.index+r.index].prdQty}"/>
														<c:if test="${(s.index+r.index) % 2  eq 1}">
															</tr>
														</c:if> 
													</c:if>
													<c:if test="${fn:length(prdList) == (s.index+r.index) && (s.index+r.index) % 2 eq 1 }">
														<td></td><td></td></tr>
													</c:if>
												</c:forEach>
												<tr>
													<td colspan="2" class="ac">합계</td>
													<td colspan="2" class="ar">${totCnt}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="tblWrap">
										<table class="tbl">
											<caption>출고증</caption>
											<colgroup>
												<col style="width:35%;">
												<col>
												<col style="width:35%;">
												<col style="width:15%;">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">제품</th>
													<th scope="col">수량</th>
													<th scope="col">제품</th>
													<th scope="col">수량</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td colspan="2" class="ac">합계</td>
													<td colspan="2" class="ar">${totCnt}</td>
												</tr>
											</tbody>
										</table>
									</div>
							</c:otherwise>
						</c:choose>
						
						<c:if test="${param.incNtcYn eq 'Y' }">
							<ul class="notice">
								<c:forEach items="${ntcList}" var="i" >
									<li>
										<c:choose>
											<c:when test="${i.ntcSecCd ne 'CST' }">
												${i.ntcType} 전달사항
												<p>${i.cntt}</p>
											</c:when>
											<c:otherwise>
												${i.ntcType} 전달사항
												<div>
													<p>${i.ntcTrgt} ${i.dlvAddr }</p>
													<p></p>
												</div>
											</c:otherwise>
										</c:choose>
									</li>
								</c:forEach>
							</ul>
						</c:if>
					</div>
				</div>
				
			</div>
			<!--left-->

			<!--right-->
			<div class="rightWrap">
			</div>
		</div>
	</div>
</body>
</html>