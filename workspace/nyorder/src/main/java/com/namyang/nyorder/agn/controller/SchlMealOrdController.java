package com.namyang.nyorder.agn.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.agn.service.SchlMealOrdService;
import com.namyang.nyorder.agn.vo.SchlMealOrdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 학교급식 주문 조회
 * 파일명  : SchlMealOrdController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 2. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 14.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class SchlMealOrdController {
	
	@Autowired
	SchlMealOrdService schlMealOrdService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : schlMealOrd
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문 조회 페이지 이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/schlMealOrd.do")
	public ModelAndView schlMealOrd(HttpServletRequest request , ModelAndView mv) {
		mv.setViewName("agn/schlMealOrd.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectSchlMealOrdList
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문리스트 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/agn/selectSchlMealOrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectSchlMealOrdList(SchlMealOrdVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return schlMealOrdService.selectSchlMealOrdList( param );
	}
}
