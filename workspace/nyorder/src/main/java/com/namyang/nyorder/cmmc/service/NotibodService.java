package com.namyang.nyorder.cmmc.service;

import java.util.List;

import com.namyang.nyorder.cmmc.vo.NttVO;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 커뮤니케이션관리 - 공지사항
 * 파일명  : Notice_boardService.java
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
public interface NotibodService {

	/**
	 * @Method Name : selectMainNoticeList
	 * @작성일 : 2022. 3. 28.
	 * @작성자 : YESOL
	 * @Method 설명 : 메인화면 공지사항 리스트 조회
	 * @return List<NttVO>
	 */
	public List<NttVO> selectMainNoticeList();
	
	/**
	 * @Method Name : selectNotiList
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : GAIN
	 * @Method 설명 : 공통 코드 게시판 리스트 조회
	 * @param param
	 * @return List<NttVO>
	 */
	public List<NttVO> selectNoticeList(NttVO param);

}
