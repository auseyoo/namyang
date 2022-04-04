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
import com.namyang.nyorder.comm.vo.BasicVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.config.error.exception.BusinessException;
import com.namyang.nyorder.cst.vo.CstRecpNdBilctVO;
import com.namyang.nyorder.cst.vo.DoubleDlvMngVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 방문영수증 및 수금자료 Controller
 * 파일명  : DoubleMngController.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 3. 25.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 25.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class CstRecpNdBilctController {
	@Autowired
	BasicService basicService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	/**
	 * @Method Name : cstRecpNdBilctInfo
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 이웅일
	 * @Method 설명 : 방문영수증 및 수금자료 페이지이동
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/cstRecpNdBilct.do")
	public ModelAndView cstRecpNdBilctInfo(ModelAndView mv) {
		mv.setViewName("cst/cstRecpNdBilct.view");
		return mv;
	}

	/**
	 * @Method Name : selectRecpTargetList
	 * @작성일 : 2022. 3. 28.
	 * @작성자 : 이웅일
	 * @Method 설명 : 애음자 영수증 리스트
	 * @param param
	 * @return List<CstRecpNdBilctVO>
	 */
	@RequestMapping(value="/cst/selectRecpTargetList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CstRecpNdBilctVO> selectRecpTargetList(CstRecpNdBilctVO param) {

		List<CstRecpNdBilctVO> list = new ArrayList<CstRecpNdBilctVO>();
		BasicVO basicVO = new BasicVO();
		basicVO.setQueryId("com.namyang.nyorder.cst.dao.CstRecpNdBilctMapper.selectRecpTargetList");
		basicVO.setParamClass(param);
		try {
			list = basicService.basicSelectList(basicVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * @Method Name : recpPrtPop
	 * @작성일 : 2022. 3. 28.
	 * @작성자 : 이웅일
	 * @Method 설명 : 방문영수증 출력 팝업
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/cst/recpPrtPop.do", method = RequestMethod.GET)
	public ModelAndView recpPrtPop(ModelAndView mv) {
		mv.setViewName("cst/recpPrtPop.jsp");
		return mv;
	}


}
