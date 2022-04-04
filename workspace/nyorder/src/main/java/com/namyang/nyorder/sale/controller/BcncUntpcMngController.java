package com.namyang.nyorder.sale.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.service.AgentMngService;
import com.namyang.nyorder.sale.service.BcncUntpcMngService;
import com.namyang.nyorder.sale.vo.BcncUntpcVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판매관리 - 거래처별 단가 관리 Controller
 * 파일명  : BcncUntpcMngController.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 1. 18.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 18.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class BcncUntpcMngController {

	@Autowired
	CommCodeService commCodeService;

	@Autowired
	AgentMngService agentMngService;

	@Autowired
	BcncUntpcMngService bcncUntpcMngService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	/**
	 * @Method Name : bcncUntpcMng
	 * @작성일 : 2022. 1. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처별 단가 관리 페이지 이동
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/bcncUntpcMng.do", method = RequestMethod.GET)
	public ModelAndView bcncUntpcMng(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sale/bcncUntpcMng.view");
		return mv;
	}

	/**
	 * @Method Name : selectUntpcMngList
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처별 단가 조회
	 * @param request
	 * @param param
	 * @return List<AgenVendVO>
	 */
	@RequestMapping(value="/sale/selectUntpcMngList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<BcncUntpcVO> selectUntpcMngList(HttpServletRequest request, BcncUntpcVO param) {
		SimpleDateFormat dateForm = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = dateForm.format(c1.getTime());

        if(param.getApplDt() == null ||param.getApplDt().equals("")) {
        	param.setApplDt(strToday);
    	}
		List<BcncUntpcVO> bcncUntpcList = bcncUntpcMngService.selectUntpcMngList(param);
		return bcncUntpcList;
	}

	/**
	 * @Method Name : saveAgenVendUntpc
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처별 단가 저장
	 * @param request
	 * @param param
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/saveAgenVendUntpc.do", method = RequestMethod.POST ,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveAgenVendUntpc(@RequestBody List<BcncUntpcVO> param, @SessionAttribute("userInfo") AccountVO account) throws Exception {
        SimpleDateFormat dateForm = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = dateForm.format(c1.getTime());

        for ( BcncUntpcVO untpcUpd : param) {
    		if(untpcUpd.getRemoveYn()==null) {
        		untpcUpd.setRemoveYn("N");
        	}
        	untpcUpd.setEmplSeq(account.getEmplSeq());
        	if(untpcUpd.getChgApplDt() == null ||untpcUpd.getChgApplDt().equals("")) {
        		untpcUpd.setChgApplDt(strToday);
        	}
        	if(untpcUpd.getChgApplDt().equals(strToday)) {
        		untpcUpd.setApplYn("Y");
        	}else{
        		untpcUpd.setApplYn("N");
        	}
        	bcncUntpcMngService.saveAgenVendUntpc(untpcUpd);
        }
		return "저장되었습니다.";
	}



	/**
	 * @Method Name : bcncPrdBndChg
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : 이웅일
	 * @Method 설명 : 판매제픔 일괄 변경
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/bcncPrdBndChg.do", method = RequestMethod.GET)
	public ModelAndView bcncPrdBndChg(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sale/bcncPrdBndChg.view");
		return mv;
	}

	/**
	 * @Method Name : selectAllBcncUntpc
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : 이웅일
	 * @Method 설명 : 제품 거래처별 단가 조회
	 * @param request
	 * @param param
	 * @return List<BcncUntpcVO>
	 */
	@RequestMapping(value="/sale/selectAllBcncUntpc.do", method = RequestMethod.POST)
	@ResponseBody
	public List<BcncUntpcVO> selectAllBcncUntpc(HttpServletRequest request, BcncUntpcVO param) {
		List<BcncUntpcVO> bcncUntpcList = bcncUntpcMngService.selectAllBcncUntpc(param);
		return bcncUntpcList;
	}

	/**
	 * @Method Name : bcncPrdChgHis
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : 이웅일
	 * @Method 설명 : 판매제품 및 단가 변경이력 [UI-PSAL-0901]
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/bcncPrdChgHis.do", method = RequestMethod.GET)
	public ModelAndView bcncPrdChgHis(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sale/bcncPrdChgHis.view");
		return mv;
	}

	/**
	 * @Method Name : selectBcncPrdChgHis
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : 이웅일
	 * @Method 설명 : 제품변경 및 단가 이력 조회
	 * @param request
	 * @param param
	 * @return List<BcncUntpcVO>
	 */
	@RequestMapping(value="/sale/selectBcncPrdChgHis.do", method = RequestMethod.POST)
	@ResponseBody
	public List<BcncUntpcVO> selectBcncPrdChgHis(HttpServletRequest request, BcncUntpcVO param) {
		List<BcncUntpcVO> bcncUntpcHisList = bcncUntpcMngService.selectBcncPrdChgHis(param);
		return bcncUntpcHisList;
	}

	/**
	 * @Method Name : selectStdrPrdList
	 * @작성일 : 2022. 3. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 단가복사 단가리스트 조회
	 * @param request
	 * @param param
	 * @return List<Map<String, Object>>
	 */
	@RequestMapping(value="/sale/selectStdrPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> selectStdrPrdList(HttpServletRequest request,@RequestBody Map<String, Object> param) {
		List<Map<String, Object>> bcncUntpcHisList = bcncUntpcMngService.selectStdrPrdList(param);
		return bcncUntpcHisList;
	}

}
