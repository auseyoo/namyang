package com.namyang.nyorder.myp.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.myp.service.CdtlSearchService;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 마이페이지 - 여신 조회 controller
 * 파일명  : CdtlSearchController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 7.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class CdtlSearchController {
	
	@Autowired
	CdtlSearchService cdtlSearchService;
	
	/**
	 * @Method Name : cdtlSearch
	 * @작성일 : 2022. 1. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/myp/cdtlSearch.do", method = RequestMethod.GET)
	public ModelAndView cdtlSearch(HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("myp/cdtlSearch.view");
		return mv;
	}
	
}
