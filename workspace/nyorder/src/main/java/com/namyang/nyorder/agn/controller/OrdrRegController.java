package com.namyang.nyorder.agn.controller;

import java.util.HashMap;
import java.util.List;
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
import com.namyang.nyorder.agn.service.OrdrRegService;
import com.namyang.nyorder.agn.vo.OrdRegVO;
import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.PrdClsVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.std.service.StdPrdMngService;
import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 대리점관리 - 주문 등록 Controller
 * 파일명  : OrdrRegController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 7.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class OrdrRegController {
	
	@Autowired
	OrdrRegService ordrRegService;
	
	@Autowired
	private CommCodeService commCodeService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	@Autowired
	OrdrRegMapper ordrRegMapper;
	
	@Autowired
	private StdPrdMngService stdPrdMngService;
	
	/**
	 * @Method Name : ordrReg
	 * @작성일 : 2022. 1. 7.
	 * @작성자 : YESOL
	 * @Method 설명 : 주문 등록 페이지 이동(방판)
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/ordrReg.do", method = RequestMethod.GET)
	public ModelAndView ordrReg(HttpServletRequest request , ModelAndView mv , OrdRegVO param) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		mv.addObject("grfeCnt", ordrRegMapper.selectGrfeCnt(param));
		mv.setViewName("agn/ordrReg.view");
		return mv;
	}
	
	/**
	 * @Method Name : mkslOrdReg
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문 등록 페이지 이동(시판)
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/mkslOrdReg.do", method = RequestMethod.GET)
	public ModelAndView mkslOrdReg(HttpServletRequest request , ModelAndView mv , OrdRegVO param) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		mv.addObject("grfeCnt", ordrRegMapper.selectGrfeCnt(param));
		mv.setViewName("agn/mkslOrdReg.view");
		return mv;
	}
	
	/**
	 * @Method Name : tmprtOrdrReg
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문 등록 페이지 이동(상온)
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/tmprtOrdrReg.do", method = RequestMethod.GET)
	public ModelAndView tmprtOrdrReg(HttpServletRequest request , ModelAndView mv , OrdRegVO param) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		mv.addObject("grfeCnt", ordrRegMapper.selectGrfeCnt(param));
		mv.addObject("clsTm", ordrRegMapper.selectAgenClsTmInfo(param));
		mv.setViewName("agn/tmprtOrdrReg.view");
		return mv;
	}
	
	/**
	 * @Method Name : stdPrdPop
	 * @작성일 : 2022. 3. 4.
	 * @작성자 : 윤이준
	 * @Method 설명 : 남양제품 팝업
	 * @param param
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/stdPrdPop.do")
	public ModelAndView stdPrdPop(ModelAndView mv , OrdRegVO param) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		mv.setViewName("agn/stdPrdPop.jsp");
		mv.addObject("lclsList", commCodeService.selectPrdCls(new PrdClsVO()));
		return mv;
	}
	
	/**
	 * @Method Name : cdtlInfoPop
	 * @작성일 : 2022. 3. 4.
	 * @작성자 : 윤이준
	 * @Method 설명 : 여신 상세보기 팝업
	 * @param param
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/agn/cdtlInfoPop.do")
	public ModelAndView cdtlInfoPop(ModelAndView mv , OrdRegVO param) {
		mv.setViewName("agn/cdtlInfoPop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : selectSdtPrdList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : 윤이준
	 * @Method 설명 : 표준제품 리스트 조회(방판)
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectSdtPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectSdtPrdList(OrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return ordrRegService.selectSdtPrdList(param);
	}
	
	/**
	 * @Method Name : selectMkslPrdList
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : 윤이준
	 * @Method 설명 : 표준제품 리스트 조회(시판)
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectMkslPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectMkslPrdList(OrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return ordrRegService.selectMkslPrdList(param);
	}
	
	/**
	 * @Method Name : selectTmprtPrdList
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 윤이준
	 * @Method 설명 : 표준제품 리스트 조회(상온)
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/agn/selectTmprtPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectTmprtPrdList(OrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		return ordrRegService.selectTmprtPrdList(param);
	}
	
	/**
	 * @Method Name : saveOrdReg
	 * @작성일 : 2022. 1. 27.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문 등록
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/agn/saveOrdReg.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveOrdReg(@RequestBody List<OrdRegVO> list) throws Exception {
		return ordrRegService.saveOrdRegList(list);
	}
	
	/**
	 * @Method Name : selectPrdMstSapList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : 윤이준
	 * @Method 설명 : 표준 제품 조회 (SAP 기준)
	 * @param param
	 * @return List<CommCodeVO>
	 */
	@RequestMapping(value="/agn/selectPrdMstSapList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<OrdRegVO> selectPrdMstList(OrdRegVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return ordrRegService.selectPrdMstSapList(param);
	}
	
	/**
	 * @Method Name : saveStdPrdDetail
	 * @작성일 : 2022. 2. 08.
	 * @작성자 : 윤이준
	 * @Method 설명 : 표준 제품 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/agn/saveStdPrdDetail.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveStdPrdDetail(StdPrdMngDetailVO vo) throws Exception{
		vo.setAgenSeq(userInfo.getAgenSeq());
		vo.setEmplSeq(userInfo.getEmplSeq());
		return stdPrdMngService.saveStdPrdDetail(vo);
	}
	
	/**
	 * @Method Name : selectOrderCnt
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : 윤이준
	 * @Method 설명 : 주문여부 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/agn/selectOrderCnt.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectOrderCnt(@RequestBody OrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("orderCnt", ordrRegMapper.selectOrderCnt( param ) );
		return result;
	}
	
	/**
	 * @Method Name : selectGrfrOrdCnt
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 총무주문 건수
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/agn/selectGrfrOrdCnt.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectGrfrOrdCnt(@RequestBody OrdRegVO param , HttpServletRequest request) {
		param.setAgenSeq( userInfo.getAgenSeq() );
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("grfrOrdCnt", ordrRegMapper.selectGrfrOrdCnt( param ) );
		return result;
	}
}
