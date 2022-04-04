package com.namyang.nyorder.sale.controller;

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
import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.service.AgentMngService;
import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;
import com.namyang.nyorder.myp.vo.AgentMngVO;
import com.namyang.nyorder.sale.service.EdiDlvService;
import com.namyang.nyorder.sale.vo.AgenVendVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판매관리 - EDI 납품 조회 Controller
 * 파일명  : EdiDlvController.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 1. 18.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 18.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class EdiDlvController {
	
	@Autowired
	CommCodeService commCodeService;
	
	@Autowired
	AgentMngService agentMngService;
	
	@Autowired
	EdiDlvService ediDlvService;
	 
	@Resource(name="userInfo")
	UserInfo userInfo;
	/**
	 * @Method Name : ediDlv
	 * @작성일 : 2022. 1. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : EDI 납품 페이지 이동
	 * @param request
	 * @return ModelAndView
	 * @throws Exception 
	 */
	@RequestMapping(value="/sale/ediDlv.do", method = RequestMethod.GET)
	public ModelAndView ediDlv(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sale/ediDlv");
		return mv;
	}

	
	
}
