package com.namyang.nyorder.agn.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.agn.dao.OrdrRegMapper;
import com.namyang.nyorder.agn.dao.SchlMealOrdRegMapper;
import com.namyang.nyorder.agn.service.SchlMealOrdRegService;
import com.namyang.nyorder.agn.vo.OrdRegVO;
import com.namyang.nyorder.agn.vo.SchlMealOrdRegVO;
import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.PrdClsVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 학교급식주문등록
 * 파일명  : SchlMealOrdRegController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 2. 9.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class SchlMealOrdRegController {
	
	@Autowired
	private CommCodeService commCodeService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	@Autowired
	OrdrRegMapper ordrRegMapper;
	
	@Autowired
	SchlMealOrdRegMapper schlMealOrdRegMapper;
	
	@Autowired
	SchlMealOrdRegService schlMealOrdRegService;
	
	/**
	 * @Method Name : schlMealOrdReg
	 * @작성일 : 2022. 2. 9.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문 등록 페이지 이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/schlMealOrdReg.do")
	public ModelAndView schlMealOrdReg(HttpServletRequest request , ModelAndView mv , OrdRegVO param) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		mv.addObject("lclsList", commCodeService.selectPrdCls(new PrdClsVO()));
		mv.addObject("grfeCnt", ordrRegMapper.selectGrfeCnt(param));
		mv.setViewName("agn/schlMealOrdReg.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectSchlList
	 * @작성일 : 2022. 2. 9.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문등록 학교리스트 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectSchlList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectSchlList(SchlMealOrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return schlMealOrdRegService.selectSchlList(param);
	}
	
	/**
	 * @Method Name : selectSchlMealPrdList
	 * @작성일 : 2022. 2. 9.
	 * @작성자 : 윤이준
	 * @Method 설명 : 학교급식 주문등록 표준제품 리스트 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */ 
	@RequestMapping(value="/agn/selectSchlMealPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectSchlMealPrdList(@RequestBody SchlMealOrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return schlMealOrdRegService.selectSchlMealPrdList(param);
	}
	
}
