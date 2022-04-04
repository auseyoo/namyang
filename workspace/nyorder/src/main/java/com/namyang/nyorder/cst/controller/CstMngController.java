package com.namyang.nyorder.cst.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.agn.vo.CrtbRtgdVO;
import com.namyang.nyorder.comm.service.BasicService;
import com.namyang.nyorder.comm.vo.BasicVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.cst.service.CstMngService;
import com.namyang.nyorder.cst.vo.CstMngVO;
import com.namyang.nyorder.prmt.vo.PrmtCstSearchVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자 관리 
 * 파일명  : CstMngController.java
 * 작성자  : DongJoo
 * 작성일  : 2022. 2. 8.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    DongJoo     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class CstMngController {
	
	@Autowired
	CstMngService cstMngService;
	
	@Autowired
	BasicService basicService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : cstMng
	 * @작성일 : 2022. 2. 8.
	 * @작성자 : DongJoo
	 * @Method 설명 : 애음자 관리 - 배달 정보(탭)
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/cstMng.do")
	public ModelAndView cstMng(ModelAndView mv) {
		mv.setViewName("cst/cstMng.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectArea
	 * @작성일 : 2022. 2. 8.
	 * @작성자 : DongJoo
	 * @Method 설명 : 애음자 관리 - 배달 정보(탭) - 지역 검색 팝업
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/selectArea.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectArea(CstMngVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return cstMngService.selectArea(param);
	}
	
	/**
	 * @Method Name : selectCstArea
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : DongJoo
	 * @Method 설명 : 애음자 관리 - 배달 정보(탭) - 지역, 애음자 검색 
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/selectCstArea.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectCstArea(CstMngVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return cstMngService.selectCstArea(param);
	}
	
	
	/**
	 * @Method Name : selectCstContract
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : DongJoo
	 * @Method 설명 : 애음자 관리 - 배달 정보(탭) - 지역, 애음자 검색 -> 계약 정보
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/selectCstContract.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectCstContract(@ModelAttribute CstMngVO param, HttpServletRequest request) {
		param.setAgenSeq(userInfo.getAgenSeq());
		
		List<CstMngVO> list= cstMngService.selectCstContract(param);
		
		//list.add(0, new CstMngVO());
		
		return list;
	}
	
	@RequestMapping(value="/cst/selectDlvyDtls.do", method = RequestMethod.POST)
	@ResponseBody
	public List<HashMap<String, Object>> selectDlvyDtls(@ModelAttribute CstMngVO cstMngVO, HttpServletRequest request) {
		cstMngVO.setAgenSeq(userInfo.getAgenSeq());
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectDlvyDtls");
		basicVO.setParamClass(cstMngVO);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		for(HashMap<String, Object> hm : list) {
			
			log.debug("hm   :: " + hm);			
		}
		
		return list;
	}
	
	
	
	@RequestMapping(value="/cst/areaSrhPop.do")
	public ModelAndView areaSrhPop(ModelAndView mv) {
		mv.setViewName("cst/areaSrhPop.jsp");
		return mv;
	}
	
	@RequestMapping(value="/cst/newPrdPop.do")
	public ModelAndView newPrdPop(ModelAndView mv, HttpServletRequest request) {
		mv.setViewName("cst/newPrdPop.jsp");
		//mv.addObject("id", "newPrdPop");
		return mv;
	}
	
	@RequestMapping(value="/cst/freeDsctPop.do")
	public ModelAndView freeDsctPop(@RequestParam(required=false) String parentWinNm
			, @RequestParam(required=false) String freeDsctData
			, @RequestParam(required=false) String targetCstSeq
			, ModelAndView mv) {
		
		log.debug("cstSeq   :" + targetCstSeq);
		
		mv.setViewName("cst/freeDsctPop.jsp");	
		mv.addObject("freeDsctData", freeDsctData);
		mv.addObject("parentWinNm", parentWinNm);
		mv.addObject("targetCstSeq", targetCstSeq);
		return mv;
	}
	
	@RequestMapping(value="/cst/inptChgPop.do")
	public ModelAndView inptChgPop(ModelAndView mv) {
		mv.setViewName("cst/inptChgPop.jsp");
		return mv;
	}
	
	@RequestMapping(value="/cst/pdRervPop.do")
	public ModelAndView pdRervPop(@RequestParam(required=false) String pageNm			
			, @RequestParam(required=false) String targetCstSeq
			, ModelAndView mv) {
		mv.setViewName("cst/pdRervPop.jsp");
		mv.addObject("pageNm", pageNm);
		mv.addObject("targetCstSeq", targetCstSeq);
		return mv;
	}
	
	@RequestMapping(value="/cst/posePop.do")
	public ModelAndView posePop(ModelAndView mv) {
		mv.setViewName("cst/posePop.jsp");
		return mv;
	}
	
	@RequestMapping(value="/cst/reDlvPop.do")
	public ModelAndView reDlvPop(@RequestParam(required=false) String targetCstSeq			
			, @RequestParam(required=false) String targetCstPrdSeq
			, @RequestParam(required=false) String prdNm
			, @RequestParam(required=false) String untpc
			, @RequestParam(required=false) String chgSecCd
			, ModelAndView mv) {
		mv.setViewName("cst/reDlvPop.jsp");
		
		mv.addObject("targetCstSeq", targetCstSeq);
		mv.addObject("targetCstPrdSeq", targetCstPrdSeq);
		mv.addObject("prdNm", prdNm);
		mv.addObject("untpc", untpc);
		mv.addObject("chgSecCd", chgSecCd);
		return mv;
	}
	
	@RequestMapping(value="/cst/cntrEndPop.do")
	public ModelAndView cntrEndPop(@RequestParam(required=false) String targetCstSeq		
			,ModelAndView mv) {
		mv.setViewName("cst/cntrEndPop.jsp");
		mv.addObject("targetCstSeq", targetCstSeq);
		return mv;
	}
	
	@RequestMapping(value="/cst/prdRegPop.do")
	public ModelAndView prdRegPop(ModelAndView mv) {
		mv.setViewName("cst/prdRegPop.jsp");
		return mv;
	}
	
	@RequestMapping(value="/cst/prmtPymInfoPop.do")
	public ModelAndView prmtPymInfoPop(CstMngVO param, ModelAndView mv) {
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectPrmtElplList");
		basicVO.setParamClass(param);	
		try {
			mv.addObject("emplList", basicService.basicSelectList(basicVO));
		} catch (Exception e) {			
			e.printStackTrace();
		}
		mv.setViewName("cst/prmtPymInfoPop.jsp");
		return mv;
	}
	
	@RequestMapping(value="/cst/getPrtmEmplSeq.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> getPrtmEmplSeq(CstMngVO param, BasicVO basicVO) throws Exception {
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectPrtmEmplSeqList");		
		basicVO.setParamClass(param);
		
		log.debug("selectPrtmEmplSeqList  param :: " + param.getAgenSeq());
		
		return basicService.basicSelectList(basicVO);
	}
	
	@RequestMapping(value="/cst/selectPopPrdSearchList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectPopPrdSearchList(CstMngVO param, BasicVO basicVO) throws Exception {
		
		List<CstMngVO> list = new ArrayList<CstMngVO>();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectPopPrdSearchList");		
		basicVO.setParamClass(param);
		try {
			
			//list = basicService.basicSelectList(basicVO);
			
			list = cstMngService.selectPopPrdSearchList(param);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return list;
	}
	
	@RequestMapping(value="/cst/saveFreeDsctPop.do", method = RequestMethod.POST)
	@ResponseBody
	public int saveFreeDsctPop(@RequestBody List<CstMngVO> list) {
		
		log.debug("list  : " + list.size());
		int cnt = 0;
		
		try {
			cstMngService.saveFreeDsctPop(list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return cnt;
	}
	
	@RequestMapping(value="/cst/saveNewPrd.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> saveNewPrd(@RequestBody CstMngVO cstMngVO) {
		
		log.debug("pttnlist  : " + cstMngVO.getPttnData().size());
		log.debug("cstMngVO  : " + cstMngVO.getPrdDtlSeq());
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		try {
			
			hm.put("insertCnt", cstMngService.saveCstPrd(cstMngVO));
			hm.put("success", true);
						
		} catch (Exception e) {			
			e.printStackTrace();
			hm.put("success", false);
			hm.put("msg", "");
		}
				
		return hm;
	}
	
	@RequestMapping(value="/cst/savePdRervPop.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> savePdRervPop(@RequestBody List<CstMngVO> list) {
		
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		try {
			
			hm.put("insertCnt", cstMngService.savePdRerv(list));
			hm.put("success", true);
						
		} catch (Exception e) {			
			e.printStackTrace();
			hm.put("success", false);
			hm.put("msg", "");
		}
				
		return hm;
	}
	
	@RequestMapping(value="/cst/saveReDlvPop.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> saveReDlvPop(@RequestBody CstMngVO cstMngVO) {
		
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		try {
			
			hm.put("insertCnt", cstMngService.saveReDlv(cstMngVO));
			hm.put("success", true);
						
		} catch (Exception e) {			
			e.printStackTrace();
			hm.put("success", false);
			hm.put("msg", "");
		}
				
		return hm;
	}
	
	@RequestMapping(value="/cst/saveCntrEndPop.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> saveCntrEndPop(@RequestBody List<CstMngVO> list) {
		
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		try {
			
			hm.put("insertCnt", cstMngService.saveCntrEnd(list));
			hm.put("success", true);
						
		} catch (Exception e) {			
			e.printStackTrace();
			hm.put("success", false);
			hm.put("msg", "");
		}
				
		return hm;
	}
	
	@RequestMapping(value="/cst/selectOverlapCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public int selectOverlapCheck(CstMngVO cstMngVO) throws Exception {
			
		int cnt = 0;
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectOverlapCheck");
		basicVO.setParamClass(cstMngVO);
		try {
			cnt = (int) basicService.basicSelectOne(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	@RequestMapping(value="/cst/selectBasicCstInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectBasicCstInfo(CstMngVO cstMngVO) throws Exception {	
		
		List<CstMngVO> list = new ArrayList<CstMngVO>(); 
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectBasicCstInfo");
		basicVO.setParamClass(cstMngVO);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	@RequestMapping(value="/cst/selectPrmtPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectPrmtPrdList(CstMngVO cstMngVO) throws Exception {	
		
		List<CstMngVO> list = new ArrayList<CstMngVO>(); 
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectPrmtPrdList");
		basicVO.setParamClass(cstMngVO);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	@RequestMapping(value="/cst/selectCstPrmtList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectCstPrmtList(CstMngVO cstMngVO) throws Exception {	
		
		List<CstMngVO> list = new ArrayList<CstMngVO>(); 
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectCstPrmtList");
		basicVO.setParamClass(cstMngVO);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	@RequestMapping(value="/cst/selectCstPttn.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectCstPrdPttn(CstMngVO cstMngVO) throws Exception {	
		
		List<CstMngVO> list = new ArrayList<CstMngVO>(); 
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstMngMapper.selectCstPttn");
		basicVO.setParamClass(cstMngVO);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	
	
	/**
	 * @Method Name : addCstMng
	 * @작성일 : 2022. 3. 4.
	 * @작성자 : YESOL
	 * @Method 설명 : 애음자 관리 - 애음자 등록 페이지 이동
	 * @param param
	 * @param mv
	 * @return ModelAndView
	 * @throws Exception 
	 */
	@RequestMapping(value="/cst/addCstMng.do")
	public ModelAndView addCstMng(PrmtCstSearchVO param, ModelAndView mv) throws Exception {
		mv.setViewName("cst/addCstMng.view");
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.prmt.dao.PrmtCstSearchMapper.selectEmplList");
		basicVO.setParamClass(param);	
		mv.addObject("emplList", basicService.basicSelectList(basicVO));
		return mv;
	}
	
	
}
