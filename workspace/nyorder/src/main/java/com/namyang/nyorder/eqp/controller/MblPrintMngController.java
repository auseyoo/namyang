package com.namyang.nyorder.eqp.controller;

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
import com.namyang.nyorder.eqp.vo.AgenEqpVO;
import com.namyang.nyorder.sel.vo.EmplSaleSttsVO;
import com.namyang.nyorder.util.StringUtil;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 장비관리 > 모바일장비 관리 > 모바일프린터 관리 [UI-PEQU-0101] 
 * 파일명  : MblPrintMngController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 3. 7.
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 7.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class MblPrintMngController {
	@Autowired
	BasicService basicService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : mblPrintMng
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 모바일 프린터 관리 - 페이지 이동
	 * @param request
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/eqp/mblPrintMng.do", method = RequestMethod.GET)
	public ModelAndView mblPrintMng(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("eqp/mblPrintMng.view");
		
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.sel.dao.EmplSaleSttsMapper.selectEmplList");		
		basicVO.setParamClass(new EmplSaleSttsVO() {{
			setAgenSeq(userInfo.getAgenSeq());
		}});	
		mv.addObject("emplList",basicService.basicSelectList(basicVO)); 
		return mv;
	}
	
	/**
	 * @Method Name : selectMblPrintMngList
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 모바일 프린터 관리 - 장비 리스트 조회
	 * @param param
	 * @param request
	 * @return List<AgenEqpVO>
	 */
	@RequestMapping(value="/eqp/selectMblPrintMngList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenEqpVO> selectMblPrintMngList(AgenEqpVO param, HttpServletRequest request) throws Exception {
		param.setAgenSeq(userInfo.getAgenSeq());
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.eqp.dao.MblPrintMngMapper.selectMblPrintMngList");		
		basicVO.setParamClass(param);	
		return basicService.basicSelectList(basicVO);
	}
	

	@RequestMapping(value="/eqp/updateMblPrintMng.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String updateMblPrintMng(AgenEqpVO vo) throws Exception{
		vo.setAgenSeq(userInfo.getAgenSeq());
		BasicVO basicVO = new BasicVO();
		
		if(StringUtil.isEmpty(vo.getAgenEqpSeq())){
			basicVO.setQueryId("com.namyang.nyorder.eqp.dao.MblPrintMngMapper.addMblPrintMng");
			basicVO.setParamClass(vo);
			basicService.basicInsert(basicVO);
		}else {
			basicVO.setQueryId("com.namyang.nyorder.eqp.dao.MblPrintMngMapper.updateMblPrintMng");
			basicVO.setParamClass(vo);
			basicService.basicUpdate(basicVO);
		}
		
	
		return "저장완료";
	}
	
}
