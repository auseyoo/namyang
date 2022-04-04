package com.namyang.nyorder.cmmc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.cmmc.dao.NotibodMapper;
import com.namyang.nyorder.cmmc.vo.NttVO;

import lombok.extern.slf4j.Slf4j;



/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 커뮤니케이션관리 - 공지사항
 * 파일명  : Notice_boardServiceImpl.java
 * 작성자  : GAIN
 * 작성일  : 2022. 2. 10.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 10.    GAIN     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Service
public class NotibodServiceImpl implements NotibodService{

	@Autowired
	private NotibodMapper notibodMapper;
	

	/* 공지사항 게시판 리스트 조회 */
	public List<NttVO> selectNoticeList(NttVO param) {
		return notibodMapper.selectNoticeList(param);
	}


	/**
	 * 메인화면 공지사항 리스트 조회
	 */
	public List<NttVO> selectMainNoticeList() {
		return notibodMapper.selectMainNoticeList();
	};
}
