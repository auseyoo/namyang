package com.namyang.nyorder.cst.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.BasicService;
import com.namyang.nyorder.comm.vo.BasicVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.cst.service.DlvMngService;
import com.namyang.nyorder.cst.vo.CstPrdDlvyVO;
import com.namyang.nyorder.cst.vo.CstStatVO;
import com.namyang.nyorder.myp.controller.CdtlSearchController;
import com.namyang.nyorder.myp.vo.MrtgInfoVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자 현황
 * 파일명  : CstStatController.java
 * 작성자  : JungsuKim
 * 작성일  : 2022. 2. 16.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 16.    JungsuKim     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class CstStatController {
	
	@Autowired
	BasicService basicService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : cstStat
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JungsuKim
	 * @Method 설명 : 화면이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/cst/cstStat.do", method = RequestMethod.GET)
	public ModelAndView cstStat(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("cst/cstStat.view");
		return mv;
	}
	
	@RequestMapping(value="/cst/areaChoicePop.do", method = RequestMethod.GET)
	public ModelAndView areaChoicePop(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("cst/areaChoicePop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : selectCstPeriAreaList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JungsuKim
	 * @Method 설명 : 지역별 애음자 리스트 GROUP
	 * @param param
	 * @param basicVO
	 * @return List<CstStatVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/selectCstPeriAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstStatVO> selectCstPeriAreaList(CstStatVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstStatMapper.selectCstPeriAreaList");		
		basicVO.setParamClass(param);
		
		log.debug("selectCstPeriPrdList  param :: " + param.getAgenSeq());
				
		return basicService.basicSelectList(basicVO);
	}
	
	
	/**
	 * @Method Name : selectCstPeriPrdList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JungsuKim
	 * @Method 설명 : 지역별 애음자 리스트
	 * @param param
	 * @param basicVO
	 * @return List<CstStatVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/selectCstPeriPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstStatVO> selectCstPeriPrdList(CstStatVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstStatMapper.selectCstPeriPrdList");		
		basicVO.setParamClass(param);
		
		log.debug("selectCstPeriPrdList  param :: " + param.getAgenSeq());
		
		return basicService.basicSelectList(basicVO);
	}
	
	/**
	 * @Method Name : selectPuchList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JungsuKim
	 * @Method 설명 : 매입처 리스트
	 * @param param
	 * @param basicVO
	 * @return List<CstStatVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/selectPuchList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstStatVO> selectPuchList(CstStatVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstStatMapper.selectPuchList");		
		basicVO.setParamClass(param);
		
		log.debug("selectPuchList  param :: " + param.getAgenSeq());
		
		return basicService.basicSelectList(basicVO);
	}
	
	
	
	/**
	 * @Method Name : selectPopAreaList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JungsuKim
	 * @Method 설명 : 팝업 지역선택 리스트
	 * @param param
	 * @param basicVO
	 * @return List<CstStatVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/selectPopAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstStatVO> selectPopAreaList(CstStatVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstStatMapper.selectPopAreaList");		
		basicVO.setParamClass(param);		
		log.debug("selectPopAreaList  param :: " + param.getAgenSeq());
		
		return basicService.basicSelectList(basicVO);
	}
	
	
	/**
	 * @Method Name : selectPrdAreaList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JungsuKim
	 * @Method 설명 : 제품별 제품 리스트
	 * @param param
	 * @param basicVO
	 * @return List<CstStatVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/selectPrdAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstStatVO> selectPrdAreaList(CstStatVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstStatMapper.selectPrdAreaList");		
		basicVO.setParamClass(param);		
		log.debug("selectPrdAreaList  param :: " + param.getAgenSeq());
		
		return basicService.basicSelectList(basicVO);
	}
	
	/**
	 * @Method Name : selectPrdAreaDetailList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JungsuKim
	 * @Method 설명 : 제품별 애음자 리스트
	 * @param param
	 * @param basicVO
	 * @return List<CstStatVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/selectPrdAreaDetailList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstStatVO> selectPrdAreaDetailList(CstStatVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstStatMapper.selectPrdAreaDetailList");		
		basicVO.setParamClass(param);		
		log.debug("selectPrdAreaDetailList  param :: " + param.getAgenSeq());
		
		return basicService.basicSelectList(basicVO);
	}
	
	/**
	 * @Method Name : selectCstPeriAreaMapList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JungsuKim
	 * @Method 설명 : 애음자분포 지역별 리스트
	 * @param param
	 * @param basicVO
	 * @return List<CstStatVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/selectCstAreaMapList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstStatVO> selectCstPeriAreaMapList(CstStatVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstStatMapper.selectCstAreaMapList");		
		basicVO.setParamClass(param);		
		log.debug("selectCstPeriAreaMapList  param :: " + param.getAgenSeq());
		return basicService.basicSelectList(basicVO);
	}
	
	
	
	
	@RequestMapping(value="/cst/selectCstAreaMapDetailList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstStatVO> selectCstAreaMapDetailList(CstStatVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstStatMapper.selectCstAreaMapDetailList");		
		basicVO.setParamClass(param);		
		log.debug("selectCstAreaMapDetailList  param :: " + param.getAgenSeq());
		
		List<CstStatVO> list = basicService.basicSelectList(basicVO);
		
		return list;
	}

}
