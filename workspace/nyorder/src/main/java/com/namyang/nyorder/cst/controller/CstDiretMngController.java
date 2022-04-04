package com.namyang.nyorder.cst.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.config.error.exception.BusinessException;
import com.namyang.nyorder.cst.service.CstDiretMngService;
import com.namyang.nyorder.cst.vo.CstDiretHisVO;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 이사고객 관리
 * 파일명  : CstDiretMngController.java
 * 작성자  : JIHUN
 * 작성일  : 2022. 3. 16.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 16.    	  JIHUN     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class CstDiretMngController {
	
	@Autowired
	private CstDiretMngService cstDiretMngService;

	/**
	 * @Method Name : cstDiretMng
	 * @작성일 : 2022. 3. 16.
	 * @작성자 : JIHUN
	 * @Method 설명 :  애음자관리 - 이사고객 관리
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/diretMng.do")
	public ModelAndView cstDiretMng(ModelAndView mv) {
		mv.setViewName("cst/cstDiretMng.view");
		return mv;
	}

	/**
	 * @Method Name : diretHisList
	 * @작성일 : 2022. 3. 16.
	 * @작성자 : JIHUN
	 * @Method 설명 : 이사고객관리 내역 조회
	 * @param param
	 * @return List<CstDiretHisVO>
	 */
	@RequestMapping(value="/cst/diretHisList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstDiretHisVO> diretHisList(CstDiretHisVO param) {
		return cstDiretMngService.selectCstDiretHis(param);
	}

	/**
	 * @Method Name : diretDtl
	 * @작성일 : 2022. 3. 23.
	 * @작성자 : JIHUN
	 * @Method 설명 : 애음자 이사내역 상세 조회
	 * @param param
	 * @return CstDiretHisVO
	 */
	@RequestMapping(value="/cst/diretDtl.do", method = RequestMethod.POST)
	@ResponseBody
	public CstDiretHisVO diretDtl(CstDiretHisVO param) {
		return cstDiretMngService.selectCstDiretDtl(param);
	}

	/**
	 * @Method Name : searchAftAgenAreaList
	 * @작성일 : 2022. 3. 23.
	 * @작성자 : JIHUN
	 * @Method 설명 : 변경후 대리점 지역목록 검색
	 * @param param
	 * @return List<CstDiretHisVO>
	 */
	@RequestMapping(value="/cst/searchAftAgenAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstDiretHisVO> searchAftAgenAreaList(CstDiretHisVO param) {
		return cstDiretMngService.searchAftAgenAreaList(param);
	}

	/**
	 * @Method Name : updateCstDiret
	 * @작성일 : 2022. 3. 23.
	 * @작성자 : JIHUN
	 * @Method 설명 : 이사내역 저장
	 * @param param
	 * @return
	 * @throws BusinessException int
	 */
	@RequestMapping(value="/cst/updateCstDiret.do", method = RequestMethod.POST)
	@ResponseBody
	public int updateCstDiret(@RequestBody CstDiretHisVO param) throws BusinessException {
		return cstDiretMngService.updateCstDiret(param);
	}
}
