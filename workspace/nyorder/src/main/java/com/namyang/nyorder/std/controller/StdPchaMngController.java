package com.namyang.nyorder.std.controller;

import java.util.HashMap;
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

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.std.dao.StdPchaMngMapper;
import com.namyang.nyorder.std.service.StdPchaMngService;
import com.namyang.nyorder.std.vo.StdPchaMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 매입처 관리 Controller
 * 파일명  : StdPchaMngController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class StdPchaMngController {

	@Autowired
	StdPchaMngService stdPchaMngService;
	
	@Autowired
	StdPchaMngMapper stdPchaMngMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : stdPchaMng
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 기준정보관리 - 매입처 관리 페이지이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/std/stdPchaMng.do", method = RequestMethod.GET)
	public ModelAndView stdPchaMng(HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("std/stdPchaMng.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectPchaList
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/std/selectPchaList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPchaList(StdPchaMngVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return stdPchaMngService.selectPchaList(param);
	}
	
	/**
	 * @Method Name : selectPchaDetail
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 상세 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/std/selectPchaDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPchaDetail(@RequestBody StdPchaMngVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return stdPchaMngService.selectPchaDetail(param);
	}
	
	/**
	 * @Method Name : savePchaDetail
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 수정 / 저장
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/std/savePchaDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> savePchaDetail(@RequestBody StdPchaMngVO param, HttpServletRequest request) throws Exception{
		param.setAgenSeq( userInfo.getAgenSeq() );
		param.setEmplSeq( userInfo.getEmplSeq() );
		return stdPchaMngService.savePchaDetail(param);
	}
	
	/**
	 * @Method Name : removePcha
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 삭제
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/std/removePcha.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> removePcha(@RequestBody StdPchaMngVO param, HttpServletRequest request) throws Exception{
		param.setAgenSeq( userInfo.getAgenSeq() );
		param.setEmplSeq( userInfo.getEmplSeq() );
		return stdPchaMngService.removePcha(param);
	}
	
	/**
	 * @Method Name : getNextPuchCd
	 * @작성일 : 2022. 1. 13.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 코드 생성
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/std/getNextPuchCd.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getNextPuchCd(StdPchaMngVO param, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		param.setAgenSeq( userInfo.getAgenSeq() );
		result.put( "nextPuchCd", stdPchaMngMapper.getNextPuchCd(param) );
		return result;
	}
	
}
