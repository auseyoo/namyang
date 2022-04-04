package com.namyang.nyorder.comm.service;

import java.util.List;

import com.namyang.nyorder.comm.vo.AccountVO;

public interface LoginService {

	AccountVO selectLoginList(AccountVO searchVO) throws Exception;
	
	List<AccountVO> selectAgenList(AccountVO searchVO) throws Exception;	
	
	int savePassword(AccountVO searchVO) throws Exception;
	
	void setSessionInfo(AccountVO account);
	
	int insertLoginHis(AccountVO account) throws Exception;
	
}
