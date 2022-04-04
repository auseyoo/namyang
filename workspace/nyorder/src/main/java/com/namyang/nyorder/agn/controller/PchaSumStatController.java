package com.namyang.nyorder.agn.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.agn.service.PchaSumStatService;
import com.namyang.nyorder.agn.vo.PchaSumStatVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 대리점관리 - 매입 집계 현황 Controller
 * 파일명  : PchaRegController.java
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
@Controller
public class PchaSumStatController {
	
	@Autowired
	PchaSumStatService pchaSumStatService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : pchaSumStat
	 * @작성일 : 2022. 1. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 매입 집계 현황 페이지 이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/pchaSumStat.do", method = RequestMethod.GET)
	public ModelAndView pchaSumStat(HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("agn/pchaSumStat.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectPchaSumStatList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectSumStatPchaList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectSumStatPchaList(PchaSumStatVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return pchaSumStatService.selectSumStatPchaList(param);
	}
	
	/**
	 * @Method Name : selectPchaSumStatList
	 * @작성일 : 2022. 1. 20.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처(일) 상세 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectPchaSumStatDayList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPchaSumStatDayList(@RequestBody PchaSumStatVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return pchaSumStatService.selectPchaSumStatDayList(param);
	}
	
	/**
	 * @Method Name : selectPchaSumStatMonList
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처 상세(월) 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectPchaSumStatMonList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPchaSumStatMonList(@RequestBody PchaSumStatVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return pchaSumStatService.selectPchaSumStatMonList(param);
	}
	
	/**
	 * @Method Name : selectMjrPchaSumStatDayList
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처(일) 상세 조회(메이저)
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectMjrPchaSumStatDayList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectMjrPchaSumStatDayList(@RequestBody PchaSumStatVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return pchaSumStatService.selectMjrPchaSumStatDayList(param);
	}
	
	/**
	 * @Method Name : selectMjrPchaSumStatMonList
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입집계 현황 매입처 상세(월) 조회(메이저)
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectMjrPchaSumStatMonList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectMjrPchaSumStatMonList(@RequestBody PchaSumStatVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return pchaSumStatService.selectMjrPchaSumStatMonList(param);
	}
}
