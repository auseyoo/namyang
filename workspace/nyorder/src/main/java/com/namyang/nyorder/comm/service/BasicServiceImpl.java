package com.namyang.nyorder.comm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.dao.BasicDao;
import com.namyang.nyorder.comm.dao.CommonMapper;
import com.namyang.nyorder.comm.vo.BasicVO;
import com.namyang.nyorder.comm.vo.CstMstVO;

@Service
public class BasicServiceImpl implements BasicService{
	
	@Autowired
	private BasicDao basicDao;
	
	public <E> List<E> basicSelectList(BasicVO param) throws Exception{
		return basicDao.basicSelectList(param);
	}
	
	public <T> Object basicSelectOne(BasicVO param) throws Exception{		
		return basicDao.basicSelectOne(param);
	}
	
	public int basicInsert(BasicVO param) throws Exception{		
		return basicDao.basicInsert(param);
	}
	
	public int basicUpdate(BasicVO param) throws Exception{		
		return basicDao.basicUpdate(param);
	}


}
