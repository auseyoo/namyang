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
	.page .leftWrap .list:not(:first-child) .header{position:relative; left:90px; width:10cm; height:30px;}
	.page .rightWrap .list:not(:first-child) .header{position:relative; left:90px; width:10cm; height:30px;}
	.page .left{width:10cm; padding-right:20px}
	.page .right{width:10cm; padding-left:20px}

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
	.info02 {text-align: left;}
	.info02 p {display:inline-block; font-size: 9pt; margin-bottom:0; font-weight: bold;} 


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
	}

	/*table, img, svg {break-inside:avoid;}*/
	.printWrap{text-align:center; margin:0;}
	.printWrap h2{font-size:25px;}

	.tblWrap{height:100%;}
	table[class*="tbl"] {table-layout:fixed; width:100%; height:100%; clear:both; border-collapse:collapse; margin-top:-15px;}
	table[class*="tbl"] tr > * {vertical-align:middle;}
	.tbl {border:1px solid #dedede;}
	.tbl tbody th, .tbl tbody td{white-space:nowrap;}
	.tbl thead th {font-size:9pt; font-weight:bold; height:20px; line-height:20px; background:#f5f5f5; border-right:1px solid #dedede; border-bottom:1px solid #dedede; padding:0 5px; color:#000;}
	.tbl tbody td {font-size:8.2pt; text-align:left; border-right:1px solid #dedede; border-bottom:1px solid #dedede; padding:4px 3.5px; height:100%;}
	.tbl tbody td p{margin:0; text-align:center;}
	.tbl tbody td.ac{text-align:center;}
	.tbl tbody td.ar{text-align:right;}
	.tbl.type02 {}
	.tbl.type02 thead th{padding:0; font-size:8pt;}
	caption,legend{visibility:hidden;}

	.pGroup {display: flex; flex-wrap:wrap;}
	.pGroup p {text-align: center;}
	.pGroup p:nth-child(1) {width: 33%;}
	.pGroup p:nth-child(2) {width: 67%; text-overflow:ellipsis; white-space:normal; overflow:hidden;}
	.tbl tbody .pGroup p:nth-child(2) {padding-bottom:3px;}
	.pGroup p:nth-child(3) {width: 100%;}
	.pGroup p:nth-child(3).al {padding:0; padding-left:4px;}
	.tbl tbody td p {padding:5px 0;}
	.tbl tbody td p:nth-child(1) {padding:0; text-overflow:ellipsis; white-space:normal; overflow:hidden;}
	.tbl tbody td p:nth-child(2) {padding:0;}

	.ac{text-align:center;}
	.ar{text-align:right;}
	.al{text-align:left !important;}
	
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
				<h2>일일 배달 명단</h2> 
				<h2>일일 배달 명단</h2>
			</div>
			<!--left-->
			<div class="leftWrap">
				<!-- list -->
				<div class="list">
					<div class="left">
						<div class="info">
							<p>${param.srcDate} <span class="ml10 weekDay"></span></p>
						</div>
						<div class="info02">
							<p>${param.areaNm}</p>
							<p>${param.emplNm}</p>
						</div>
						
						<c:set var="dlvCnt" value="${fn:length(dlvList)/9}"/>
						<c:forEach begin="0" step="1" end="${dlvCnt}" varStatus="r">
							<div class="tblWrap">
								<table class="tbl">
									<caption>일일 배달 명단</caption>
									<colgroup>
										<col style="width:10%;">
										<col>
										<col style="width:13%;">
										<col style="width:10%;">
										<col style="width:25%;">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">순서</th>
											<th scope="col">배달정보</th>
											<th scope="col">약어</th>
											<th scope="col">수량</th>
											<th scope="col">주문패턴</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach begin="${r.index*9}" step="1" end="${r.index*9+9}" varStatus="s">
											<c:if test="${fn:length(dlvList[s.index+r.index].cstPrdDlvySeq) > 0}">
												<tr>
													<td>
														<p>${(r.index+s.index) + 1}</p>
													</td>
													<td>
														<div class="pGroup">
															<p>${dlvList[s.index+r.index].cstNm}</p>
															<p class="al">${dlvList[s.index+r.index].dlvAddr}</p>
															<p class="al">${dlvList[s.index+r.index].inPosi}</p>										
														</div>
													</td>
													<td>
														<p>${dlvList[s.index+r.index].abrvNm}</p>
													</td>
													<td>
														<p>${dlvList[s.index+r.index].dlvyQty}</p>
													</td>
													<td>
														<p>배달요일</p>
														<p>${dlvList[s.index+r.index].pttn}</p>
													</td>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:forEach>
						
						<c:set var="prdCnt" value="${fn:length(prdList)/10}"/>
						<c:set var="totCnt" value="0"/>
						<c:forEach begin="0" step="1" end="${prdCnt}" varStatus="r">
								<div class="tblWrap">
									<table class="tbl type02">
										<caption>일일 배달 명단</caption>
										<colgroup>
											<col style="width:10%;">
											<col style="width:10%;">
											<col style="width:10%;">
											<col style="width:10%;">
											<col style="width:10%;">
											<col style="width:10%;">
											<col style="width:10%;">
											<col style="width:10%;">
											<col style="width:10%;">
											<col>
										</colgroup>
										<thead>
											<tr>
												<c:forEach begin="${r.index*8}" step="1" end="${r.index*8+8}" varStatus="s">
													<c:if test="${r.index*9+9 > s.index}">
														<th scope="col">${prdList[s.index+r.index].abrvNm}</th>
													</c:if>
												</c:forEach>
												<th scope="col">합계</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<c:forEach begin="${r.index*8}" step="1" end="${r.index*8+8}" varStatus="s">
													<c:if test="${r.index*9+9 > s.index}">
														<td><p>${prdList[s.index+r.index].prdQty}</p></td>
														<c:set var="totCnt" value="${totCnt + prdList[s.index+r.index].prdQty}"/>
													</c:if>
												</c:forEach>
												<td>${totCnt}</td>
											</tr>
										</tbody>
									</table>
								</div>
						</c:forEach>
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