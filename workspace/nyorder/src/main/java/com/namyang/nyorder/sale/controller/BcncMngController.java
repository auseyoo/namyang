package com.namyang.nyorder.sale.controller;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.h2.util.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.service.AgentMngService;
import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;
import com.namyang.nyorder.myp.vo.AgentMngVO;
import com.namyang.nyorder.sale.service.BcncMngService;
import com.namyang.nyorder.sale.vo.AgenVendVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판매관리 - 거래처 관리 Controller
 * 파일명  : BcncMngController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 7.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class BcncMngController {

	@Autowired
	CommCodeService commCodeService;

	@Autowired
	AgentMngService agentMngService;

	@Autowired
	BcncMngService bcncMngService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	/**
	 * @Method Name : agentMenuRoleList
	 * @작성일 : 2022. 1. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 거래처 관리 페이지 이동
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/bcncMng.do", method = RequestMethod.GET)
	public ModelAndView agentMenuRoleList(HttpServletRequest request, ModelAndView mv,@SessionAttribute("userInfo") AccountVO account) throws Exception {
		// 직원 리스트 조회
		mv.addObject("emplList", bcncMngService.selectAgentEmplList(new AgenVendVO() {{
			setAgenSeq(account.getAgenSeq());
		}}));


		mv.setViewName("sale/bcncMng.view");
		return mv;
	}
	/**
	 * @Method Name : bcncMngDtl
	 * @작성일 : 2022. 1. 14.
	 * @작성자 : WOONGIL
	 * @Method 설명 : 거래처 상세/등록 화면
	 * @param request
	 * @param param
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/bcncMngDtl.do", method = RequestMethod.GET)
	public ModelAndView bcncMngDtl(HttpServletRequest request,AgenVendVO param ,ModelAndView mv,@SessionAttribute("userInfo") AccountVO account) throws Exception {

		/*대리점 직원 조회*/
		mv.addObject("emplList", bcncMngService.selectAgentEmplList(new AgenVendVO() {{
			setAgenSeq(account.getAgenSeq());
		}}));

		/* 은행 정보 조회 */
		CommCodeVO codeParam = new CommCodeVO();
		codeParam.setCommGrpCd("BANK_CD");
		codeParam.setUseYn("Y");
		mv.addObject("bankList", commCodeService.selectCommCodeList(codeParam));

		/*거래처 상세 정보 조회*/
		mv.addObject("bcncMngDtl", bcncMngService.selectBcncMngDtl(param));

		mv.setViewName("sale/bcncMngDtl.view");
		return mv;
	}

	/**
	 * @Method Name : selectBcncMngList
	 * @작성일 : 2022. 1. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 거래처 조회
	 * @param request
	 * @param param
	 * @return List<AgenVendVO>
	 */
	@RequestMapping(value="/sale/selectBcncMngList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenVendVO> selectBcncMngList(HttpServletRequest request, AgenVendVO param) {

		List<AgenVendVO> bcncMngList = bcncMngService.selectBcncMngList(param);
		return bcncMngList;
	}

	/**
	 * @Method Name : saveBcnc
	 * @작성일 : 2022. 1. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 거래처 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/sale/saveBcnc.do", method = RequestMethod.POST)
	@ResponseBody
	public String saveBcnc(HttpServletRequest request, AgenVendVO param) throws Exception {
		return bcncMngService.saveBcnc((AgenVendVO) emptyIsNull(param));
	}

	/**
	 * @Method Name : bcncSprt
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 지원내역 관리 페이지이동
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/bcncSprtMng.do", method = RequestMethod.GET)
	public ModelAndView bcncSprtMng(HttpServletRequest request, ModelAndView mv,@SessionAttribute("userInfo") AccountVO account) throws Exception {
		// 직원 리스트 조회
		mv.addObject("emplList", bcncMngService.selectAgentEmplList(new AgenVendVO() {{
			setAgenSeq(account.getAgenSeq());
		}}));
		mv.setViewName("sale/bcncSprtMng.view");
		return mv;
	}

	/**
	 * @Method Name : saveBcncSprt
	 * @작성일 : 2022. 1. 21.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 지원내역 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/sale/saveBcncSprt.do", method = RequestMethod.POST)
	@ResponseBody
	public String saveBcncSprt(HttpServletRequest request, AgenVendVO param) throws Exception {

		return bcncMngService.saveBcncSprt((AgenVendVO) emptyIsNull(param));
	}

	/**
	 * @Method Name : selectBcncSprtList
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 지원내역 조회
	 * @param request
	 * @param param
	 * @return List<AgenVendVO>
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 */
	@RequestMapping(value="/sale/selectBcncSprtList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectBcncSprtList(HttpServletRequest request, AgenVendVO param) throws Exception {
		Map<String,Object> result = new HashMap<String, Object>();


		List<AgenVendVO> bcncSprtList = bcncMngService.selectBcncSprtList((AgenVendVO) emptyIsNull(param));
//		String useBcncSec = bcncMngService.useSprtSec(param);
		result.put("bcncSprtList", bcncSprtList);
//		result.put("useBcncSec", useBcncSec);
		return result;
	}

	/**
	 * @Method Name : bncSprtDtl
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 지원내역 상세
	 * @param request
	 * @param param
	 * @return AgenVendVO
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/bncSprtDtl.do", method = RequestMethod.POST)
	@ResponseBody
	public AgenVendVO bncSprtDtl(HttpServletRequest request,AgenVendVO param ) throws Exception {
		return bcncMngService.bncSprtDtl(param);
	}

	/**
	 * @Method Name : emptyIsNull
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 빈값 Null 처리
	 * @param obj
	 * @return
	 * @throws Exception String
	 */
	public Object emptyIsNull(Object obj) throws IllegalArgumentException, IllegalAccessException {
		 for (Field field :  obj.getClass().getDeclaredFields()) {
			 field.setAccessible(true);
	         Object value=field.get(obj);
	         if(value == null ||value.equals("")) {
	        	 field.set(obj, null);
	         }
	         if(field.getName().contains("Dt")){
	        	 if(value !=null) {
	        		 field.set(obj, ((String) value).replaceAll("-",""));
	        	 }
	         }
	         System.out.println(field.getName()+","+field.get(obj));
		 }
		 return obj;
	}
}
