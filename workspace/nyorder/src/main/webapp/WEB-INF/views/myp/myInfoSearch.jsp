<!-- 
	@File Name: myInfoSearch.jsp
	@File 설명 : 내 정보 조회
	@UI ID : 	UI-PMYP-0101
	@작성일 : 2022. 1. 4.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/getCommCode.tld" prefix="code" %>
<code:makeSelect commGrpCd="BANK_CD" 	var="bankCd"	name="bankCd" classNm="sel w160"/>
<script type="text/javascript">

$(document).ready(function(){
 	$("#inp_inquiry").click(saveMyInfo);
});

function saveMyInfo(){

	$.ajax({
		url : "/myp/saveAgenAcctInfo.do", 
		type : "POST", 
		data : $("#frm").serialize(),
		success : function(data) {
			alert(data);
			searchList();
		}, // success 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 
}

</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>

	<div class="btnArea type02 ar">
		<button type="button" name="" class="inquBtn" id="inp_inquiry">저장</button>
	</div>

	<!-- 대리점 상세 정보 -->
	<div class="titleArea right">
		<h3 class="tit01">대리점 상세 정보</h3>

		<p class="txt01 pColor02">* 정보 수정 사항은 담당사원에게 요청해주세요.</p>
	</div>

	<div class="tblWrap type02">
		<table class="tbl">
			<caption>대리점 상세정보</caption>
			<colgroup>
				<col style="width:170px;">
				<col>
				<col style="width:170px;">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">
						대리점 코드
					</th>
					<td>
						${agenMst.agenCd}
					</td>
					<th scope="row">
						상호
					</th>
					<td>
						${agenMst.agenNm}
					</td>
				</tr>
				<tr>
					<th scope="row">
						사업자번호
					</th>
					<td>
						${agenMst.bizNo}
					</td>
					<th scope="row">
						대표자명
					</th>
					<td>
						${agenMst.agenPrst}
					</td>
				</tr>
				<tr>
					<th scope="row">
						업태
					</th>
					<td>
						${agenMst.bizCon}
					</td>
					<th scope="row">
						업종
					</th>
					<td>
						${agenMst.bizIndu}
					</td>
				</tr>
				<tr>
					<th scope="row">
						사업장 전화번호
					</th>
					<td>
						${agenMst.telNo}
					</td>
					<th scope="row">
						휴대폰 번호
					</th>
					<td>
						${agenMst.prstTelNo}
					</td>
				</tr>
				<tr>
					<th scope="row">
						팩스
					</th>
					<td>
						${agenMst.faxNo}
					</td>
					<th scope="row">
						이메일 주소
					</th>
					<td>
						${agenMst.agenEml} 
					</td>
				</tr>
				<tr>
					<th scope="row">
						우편번호
					</th>
					<td colspan="3">
						${agenMst.zipCd} 
					</td>
				</tr>
				<tr>
					<th scope="row">
						주소
					</th>
					<td>
						${agenMst.addr1} 
					</td>
					<th scope="row">
						상세주소
					</th>
					<td>
						${agenMst.addr2} 
					</td>
				</tr>
				<tr>
					<th scope="row">
						담당지점
					</th>
					<td>
						--확인필요--
					</td>
					<th scope="row">
						담당사원
					</th>
					<td>
						--확인필요--
					</td>
				</tr>
				<tr>
					<th scope="row">
						계약종류명
					</th>
					<td>
						--확인필요--
					</td>
					<th scope="row">
						계약잔여일
					</th>
					<td>
						--확인필요--
					</td>
				</tr>
				<tr>
					<th scope="row">
						계약시작일
					</th>
					<td>
						--확인필요--
					</td>
					<th scope="row">
						계약종료일
					</th>
					<td>
						--확인필요--
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 대리점 상세 정보 -->
	
	
	<form id="frm" method="post">
		<!-- 입금 계좌 -->
		<div class="titleArea right">
			<h3 class="tit01">입금 계좌</h3>
		</div>
	
		<div class="tblWrap">
			<table class="tbl">
				<caption>입금계좌 정보</caption>
				<colgroup>
					<col style="width:170px;">
					<col>
					<col style="width:170px;">
					<col>
				</colgroup>
				<tbody>
					<c:set var="cnt" value="0"/>
					<c:forEach var="i" items="${acctInfoList}">
						<c:if test="${cnt < 3}">
						<tr>
							<th scope="row">
								<input type="hidden" id="acctSeq_${cnt}" name="acctInfoList[${cnt}].acctSeq" value="${i.acctSeq}"/>
								<label for="sel_bankNum01" title="필수입력">은행/계좌번호</label>
							</th>
							<td>
								<div class="formWrap">
									<select name="acctInfoList[${cnt}].bankCd" class="sel w160 mr7" id="bankCd_${cnt}">
										<option value="">전체</option>
										<c:forEach var="code" items="${bankList}" varStatus="status">	
											<option value="${code.commCd}"	
												<c:if test="${ code.commCd == i.bankCd }" > selected </c:if>
											>${code.commNm}</option>
										</c:forEach>
									</select>
									<input type="text" id="stmAcctNo_${cnt}" name="acctInfoList[${cnt}].stmAcctNo" class="inp" value="${i.stmAcctNo}">
								</div>
							</td>
							<th scope="row">
								<label for="inp_account_name01">예금주</label>
							</th>
							<td>
								<input type="text" id="acctDpsr_${cnt}" class="inp" value="${i.acctDpsr}" name="acctInfoList[${cnt}].acctDpsr">
							</td>
						</tr>
						<c:set var="cnt" value="${cnt+1}"/>
						</c:if>
					</c:forEach>
					
					<c:if test="${cnt < 2 }">
						<c:forEach var="i" begin="${cnt}" end="2">
							<tr>
								<th scope="row">
									<input type="hidden" id="acctSeq_${cnt}" name="acctInfoList[${cnt}].acctSeq" value=""/>
									<label for="sel_bankNum01" title="필수입력">은행/계좌번호</label>
								</th>
								<td>
									<div class="formWrap">
										<select name="acctInfoList[${cnt}].bankCd" class="sel w160 mr7" id="bankCd_${i}">
											<option value="">전체</option>
											<c:forEach var="code" items="${bankList}" varStatus="status">	
												<option value="${code.commCd}">${code.commNm}</option>
											</c:forEach>
										</select>
										<input type="text" id="stmAcctNo_${i}" name="acctInfoList[${cnt}].stmAcctNo" class="inp" value="" name="stmAcctNo">
									</div>
								</td>
								<th scope="row">
									<label for="inp_account_name01">예금주</label>
								</th>
								<td>
									<input type="text" id="acctDpsr_${i}" class="inp" value="" name="acctInfoList[${cnt}].acctDpsr">
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<!-- 입금 계좌 -->
	
		<!-- CMS / 가상계좌 정보 -->
		<div class="titleArea right">
			<h3 class="tit01">CMS / 가상계좌 정보</h3>
			<p class="txt01"><i class="icoRequir"></i>필수 입력 항목입니다.</p>
		</div>
	
		<div class="tblWrap">
			<table class="tbl">
				<caption>CMS / 가상계좌 정보</caption>
				<colgroup>
					<col style="width:170px;">
					<col>
					<col style="width:170px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">
							<label for="inp_id" class="required" title="필수입력">아이디</label>
						</th>
						<td>
							<input type="text" id="inp_id" class="inp" value="" name="">
						</td>
						<th scope="row">
							<label for="inp_password" class="required" title="필수입력">비밀번호</label>
						</th>
						<td>
							<input type="password" id="inp_password" class="inp" value="" name="">
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="sel_agreement_date" class="required" title="필수입력">이체약정일</label>
						</th>
						<td>
							<span class="dNum">①</span>
							<select name="" class="sel w80 mr20" id="sel_agreement_date">
								<option>전체</option>
								<option>01일</option>
							</select>
	
							<span class="dNum">②</span>
							<select name="" class="sel w80 mr20">
								<option>전체</option>
								<option>01일</option>
							</select>
	
							<span class="dNum">③</span>
							<select name="" class="sel w80 mr20">
								<option>전체</option>
								<option>01일</option>
							</select>
	
							<span class="dNum">④</span>
							<select name="" class="sel w80">
								<option>전체</option>
								<option>01일</option>
							</select>
						</td>
						<th scope="row">
							<label for="inp_password_com" class="required" title="필수입력">비밀번호 재확인</label>
						</th>
						<td>
							<input type="password" id="inp_password_com" class="inp" value="" name="">
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="sel_bankNum04" title="필수입력">은행/계좌번호</label>
						</th>
						<td>
							<div class="formWrap">
								${bankCd}
								<input type="text" id="inp_num03" class="inp" value="" name="">
							</div>
						</td>
						<th scope="row">
							<label for="inp_account_name04" class="required">예금주</label>
						</th>
						<td>
							<input type="text" id="inp_account_name04" class="inp" value="" name="">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- CMS / 가상계좌 정보 -->
		
		
		<div class="tblWrap">
			<table class="tbl">
				<caption>CMS / 가상계좌 정보</caption>
				<colgroup>
					<col style="width:170px;">
					<col>
					<col style="width:170px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">
							작업자
						</th>
						<td>
							김남양
						</td>
						<th scope="row">
							작업일시
						</th>
						<td>
							2021.12.12. 12:12:12
						</td>
					</tr>
					<tr>
						<th colspan="4">미완료 => 상세 정보 조회(SAP에서 연동) / CMS 가상계좌 연동 / 작업자 기준 </th>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
</div>
