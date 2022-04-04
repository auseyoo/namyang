package com.namyang.nyorder.prmt.controller;

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

import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.prmt.dao.PrmtEmplMngMapper;
import com.namyang.nyorder.prmt.service.PrmtEmplMngService;
import com.namyang.nyorder.prmt.vo.PrmtEmplMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 관리
 * 파일명  : PrmtEmplMngController.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class PrmtEmplMngController {
	@Autowired
	PrmtEmplMngService prmtEmplMngService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * @Method Name : PrmtEmplMng
	 * @작성일 : 2022. 3. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 관리 - 페이지 이동
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/prmt/PrmtEmplMng.do" , method = RequestMethod.GET)
	public ModelAndView PrmtEmplMng(PrmtEmplMngVO param, ModelAndView mv) throws Exception{
		mv.setViewName("prmt/PrmtEmplMng.view");
		return mv;
	}
	
	/**
	 * @Method Name : selectPrmtEmplMngList
	 * @작성일 : 2022. 3. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 관리 리스트 조회
	 * @param param
	 * @param request
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/prmt/selectPrmtEmplMngList.do", method = RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public Map<String,Object> selectPrmtEmplMngList(@RequestBody PrmtEmplMngVO param , HttpServletRequest request) throws Exception{
		param.setAgenSeq( userInfo.getAgenSeq() );
		return prmtEmplMngService.selectPrmtEmplMngList(param);
	}
	
	/**
	 * @Method Name : savePrmtEmplHis
	 * @작성일 : 2022. 3. 14.
	 * @작성자 : 윤이준
	 * @Method 설명 : 판촉사원 관리 저장
	 * @param param
	 * @return String
	 */
	@RequestMapping(value="/prmt/savePrmtEmplHis.do", method = RequestMethod.POST)
	@ResponseBody
	public String savePrmtEmplMng(@RequestBody List<PrmtEmplMngVO> list) throws Exception {
		return prmtEmplMngService.savePrmtEmplHisList(list );
	}
}
