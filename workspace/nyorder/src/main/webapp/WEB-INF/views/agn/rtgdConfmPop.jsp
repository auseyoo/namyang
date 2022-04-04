<!-- 
	@File Name: rtgdConfmPop
	@File 설명 : 반품확인서 팝업
	@UI ID : PR-F-001.html
	@작성일 : 2022.03.16
	@작성자 : 김정애
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>남양유업 대리점 주문시스템 - 반품확인서</title>
<style>
	body,html{margin:0; padding:0; height:100%; font-size:12pt;}
	* {color-adjust: exact!important; -webkit-print-color-adjust: exact!important; print-color-adjust: exact!important; box-sizing:border-box; -moz-box-sizing: border-box}
     .page {width:21cm; min-height:29.7cm; padding:1cm 1.5cm; margin:1cm auto; background:#fff; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}
	/*.subpage {padding:1cm; height:256mm;}*/
	@page {
		/*size: A4 landscape;*/    /*Portrait*/
		size: A4 Portrait;
		margin:20px 0 10px;
		/*size: landscape;*/
	}
	@media print {
		html, body {width:210mm; height:297mm;}
		.page {margin:0; border:initial; border-radius:initial; width:initial; min-height:initial; box-shadow:initial; background:initial; page-break-after:avoid}
		.tbl tbody th {background:#f5f5f5 !important;}
	}

	/*table, img, svg {break-inside:avoid;}*/
	.printWrap{text-align:center;}
	.printWrap h2{font-size:27px; text-decoration:underline;}

	.tblWrap{height:100%;}
	table[class*="tbl"] {table-layout:fixed; width:100%; height:100%; clear:both; border-collapse:collapse;}
	table[class*="tbl"] tr > * {vertical-align:middle;}
	.tbl {border:1px solid #dedede;}
	.tbl tbody th, .tbl tbody td{white-space:nowrap;}
	.tbl thead th {font-size:10pt; font-weight:bold; height:20px; line-height:20px; background:#f5f5f5; border-right:1px solid #dedede; border-bottom:1px solid #dedede; padding:0 5px; color:#000;}
	.tbl tbody td {font-size:9.5pt; text-align:left; border-right:1px solid #dedede; border-bottom:1px solid #dedede; padding:4px 7px 4px 7px; height:100%;}
	.tbl tbody td p{margin:0;}
	.tbl tbody td.ac{text-align:center;}
	.tbl tbody td.ar{text-align:right;}
	caption,legend{visibility:hidden;}

	.usage{font-size:10pt;}
	.info{text-align:left;}
	.info dl{display:flex;}
	.info dl dd{margin-left:10px;}

	.confirm{display:flex; justify-content:space-between; font-size:11pt;}
	.ac{text-align:center;}
	.ar{text-align:right;}
</style>
<script>
window.print();
</script>
</head>
<body>
	<div class="printWrap">
		<div class="page">
			<h2>반품확인서</h2>

			<div class="usage ar">
				<p>(대리점 보관용)</p>
			</div>

			<div class="info">
				<dl>
					<dt>확정일자 :</dt>
					<dd>${dcsnDt}</dd>
				</dl>
				<dl>
					<dt>대리점명 :</dt>
					<dd>${agenNm}</dd>
				</dl>
			</div>

			<div class="tblWrap">
				<table class="tbl"> <!-- style="page-break-after:always;"-->
					<caption>반품확인서</caption>
					<colgroup>
						<col style="width:5%;">
						<col>
						<col style="width:10%;">
						<col style="width:10%;">
						<col style="width:14%;">
						<col style="width:20%;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" rowspan="2">No</th>
							<th scope="col" rowspan="2">제품명</th>
							<th scope="col" colspan="3">수량</th>
							<th scope="col" rowspan="2">비고</th>
						</tr>
						<tr>
							<th scope="col">박스</th>
							<th scope="col">낱봉</th>
							<th scope="col">합계</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${list}" varStatus="status">
						<tr>
							<td class="ac">${status.count}</td>
							<td>
								<p><c:out value="${item.prdNm}" /></p>
							</td>
							<td class="ar">
								<c:out value="${item.dcsnBoxQty}" />
							</td>
							<td class="ar">
								<c:out value="${item.dcsnIddyQty}" />
							</td>
							<td class="ar">
								<c:out value="${item.dcsnQty}" />
							</td>
							<td>
								<c:out value="${item.rtgdSecTxt}" />
							</td>
						</tr>
						</c:forEach>						
					</tbody>
				</table>
			</div>

			<dl class="confirm">
				<dt>배송기사 :</dt>
				<dd>
					(인)
				</dd>
				<dt>대리점장 :</dt>
				<dd>
					(인)
				</dd>
			</dl>
		</div>
	</div>
</body>
</html>