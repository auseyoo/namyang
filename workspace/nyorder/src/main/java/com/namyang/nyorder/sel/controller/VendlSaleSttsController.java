package com.namyang.nyorder.sel.controller;

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
import com.namyang.nyorder.sel.vo.PrdSaleSttsVO;
import com.namyang.nyorder.sel.vo.VendSaleSttsVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처별 판매 현황
 * 파일명  : VendlSaleSttsController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 2. 16.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 16.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class VendlSaleSttsController {
	@Autowired
	BasicService basicService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : vendSaleStts
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : YESOL
	 * @Method 설명 :  거래처별 판매 현황 페이지 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/sel/vendSaleStts.do", method = RequestMethod.GET)
	public ModelAndView vendSaleStts(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sel/vendSaleStts.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectVendList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : YESOL
	 * @Method 설명 : 거래처별 판매 현황 - 담당 조회
	 * @param param
	 * @param request
	 * @return List<PrdSaleSttsVO>
	 */
	@RequestMapping(value="/sel/selectVendList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<PrdSaleSttsVO> selectVendList(VendSaleSttsVO param, HttpServletRequest request) throws Exception {
		param.setAgenSeq(userInfo.getAgenSeq());
		
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.sel.dao.VendSaleSttsMapper.selectVendList");		
		basicVO.setParamClass(param);	
		
		return basicService.basicSelectList(basicVO);
	}
	
	/**
	 * @Method Name : selectVendSaleSttsList
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : YESOL
	 * @Method 설명 : 
	 * @param param
	 * @param request
	 * @return List<PrdSaleSttsVO>
	 */
	@RequestMapping(value="/sel/selectVendSaleSttsList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<PrdSaleSttsVO> selectVendSaleSttsList(VendSaleSttsVO param, HttpServletRequest request) throws Exception {
		param.setAgenSeq(userInfo.getAgenSeq());
		
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.sel.dao.VendSaleSttsMapper.selectVendSaleSttsList");		
		basicVO.setParamClass(param);	
		
		return basicService.basicSelectList(basicVO);
	}
}
