package com.namyang.nyorder.comm.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.dao.BiznoMapper;
import com.namyang.nyorder.comm.vo.BiznoVO;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : MDB upload sample page
 * 파일명  : BiznoService.java
 * 작성자  : GAIN
 * 작성일  : 2022. 1. 24.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 24.    GAIN     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class BiznoServiceImpl implements BiznoService{

	@Autowired
	BiznoMapper biznoMapper;

	@Override
	public BiznoVO selectBizno(BiznoVO param) {
		return biznoMapper.selectBizno(param);
	}
	/**
	 * @Method Name : selectBiznoList
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 사업자번호 - 대리점코드 조회
	 * @param vO
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> selectBiznoList(BiznoVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", biznoMapper.selectBiznoList(param));
		return result;
	};



}
