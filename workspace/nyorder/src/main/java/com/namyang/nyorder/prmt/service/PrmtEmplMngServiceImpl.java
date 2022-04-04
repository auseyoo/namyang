package com.namyang.nyorder.prmt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.prmt.dao.PrmtEmplMngMapper;
import com.namyang.nyorder.prmt.vo.PrmtEmplMngVO;
import org.springframework.transaction.annotation.Transactional;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 수당 관리 Service Implement
 * 파일명  : PrmtEmplAllwncMngServiceImpl.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class PrmtEmplMngServiceImpl implements PrmtEmplMngService {
	@Autowired
	private PrmtEmplMngMapper prmtEmplMngMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;

	@Override
	public Map<String, Object> selectPrmtEmplMngList(PrmtEmplMngVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", prmtEmplMngMapper.selectPrmtEmplMngList(param));
		return result;
	}
	
	@Override
	@Transactional
	public String savePrmtEmplHisList(List<PrmtEmplMngVO> list) throws Exception {
		for(PrmtEmplMngVO param : list) {
			param.setAgenSeq( userInfo.getAgenSeq() );
			param.setEmplSeq( userInfo.getEmplSeq() );
			
			if( "U".equals( param.getCrudMode() ) ) {
				prmtEmplMngMapper.updatePrmtEmplHis( param );
			}
		}
		
		return "정상적으로 저장되었습니다.";
	}
}
