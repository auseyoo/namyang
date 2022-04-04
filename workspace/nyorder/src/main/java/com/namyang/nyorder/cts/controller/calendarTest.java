package com.namyang.nyorder.cts.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자 캘린더그리드 예제
 * 파일명  : calendarTest.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 10.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일			 변경자		   변경내역
 * --------------------------------------------------
 * 2022. 1. 10.	윤이준	 최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class calendarTest {
	@RequestMapping(value="/cts/calendarTestList.do", method = RequestMethod.GET)
	public ModelAndView calendarList( HttpServletRequest request , ModelAndView mv ) {
		mv.setViewName("cts/calendarTestList.view");
		return mv;
	}
}
