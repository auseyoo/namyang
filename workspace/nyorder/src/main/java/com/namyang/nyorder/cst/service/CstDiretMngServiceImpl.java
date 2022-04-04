package com.namyang.nyorder.cst.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.config.error.exception.BusinessException;
import com.namyang.nyorder.cst.dao.CstDiretMngMapper;
import com.namyang.nyorder.cst.vo.CstDiretHisVO;
import com.namyang.nyorder.util.StringUtil;

/**
 * 시스템명 : 애음자 - 이사고객관리
 * 업무명  : 
 * 파일명  : CstDiretMngServiceImpl.java
 * 작성자  : JIHUN
 * 작성일  : 2022. 3. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 23.    JIHUN     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class CstDiretMngServiceImpl implements CstDiretMngService {
	
	@Autowired
	private CstDiretMngMapper cstDiretMngMapper;
	
	@Resource
    UserInfo userInfo;
	
	@Override
	public List<CstDiretHisVO> selectCstDiretHis(CstDiretHisVO param) {
		param.setCurAgenSeq(userInfo.getAgenSeq());
		return cstDiretMngMapper.selectCstDiretHis(param);
	}

	@Override
	public CstDiretHisVO selectCstDiretDtl(CstDiretHisVO param) {
		CstDiretHisVO result = cstDiretMngMapper.selectCstDiretDtl(param);
		result.setCurAgenSeq(userInfo.getAgenSeq());
		result.setCntrList(cstDiretMngMapper.selectCstCntrList(result));
		return result;
	}

	@Override
	public List<CstDiretHisVO> searchAftAgenAreaList(CstDiretHisVO param) {
		param.setCurAgenSeq(userInfo.getAgenSeq());
		return cstDiretMngMapper.searchAftAgenAreaList(param);
	}

	@Override
	public int updateCstDiret(CstDiretHisVO param) throws BusinessException {
		String curAgenSeq = userInfo.getAgenSeq();
		param.setCurAgenSeq(curAgenSeq);
		if(curAgenSeq.equals(param.getBefAgenSeq())) 
		{
			if(StringUtil.isEmpty(param.getDiretCt())) 
			{
				throw new BusinessException("alert.rqbod05");
			}
		} else if(curAgenSeq.equals(param.getAftAgenSeq())) 
		{
			if(StringUtil.isEmpty(param.getAftAreaSeq()) || StringUtil.isEmpty(param.getCntrStus()))
			{
				throw new BusinessException("alert.rqbod05");
			}
		}
		return cstDiretMngMapper.updateCstDiret(param);
	}

}
