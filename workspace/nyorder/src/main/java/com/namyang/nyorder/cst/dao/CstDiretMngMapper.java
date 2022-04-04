package com.namyang.nyorder.cst.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.namyang.nyorder.cst.vo.CstCntrVO;
import com.namyang.nyorder.cst.vo.CstDiretHisVO;

@Mapper
public interface CstDiretMngMapper {
	
	List<CstDiretHisVO> selectCstDiretHis(CstDiretHisVO param);

	CstDiretHisVO selectCstDiretDtl(CstDiretHisVO param);

	List<CstCntrVO> selectCstCntrList(CstDiretHisVO param);
	
	List<CstDiretHisVO> searchAftAgenAreaList(CstDiretHisVO param);

	int updateCstDiret(CstDiretHisVO param);
}
