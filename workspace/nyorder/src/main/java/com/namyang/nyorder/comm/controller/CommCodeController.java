package com.namyang.nyorder.comm.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.PrdClsVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.util.SapRfcCall;
import com.sap.conn.jco.JCoException;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 공통 코드 관리 Controller
 * 파일명  : CommCodeController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 4.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class CommCodeController {
	@Autowired
	CommCodeService commCodeService;
	
	@Autowired
	SapRfcCall sapRfcCall;
	
	@Resource(name="userInfo")
	UserInfo userInfo;

	/**
	 * @Method Name : commCodeList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 공통 코드 설정 페이지 이동 
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/comm/commCodeList.do", method = RequestMethod.GET)
	public ModelAndView commCodeList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("comm/commCodeList.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectCommCodeList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 공통 코드 리스트 조회
	 * @param param
	 * @return List<CommCodeVO>
	 */
	@RequestMapping(value="/comm/selectCommCodeList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CommCodeVO> selectCommCodeList(CommCodeVO param) {
		return commCodeService.selectCommCodeList(param);
	}
	
	/**
	 * @Method Name : saveCommCodeList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 공통 코드 리스트 저장
	 * @param vo
	 * @return String
	 */
	@RequestMapping(value="/comm/saveCommCodeList.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveCommCodeList(@RequestBody List<CommCodeVO> vo) {
		return commCodeService.saveCommCodeList(vo);
	}
	
	/**
	 * @Method Name : selectPrdCls
	 * @작성일 : 2022. 01. 20.
	 * @작성자 : YESOL
	 * @Method 설명 : 제품 분류 조회
	 * @param param
	 * @return List<CommCodeVO>
	 */
	@RequestMapping(value="/comm/selectPrdCls.do", method = RequestMethod.POST)
	@ResponseBody
	public List<PrdClsVO> selectPrdCls(PrdClsVO param) {
		return commCodeService.selectPrdCls(param);
	}
	
	/**
	 * @Method Name : getCdtlInfo
	 * @작성일 : 2022. 01. 20.
	 * @작성자 : YESOL
	 * @Method 설명 : 여신 조회(RFC)
	 * @param param
	 * @return List<CommCodeVO>
	 */
	@RequestMapping(value="/comm/getCdtlInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getCdtlInfo() {
	
		HashMap<String, Object> ifParam = new HashMap<String, Object>();
		
		ifParam.put("IF_NAME", "ZFC_SD_IF_CREDIT_SEND");
		ifParam.put("I_BSARK", "Z002");
		ifParam.put("I_KUNNR", userInfo.getAgenCd());
						
		HashMap<String, Object> ifResult = new HashMap<String, Object>();
		try {
			ifResult = sapRfcCall.getCreditSend(ifParam);
		} catch (JCoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ifResult;
	}
}
