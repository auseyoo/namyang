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
import com.namyang.nyorder.agn.dao.SpclOrdRegMapper;
import com.namyang.nyorder.agn.service.SpclOrdRegService;
import com.namyang.nyorder.agn.vo.OrdRegVO;
import com.namyang.nyorder.agn.vo.SpclOrdRegVO;
import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 특수처 주문등록
 * 파일명  : SpclOrdRegController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 22.
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
public class SpclOrdRegController {
	
	@Autowired
	private CommCodeService commCodeService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	@Autowired
	OrdrRegMapper ordrRegMapper;
	
	@Autowired
	SpclOrdRegService spclOrdRegService;
	
	@Autowired
	SpclOrdRegMapper spclOrdRegMapper;
	
	/**
	 * @Method Name : spclOrdReg
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 윤이준
	 * @Method 설명 : 특수처 주문 등록 페이지 이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/spclOrdReg.do")
	public ModelAndView spclOrdReg(HttpServletRequest request , ModelAndView mv , OrdRegVO param) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		param.setEmplSeq( userInfo.getEmplSeq() );
		mv.addObject("grfeCnt", ordrRegMapper.selectGrfeCnt(param));
		mv.addObject("clsTm", ordrRegMapper.selectAgenClsTmInfo(param));
		mv.setViewName("agn/spclOrdReg.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectSpclList
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 윤이준
	 * @Method 설명 : 특수처 주문등록 학교리스트 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/agn/selectSpclList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectSpclList(SpclOrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		param.setEmplSeq( userInfo.getEmplSeq() );
		return spclOrdRegService.selectSpclList(param);
	}
	
	/**
	 * @Method Name : selectSpclStdPrdList
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 윤이준
	 * @Method 설명 : 특수처 주문등록 표준제품 리스트 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */ 
	@RequestMapping(value="/agn/selectSpclStdPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectSpclStdPrdList(@RequestBody SpclOrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return spclOrdRegService.selectSpclStdPrdList(param);
	}
	
}
