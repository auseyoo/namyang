package com.namyang.nyorder.std.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 단가 정보 관리 Controller
 * 파일명  : StdUntpcInfoMngController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 17.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class StdUntpcInfoMngController {
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : stdUntpcInfoMng
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : YESOL
	 * @Method 설명 : 기준정보관리 - 매입처 관리 페이지이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/std/stdUntpcInfoMng.do", method = RequestMethod.GET)
	public ModelAndView stdUntpcInfoMng(HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("std/stdUntpcInfoMng");
		return mv;
	}
}
