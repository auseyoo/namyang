package com.namyang.nyorder.cst.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.BasicService;
import com.namyang.nyorder.cst.service.DoubleDlvMngService;
import com.namyang.nyorder.comm.vo.BasicVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.config.error.exception.BusinessException;
import com.namyang.nyorder.cst.vo.CstMngVO;
import com.namyang.nyorder.cst.vo.CstPrdDlvyVO;
import com.namyang.nyorder.cst.vo.DoubleDlvMngVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 더블 작업 Controller
 * 파일명  : DoubleMngController.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 3. 10.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 10.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class DoubleMngController {
	@Autowired
	BasicService basicService;

	@Autowired
	DoubleDlvMngService doubleDlvMngService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	/**
	 * @Method Name : doubleDlvMng
	 * @작성일 : 2022. 3. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블/휴무 작업 페이지이동
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/doubleDlvMng.do")
	public ModelAndView doubleDlvMng(ModelAndView mv) {
		mv.setViewName("cst/doubleDlvMng.view");
		return mv;
	}

	@RequestMapping(value="/cst/selectDlvAllPrdList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstMngVO> selectDlvAllPrdList(CstPrdDlvyVO cstPrdDlvyVO) throws Exception {

		List<CstMngVO> list = new ArrayList<CstMngVO>();
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.DoubleDlvMngMapper.selectDlvAllPrdList");
		basicVO.setParamClass(cstPrdDlvyVO);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * @Method Name : selectDailDlvAreaList
	 * @작성일 : 2022. 3. 17.
	 * @작성자 : 이웅일
	 * @Method 설명 : 배달 지역 조회
	 * @param param
	 * @return List<CstPrdDlvyVO>
	 */
	@RequestMapping(value="/cst/selectDoubleDlvAreaList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstPrdDlvyVO> selectDailDlvAreaList(CstPrdDlvyVO cstPrdDlvyVO) {

		List<CstPrdDlvyVO> list = new ArrayList<CstPrdDlvyVO>();
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.DoubleDlvMngMapper.selectDoubleDlvAreaList");
		basicVO.setParamClass(cstPrdDlvyVO);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * @Method Name : startDoubleProc
	 * @작성일 : 2022. 3. 17.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블 시작
	 * @param param
	 * @return
	 * @throws BusinessException
	 */
	@RequestMapping(value="/cst/startDoubleProc.do", method = RequestMethod.POST)
	@ResponseBody
	public String startDoubleProc(@RequestBody Map<String, Object> param) throws BusinessException {
		param.put("agenSeq", userInfo.getAgenSeq());
		param.put("emplSeq", userInfo.getEmplSeq());
		return doubleDlvMngService.startDoubleProc(param);
	}

	/**
	 * @Method Name : returnDoubleProc
	 * @작성일 : 2022. 3. 21.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블 분리
	 * @param param
	 * @return
	 * @throws BusinessException
	 */
	@RequestMapping(value="/cst/returnDoubleProc.do", method = RequestMethod.POST)
	@ResponseBody
	public String returnDoubleProc(@RequestBody Map<String, Object> param) throws BusinessException {
		param.put("agenSeq", userInfo.getAgenSeq());
		param.put("emplSeq", userInfo.getEmplSeq());
		return doubleDlvMngService.returnDoubleProc(param);
	}


	/**
	 * @Method Name : doubleHisPop
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블 이력 팝업
	 * @param mv
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cst/doubleHisPop.do", method = RequestMethod.GET)
	public ModelAndView doubleHisPop(ModelAndView mv ) throws Exception{
		mv.setViewName("cst/doubleHisPop.jsp");
		return mv;
	}

	/**
	 * @Method Name : selectDoubleDlvAreaList
	 * @작성일 : 2022. 3. 17.
	 * @작성자 : 이웅일
	 * @Method 설명 : 배달 지역 조회
	 * @param param
	 * @return List<DoubleDlvMngVO>
	 */
	@RequestMapping(value="/cst/selectDoubleHisList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<DoubleDlvMngVO> selectDoubleHisList(DoubleDlvMngVO param) {

		List<DoubleDlvMngVO> list = new ArrayList<DoubleDlvMngVO>();
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.DoubleDlvMngMapper.selectDoubleHisList");
		basicVO.setParamClass(param);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

}
