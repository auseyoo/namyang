package com.namyang.nyorder.prmt.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.prmt.service.PrmtAgenRqstService;
import com.namyang.nyorder.prmt.vo.PrmtAgenRqstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 소요량 요청 관리 Controller
 * 파일명  : prmtAgenRqstController.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 2. 23.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class PrmtAgenRqstController {
	@Autowired
	PrmtAgenRqstService prmtAgenRqstService;
		
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : prmtAgenRqst
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 관리 - 페이지 이동
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/prmt/prmtAgenRqst.do", method = RequestMethod.GET)
	public ModelAndView prmtAgenRqst(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM"); 
		Calendar c1 = Calendar.getInstance(); 
		String reqYm = sdf.format(c1.getTime());

		PrmtAgenRqstVO param2 = new PrmtAgenRqstVO();
		param2.setAgenSeq(userInfo.getAgenSeq());
		param2.setReqYm(reqYm);
		mv.addObject("rqstMonth", prmtAgenRqstService.selectDvyfgRqstMonth(param2));
		
		mv.addObject("agenSaleCd", userInfo.getSaleCd());
		
		mv.setViewName("prmt/prmtAgenRqst.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectDvyfgRqstMonth
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청월 조회
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/selectDvyfgRqstMonth.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectDvyfgRqstMonth(PrmtAgenRqstVO param, HttpServletRequest request) {
		param.setReqYm(param.getReqYm().replace("-", ""));
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", prmtAgenRqstService.selectDvyfgRqstMonth(param));
		return result;
	}
	
	/**
	 * @Method Name : selectPrmtAgenRqstList
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 조회
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/selectPrmtAgenRqstList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selectPrmtAgenRqstList(PrmtAgenRqstVO param, HttpServletRequest request) {
		return prmtAgenRqstService.selectPrmtAgenRqstList(param);
	}
	
	/**
	 * @Method Name : savePrmtAgenRqst
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 저장
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/savePrmtAgenRqst.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String savePrmtAgenRqst(@RequestBody List<PrmtAgenRqstVO> list) throws Exception {
		return prmtAgenRqstService.savePrmtAgenRqst(list);
	}	
	
	/**
	 * @Method Name : selectSavedYn
	 * @작성일 : 2022. 3. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 - 저장여부 조회
	 * @param param
	 * @param request
	 * @return List<HashMap>
	 */
	@RequestMapping(value="/prmt/selectSavedYn.do", method = RequestMethod.POST)
	@ResponseBody
	public String selectSavedYn(PrmtAgenRqstVO param, HttpServletRequest request) {
		return prmtAgenRqstService.selectSavedYn(param);
	}
	
	/**
	 * @Method Name : sendPrmtAgenRqst
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 전송
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/sendPrmtAgenRqst.do", method = RequestMethod.POST)
	@ResponseBody
	public String sendPrmtAgenRqst(PrmtAgenRqstVO param, HttpServletRequest request) {
		return prmtAgenRqstService.sendPrmtAgenRqst(param);
	}		
}
