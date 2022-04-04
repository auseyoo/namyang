package com.namyang.nyorder.myp.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.config.aop.SessionInfo;
import com.namyang.nyorder.myp.service.AgentMngService;

import com.namyang.nyorder.myp.vo.AgentMngVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AgentMngController {
	
	@Autowired
	AgentMngService agentMngService;
	
	@Autowired
	CommCodeService commCodeService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;


	@SessionInfo
	@RequestMapping(value="/myp/staffMng.do", method = RequestMethod.GET)	
	public ModelAndView staffMng(HttpServletRequest request, AgentMngVO agentMngVO) {		
		ModelAndView mv = new ModelAndView();
		CommCodeVO param = new CommCodeVO();
		param.setCommGrpCd("EMPL_SEC");
		param.setCommDesc1("Y");
		
		//AgentMngVO agentMngVO = new AgentMngVO(userInfo);		
		log.debug("selectAgentMngList  agentMngVO ::" + agentMngVO.getAgenSeq());
		mv.addObject("emplCode", commCodeService.selectCommCodeList(param));		
		mv.setViewName("myp/staffMng.view");		
		return mv;
	}
	
	@SessionInfo
	@RequestMapping(value="/myp/selectAgentMngList.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> selectAgentMngList(AgentMngVO param, HttpServletRequest request) throws Exception {
		
		
		log.debug("selectAgentMngList  userInfo ::" + userInfo.getAgenSeq());
		
		log.debug("selectAgentMngList  param ::" + param.getAgenSeq());
		
		log.debug("selectAgentMngList  param getSaleCd ::" + param.getSaleCd());
		
		log.debug("selectAgentMngList  param getEmplSecCd ::" + param.getEmplSecCd());
		
		
		//param.setAgenSeq(userInfo.getAgenSeq());
		
		//agentMngService.selectAxis(param);
		
		log.debug("selectAgentMngList  param ::" + param.getEmplSecCd());	
		
		AgentMngVO param2 = new AgentMngVO();
		
		return agentMngService.selectAgentMngList(param2);
	}
	
	@RequestMapping(value="/myp/insertAgentMng.do", method = RequestMethod.POST)
	@ResponseBody
	public int insertAgentMng(AgentMngVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return agentMngService.insertAgentMng(param);
	}
	
	
	

}
