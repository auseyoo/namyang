<!-- 
	@File Name: addRqbodPop.jsp
	@File 설명 : 요청게시판
	@UI ID : 	UI-PCOM-0301P1
	@작성일 : 2022. 3. 15.
	@작성자 : YESOL
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

	$(document).ready(function(){
		$("#closeBtn").click(function(){
			$.closeDialog("<c:out value='${param.id}'/>");
		});

		//저장 버튼 클릭
		$("#saveBtn").click(function(){
			if($("#nttSub").val() == '' || $("#nttCntt").val() == ''){
				var popupParam = [];
				popupParam.data = {
					title : "요청 게시판",
					message : "<spring:message code='alert.rqbod05'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			}
			saveNotibod();		
		});
		
		//글자수 count - 내용
		$("#nttCntt").keyup(function(e) {
			var nttCntt = $(this).val();
			$("#nttCnttCnt").html("(" + nttCntt.length + "/ 400)"); //실시간 글자수 카운팅
			if (nttCntt.length > 400) {
				var popupParam = [];
				popupParam.data = {
					title : "요청 게시판",
					message : "<spring:message code='alert.rqbod06'	arguments='400'/>",
					showBtn2 : 'N'
				}
				layerAlert(popupParam);
				$(this).val(nttCntt.substring(0, 400));
				$('#nttCnttCnt').html("(400 / 최대 400자)");
			} 
		});
		$("#nttCntt").keyup();

		//글자수 count - 제목
		$("#nttSub").keyup(function(e) {
			var nttSub = $(this).val();
			$("#nttSubCnt").html("(" + nttSub.length + "/ 50)"); //실시간 글자수 카운팅
			if (nttSub.length > 50) {
				var popupParam = [];
				popupParam.data = {
						title : "요청 게시판",
						message : "<spring:message code='alert.rqbod06'	arguments='50'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				$(this).val(nttSub.substring(0, 50));
				$("#nttSubCnt").html("(50 / 최대 50자)");
			}
		});
		$("#nttSub").keyup();

		// 파일 업로드 삭제 버튼
		$("button[name='rmvFileBtn']").click(function(){
			popupParam.data = {
				message : "<spring:message code='alert.rqbod01'/>",
				btn1Func : function(){
					$('[data-popup="modalAlert"]').fadeOut(100);
					$('[data-popup="modalAlert"]').parent().find(".modal_bg").fadeOut(100);
					rmvAtclDtl();
				},
				showBtn2 : 'Y'
			}
			layerAlert(popupParam);
		});

		//파일업로드 형식 제한
		$('input[type="file"]').change(function (e) {
			var popupParam = [];
			if (this.files[0].size > 10485760) {
				popupParam.data = {
						title : "자료실",
						message : "<spring:message code='alert.rqbod04'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				this.value = "";
				return;
			}			 
			var ext = this.value.match(/\.(.+)$/)[1];
			switch (ext) {
				case 'hwp' :
				case 'doc' :
				case 'docx' :
				case 'ppt' :
				case 'pptx' :
				case 'xls' :
				case 'xlsx' :
				case 'txt' :
				case 'jpg' :
				case 'jpeg' :
				case 'png' :
				case 'gif' :
				case 'bmp' :
				case 'jpeg' :
				case 'png' :
				case 'zip' :
					break;
				default:
					popupParam.data = {
						title : "자료실",
						message : "<spring:message code='alert.rqbod03'/>",
						showBtn2 : 'N'
					}
					layerAlert(popupParam);
					this.value = '';
					return;
			}
			$("#fileNm").val(this.files[0].name);
		});

		if(CommUtil.isNotEmpty("${param.nttSeq}")){
			var param = {};
			param.nttSeq = "${param.nttSeq}";
			$.ajax({
				url : "/cmmc/selectRqst.do",
	 			type : 'POST',
	 			contentType : "application/json; charset=utf-8",
	 			data : JSON.stringify(param),
				success : function(data) {
					$("#nttSub").val(data.nttSub);
					$("#nttSub").keyup();
					$("#nttCntt").val(data.nttCntt);
					$("#nttCntt").keyup();
					$("#nttAtclSeq").val(data.nttAtclSeq);
					$("input[name='resSecCd']:radio[value='"+data.resSecCd+"']").prop("checked",true);
					//​$("input[name='resSecCd']:radio[value='"+data.resSecCd+"']").prop("checked",true); 

					searchAtclList(data.nttAtclSeq);
				}, // success 
				error : function(xhr, status) {
					alert("요청게시판 상세 조회 중 오류가 발생하였습니다");
				}
			});
		}
		
	});

	function searchAtclList(nttAtclSeq){
		var param = {};
		param.nttAtclSeq = nttAtclSeq;
		$.ajax({
 			url : "/file/selectAtclList.do",
 			type : 'POST',
 			contentType : "application/json; charset=utf-8",
 			data : JSON.stringify(param),
 			success : function(data) {
				$("#fileNm").val(data[0].fileOriNm);
				$("#nttAtclDtlSeq").val(data[0].nttAtclDtlSeq);
				
 			}, // success 
 			error : function(xhr, status) {
 				alert('수정하는 도중 오류가 발생하였습니다');
 			}
 		});
	}
	function rmvAtclDtl(){
		var agent = navigator.userAgent.toLowerCase();
		if ( (navigator.appName == 'Netscape' && agent.indexOf('trident') != -1) || (agent.indexOf("msie") != -1)) { 
			$("#file").replaceWith( $("#file").clone(true) );
		}else{
			$("#file").val("");
		}
		
		var param = {};
		param.nttAtclDtlSeq = $("#nttAtclDtlSeq").val();
		$.ajax({
			url : "/file/rmvAtclDtl.do",
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(param),
			success : function(data) {
				$("#fileNm").val("");
				$("#nttAtclDtlSeq").val("");
			},  
			error : function(xhr, status) {
				alert('수정하는 도중 오류가 발생하였습니다');
			}
		});
	}
	//등록 - 새로운 공지사항 글 저장
	function saveNotibod(){
		var formData = new FormData($("#addfrm")[0]);
		$.ajax({
			url : "/cmmc/saveRqbod.do",
			type : 'POST',
			data : formData,
			processData:false, 
			contentType:false,
			enctype : 'multipart/form-data',
			success : function(data) {
				if (CommUtil.isNotEmpty(data.res) && data.res && data.updateCnt > 0){
					var popupParam = [];
					popupParam.data = {
						title : "요청 게시판",
						message : "<spring:message code='alert.save'/>",
						showBtn2 : 'N'
					}
					layerAlert(popupParam);
					searchList();
					$.closeDialog("<c:out value='${param.id}'/>");
				}else{
					alert("저장 실패 하였습니다.\n다시 시도해 주세요.");
				}
			}, // success 
			error : function(xhr, status, errorThrown) {
				if ( Common.IsJsonString(xhr.responseText) )
				{
					var message = JSON.parse(xhr.responseText).message;
					alert(message);
				}
				else{
					alert("처리중 오류가 발생 하였습니다.");
				}
			}
		});
	}
</script>
<div class="popWrap small modal_wrap" data-popup="modalAgencyViews" id="addRqbodPop">
	<header>
		<h3>요청 등록</h3>
	</header>
	<form id="addfrm" name="addfrm" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="nttSeq" id="nttSeq" value="<c:out value='${param.nttSeq}'/>" />
	<input type="hidden" name="nttAtclSeq"	id="nttAtclSeq"/>
	<input type="hidden" id="nttAtclDtlSeq"/>
	<div class="popCon">
		<div class="popTitArea">
			<h3>요청 등록</h3>
			<div class="popBtnArea">
				<button type="button" id="saveBtn" 	name="" class="inquBtn" id="saveBtn">저장</button>
				<button type="button" id="closeBtn" name="" class="comBtn modalCloseBtn">닫기</button>
			</div>
		</div>

		<div class="receptCate">
			<div class="formWrap type02">
				<p class="tit required">수신구분</p>
				<div class="checkGroup">
					<input type="radio" name="resSecCd" id="resSecCd1" class="type01" value="1" checked><label for="resSecCd1"><span>본사</span></label> 
					<input type="radio" name="resSecCd" id="resSecCd2" class="type01" value="2"><label for="resSecCd2"><span>지점</span></label>
				</div>
			</div>
		</div>
		
		<div class="titleArea">
			<h3 class="tit01 required">제목 <span class="pColor03" id="nttSubCnt"></span></h3>
		</div>
		<div>
			<input name="nttSub" id="nttSub" class="inp w100per mb10" placeholder="제목을 작성해 주세요." maxlength="50">
		</div>
		<div class="titleArea">
			<h3 class="tit01 required">내용 <span class="pColor03" id="nttCnttCnt"></span></h3>
		</div>

		<div class="fileInfo">
			<textarea name="nttCntt" id="nttCntt" class="h270" placeholder="내용을 작성해주세요"></textarea>

			<div class="formWrap type02 file">
				<p class="tit">파일 :</p>
				<p>
					<div class="formWrap filebox">
						<input type="text" id="fileNm" class="upload" placeholder="첨부파일" readonly="readonly">
						<label for="file">찾기</label>
						<input type="file" id="file" name="file">
						<button type="button" id="rmvFileBtn" name="rmvFileBtn" class="delBtn">삭제</button>
					</div>
				</p>
			</div>
		</div>
		<p class="txt02">
			hwp, doc, docx, ppt, pptx, xls, xlsx, txt, jpg, jpeg, gif, png, bmp, pdf, zip 확장자의 10MB 이하<br/> 파일만 업로드 할 수 있습니다.
		</p>

	</div>
	</form>
</div>
<!-- 요청 등록 -->

