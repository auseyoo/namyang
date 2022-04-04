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
import com.namyang.nyorder.sel.vo.MnthSaleSttsVO;
import com.namyang.nyorder.sel.vo.PrdSaleSttsVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 제품별 판매 현황
 * 파일명  : PrdSaleSttsController.java
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
public class PrdSaleSttsController {
	@Autowired
	BasicService basicService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	/**
	 * @Method Name : mnthSaleStts
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : YESOL
	 * @Method 설명 : 제품별 판매 현황 페이지 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/sel/prdSaleStts.do", method = RequestMethod.GET)
	public ModelAndView prdSaleStts(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sel/prdSaleStts.view");
		return mv;
	}
	
	@RequestMapping(value="/sel/selectPrdSaleSttsList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<PrdSaleSttsVO> selectPrdSaleSttsList(PrdSaleSttsVO param, HttpServletRequest request) throws Exception {
		param.setAgenSeq(userInfo.getAgenSeq());
		
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.sel.dao.PrdSaleSttsMapper.selectPrdSaleSttsList");		
		basicVO.setParamClass(param);	
		
		return basicService.basicSelectList(basicVO);
	}
}
