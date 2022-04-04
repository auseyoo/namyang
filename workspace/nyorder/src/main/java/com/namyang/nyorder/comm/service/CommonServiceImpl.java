package com.namyang.nyorder.comm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.dao.CommonMapper;
import com.namyang.nyorder.comm.vo.CstMstVO;
@Service
public class CommonServiceImpl implements CommonService{
	
	@Autowired
	private CommonMapper commonMapper;
	
	public List<CstMstVO> selectAddr(CstMstVO param){
		return commonMapper.selectAddr(param);
	}

}
