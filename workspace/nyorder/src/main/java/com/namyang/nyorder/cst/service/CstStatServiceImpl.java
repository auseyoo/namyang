package com.namyang.nyorder.cst.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.cst.dao.CstStatMapper;
import com.namyang.nyorder.cst.vo.CstStatVO;

@Service
public class CstStatServiceImpl implements CstStatService {
	
	@Autowired
	CstStatMapper cstStatMapper;
	
	public List<CstStatVO> selectCstPeriAreaList(CstStatVO param){
		
		return cstStatMapper.selectCstPeriAreaList(param);
	}
}
