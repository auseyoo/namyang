package com.namyang.nyorder.cmmc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.cmmc.dao.RcbodMapper;
import com.namyang.nyorder.cmmc.vo.RcbodVO;

import lombok.extern.slf4j.Slf4j;




@Slf4j
@Service
public class RcbodServiceImpl implements RcbodService{

	@Autowired
	private RcbodMapper rcbodMapper;
	

	/* 자료실 게시판 리스트 조회 */
	public List<RcbodVO> selectRcbodList(RcbodVO param) {
		return rcbodMapper.selectRcbodList(param);
	};

	/* 자료실 게시판 해당 게시판 글 조회 */
	public List<RcbodVO> selectRcbodDtlList(RcbodVO param) {
		return rcbodMapper.selectRcbodDtlList(param);
	}

	

	

	

	
	
}
