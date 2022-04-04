package com.namyang.nyorder.comm.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.cmmc.vo.NttVO;

public interface MainService {

	public List<NttVO> selectMainNotice();
	
	public Map<String, Object> selectMainCredit();
	
	public Map<String, Object> selectMainDly();
	
}
