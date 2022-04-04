package com.namyang.nyorder.agn.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.agn.service.RtgdService;
import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품/반송 조회 Controller
 * 파일명  : RtgdController.java
 * 작성자  : LEEJUN
 * 작성일  : 2022. 1. 04.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 1. 04.    LEEJUN     최조 프로그램 작성
 * 2022. 1. 26.    JUNGAE     반품/반송조회 그리드 데이터 조회
 *
 ****************************************************/
@Controller
public class RtgdController {
	@Autowired
	RtgdService rtgdService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;

	/**
	 * @Method Name : rtngudList
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : LEEJUN
	 * @Method 설명 : 반품/반송 조회 페이지 이동  
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/rtngudList.do", method = RequestMethod.GET)
	public ModelAndView rtngudList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("agn/rtngudList.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectRtngudList
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품/반송 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectRtngudList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectRtngudList(RtgdVO param, HttpServletRequest request) {
		return rtgdService.selectRtngudList(param);
	}
	
	/**
	 * @Method Name : rtgdConfmPop
	 * @작성일 : 2022. 1. 04.
	 * @작성자 : LEEJUN
	 * @Method 설명 : 반품확인서 이동  
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/rtgdConfmPop.do", method = RequestMethod.GET)
	public ModelAndView rtgdConfmPop(@ModelAttribute("params") RtgdVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		List<RtgdVO> data =  rtgdService.selectRtgdConfmList(param);
		
		// 확정일자
		String sDcsnDt = "";
		if(data != null && data.size() > 0) {
			RtgdVO item = data.get(0);
			sDcsnDt = item.getDcsnDt();
			
			if(sDcsnDt.length() > 0) {
				sDcsnDt = sDcsnDt.substring(0,4) + "-" +sDcsnDt.substring(4,6) + "-" + sDcsnDt.substring(6,8);  
			}
		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("agn/rtgdConfmPop.jsp");
		mv.addObject("agenNm", userInfo.getAgenNm());
		mv.addObject("list", data);
		mv.addObject("dcsnDt", sDcsnDt);
		
		return mv;
	}
}
