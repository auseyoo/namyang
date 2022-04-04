package com.namyang.nyorder.cst.service;

import java.util.List;

import com.namyang.nyorder.cst.vo.CstStatVO;

public interface CstStatService {
	
	List<CstStatVO> selectCstPeriAreaList(CstStatVO param);

}
