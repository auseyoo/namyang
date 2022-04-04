package com.namyang.nyorder.comm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.CommVO;
import com.namyang.nyorder.comm.vo.PrdClsVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 팝업 컨트롤러
 * 파일명  : CommPopController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 10.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 10.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class CommPopController {
	
	@Autowired
	private CommCodeService commCodeService;
	
	/**
	 * @Method Name : commCodeList
	 * @작성일 : 2022. 1. 10.
	 * @작성자 : YESOL
	 * @Method 설명 : 팝업 페이지 이동
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/comm/pop/{path}.pop")
	public ModelAndView commPopList(@PathVariable String path, @ModelAttribute("params") CommVO param, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("lclsList", commCodeService.selectPrdCls(new PrdClsVO()));
		mv.setViewName("pop/"+path +".jsp");
		return mv;
	}
	
}
