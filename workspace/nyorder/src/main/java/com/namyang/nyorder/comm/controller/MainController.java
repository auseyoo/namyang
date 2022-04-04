package com.namyang.nyorder.comm.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.cmmc.vo.NttVO;
import com.namyang.nyorder.comm.service.CommonService;
import com.namyang.nyorder.comm.service.LoginService;
import com.namyang.nyorder.comm.service.MainService;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.CstMstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : Main Controller
 * 파일명  : MainController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일			 변경자		   변경내역
 * --------------------------------------------------
 * 2022. 1. 4.	YESOL	 최조 프로그램 작성
 * 2022. 3. 28.	JUNGAE	 공지사항조회, 여신조회 추가 
 *
 ****************************************************/
@Controller
@RequestMapping("/comm")
public class MainController {
	
	@Autowired
	private LoginService loginService;

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private MainService mainService;
	
		
	@RequestMapping("/main.do")
	public ModelAndView mainList( @SessionAttribute("userInfo") AccountVO account) {
		loginService.setSessionInfo(account);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("comm/mainList");
		return mv;
	}
	
	/**
	 * @Method Name : selectMainNotice
	 * @작성일 : 2022. 3. 28.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 메인화면 - 공지사항 리스트 조회
	 * @param param
	 * @return List<NttVO>
	 */
	@RequestMapping(value="/selectMainNotice.do", method = RequestMethod.POST)
	@ResponseBody
	public List<NttVO> selectMainNotice() {
		return mainService.selectMainNotice();
	}
	
	/**
	 * @Method Name : selectMainCredit
	 * @작성일 : 2022. 3. 28.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 메인화면 - 여신조회
	 * @param param
	 * @return List<NttVO>
	 */
	@RequestMapping(value="/selectMainCredit.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectMainCredit() {
		return mainService.selectMainCredit();
	}

	/**
	 * @Method Name : selectMainDly
	 * @작성일 : 2022. 3. 31.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 메인화면 - 배송조회
	 * @param param
	 * @return List<NttVO>
	 */
	@RequestMapping(value="/selectMainDly.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectMainDly() {
		return mainService.selectMainDly();
	}
		
	@RequestMapping("/dev.do")
	public ModelAndView mainList( ) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("comm/dev.view");
		return mv;
	}

	@RequestMapping("/selectAddr.do")
	@ResponseBody
	public List<CstMstVO> selectAddr(CstMstVO param ) {
		return commonService.selectAddr(param);
	}
	
	
}
