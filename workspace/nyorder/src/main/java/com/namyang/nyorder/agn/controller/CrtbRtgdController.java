package com.namyang.nyorder.agn.controller;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.namyang.nyorder.agn.service.CrtbRtgdService;
import com.namyang.nyorder.agn.vo.CrtbRtgdVO;
import com.namyang.nyorder.agn.vo.InvryMstVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 크레이트 반납 관리 Controller
 * 파일명  : CrtbRtgdController.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 15.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 2. 15.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class CrtbRtgdController {
	
	@Autowired
	CrtbRtgdService crtbRtgdService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 *	재고 관리 페이지 이동  
	 */
	/**
	 * @Method Name : crtbRtgd
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 반납 페이지 이동
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/crtbRtgd.do", method = RequestMethod.GET)
	public ModelAndView crtbRtgd(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("agn/crtbRtgd.view");
		CrtbRtgdVO param2 = new CrtbRtgdVO();
		mv.addObject("crtbCdList", crtbRtgdService.selectCrtbCdList(param2));
		return mv;
	}

	/**
	 * @Method Name : selectCrtbRtgdList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 반납 데이터 조회
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/agn/selectCrtbRtgdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectCrtbRtgdList(CrtbRtgdVO param, HttpServletRequest request) {
		return crtbRtgdService.selectCrtbRtgdList(param);
	}	
	
	/**
	 * @Method Name : saveCrtbRtgd
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 반납 저장
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/agn/saveCrtbRtgd.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveCrtbRtgd(@RequestBody List<CrtbRtgdVO> list) throws Exception {
		return crtbRtgdService.saveCrtbRtgd(list);
	}	
}
