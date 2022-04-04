package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.agn.dao.InvryMstMapper;
import com.namyang.nyorder.agn.vo.InvryMstVO;
import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 재고 관리 Service Implement
 * 파일명  : InvryMstServiceImpl.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 1. 04.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 14.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class InvryMstServiceImpl implements InvryMstService{
	@Autowired
	private InvryMstMapper invryMstMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;

	@Override
	public Map<String, Object> selectPuchList(InvryMstVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", invryMstMapper.selectPuchList(param));
		return result;
	}

	@Override
	public Map<String, Object> selectInvryMstList(InvryMstVO param) {
		int iCnt = invryMstMapper.selectInvryMstList(param).size();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", invryMstMapper.selectInvryMstList(param));
		result.put("cnt", iCnt);
		return result;
	}

	/**
	 *	재고 관리 저장
	 */	
	@Override
	@Transactional
	public String saveInvryMst(List<InvryMstVO> list) {
		for(InvryMstVO param : list) {
			param.setEmplSeq( userInfo.getEmplSeq());
			invryMstMapper.updInvryMst(param);
			invryMstMapper.insInvryMstLog(param);
			
			invryMstMapper.updStdPrdInvryAfterUpd(param);
		}		
		return "정상적으로 저장되었습니다.";
	}
}
