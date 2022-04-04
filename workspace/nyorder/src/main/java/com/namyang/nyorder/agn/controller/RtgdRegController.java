package com.namyang.nyorder.agn.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.agn.service.RtgdRegService;
import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.comm.vo.CommVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품등록 Controller
 * 파일명  : RtgdRegController.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 1. 04.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 1. 26.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class RtgdRegController {
	@Autowired
	RtgdRegService rtgdRegService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 *	반품등록 페이지 이동  
	 */
	/**
	 * @Method Name : rtngudReg
	 * @작성일 : 2022. 1. 21.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 페이지 이동  
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/rtngudReg.do", method = RequestMethod.GET)
	public ModelAndView rtngudReg(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("agn/rtngudReg.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectRtgdRegList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectRtgdRegList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectRtgdRegList(RtgdVO param, HttpServletRequest request) {
		return rtgdRegService.selectRtgdRegList(param);
	}	
	
	/**
	 * @Method Name : selectStdPrdList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 표준제품 불러오기
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectStdPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectStdPrdList(RtgdVO param, HttpServletRequest request) {
		return rtgdRegService.selectStdPrdList(param);
	}
	
	/**
	 * @Method Name : selectPrevRtgdList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 전월반품 불러오기
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectPrevRtgdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPrevRtgdList(RtgdVO param, HttpServletRequest request) {
		return rtgdRegService.selectPrevRtgdList(param);
	}	
	
	/**
	 * @Method Name : saveRtgdReg
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 저장
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/agn/saveRtgdReg.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveRtgdReg(@RequestBody List<RtgdVO> list) throws Exception {
		return rtgdRegService.saveRtgdRegList(list );
	}
	
	/**
	 * @Method Name : sendRtgdReg
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 전송
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/agn/sendRtgdReg.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String sendRtgdReg(@RequestBody List<RtgdVO> list) throws Exception {
		return rtgdRegService.sendRtgdReg(list);
	}
	
	/**
	 * @Method Name : selectTrnstYn
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 전송여부 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectTrnstYn.do", method = RequestMethod.POST)
	@ResponseBody
	public String selectTrnstYn(RtgdVO param, HttpServletRequest request) {
		return rtgdRegService.selectTrnstYn(param);
	}
	
	/**
	 * @Method Name : selectSavedYn
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 저장여부 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectSavedYn.do", method = RequestMethod.POST)
	@ResponseBody
	public String selectSavedYn(RtgdVO param, HttpServletRequest request) {
		return rtgdRegService.selectSavedYn(param);
	}
	
	/**
	 * @Method Name : stdPrdPop
	 * @작성일 : 2022. 3. 14.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 제품등록 팝업창 오픈
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/agn/rtgdStdPrdPop.do")
	public ModelAndView stdPrdPop(@ModelAttribute("params") CommVO param, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("agn/rtgdStdPrdPop.jsp");
		return mv;
	}
		
	/**
	 * @Method Name : selectPrdList
	 * @작성일 : 2022. 2. 07.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 제품등록 팝업창 - 제품리스트
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPrdList(RtgdVO param, HttpServletRequest request) {
		return rtgdRegService.selectPrdList(param);
	}	
}
