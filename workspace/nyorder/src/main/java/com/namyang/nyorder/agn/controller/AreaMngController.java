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

import com.namyang.nyorder.agn.dao.AreaMngMapper;
import com.namyang.nyorder.agn.service.AreaMngService;
import com.namyang.nyorder.agn.vo.AreaMngVO;
import com.namyang.nyorder.agn.vo.CstAreaHisVO;
import com.namyang.nyorder.agn.vo.EmplVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.vo.AgenAcctInfoVO;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자관리 - 지역관리
 * 파일명  : AreaMngController.java
 * 작성자  : GAIN
 * 작성일  : 2022. 2. 8.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    GAIN     최조 프로그램 작성
 * 2022. 3. 17.	  YESOL    이관
 *
 ****************************************************/
@Controller
@RequestMapping("/agn")
public class AreaMngController {
	
	@Autowired	
	AreaMngService areaMngService;
	
	@Autowired
	AreaMngMapper areaMngMapper;
	
	@Resource(name="userInfo")
	private UserInfo userInfo;
	
	/**
	 * @Method Name : areaMng
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자 관리 - 지역 관리 페이지 
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/areaMng.do", method= RequestMethod.GET)
	public ModelAndView areaMng(HttpServletRequest request, ModelAndView mv) {
		mv.addObject("areaList", areaMngService.selectAgenAreaList(new AreaMngVO() {{
			setAgenSeq( userInfo.getAgenSeq());
		}}));
		mv.setViewName("agn/areaMng.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectAgenAreaList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN	-> YeSoL
	 * @Method 설명 : 지역 목록 조회
	 * @param request
	 * @param VO
	 * @return List<AreaMngVO>
	 */
	@RequestMapping(value= "/selectAgenAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AreaMngVO> selectAgenAreaList(HttpServletRequest request, AreaMngVO param) {
		param.setAgenSeq( userInfo.getAgenSeq());
		return areaMngService.selectAgenAreaList(param);
	}
	
	/**
	 * @Method Name : selectAreaMngDetail
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 상세보기
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/selectAreaMngDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public AreaMngVO selectAreaMngDetail(@RequestBody AreaMngVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return areaMngService.selectAreaMngDetail(param);
	}
	
	/**
	 * @Method Name : stdPrdSearchPop
	 * @작성일 : 2022. 3. 17.
	 * @작성자 : YESOL
	 * @Method 설명 : 판매사원 검색 팝업
	 * @param param
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/emplSearchPop.do", method = RequestMethod.GET)
	public ModelAndView stdPrdSearchPop(AreaMngVO param, ModelAndView mv ) throws Exception{
		mv.setViewName("agn/emplSearchPop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : selectEmplList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 판매원 검색
	 * @param request
	 * @param VO
	 * @return List<EmplVO> 
	 */
	@RequestMapping(value= "/selectEmplList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<EmplVO> selectEmplList(HttpServletRequest request, EmplVO VO) {
		//대리점 지역 코드 set
		VO.setAgenSeq( userInfo.getAgenSeq());
		return areaMngService.selectEmplList(VO);
	}
	
	/**
	 * @Method Name : selectEmplAcctList
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 상세보기 - 판매원명(계좌)
	 * @param request
	 * @param VO
	 * @return Map<String,Object>
	 */
	@RequestMapping(value= "/selectEmplAcctList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AgenAcctInfoVO> selectEmplAcctList(HttpServletRequest request, AreaMngVO vo) {
		//대리점 지역 코드 set
		vo.setAgenSeq( userInfo.getAgenSeq());
		return areaMngService.selectEmplAcctList(vo);
	}
	
	
	/**
	 * @Method Name : areaOrdrChgPop
	 * @작성일 : 2022. 3. 21.
	 * @작성자 : YESOL
	 * @Method 설명 : 순서변경 팝업 
	 * @param param
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/areaOrdrChgPop.do", method = RequestMethod.GET)
	public ModelAndView areaOrdrChgPop(AreaMngVO param, ModelAndView mv ) throws Exception{
		mv.setViewName("agn/areaOrdrChgPop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : selectAgenAreaListByOrdr
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 애움자관리 - 지역관리 - 순서 변경 리스트 조회
	 * @param request
	 * @param VO
	 * @return List<AreaMngVO>
	 */
	@RequestMapping(value= "/selectAreaOrdrList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AreaMngVO> selectAreaOrdrList(HttpServletRequest request, AreaMngVO VO) {
		VO.setAgenSeq( userInfo.getAgenSeq());
		return areaMngService.selectAreaOrdrList(VO);
	}

	/**
	 * @Method Name : updateAgenAreaListByOrdr
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 순서 변경 저장
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 * @throws Exception 
	 */
	@RequestMapping(value="/updateAreaOrdrList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> updateAreaOrdrList(@RequestBody List<AreaMngVO> param, HttpServletRequest request) throws Exception {
		return areaMngService.updateAreaOrdrList(param);
	}
	
	/**
	 * @Method Name : cstAreaChgHisPop
	 * @작성일 : 2022. 3. 21.
	 * @작성자 : YESOL
	 * @Method 설명 : 이력보기 팝업
	 * @param param
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/cstAreaChgHisPop.do", method = RequestMethod.GET)
	public ModelAndView cstAreaChgHisPop(AreaMngVO param, ModelAndView mv ) throws Exception{
		mv.setViewName("agn/cstAreaChgHisPop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : saveAreaMng
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 상세보기 - 수정/저장
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveAreaMng.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> saveAreaMng(AreaMngVO param, HttpServletRequest request) throws Exception {
		param.setEmplSeq( userInfo.getEmplSeq() );
		param.setAgenSeq( userInfo.getAgenSeq() );
		return areaMngService.saveAreaMng(param);
	}
	/**
	 * @Method Name : getNextAgenAreaCd
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 신규 지역 코드 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/getNextAgenAreaCd.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getNextAgenAreaCd(AreaMngVO param, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		//대리점 코드 set
		param.setAgenSeq(userInfo.getAgenSeq());
		result.put( "nextAgenAreaCd", areaMngMapper.getNextAgenAreaCd(param) );
		return result;
	}

	
	
	
	/* 애음자 지역변경 탭 */
	
	/**
	 * @Method Name : selectCstAreaChgList
	 * @작성일 : 2022. 2. 17.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 지역 애음자 리스트 조회
	 * @param request
	 * @param VO
	 * @return Map<String,Object>
	 */
	@RequestMapping(value= "/selectCstAreaChgList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstAreaHisVO> selectCstAreaChgList(HttpServletRequest request, CstAreaHisVO param) {
		//대리점 지역 코드 set
		param.setAgenSeq( userInfo.getAgenSeq());
		return areaMngService.selectCstAreaChgList(param);
	}
	/**
	 * @Method Name : selectCstAreaHisList
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 - 변경이력 리스트 조회
	 * @param request
	 * @param VO
	 * @return Map<String,Object>
	 */
	@RequestMapping(value= "/selectCstAreaHisList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstAreaHisVO> selectCstAreaHisList(HttpServletRequest request, CstAreaHisVO param) {
		//대리점 지역 코드 set
		param.setAgenSeq( userInfo.getAgenSeq());
		return areaMngService.selectCstAreaHisList(param);
	}
	
	
	
	
	
	
	





	
	/**
	 * @Method Name : saveCstAgenArea
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 - 저장
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/saveCstAgenAreaChg.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> saveCstAgenAreaChg(@RequestBody List<CstAreaHisVO> list, HttpServletRequest request) {
		return areaMngService.saveCstAgenAreaChg(list);
	}

	

}
