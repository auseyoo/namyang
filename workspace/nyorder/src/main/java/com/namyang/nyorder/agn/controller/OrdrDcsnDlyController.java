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

import com.namyang.nyorder.agn.service.OrdrDcsnDlyService;
import com.namyang.nyorder.agn.vo.OrdrDcsnDlyVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 대리점관리 - 주문확정/배송조회 Controller
 * 파일명  : OrdrDcsnDlyController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 15.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class OrdrDcsnDlyController {
	
	@Autowired
	OrdrDcsnDlyService ordrDcsnDlyService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : ordrDcsnDly
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문확정/배송조회 페이지 이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/ordrDcsnDly.do", method = RequestMethod.GET)
	public ModelAndView ordrDcsnDly(HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("agn/ordrDcsnDly.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectOrdrDcsnDlyList
	 * @작성일 : 2022. 2. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문확정/배송 리스트 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/agn/selectOrdrDcsnDlyList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectOrdrDcsnDlyList(OrdrDcsnDlyVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return ordrDcsnDlyService.selectOrdrDcsnDlyList( param );
	}
}
