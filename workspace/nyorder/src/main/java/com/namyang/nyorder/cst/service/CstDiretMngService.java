package com.namyang.nyorder.cst.service;

import java.util.List;

import com.namyang.nyorder.config.error.exception.BusinessException;
import com.namyang.nyorder.cst.vo.CstDiretHisVO;

public interface CstDiretMngService {
	
	List<CstDiretHisVO> selectCstDiretHis(CstDiretHisVO param);

	CstDiretHisVO selectCstDiretDtl(CstDiretHisVO param);

	List<CstDiretHisVO> searchAftAgenAreaList(CstDiretHisVO param);

	int updateCstDiret(CstDiretHisVO param) throws BusinessException;
}
