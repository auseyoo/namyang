<!-- 
	@File Name: cdtlInfoPop
	@File 설명 : 여신 상세보기
	@UI ID : UI-PORD-0101P1.html
	@작성일 : 2022. 3. 4.
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
	$(document).ready(function(){
		getCdtlInfo(setCdtlInfoDetail);
	});
	
	//여신 상세보기
	function setCdtlInfoDetail(data){
		//사용율
		data.RATE = Math.floor( data.AVAIL_AMT / data.CREDIT_LIMIT * 100 );
		//여신사용액
		data.USE_PRICE = setComma( data.CREDIT_LIMIT - data.AVAIL_AMT );
		//콤마 처리
		data.AVAIL_AMT = setComma( data.AVAIL_AMT );
		data.CREDIT_LIMIT = setComma( data.CREDIT_LIMIT );
		data.COMM_AR = setComma( data.COMM_AR );
		data.CMS_OVERDUE_AMT = setComma( data .CMS_OVERDUE_AMT );
		data.COMM_SO = setComma( data.COMM_SO );
		data.SO_AMT = setComma( data.SO_AMT );
		data.DO_AMT = setComma( data.DO_AMT );
		
		$("#detailArea").html($("#detailTmpl").tmpl( data ));
	}
</script>
<!-- 여신 상세보기 -->
<div class="popWrap mideum modal_wrap h580" data-popup="cdtlnDetailPop"> <!-- small 사이즈 600px * 370px -->
	<div id="detailArea"></div>
</div>
<!--// 여신 상세보기 -->

<script id="detailTmpl" type="text/x-jquery-tmpl">
	<!-- popCon -->
	<header>
		<h3>여신 상세보기</h3>
		<button type="button" name="" class="closeBtn" id="modalCloseBtn" data-target="cdtlnDetailPop"></button>
	</header>
	<div class="popCon">
		<div class="popTitArea">
			<h3>여신 상세보기</h3>
			<div class="popBtnArea">
				<button type="button" name="" class="comBtn" id="modalCloseBtn" data-target="cdtlnDetailPop">닫기</button>
			</div>
		</div>
			
		<div class="titleArea">
			<h3 class="tit01">여신 정보</h3>
		</div>
			
		<div class="txtInfo pColor02">
			※ 장비담보는 여신에 반영되지 않습니다.
		</div>
			
		<div class="tblWrap">
			<table class="tbl">
				<caption>여신 상세정보</caption>
				<colgroup>
					<col style="width:185px;">
					<col>
					<col style="width:185px;">
					<col>
				</colgroup>
				<tbody>
					<tr class="point">
						<th scope="row">여신잔액</th>
						<td>\${AVAIL_AMT}</td>
						<th scope="row">사용율(%)</th>
						<td>\${RATE}</td>
					</tr>
					<tr>
						<th scope="row">총 여신금액</th>
						<td>\${CREDIT_LIMIT}</td>
						<th scope="row">여신사용액</th>
						<td>\${USE_PRICE}</td>
					</tr>
					<tr>
						<th scope="row">부동산담보</th>
						<td></td>
						<th scope="row">매출채권</th>
						<td>\${COMM_AR}</td>
					</tr>
					<tr>
						<th scope="row">보증보험/금융채권</th>
						<td></td>
						<th scope="row">CMS 연체금액</th>
						<td>\${CMS_OVERDUE_AMT}</td>
					</tr>
					<tr>
						<th scope="row">특별여신</th>
						<td></td>
						<th scope="row">미매출액( A + B + C)</th>
						<td>\${COMM_SO}</td>
					</tr>
					<tr>
						<th scope="row">임시여신</th>
						<td></td>
						<th scope="row">미결주문(A)</th>
						<td>\${SO_AMT}</td>
					</tr>
					<tr>
						<th scope="row">여신통화</th>
						<td>\${LIMIT_CURRENCY}</td>
						<th scope="row">납품금액(B)</th>
						<td>\${DO_AMT}</td>
					</tr>
					<tr>
						<th scope="row">I/F 일시</th>
						<td></td>
						<th scope="row">청구금액(C)</th>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- popCon -->
</script>