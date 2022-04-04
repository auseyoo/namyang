package com.namyang.nyorder.sel.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 마감장 조회
 * 파일명  : ClsController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 2. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 23.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class ClsSearchController {
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	
	/**
	 * @Method Name : clsSearch
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : YESOL
	 * @Method 설명 : 마감장 조회 - 페이지 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/sel/clsSearch.do", method = RequestMethod.GET)
	public ModelAndView clsSearch(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sel/clsSearch.view");
		return mv;
	}
}
