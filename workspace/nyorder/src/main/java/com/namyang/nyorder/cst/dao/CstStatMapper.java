package com.namyang.nyorder.cst.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.namyang.nyorder.cst.vo.CstPrdDlvyVO;
import com.namyang.nyorder.cst.vo.CstStatVO;

@Repository
public interface CstStatMapper {
	
	List<CstStatVO> selectCstPeriAreaList(CstStatVO param);
	
	

}
