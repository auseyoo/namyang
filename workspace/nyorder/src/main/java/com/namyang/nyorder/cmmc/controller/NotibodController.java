package com.namyang.nyorder.cmmc.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.cmmc.service.NotibodService;
import com.namyang.nyorder.cmmc.vo.NttVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 커뮤니케이션관리 - 공지사항
 * 파일명  : NotibodController.java
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
@Controller
@RequestMapping("/cmmc")
public class NotibodController {

	
	@Autowired 
	NotibodService notibodService;
	 
	@Resource
	UserInfo userInfo;
	
	private Logger logger = LoggerFactory.getLogger(NotibodController.class);

	
	/**
	 * @Method Name : notice_board
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : GAIN
	 * @Method 설명 : 공지사항게시판 화면
	 * @param request
	 * @param VO
	 * @return ModelAndView
	 */
	@RequestMapping(value="/notibod.do", method= RequestMethod.GET)
	public ModelAndView noti_bod(HttpServletRequest request, NttVO VO) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("cmmc/notibod.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectNotiList
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : GAIN
	 * @Method 설명 : 공지사항게시판 공지사항 리스트 조회
	 * @param request
	 * @param VO
	 * @return List<NttVO>
	 */
	@RequestMapping(value="/selectNotiList.do", method= RequestMethod.POST)
	@ResponseBody
	public List<NttVO> selectNotiList(HttpServletRequest request, NttVO VO) {

		return notibodService.selectNoticeList(VO);
	}
}
