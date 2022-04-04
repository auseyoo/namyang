package com.namyang.nyorder.prmt.controller;

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

import com.namyang.nyorder.comm.vo.CommVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.prmt.service.PrmtAgenMngService;
import com.namyang.nyorder.prmt.vo.PrmtAgenMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 입고 관리 Controller
 * 파일명  : prmtAgenMngController.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 24.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 2. 24.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class PrmtAgenMngController {
		
	@Autowired
	PrmtAgenMngService prmtAgenMngService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : prmtAgenMng
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 관리 - 페이지 이동
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/prmt/prmtAgenMng.do", method = RequestMethod.GET)
	public ModelAndView prmtAgenRqst(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("prmt/prmtAgenMng.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectPrmtAgenMngList
	 * @작성일 : 2022. 2. 28.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 조회
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/selectPrmtAgenMngList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPrmtAgenMngList(PrmtAgenMngVO param, HttpServletRequest request) {
		param.setReqYm(param.getReqYm().replace("-", ""));
		return prmtAgenMngService.selectPrmtAgenMngList(param);
	}
	
	/**
	 * @Method Name : savePrmtAgenMng
	 * @작성일 : 2022. 2. 28.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 저장
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/savePrmtAgenMng.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String savePrmtAgenMng(@RequestBody List<PrmtAgenMngVO> list) throws Exception {
		return prmtAgenMngService.savePrmtAgenMng(list);
	}
	
	/**
	 * @Method Name : prmtRegPop
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 등록 팝업 오픈
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/prmtRegPop.do")
	public ModelAndView prmtRegPop(@ModelAttribute("params") CommVO param, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("prmt/prmtRegPop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : selectPrmtList
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 등록 팝업 - 판촉물 조회
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/selectPrmtList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPrmtList(PrmtAgenMngVO param, HttpServletRequest request) {
		return prmtAgenMngService.selectPrmtList(param);
	}
}
