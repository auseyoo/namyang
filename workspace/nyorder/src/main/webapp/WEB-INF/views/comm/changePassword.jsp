<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<script>

// 비밀번호 변경 클릭 이벤트
function btnDisabled()  {
    var pwBtnId = $('.cerNum_wrap');
    const target = document.getElementById('btn_pwEdit');
    target.disabled = true;
    $(pwBtnId).removeClass('disabled');
    $(pwBtnId).removeAttr('style');
}
    
function inputValidation(){
	
	var passwordRule = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,20}$/;
	if(!passwordRule.test($('#password').val().trim())){
		console.log("비밀번호 실패");
		return false;
	}
	
	if($('#password').val() != $('#password2').val()){
		console.log("비밀번호 확인 실패 :: " + $('#password').val() + ", :: " + $('#password2').val());
		return false;
	}
	console.log("비밀번호 성공");	
	return true;
	
}    

function changePasswordBtn(){
	if(inputValidation()){
		btnDisabled();
		
	}	
}
    
    
</script>
</head>

<body>
	<div class="logWrap pwWrap">
		<header>
            <h1><a href="#" class="logo" title="남양유업"></a></h1>         
		</header>

		<div class="contentWrap">
            <!-- content -->
            <div class="login_wrap">
                <div class="content">
                    <div class="login_box">
                        <h2 class="login_mainTit">비밀번호 변경</h2>
                        <span class="login_susTxt">Change password</span>       
                        <form name="passform" id="passform" action="/savePassword.do" class="form-signin" method="post">
                        
                        	<input type="hidden" id="emplCd" class="inp" name="emplCd" value="<c:out value='${userInfo.emplCd}'/>">
                        	<input type="hidden" id="bizNo" class="inp" name="bizNo" value="<c:out value='${userInfo.bizNo}'/>" >
                        	<input type="hidden" id="agenSeq" class="inp" name="agenSeq" value="<c:out value='${userInfo.agenSeq}'/>">
                        	<input type="hidden" id="emplSeq" class="inp" name="emplSeq" value="<c:out value='${userInfo.emplSeq}'/>" >
                                        
	                        <div class="formWrap jEnd">
	                            
	                            <label for="inp_pw01" class="required badge" title="새 비밀번호">새 비밀번호</label>
	                            <input type="password" id="password" class="inp" name="password" minlength="4" maxlength="12">
	                           
	                            <p class="inpText">영문+숫자+특수문자 조합으로 8자리 이상</p>
	                        </div>
	                        
	                        <div class="formWrap jEnd">
	                            
	                            <label for="inp_pw02" class="required badge" title="비밀번호 확인">비밀번호 확인</label>
	                            <input type="password" id="password2" class="inp" name="password2" minlength="6" maxlength="12">
	                            
	                            <p class="inpText">비밀번호를 재입력해주세요.</p>
	                        </div>
	                        <div class="formWrap jCenter">
	                             <button type="button" name="" class="inquBtn large" id="btn_pwEdit" onclick="changePasswordBtn();" >비밀번호 변경</button>
	                        </div>
                        
                        
	                        <!-- 인증번호 -->
	                        <div class="cerNum_wrap" style="display: none;">
	                            <p>본인 인증을 위해 계정에 <span class="fb">등록된 휴대폰 번호</span>로 <span class="fb">인증번호를 전송</span>했습니다.</p>
	                            <p class="last">휴대폰으로 전송된 인증번호를 입력해주세요.</p>
	                            <div class="formWrap jCenter">
	                                <button type="button" name="" class="inquBtn large w170" id="btn_pw">인증번호 재전송</button>
	                            </div>
	                            <div class="formWrap jEnd">
	                                
                                    <label for="inp_num01" class="required badge" title="인증번호">인증번호</label>
                                    <input type="password" id="inp_num01" class="inp w180" name="pw" minlength="9" maxlength="9">
                                    <button type="submit" name="" class="inquBtn" data-modal="modal" >확인</button> 
	                            
	                                <p class="inpText">3:00</p>
	                            </div>    
	                        </div>
	                        <!--// 인증번호 -->
                        
                        </form>
                                     
                    </div>
                       
                </div>
                
                 <footer>
                    COPYRIGHT-NAMYANG-DAIRY-PRODUCTS-COLTD-ALL-RIGHT-RESERVED
                </footer>
            </div>
            <!-- content -->
		</div>
	</div>
</body>
</html>