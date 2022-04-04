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
import com.namyang.nyorder.sel.vo.EmplSaleSttsVO;
import com.namyang.nyorder.sel.vo.PrdSaleSttsVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 담당자별 판매 현황
 * 파일명  : EmplSaleSttsController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 2. 10.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 10.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class EmplSaleSttsController {
	@Autowired
	BasicService basicService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : emplSaleStts
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : YESOL
	 * @Method 설명 :  담당자별 판매 현황 페이지 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/sel/emplSaleStts.do", method = RequestMethod.GET)
	public ModelAndView emplSaleStts(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sel/emplSaleStts.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectEmplList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : YESOL
	 * @Method 설명 : 담당자별 판매 현황 - 담당 조회
	 * @param param
	 * @param request
	 * @return List<PrdSaleSttsVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/sel/selectEmplList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<PrdSaleSttsVO> selectEmplList(EmplSaleSttsVO param, HttpServletRequest request) throws Exception {
		param.setAgenSeq(userInfo.getAgenSeq());
		
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.sel.dao.EmplSaleSttsMapper.selectEmplList");		
		basicVO.setParamClass(param);	
		
		return basicService.basicSelectList(basicVO);
	}
	
	/**
	 * @Method Name : selectEmplSaleSttsList
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : YESOL
	 * @Method 설명 : 
	 * @param param
	 * @param request
	 * @return List<PrdSaleSttsVO>
	 * @throws Exception 
	 */
	@RequestMapping(value="/sel/selectEmplSaleSttsList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<PrdSaleSttsVO> selectEmplSaleSttsList(EmplSaleSttsVO param, HttpServletRequest request) throws Exception {
		param.setAgenSeq(userInfo.getAgenSeq());
		
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.sel.dao.EmplSaleSttsMapper.selectEmplSaleSttsList");		
		basicVO.setParamClass(param);	
		
		return basicService.basicSelectList(basicVO);
	}
}
