package com.namyang.nyorder.agn.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.agn.service.SpclOrdService;
import com.namyang.nyorder.agn.vo.SpclOrdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 특수처 주문 조회
 * 파일명  : SpclOrdController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 22.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 22.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class SpclOrdController {
	
	@Autowired
	SpclOrdService spclOrdService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : spclOrd
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 윤이준
	 * @Method 설명 : 특수처 주문 조회 페이지 이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/spclOrd.do")
	public ModelAndView spclOrd(HttpServletRequest request , ModelAndView mv) {
		mv.setViewName("agn/spclOrd.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectSpclOrdList
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 윤이준
	 * @Method 설명 : 특수처 주문 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/agn/selectSpclOrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectSpclOrdList(SpclOrdVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return spclOrdService.selectSpclOrdList( param );
	}
}
