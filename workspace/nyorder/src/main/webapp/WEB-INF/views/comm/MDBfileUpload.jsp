<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
$(document).ready(function() {
	/* 사업자번호 입력 확인 클릭 - 대리점코드리스트 조회 */
	$("#searchBizno").click(function(){
		//조회
		fnSelBizNo();
	});
	//대기열에 올려놓은 파일 삭제 버튼 클릭
	$("#delBtn").click(function(){
	  document.getElementById("fileform").reset();
		});
	//file이름 input에 나오게
	$("#mdbFile").change(function(){
		var mdbFileName = $("#mdbFile").val();
		var fileName = mdbFileName.substr(mdbFileName.lastIndexOf("\\") + 1);
		$("#fake").val(fileName).append();
		});
	//file upload form
	$("#fileform").submit(function(event) {
		event.preventDefault();
		const mdbFiles = $("#mdbFile")[0].files;
		// 파일을 여러개 선택할 수 있으므로 files 라는 객체에 담긴다.
		console.log("mdbFiles: ", mdbFiles.files)

		if(mdbFiles.length === 0){
			alert("파일은 선택해주세요");
		    return false;
		}
		for(let i=0; mdbFiles.length > i; i++){
			let item = mdbFiles[i];
			
			let fileName = item.name;
			
			console.log("fileName.  : " +  fileName);
			
			console.log("fileName.substr(fileName.lastIndexOf() : " +  fileName.substr(fileName.lastIndexOf(".") + 1));
			if(fileName.substr(fileName.lastIndexOf(".") + 1) != "MDB"){
				alert("MDB파일만 선택해주세요");
				return false;
			}
		}
		this.submit();
	});
});
	function fnFileSubmit(_saleCd, _agenCd){
		$("#fAgenCd").val(_agenCd);
	}
//대리점코드 리스트 조회
function fnSelBizNo(){

	  $.ajax({
		url : "/comm/selectBiznoList.do",
		type : 'POST',
	    data : $("#frm1").serialize(),
		success : function(data) {
			console.log(data.list);
			var inp_agenCd = document.querySelector("#inp_agenCd");
			for(i = 0; i < data.list.length; i++){
				$(inp_agenCd).append($("<option></option>").attr("value",data.list[i].agenNm).text(data.list[i].agenCd));
				};
			//대리점코드 selectOption 클릭
			$("#inp_agenCd").on('change', function(){
				$("#inp_name").val(this.value).append();
				//selectOption 클릭 후 BA/SI 조회
				selectAgen();
				});
		}, 
		error : function(xhr, status) {
			alert("사업자 번호 조회 불가.")
		}
	});  
}
//대리점 명 조회
function selectAgen() {
	var bizNo 	= $("#bizNo").val();
	var agenCd = $("#inp_agenCd option:selected").text();
	var item 	= { "bizNo" : bizNo , "agenCd" : agenCd };
	console.log("item", item);
	 $.ajax({
		url : "/comm/selectBizno.do",
		type : 'POST',
		contentType : "application/json; charset=utf-8",
	    data : JSON.stringify(item),
	    dataType : "json",
		success : function(data) {
			console.log(data);
			if( data.saleCd == "SI" ){
				$("#uploadDiv").show();
				$("#BAtxt").hide();
				$("#SItxt").show();
				fnFileSubmit(data.saleCd, data.agenCd);
			}
			else if(data.saleCd == "BA"){
				$("#uploadDiv").show();
				fnFileSubmit(data.saleCd, data.agenCd);
			}
		}, 
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	}); 
}
			
</script>
<div class="logWrap pwWrap mdbWrap">

		<div class="contentWrap">
            <!-- content -->
            <div class="login_wrap">
                <div class="content">
                <tiles:insertAttribute name="body.breadcrumb"/> 
                    <div class="login_box" style="margin: auto;"> 
                        <!-- 1 -->
                        <div class="content01">
                            <div class="titleArea right">
                                <h2 class="login_mainTit">MDB 파일 업로드</h2>
                                <ul class="lnb">
                                    <li class="active" rel="tab01">1</li>
                                    <li class="" rel="tab02">2</li>
                                </ul>
                            </div>
                        
                            <div class="txt_wrap active">
                                <span class=" num">1</span>
                                <div class="txt">
                                '사업자등록번호'를 입력 후 "확인" 버튼을 클릭하면 "대리점코드"를 선택할 수 있습니다.
                                </div>                                
                            </div>
                      	  <form id="frm1">
                            <div class="formGroup">
                                <div class="formWrap jStart">
                                    <label for="inp_num">사업자등록번호</label>
                                    <input type="text" name="bizNo" value="" id="bizNo" class="inp type02 w180" placeholder="-없이 숫자만 입력">
                                    <button type="button" name="" class="inquBtn" id="searchBizno">확인</button>
                                </div>
                          </form>
                                <div class="formWrap jStart">
                                    <label for="inp_agenCd">대리점코드(agen cd)</label>
                                    <div class="selectbox">
                                        <select id="inp_agenCd" name="" class="sel large w270">
                                        <option value="">선택</option>
                                        </select>
                                    </div>
                                    
                                </div>

                                <div class="formWrap jStart">
                                    <label for="inp_name">대리점명</label>
                                    <input type="text" id="inp_name" class="inp readonly" value="" name="" readonly>
                                </div>
                            </div>
                        </div>
                        <!--// 1 -->

                        <!-- 2 -->
                        <div class="content02" id="uploadDiv" style="display:none;">
                            <div class="txt_wrap mt50">
                                <span class=" num">2</span>
                                <div class="txt" id="BAtxt">
                                “C:\Pams21\db”의 경로에서 “Pams21_01.MDB” 파일을 찾아 업로드해 주세요.<br>
                                별도의 드라이브나 폴더에 프로그램이 설치되어 있을 경우에는 해당 위치에서 “Pams21_01.MDB” 파일을 찾아 업로드해 주세요.
                                </div>
                                <div class="txt" id="SItxt"style="display:none">
                                “C:\Pams21\db\”의 경로에서 “Pams21_01.MDB” 파일을 찾아 업로드해 주세요.<br>
  								 별도의 드라이브나 폴더에 프로그램이 설치되어 있을 경우에는 해당 위치에서 “Pams21_01.MDB” 파일을 찾아 업로드해 주세요.

                                </div>
                            </div>

                         <div id="fileDiv" class="formWrap jStart right">
                           <form name="fileform" id="fileform" action="/comm/fileUploadProcess.do" class="form-signin" method="post"  enctype="multipart/form-data">
                                <label for="mdbFile">MDB 파일</label>
                                <div class="formWrap filebox">
                                	<input id="fake" class="upload">
	                                <input type="file" name="mdbFile" id="mdbFile" class="upload" value="">
	                                <label for="mdbFile" class="comBtn">찾기</label> 
	                                <input type="hidden" id="fAgenCd" name="fAgenCd">
	                                    
                                    <button type="submit" name="" class="inquBtn" id="submitBtn">저장</button>
                                    <button type="button" name="" class="delBtn" id="delBtn">삭제</button>
                                </div>
                       	  </form> 
                        </div>
                      </div>
                        <!--// 2 -->  
                    </div>
                </div>
            <!-- content -->
		</div>
	</div>
    