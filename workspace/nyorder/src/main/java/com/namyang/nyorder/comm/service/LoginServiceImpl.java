package com.namyang.nyorder.comm.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.dao.AccountMapper;
import com.namyang.nyorder.comm.dao.LoginMapper;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.CommVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.config.YamlPropertySourceFactory;

@Service
@PropertySource(value = "classpath:config/database.yml", factory = YamlPropertySourceFactory.class, ignoreResourceNotFound = true)
public class LoginServiceImpl  implements LoginService{
	
	@Autowired
    private AccountMapper accountMapper;
	
	@Autowired
    private LoginMapper loginMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	@Autowired
    private PasswordEncoder passwordEncoder;
	
	@Value(value = "${salt.string}")
	private String saltString;
	
	public AccountVO selectLoginList(AccountVO searchVO) throws Exception{	
		
		return accountMapper.selectAccount(searchVO);
	}
	
	public List<AccountVO> selectAgenList(AccountVO searchVO) throws Exception{
		
		return loginMapper.selectAgenList(searchVO);
	}
	
	public int savePassword(AccountVO loginVO) throws Exception{
		
		int cnt = 0;
		String newPass = "";
		
		//TransPassword transPassword = new TransPassword();
		//newPass = transPassword.encrypt(loginVO.getPassword(), saltString);
		
		newPass = passwordEncoder.encode(loginVO.getPassword());
		
		loginVO.setHexPassword(newPass);
		
		cnt = loginMapper.updatePassword(loginVO);
		
		cnt = cnt + loginMapper.insertPassword(loginVO);
		
		return cnt;
	}
	
	public void setSessionInfo(AccountVO account) {
		
		userInfo.setAgenCd(account.getAgenCd());
		userInfo.setAgenSeq(account.getAgenSeq());
		userInfo.setEmplCd(account.getEmplCd());
		userInfo.setEmplSeq(account.getEmplSeq());
		
		userInfo.setSaleCd(account.getSaleCd());		
		
		//commVO.setAgenSeq(account.getAgenSeq());		
		//commVO.setEmplSeq(account.getEmplSeq());
		
	}

	@Override
	public int insertLoginHis(AccountVO account) throws Exception {
		return loginMapper.insertLoginHis(account);
	}
}
