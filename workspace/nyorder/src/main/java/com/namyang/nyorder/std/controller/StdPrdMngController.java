package com.namyang.nyorder.std.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.PrdClsVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.std.service.StdPrdMngService;
import com.namyang.nyorder.std.vo.StdPrdBndChgVO;
import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;
import com.namyang.nyorder.std.vo.StdPrdMngVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준벙보관리 - 표준 제품 관리 Controller
 * 파일명  : StdPrdMngController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 11.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class StdPrdMngController {

	@Autowired
	private StdPrdMngService stdPrdMngService;
	
	@Autowired
	private CommCodeService commCodeService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : stdPrdMng
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : YESOL
	 * @Method 설명 : 기준벙보관리 - 표준 제품 관리 페이지이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/std/stdPrdMng.do", method = RequestMethod.GET)
	public ModelAndView stdPrdMng(StdPrdMngVO param, HttpServletRequest request, ModelAndView mv) {
		mv.setViewName("std/stdPrdMng.view");
		mv.addObject("lclsList", commCodeService.selectPrdCls(new PrdClsVO()));
		return mv;
	}
	
	
	/**
	 * @Method Name : selectPrdMstList
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 조회 (SAP 기준)
	 * @param param
	 * @return List<CommCodeVO>
	 */
	@RequestMapping(value="/std/selectPrdMstList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<StdPrdMngVO> selectPrdMstList(StdPrdMngVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		log.debug("selectStdPrdMngList  userInfo ::" + userInfo.getAgenSeq());
		return stdPrdMngService.selectPrdMstList(param);
	}
	
	/**
	 * @Method Name : selectStdPrdMngList
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 조회 (대리점 기준)
	 * @param param
	 * @return List<CommCodeVO>
	 */
	@RequestMapping(value="/std/selectStdPrdMngList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<StdPrdMngVO> selectStdPrdMngList(StdPrdMngVO param, HttpServletRequest request) {
		log.debug("selectStdPrdMngList  userInfo ::" + userInfo.getAgenSeq());
		return stdPrdMngService.selectStdPrdMngList(param);
	}

	/**
	 * @Method Name : selectStdPrdMngList
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 상세 조회 
	 * @param param
	 * @return List<CommCodeVO>
	 */
	@RequestMapping(value="/std/selectStdPrdMngDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public StdPrdMngDetailVO selectStdPrdMngDetail(@RequestBody StdPrdMngDetailVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return stdPrdMngService.selectStdPrdMngDetail(param);
	}
	
	/**
	 * @Method Name : saveStdPrdDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/std/saveStdPrdDetail.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveStdPrdDetail(StdPrdMngDetailVO vo) throws Exception{
		vo.setAgenSeq(userInfo.getAgenSeq());
		vo.setEmplSeq(userInfo.getEmplSeq());
		return stdPrdMngService.saveStdPrdDetail(vo);
	}
	
	/**
	 * @Method Name : delStdPrdDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 삭제
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/std/delStdPrdDetail.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String delStdPrdDetail(StdPrdMngDetailVO vo) throws Exception{
		vo.setAgenSeq(userInfo.getAgenSeq());
		vo.setEmplSeq(userInfo.getEmplSeq());
		return stdPrdMngService.delStdPrdDetail(vo);
	}
	
	/**
	 * @Method Name : saveStdPrdOrdr
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 순서 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/std/saveStdPrdOrdr.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveStdPrdOrdr(@RequestBody List<StdPrdMngDetailVO> list) throws Exception{
		return stdPrdMngService.saveStdPrdOrdr(list);
	}
	
	/**
	 * @Method Name : stdPrdBndChg
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준제품 일괄 변경 - 페이지 이동
	 * @param param
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/std/stdPrdBndChg.do", method = RequestMethod.GET)
	public ModelAndView stdPrdBndChg(StdPrdMngVO param, HttpServletRequest request, ModelAndView mv) {
		mv.addObject("lclsList", commCodeService.selectPrdCls(new PrdClsVO()));
		mv.setViewName("std/stdPrdBndChg.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectStdPrdBndChgList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 일괄 변경 - 리스트 조회
	 * @param param
	 * @param request
	 * @return List<StdPrdBndChgVO>
	 */
	@RequestMapping(value="/std/selectStdPrdBndChgList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<StdPrdBndChgVO> selectStdPrdBndChgList(StdPrdBndChgVO param, HttpServletRequest request) {
		return stdPrdMngService.selectStdPrdBndChgList(param);
	}
	
	/**
	 * @Method Name : saveStdPrdOrdr
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 일괄변경 - 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/std/saveStdPrdBndChgList.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveStdPrdBndChgList(@RequestBody List<StdPrdBndChgVO> list) throws Exception{
		return stdPrdMngService.saveStdPrdBndChgList(list);
	}
	
	/**
	 * @Method Name : addStdPrdPop
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 등록 팝업
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/std/addStdPrdPop.do", method = RequestMethod.GET)
	public ModelAndView addStdPrdPop(StdPrdBndChgVO param, ModelAndView mv ) throws Exception{
		mv.addObject("lclsList", commCodeService.selectPrdCls(new PrdClsVO()));
		mv.setViewName("std/addStdPrdPop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : editStdPrdOrdrPop
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 순서 변경 팝업
	 * @param param
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/std/editStdPrdOrdrPop.do", method = RequestMethod.GET)
	public ModelAndView editStdPrdOrdrPop(StdPrdBndChgVO param, ModelAndView mv ) throws Exception{
		mv.setViewName("std/editStdPrdOrdrPop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : agenStdPrdSearchPop
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 조회 팝업 (대리점 기준)
	 * @param param
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/std/agenStdPrdSearchPop.do", method = RequestMethod.GET)
	public ModelAndView agenStdPrdSearchPop(StdPrdBndChgVO param, ModelAndView mv ) throws Exception{
		mv.setViewName("std/agenStdPrdSearchPop.jsp");
		return mv;
	}
	/**
	 * @Method Name : stdPrdSearchPop
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 표준 제품 조회 팝업 (남양 제품)
	 * @param param
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/std/stdPrdSearchPop.do", method = RequestMethod.GET)
	public ModelAndView stdPrdSearchPop(StdPrdBndChgVO param, ModelAndView mv ) throws Exception{
		mv.addObject("lclsList", commCodeService.selectPrdCls(new PrdClsVO()));
		mv.setViewName("std/stdPrdSearchPop.jsp");
		return mv;
	}
	
}
