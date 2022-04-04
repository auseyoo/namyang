package com.namyang.nyorder.cst.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.BasicService;
import com.namyang.nyorder.comm.vo.BasicVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.cst.service.DlvMngService;
import com.namyang.nyorder.cst.vo.CstDlvNtcVO;
import com.namyang.nyorder.cst.vo.CstPrdDlvyVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자관리 - 배달 관리
 * 파일명  : DlvMngController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 28.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 28.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class DlvMngController {
	
	@Autowired
	private DlvMngService dlvMngService;
	
	@Autowired
	BasicService basicService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : dlvMng
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 관리 - 페이지 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/cst/dlvMng.do", method = RequestMethod.GET)
	public ModelAndView dlvMng(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("cst/dlvMng.view");
		return mv;
	}
	
	/**
	 * @Method Name : printDlvMapPop
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 관리 - 페이지 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/cst/printDlvMapPop.pop")
	public ModelAndView printDlvMapPop(HttpServletRequest request, CstPrdDlvyVO param,  ModelAndView mv) throws Exception {
		mv.setViewName("cst/printDlvMapPop.pop");
		mv.addObject("param", param);
		return mv;
	}
	/**
	 * @Method Name : receiptPrintPop
	 * @작성일 : 2022. 3. 30.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 관리 - 출고증 인쇄 팝업 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/cst/receiptPrintPop.pop")
	public ModelAndView receiptPrintPop(HttpServletRequest request, CstPrdDlvyVO param,  ModelAndView mv) throws Exception {
		mv.setViewName("cst/receiptPrintPop.popBlank");
		if(StringUtils.equals(param.getBlankYn(), "N")) {
			mv.addObject("prdList" , dlvMngService.selectDailDlvDetailList(param));
		}
		
		if(StringUtils.equals(param.getIncNtcYn(), "Y")) {
			mv.addObject("ntcList" , dlvMngService.selectCstDlvNtcList(new CstDlvNtcVO() {{
				setAgenSeq(param.getAgenSeq());
				setAreaSeq(param.getAreaSeq());
				setSrcDate(param.getSrcDate());
			}}));
		}
		
		
		mv.addObject("param", param);
		return mv;
	}
	
	
	/**
	 * @Method Name : dailyDlvPrintPop
	 * @작성일 : 2022. 3. 29.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 관리 - 일일배달명단 인쇄 팝업 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/cst/dailyDlvPrintPop.pop", method = RequestMethod.POST)
	public ModelAndView dailyDlvPrintPop(HttpServletRequest request, CstPrdDlvyVO param,  ModelAndView mv) throws Exception {
		mv.setViewName("cst/dailyDlvPrintPop.popBlank");
		
		mv.addObject("dlvList" , dlvMngService.selectDailDlvCstDetailList(param)); 
		mv.addObject("prdList" , dlvMngService.selectDailDlvDetailList(param)); 
		
		mv.addObject("param" , param); 
		return mv;
	}
	
	
	/**
	 * @Method Name : selectOrdDlvList
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 지역 조회
	 * @param param
	 * @return List<OrdDlvVO>
	 */
	@RequestMapping(value="/cst/selectDailDlvAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstPrdDlvyVO> selectDailDlvAreaList(CstPrdDlvyVO param) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return dlvMngService.selectDailDlvAreaList(param);
	}
	
	/**
	 * @Method Name : selectDailDlvDetailList
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 상품 조회
	 * @param param
	 * @param request
	 * @return List<CstPrdDlvyVO>
	 */
	@RequestMapping(value="/cst/selectDailDlvDetailList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstPrdDlvyVO> selectDailDlvDetailList(@RequestBody CstPrdDlvyVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return dlvMngService.selectDailDlvDetailList(param);
	}

	/**
	 * @Method Name : selectDailDlvCstDetailList
	 * @작성일 : 2022. 2. 9.
	 * @작성자 : YESOL
	 * @Method 설명 :	 배달 고객 조회 
	 * @param param
	 * @param request
	 * @return List<CstPrdDlvyVO>
	 */
	@RequestMapping(value="/cst/selectDailDlvCstDetailList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstPrdDlvyVO> selectDailDlvCstDetailList(@RequestBody CstPrdDlvyVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return dlvMngService.selectDailDlvCstDetailList(param);
	}
	
	/**
	 * @Method Name : selectDlvAreaList
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 지역 리스트 조회 (SELECT BOX)
	 * @param param
	 * @return List<OrdDlvVO>
	 */
	@RequestMapping(value="/cst/selectDlvAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstPrdDlvyVO> selectDlvAreaList(CstPrdDlvyVO param) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return dlvMngService.selectDlvAreaList(param);
	}
	
	/**
	 * @Method Name : selectDlvCstList
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 고객 리스트 조회 (SELECT BOX)
	 * @param param
	 * @return List<OrdDlvVO>
	 */
	@RequestMapping(value="/cst/selectDlvCstList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstPrdDlvyVO> selectDlvCstList(@RequestBody CstPrdDlvyVO param) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return dlvMngService.selectDlvCstList(param);
	}
	
	
	/**
	 * @Method Name : selectOrdDlvList
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 전달사항 리스트 조회
	 * @param param
	 * @return List<OrdDlvVO>
	 */
	@RequestMapping(value="/cst/selectCstDlvNtcList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstDlvNtcVO> selectCstDlvNtcList(CstDlvNtcVO param) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return dlvMngService.selectCstDlvNtcList(param);
	}
	
	
	/**
	 * @Method Name : addCstDlvNtc
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 전달사항 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/cst/addCstDlvNtc.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String addCstDlvNtc(CstDlvNtcVO vo) throws Exception{
		vo.setAgenSeq(userInfo.getAgenSeq());
		dlvMngService.addCstDlvNtc(vo);
		return "저장되었습니다.";
	}
	
	/**
	 * @Method Name : rmvCstDlvNtc
	 * @작성일 : 2022. 2. 9.
	 * @작성자 : YESOL
	 * @Method 설명 : 배달 전달 사항 삭제
	 * @param list
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/cst/rmvCstDlvNtc.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String rmvCstDlvNtc(@RequestBody List<CstDlvNtcVO> list) throws Exception{
		return dlvMngService.rmvCstDlvNtc(list);
	}
	
	
	/**
	 * @Method Name : saveAreaDlvOrdr
	 * @작성일 : 2022. 2. 9.
	 * @작성자 : YESOL
	 * @Method 설명 : 지역 순서 변경
	 * @param list
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/cst/saveAreaDlvOrdr.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveAreaDlvOrdr(@RequestBody List<CstPrdDlvyVO> list) throws Exception{
		return dlvMngService.saveAreaDlvOrdr(list);
	}
	/**
	 * @Method Name : saveDlvCstDtl
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : YESOL
	 * @Method 설명 : 고객 배송 정보 수정
	 * @param list
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/cst/saveDlvCstDtl.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveDlvCstDtl(@RequestBody List<CstPrdDlvyVO> list) throws Exception{
		return dlvMngService.saveDlvCstDtl(list);
	}
	
	@RequestMapping(value="/cst/saveDlvCstAddrLalo.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveDlvCstAddrLalo(@RequestBody CstPrdDlvyVO vo) throws Exception{
		vo.setAgenSeq(userInfo.getAgenSeq());
		vo.setEmplSeq(userInfo.getEmplSeq());
		
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.DlvMngMapper.updateDlvCstAddrLalo");
		basicVO.setParamClass(vo);	
		basicService.basicUpdate(basicVO);
		return "저장완료";
	}
	
	@RequestMapping(value="/cst/dlvMapPop.do", method = RequestMethod.GET)
	public ModelAndView dlvMapPop(@ModelAttribute("params") CstPrdDlvyVO param, ModelAndView mv ) throws Exception{
		mv.setViewName("cst/dlvMapPop.jsp");
		return mv;
	}
	
}
