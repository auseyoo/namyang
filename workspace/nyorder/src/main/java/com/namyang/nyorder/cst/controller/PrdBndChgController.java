package com.namyang.nyorder.cst.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.cst.dao.PrdBndChgMapper;
import com.namyang.nyorder.cst.service.PrdBndChgService;
import com.namyang.nyorder.cst.service.UntpcMngService;
import com.namyang.nyorder.cst.vo.AgenAreaPrdBndChgVO;
import com.namyang.nyorder.cst.vo.AgenAreaUntpcVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자관리 - 제품 일괄 변경
 * 파일명  : PrdBndChgController.java
 * 작성자  : GAIN
 * 작성일  : 2022. 2. 8.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    GAIN     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
@RequestMapping("/cst")
public class PrdBndChgController {
	

	 @Autowired 
	 PrdBndChgService prdBndChgService;
	 
	 @Autowired
	 UntpcMngService untpcMngService;
	 
	/**
	 * @Method Name : prdBndChg
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 제품 일괄 변경 페이지
	 * @return ModelAndView
	 */
	@RequestMapping(value="/prdBndChg.do")
	public ModelAndView prdBndChg(ModelAndView mv) {
		mv.setViewName("cst/prdBndChg.view");
		return mv;
	}
	
	/**
	 * @Method Name : searchBndChgPrdPopList
	 * @작성일 : 2022. 3. 4.
	 * @작성자 : JIHUN
	 * @Method 설명 : 제품 일괄변경 제품 팝업 목록 조회 
	 * @param param
	 * @return List<AgenAreaUntpcVO>
	 */
	@RequestMapping(value="/searchBndChgPrdPopList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenAreaUntpcVO> searchBndChgPrdPopList(AgenAreaUntpcVO param) {
		return prdBndChgService.searchAgenBngChgPrdPopList(param);
	}

	/**
	 * @Method Name : searchPrdAreaUntpcList
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : JIHUN
	 * @Method 설명 : 제품 지역별 판매원/애음자 단가 조회
	 * @param param
	 * @return List<AgenAreaUntpcVO>
	 */
	@RequestMapping(value="/searchPrdAreaUntpcList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenAreaUntpcVO> searchPrdAreaUntpcList(AgenAreaUntpcVO param) {
		return prdBndChgService.searchPrdAreaUntpcList(param);
	}
	
	/**
	 * @Method Name : selectAgenAreaPrdBndChgHis
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : JIHUN
	 * @Method 설명 : 애음자 관리 제품 일괄 변경 이력조회 
	 * @param param
	 * @return List<AgenAreaPrdBndChgVO>
	 */
	@RequestMapping(value="/selectAgenAreaPrdBndChgHis.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenAreaPrdBndChgVO> selectAgenAreaPrdBndChgHis(AgenAreaPrdBndChgVO param) {
		return prdBndChgService.selectAgenAreaPrdBndChgHis(param);
	}
	
}
