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
import com.namyang.nyorder.std.dao.StdPrdCdMngMapper;
import com.namyang.nyorder.std.service.StdPrdCdMngService;
import com.namyang.nyorder.std.service.StdPrdMngService;
import com.namyang.nyorder.std.vo.StdPchaMngVO;
import com.namyang.nyorder.std.vo.StdPrdCdMngVO;
import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 타사제품코드 관리 Controller
 * 파일명  : StdPrdCdMngController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 17.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class StdPrdCdMngController {

	/*
	 * @Autowired StdPrdMngService stdPrdMngService;
	 */
	
	@Autowired
	StdPrdCdMngService stdPrdCdMngService;
	
	@Autowired
	StdPrdCdMngMapper stdPrdCdMngMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : stdPrdCdMng
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 기준정보관리 - 타사제품코드 관리 페이지이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/std/stdPrdCdMng.do", method = RequestMethod.GET)
	public ModelAndView stdPrdCdMng(HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("std/stdPrdCdMng.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectPrdCdPchaList
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 매입처 조회
	 * @param param
	 * @return List<StdPchaMngVO>
	 */
	@RequestMapping(value="/std/selectPrdCdPchaList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPrdCdPchaList(StdPrdCdMngVO param, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		param.setAgenSeq( userInfo.getAgenSeq() );
		result.put("list", stdPrdCdMngMapper.selectPrdCdPchaList(param) );
		return result;
	}
	
	/**
	 * @Method Name : selectPrdCdMstList
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 마스터 조회
	 * @param param
	 * @return List<StdPchaMngVO>
	 */
	@RequestMapping(value="/std/selectPrdCdMstList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPrdCdMstList(@RequestBody StdPrdCdMngVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return stdPrdCdMngService.selectPrdCdMstList(param);
	}
	
	/**
	 * @Method Name : selectStdPrdCdDetail
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 제품 조회
	 * @param param
	 * @return List<StdPchaMngVO>
	 */
	@RequestMapping(value="/std/selectStdPrdCdDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public StdPrdCdMngVO selectStdPrdCdDetail(@RequestBody StdPrdCdMngVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return stdPrdCdMngService.selectStdPrdMngDetail(param);
	}
	
	/**
	 * @Method Name : saveStdPrdCdDetail
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 제품 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/std/saveStdPrdCdDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveStdPrdCdDetail(@RequestBody StdPrdCdMngVO param) throws Exception{
		param.setAgenSeq(userInfo.getAgenSeq());
		return stdPrdCdMngService.saveStdPrdCdDetail(param);
	}
	
	/**
	 * @Method Name : removeStdPrdCd
	 * @작성일 : 2022. 1. 18.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품코드 관리 삭제
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/std/removeStdPrdCd.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> removeStdPrdCd(@RequestBody StdPrdCdMngVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return stdPrdCdMngService.removeStdPrdCd( param );
	}
	
	/**
	 * @Method Name : getNextPrdDtlCd
	 * @작성일 : 2022. 1. 18.
	 * @작성자 : 윤이준
	 * @Method 설명 : 제품 코드 생성
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/std/getNextPrdDtlCd.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getNextPrdDtlCd(@RequestBody StdPrdCdMngVO param, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		param.setAgenSeq( userInfo.getAgenSeq() );
		result.put( "nextPrdDtlCd", stdPrdCdMngMapper.getNextPrdDtlCd(param) );
		return result;
	}
}
