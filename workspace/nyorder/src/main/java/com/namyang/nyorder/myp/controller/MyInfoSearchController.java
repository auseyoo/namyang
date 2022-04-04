package com.namyang.nyorder.myp.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.service.MyInfoSearchService;
import com.namyang.nyorder.myp.vo.MyInfoSearchVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 마이페이지 - 내 정보 조회
 * 파일명  : MyInfoController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 3.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 3.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class MyInfoSearchController {
	@Resource(name="userInfo")
	UserInfo userInfo;

	@Autowired
	MyInfoSearchService myInfoSearchService;
	
	@Autowired
	CommCodeService commCodeService;
	
	/**
	 * @Method Name : agentMenuRoleList
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 내 정보 조회 페이지 이동
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/myp/myInfoSearch.do", method = RequestMethod.GET)
	public ModelAndView myInfoSearch(HttpServletRequest request, MyInfoSearchVO param ) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("myp/myInfoSearch.view");
		
		/* 대리점 상세 정보 조회 - 추후 SAP연동 */
		param.setAgenSeq(userInfo.getAgenSeq());
		mv.addObject("agenMst" , myInfoSearchService.selectAgenMst(param));
		
		/* 입금 계좌 정보 조회 */
		param.setEmplSeq(userInfo.getEmplSeq());
		mv.addObject("acctInfoList" , myInfoSearchService.selectMyInfoSearch(param));
		
		/* 가상 계좌 정보 조회 */
		
		return mv;
	}
	
	/**
	 * @Method Name : saveAgenAcctInfo
	 * @작성일 : 2022. 1. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 내 정보 저장
	 * @param vo
	 * @return String
	 * @throws Exception 
	 */
	@RequestMapping(value="/myp/saveAgenAcctInfo.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveAgenAcctInfo(MyInfoSearchVO vo) throws Exception {
		
		myInfoSearchService.saveAgenAcctInfo(vo);
		return "저장되었습니다.";
	}
}
