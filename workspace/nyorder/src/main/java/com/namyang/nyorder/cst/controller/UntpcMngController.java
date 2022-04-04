package com.namyang.nyorder.cst.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.cst.service.UntpcMngService;
import com.namyang.nyorder.cst.vo.AgenAreaUntpcVO;
import com.namyang.nyorder.cst.vo.AgenAreaVO;
import com.namyang.nyorder.cst.vo.UntpcHisVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 
 * 파일명  : CstUntpcMngController.java
 * 작성자  : JIHUN
 * 작성일  : 2022. 1. 26.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 26.    JIHUN     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class UntpcMngController {
	
	@Autowired
	UntpcMngService cstUntpcMngService;
	
	/**
	 * @Method Name : untpcInfoMng
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : JIHUN
	 * @Method 설명 : 거래처/애음자 지역별 단가관리 페이지 이동
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/untpcInfoMng.do")
	public ModelAndView untpcInfoMng(ModelAndView mv) {
		mv.setViewName("cst/untpcInfoMng.view");
		return mv;
	}

	/**
	 * @Method Name : selectAreaList
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : JIHUN
	 * @Method 설명 : 지역 목록 조회
	 * @param params
	 * @return List<AgenAreaVO>
	 */
	@RequestMapping(value="/cst/selectAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenAreaVO> selectAreaList(AgenAreaUntpcVO param) {
		return cstUntpcMngService.selectAreaList(param);
	}

	/**
	 * @Method Name : selectUntpcList
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : JIHUN
	 * @Method 설명 : 거래처 지역별 제품목록 조회
	 * @param params
	 * @return List<AgenAreaUntpcVO>
	 */
	@RequestMapping(value="/cst/selectUntpcList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenAreaUntpcVO> selectUntpcList(AgenAreaUntpcVO param)  {
		return cstUntpcMngService.selectUntpcList(param);
	}
	
	/**
	 * @Method Name : saveAreaUntpcList
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : JIHUN
	 * @Method 설명 : 지역별 제품 단가 변경 예약
	 * @param param
	 * @return String
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/saveAreaUntpcList.do", method = RequestMethod.POST)
	public String saveAreaUntpcList(@RequestBody List<AgenAreaUntpcVO> param) throws Exception {
		cstUntpcMngService.saveAgenAreaUntpcList(param);
		return "cst/untpcInfoMng.view";
	}
	
	/**
	 * @Method Name : selectAgenPrdPopList
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : JIHUN
	 * @Method 설명 : 제품등록 팝업 제품 목록 조회
	 * @param param
	 * @return List<AgenAreaUntpcVO>
	 */
	@RequestMapping(value="/cst/selectAgenPrdPopList.do")
	@ResponseBody
	public List<AgenAreaUntpcVO> selectAgenPrdPopList(AgenAreaUntpcVO param) {
		return cstUntpcMngService.selectAgenPrdPopList(param);
	}

	/**
	 * @Method Name : selectUntpcHisPopList
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : JIHUN
	 * @Method 설명 : 단가변경 이력 내역 조회
	 * @param param
	 * @return List<UntpcHisVO>
	 */
	@RequestMapping(value="/cst/selectUntpcHisPopList.do")
	@ResponseBody
	public List<UntpcHisVO> selectUntpcHisPopList(UntpcHisVO param) {
		return cstUntpcMngService.selectUntpcHisPopList(param);
	}
	
	
	/**
	 * @Method Name : selectCstAreaUntpcList
	 * @작성일 : 2022. 2. 22.
	 * @작성자 : JIHUN
	 * @Method 설명 : 애음자 지역별 제품 목록 조회
	 * @param param
	 * @return List<AgenAreaUntpcVO>
	 */
	@RequestMapping(value="/cst/selectCstAreaUntpcList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenAreaUntpcVO> selectCstAreaUntpcList(AgenAreaUntpcVO param) {
		return cstUntpcMngService.selectCstAreaUntpcList(param);
	}

	/**
	 * @Method Name : deleteAbleCheck
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : JIHUN
	 * @Method 설명 : 삭제가능 여부 조회
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/cst/deleteAbleCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String deleteAbleCheck(AgenAreaUntpcVO param) {
		return cstUntpcMngService.deleteAbleCheck(param);
	}
}
