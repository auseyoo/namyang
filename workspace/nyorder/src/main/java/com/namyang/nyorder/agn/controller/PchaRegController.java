package com.namyang.nyorder.agn.controller;

import java.util.List;
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

import com.namyang.nyorder.agn.dao.PchaRegMapper;
import com.namyang.nyorder.agn.service.PchaRegService;
import com.namyang.nyorder.agn.vo.PchaRegVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;
import com.namyang.nyorder.std.vo.StdPrdCdMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 대리점관리 - 매입 등록 Controller
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
public class PchaRegController {
	
	@Autowired
	PchaRegService pchaRegService;
	
	@Autowired
	PchaRegMapper pchaRegMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : ordrReg
	 * @작성일 : 2022. 1. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 매입 등록 페이지 이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/pchaReg.do", method = RequestMethod.GET)
	public ModelAndView ordrReg(HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("agn/pchaReg.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectPchaList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectPchaList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPchaList(PchaRegVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return pchaRegService.selectPchaList(param);
	}
	
	/**
	 * @Method Name : selectPchaRegList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입 제품 조회
	 * @param param
	 * @return List<PchaRegVO>
	 */
	@RequestMapping(value="/agn/selectPchaRegList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPchaRegList(@RequestBody PchaRegVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return pchaRegService.selectPchaRegList(param);
	}
	
	/**
	 * @Method Name : savePchaReg
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입 등록
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/agn/savePchaReg.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String savePchaReg(@RequestBody List<PchaRegVO> param) throws Exception {
		return pchaRegService.savePchaRegList(param);
	}
	
	/**
	 * @Method Name : othComPrdPop
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품 팝업 페이지 이동
	 * @param param
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/othComPrdPop.do")
	public ModelAndView othComPrdPop(ModelAndView mv , PchaRegVO param) {
		mv.setViewName("agn/othComPrdPop.jsp");
		mv.addObject("puchSeq", param.getPuchSeq());
		return mv;
	}
	
	/**
	 * @Method Name : selectOthComPrdList
	 * @작성일 : 2022. 1. 19.
	 * @작성자 : 윤이준
	 * @Method 설명 : 타사제품 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/agn/selectOthComPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectOthComPrdList(@RequestBody PchaRegVO param, HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return pchaRegService.selectOthComPrdList(param);
	}
	
}
