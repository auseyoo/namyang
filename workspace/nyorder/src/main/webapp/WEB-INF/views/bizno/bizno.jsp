<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">
	$(document).ready(function() {
		//selectBizno();
		$("#inp_name01").click(function(){
			alert("1111");
			selectBizno();
		})
	});
	function selectBizno() {
		var bizNo = $("#inp_bizno01").val() + $("#inp_bizno02").val() + $("#inp_bizno03").val();
		//$("#bizNo").val(bizNo);
		var item = { "bizNo" : bizNo , "agenCd" : $("#agenCd").val() };
		console.log(item)
		
		 $.ajax({
			url : "/comm/selectBizno.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
		    data : JSON.stringify(item),
		    dataType : "json",
			success : function(data) {
				console.log(data);
				console.log(JSON.stringify(data));
				$("#agenSeq").html(data.agenSeq);
				$("#saleCd").html(data.saleCd);
			}, 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});  
	}
</script>
<div class="content">
	<form id="frm">
		<div class="exTypeWrap">
			<!-- 사업자번호 input -->
			<div class="inquiryBox type02">
				<dl>
					<dt>MDB upload</dt>
	
					<dt>사업자번호</dt>
					<dd>
						<div class="formWrap">
							<input type="tel" maxlength="3" id="inp_bizno01" class="inp w120 mr10 "  value="" name="bizno" placeholder="394">- 
							<input type="tel" maxlength="2" id="inp_bizno02" class="inp w160" value="" name="bizno" placeholder="22">- 
							<input type="tel" maxlength="5" id="inp_bizno03" class="inp w160" value="" name="bizno" placeholder="00101">
						</div>
					</dd>
				</dl>
			<!-- !사업자번호 input -->
			
			<!-- 거래처코드 input -->
					<dl>
						<dt></dt>
						<dt>거래처코드</dt>
						<dd>
							<input type="hidden" name="bizNo" id="bizNo" value="${bizNo }"/>
							<input type="tel" id="agenCd" class="inp" value="${agenCd }" name="agenCd" placeholder="1200302">
						</dd>
						<dd>
							<button type="button" class="comBtn" id="inp_name01">조회</button>
						</dd>
					</dl>
				</div>
				
			</div>
			<!-- !거래처코드 input -->
		</form>
	<div class="test">
		<div class="sample">
			<div class="titleArea">
				<h3 class="tit01">AGEN_SEQ </h3>
				<p id="agenSeq"></p>
				<h3 class="tit01">SALE_CD</h3>
				<p id="saleCd"></p>	
			</div>
		</div>
	</div>	
</div>

