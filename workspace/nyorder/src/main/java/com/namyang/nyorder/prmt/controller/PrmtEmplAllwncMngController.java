package com.namyang.nyorder.prmt.controller;

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

import com.namyang.nyorder.agn.vo.OrdRegVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.prmt.service.PrmtEmplAllwncMngService;
import com.namyang.nyorder.prmt.vo.PrmtEmplAllwncMngVO;
import com.namyang.nyorder.prmt.vo.PrmtEmplMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 수당 관리
 * 파일명  : PrmtEmplAllwncMngController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 10.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 10.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class PrmtEmplAllwncMngController {
	@Autowired
	PrmtEmplAllwncMngService prmtEmplAllwncMngService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : prmtEmplAllwncMng
	 * @작성일 : 2022. 3. 10.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 수당 관리 - 페이지 이동
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/prmt/prmtEmplAllwncMng.do")
	public ModelAndView prmtEmplAllwncMng(PrmtEmplAllwncMngVO param, ModelAndView mv) throws Exception {
		mv.setViewName("prmt/prmtEmplAllwncMng.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectPrmtEmplAllwncList
	 * @작성일 : 2022. 3. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 수당 관리
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/prmt/selectPrmtEmplAllwncList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPrmtEmplAllwncList(@RequestBody PrmtEmplAllwncMngVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return prmtEmplAllwncMngService.selectPrmtEmplAllwncList(param);
	}
	
	/**
	 * @Method Name : savePrmtEmplAllwnc
	 * @작성일 : 2022. 3. 16.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 수당 저장
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/savePrmtEmplAllwnc.do", method = RequestMethod.POST)
	@ResponseBody
	public String savePrmtEmplAllwnc(@RequestBody List<PrmtEmplAllwncMngVO> list) throws Exception {
		return prmtEmplAllwncMngService.savePrmtEmplAllwncList(list);
	}
}
