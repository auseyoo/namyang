package com.namyang.nyorder.myp.controller;

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

import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.service.AgentMenuRoleService;
import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 마이페이지 - 권한 관리 Controller
 * 파일명  : AgentMenuRoleController.java
 * 작성자  : YESOL
 * 작성일  : 2021. 12. 31.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 12. 31.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class AgentMenuRoleController {
	
	private Logger logger = LoggerFactory.getLogger(AgentMenuRoleController.class);
		
	
	@Autowired
	AgentMenuRoleService agentMenuRoleService;

	@Autowired
	CommCodeService commCodeService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 *	권한 설정 페이지 이동  
	 */
	/**
	 * @Method Name : agentMenuRoleList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 권한 관리 페이지 이동  
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/myp/agentMenuRoleList.do", method = RequestMethod.GET)
	public ModelAndView agentMenuRoleList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("myp/agentMenuRoleList.view");
		AgentMenuRoleVO param2 = new AgentMenuRoleVO();
		param2.setAgenSeq(userInfo.getAgenSeq());
		mv.addObject("emplSeqList", agentMenuRoleService.selectEmplSeqList(param2));
		return mv;
	}
	
	/**
	 * @Method Name : readAgentMenuRoleGrpList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 그룹별 권한 리스트 조회  
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/myp/selectAgentMenuRoleGrpList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectAgentMenuRoleGrpList(AgentMenuRoleVO param, HttpServletRequest request) {
		return agentMenuRoleService.selectAgentMenuRoleGrpList(param);
	}
	
	/**
	 *	메뉴 조회  
	 */
	/**
	 * @Method Name : selectAgentMenuList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 직원별 권한 리스트 조회  
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/myp/selectAgentMenuRoleEmpList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectAgentMenuRoleEmpList(AgentMenuRoleVO param, HttpServletRequest request) {
		return agentMenuRoleService.selectAgentMenuRoleEmpList(param);
	}
	
	
	/**
	 * @Method Name : saveEmplGrpList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 그룹별 권한 리스트 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/myp/saveEmplGrpList.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveEmplGrpList(@RequestBody List<AgentMenuRoleVO> vo) throws Exception {
		return agentMenuRoleService.saveEmplGrpList(vo);
	}
	
	/**
	 * @Method Name : saveEmplList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 직원별 권한 리스트 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/myp/saveEmplList.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveEmplList(@RequestBody List<AgentMenuRoleVO> vo) throws Exception {
		return agentMenuRoleService.saveEmplList(vo);
	}
	
}
