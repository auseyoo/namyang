package com.namyang.nyorder.cmmc.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.cmmc.service.RcbodService;
import com.namyang.nyorder.cmmc.vo.RcbodVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("/cmmc")
public class RcbodController {

	
	 @Autowired 
	 RcbodService rcbodService;
	
	 @Resource(name="userInfo")
     UserInfo userInfo;
	
	private Logger logger = LoggerFactory.getLogger(RcbodController.class);

	
	
	/**
	 * @Method Name : resc_bod
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 자료실
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/rcbod.do", method= RequestMethod.GET)
	public ModelAndView rcbod(HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("cmmc/rcbod.view");
		return mv;
	}
	/**
	 * @Method Name : selectRcbodList
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 자료실 제목 리스트 조회
	 * @param VO
	 * @param request
	 * @return List<RcbodVO>
	 */
	@RequestMapping(value="/selectRcbodList.do", method=RequestMethod.POST)
	@ResponseBody
	public List<RcbodVO> selectRcbodList(RcbodVO vo, HttpServletRequest request) {
		vo.setAgenSeq(userInfo.getAgenSeq());
		return rcbodService.selectRcbodList(vo);
	}
	
	/**
	 * @Method Name : selectRcbodDtlList
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 자료실 내용 조회 
	 * @param VO
	 * @param request
	 * @return List<RcbodVO>
	 */
	@RequestMapping(value="/selectRcbodDtlList.do", method=RequestMethod.POST)
	@ResponseBody
	public List<RcbodVO> selectRcbodDtlList(@RequestBody RcbodVO vo, HttpServletRequest request) {
		vo.setAgenSeq(userInfo.getAgenSeq());
		return rcbodService.selectRcbodDtlList(vo);
	}
}
