package com.namyang.nyorder.myp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.myp.dao.MyInfoSearchMapper;
import com.namyang.nyorder.myp.vo.AgenAcctInfoVO;
import com.namyang.nyorder.myp.vo.AgenMstVO;
import com.namyang.nyorder.myp.vo.MyInfoSearchVO;
import com.namyang.nyorder.util.StringUtil;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 내 정보 조회 Service Implement
 * 파일명  : MyInfoSearchServiceImpl.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 3.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 3.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class MyInfoSearchServiceImpl implements MyInfoSearchService {

	@Autowired
	private MyInfoSearchMapper myInfoSearchMapper;
	
	/**
	 * @Method Name : selectAgenMst
	 * @작성일 : 2022. 1. 4.
	 * @작성자 : YESOL
	 * @Method 설명 : 대리점 정보 조회 (임시: 차후 SAP에서 조회)  
	 * @param vo
	 * @return MyInfoSearchVO
	 */
	public AgenMstVO selectAgenMst(MyInfoSearchVO param) {
		return myInfoSearchMapper.selectAgenMst(param);
	}
	
	/**
	 * @Method Name : selectAgenAcctInfo
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 입금 계좌 리스트 조회
	 * @param vo
	 * @return MyInfoSearchVO
	 */
	public List<AgenAcctInfoVO> selectMyInfoSearch(MyInfoSearchVO param){
		return myInfoSearchMapper.selectAgenAcctInfo(param);
	}
	
	/**
	 * @Method Name : saveAgenAcctInfo
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 내 정보 저장
	 * @param vo
	 * @return int
	 */
	@Transactional
	public int saveAgenAcctInfo(MyInfoSearchVO vo) throws Exception{
		int result = 0;
		for(AgenAcctInfoVO one : vo.getAcctInfoList()) {
			one.setAgenSeq("0");
			one.setEmplSeq("0");
			if(StringUtil.isEmpty(one.getAcctSeq())) {
				result += myInfoSearchMapper.insertAgenAcctInfo(one);
			}else {
				result += myInfoSearchMapper.updateAgenAcctInfo(one);
			}
		}
		return result;
	}

	
	
}
