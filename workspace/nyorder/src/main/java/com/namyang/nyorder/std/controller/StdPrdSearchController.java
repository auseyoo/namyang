package com.namyang.nyorder.std.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.PrdClsVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.std.service.StdPrdMngService;
import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;
import com.namyang.nyorder.std.vo.StdPrdMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 제품 조회 Controller
 * 파일명  : StdPrdSearchController.java
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
public class StdPrdSearchController {
	@Resource(name="userInfo")
	private UserInfo userInfo;
	
	@Autowired
	private CommCodeService commCodeService;
	
	@Autowired
	private StdPrdMngService stdPrdMngService;
	
	/**
	 * @Method Name : stdPrdSearch
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 박예솔
	 * @Method 설명 : 기준정보관리 - 제품 조회 : 페이지 이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/std/stdPrdSearch.do", method = RequestMethod.GET)
	public ModelAndView stdPrdSearch(HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("std/stdPrdSearch.view");
		mv.addObject("lclsList", commCodeService.selectPrdCls(new PrdClsVO()));
		return mv;
	}
	
	/**
	 * @Method Name : addStdPrdList
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 리스트 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/std/addStdPrdList.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String addStdPrdList(@RequestBody List<StdPrdMngDetailVO> list) throws Exception{
		return stdPrdMngService.addStdPrdList(list);
	}
}
