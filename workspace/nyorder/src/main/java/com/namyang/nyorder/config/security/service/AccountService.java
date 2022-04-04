package com.namyang.nyorder.config.security.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.dao.AccountMapper;
import com.namyang.nyorder.comm.vo.AccountVO;

@Service
public class AccountService implements CustomUserDetailsService{
	
	@Autowired
	AccountMapper accountMapper;
	
	private Logger logger = LoggerFactory.getLogger(AccountService.class);

	//@Override
	public UserDetails loadUserByUsername(String bizNo, String emplCd) throws UsernameNotFoundException {
		
		logger.info("## loadUserByUsername ## bizNo ::" + bizNo);
		AccountVO accountVO = new AccountVO();
		AccountVO resultVO = new AccountVO();
		
		accountVO.setBizNo(bizNo);
		accountVO.setEmplCd(emplCd);
		try {
			resultVO = accountMapper.selectAccount(accountVO);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if( resultVO == null ) {
			logger.debug("## ");
			throw new UsernameNotFoundException(bizNo + emplCd);
		}
		
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();			
		authorities.add(new SimpleGrantedAuthority(resultVO.getRolecode()));
		
		System.out.println("**************Found user***************");
		System.out.println("id : " + resultVO.getUsername());
		
		if(resultVO.isEnabled()) {
			
			System.out.println("**************###############***************");
		}
		
		resultVO.setAccountNonExpired(true);
		resultVO.setAccountNonLocked(true);
		resultVO.setCredentialsNonExpired(true);
		
		System.out.println("enabled : " + resultVO.isEnabled());
		
		return resultVO;
	}

	@Override
	public UserDetails loadUserByUsername(String loginInfo) throws UsernameNotFoundException {
		logger.info("## loadUserByUsername ## username ::" + loginInfo);		
		AccountVO resultVO = new AccountVO();
		AccountVO accountVO = new AccountVO();
		
		String[] loginArr = loginInfo.split(",");
		
		if(loginArr.length != 2) {
			logger.info("로그인정보 오류 ");
			throw new UsernameNotFoundException(loginInfo);			
		}
		
		accountVO.setBizNo(loginArr[0]);
		accountVO.setEmplCd(loginArr[1]);
		
		try {
			resultVO = accountMapper.selectAccount(accountVO);
			
			List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
			authorities.add(new SimpleGrantedAuthority(resultVO.getRolecode()));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if( resultVO == null ) {
			logger.debug("## ");
			throw new UsernameNotFoundException(loginInfo);
		}
		
		System.out.println("**************Found user***************");
		System.out.println("id : " + resultVO.getUsername());
		
		if(resultVO.isEnabled()) {
			
			System.out.println("**************###############***************");
		}
		
		resultVO.setAccountNonExpired(true);
		resultVO.setAccountNonLocked(true);
		resultVO.setCredentialsNonExpired(true);
		
		System.out.println("enabled : " + resultVO.isEnabled());
		
		return resultVO;
	}

}
