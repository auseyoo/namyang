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

import com.namyang.nyorder.agn.service.InvryMstService;
import com.namyang.nyorder.agn.vo.InvryMstVO;
import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 재고 관리 Controller
 * 파일명  : InvryMstController.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 2. 14.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class InvryMstController {
	
	@Autowired
	InvryMstService invryMstService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 *	재고 관리 페이지 이동  
	 */
	/**
	 * @Method Name : invryMst
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고 관리 페이지 이동
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/invryMst.do", method = RequestMethod.GET)
	public ModelAndView rtngudList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("agn/invryMst.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectPuchList
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 매입처 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectPuchList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectRtngudList(InvryMstVO param, HttpServletRequest request) {
		return invryMstService.selectPuchList(param);
	}
	
	/**
	 * @Method Name : selectInvryMstList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고 관리 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectInvryMstList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectInvryMstList(InvryMstVO param, HttpServletRequest request) {
		param.setStdrDt(param.getStdrDt().replace("-", ""));
		return invryMstService.selectInvryMstList(param);
	}	
	
	/**
	 * @Method Name : saveInvryMst
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 재고 관리 저장
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/agn/saveInvryMst.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveInvryMst(@RequestBody List<InvryMstVO> list) throws Exception {
		return invryMstService.saveInvryMst(list );
	}
}
