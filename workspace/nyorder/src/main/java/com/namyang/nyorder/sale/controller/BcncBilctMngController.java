package com.namyang.nyorder.sale.controller;

import java.lang.reflect.Field;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.myp.service.AgentMngService;
import com.namyang.nyorder.myp.vo.AgentMngVO;
import com.namyang.nyorder.sale.service.BcncBilctMngService;
import com.namyang.nyorder.sale.service.BcncMngService;
import com.namyang.nyorder.sale.vo.AgenVendVO;
import com.namyang.nyorder.sale.vo.BcncUntpcVO;
import com.namyang.nyorder.sale.vo.SaleRegVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 거래처 수금 관리
 * 파일명  : BcncBilctMngController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 17.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Controller
public class BcncBilctMngController {
	@Autowired
	BcncMngService bcncMngService;

	@Autowired
	BcncBilctMngService bcncBilctMngService;


	/**
	 * @Method Name : bcncBilctMng
	 * @작성일 : 2022. 1. 17.
	 * @작성자 : YESOL
	 * @Method 설명 : 기준정보관리 : 거래처 수금 관리 페이지이동
	 * @param request
	 * @param mv
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/bcncBilctMng.do", method = RequestMethod.GET)
	public ModelAndView bcncBilctMng(HttpServletRequest request, ModelAndView mv ,@SessionAttribute("userInfo") AccountVO account) throws Exception {
		/*대리점 직원 조회*/
		mv.addObject("emplList", bcncMngService.selectAgentEmplList(new AgenVendVO() {{
			setAgenSeq(account.getAgenSeq());
		}}));
		mv.setViewName("sale/bcncBilctMng.view");
		return mv;
	}

	/**
	 * @Method Name : selectBaBillTotList
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 수금 리스트 조회
	 * @param request
	 * @param param
	 * @return SaleRegVO
	 */
	@RequestMapping(value="/sale/selectBaBillTotList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<SaleRegVO> selectSaleRegList(HttpServletRequest request, SaleRegVO param) {
		List<SaleRegVO>  baBillTotList =  bcncBilctMngService.selectBaBillTotList(param);
		return baBillTotList;
	}
	/**
	 * @Method Name : saveBaBillTot
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 등록
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/sale/saveBaBillTot.do", method = RequestMethod.POST)
	@ResponseBody
	public String saveBaBillTot(@RequestBody List<SaleRegVO> param ,@SessionAttribute("userInfo") AccountVO account) throws Exception {
		for ( SaleRegVO updVo : param) {
			updVo.setAgenSeq(account.getAgenSeq());
			updVo.setEmplSeq(account.getEmplSeq());
			bcncBilctMngService.saveBaBillTot((SaleRegVO) (SaleRegVO)emptyIsNull(updVo));
		}
		return "저장되었습니다.";
	}

	/**
	 * @Method Name : searchBcncPop
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 등록 팝업
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/sale/searchBcncPop.do", method = RequestMethod.GET)
	public ModelAndView searchBcncPop(ModelAndView mv ) throws Exception{
		mv.setViewName("sale/searchBcncPop.jsp");
		return mv;
	}

	/**
	 * @Method Name : emptyIsNull
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 빈값 Null 처리
	 * @param obj
	 * @return
	 * @throws Exception String
	 */
	public Object emptyIsNull(Object obj) throws IllegalArgumentException, IllegalAccessException {
		 for (Field field :  obj.getClass().getDeclaredFields()) {
			 field.setAccessible(true);
	         Object value=field.get(obj);
	         if(value == null ||value.equals("")) {
	        	 field.set(obj, null);
	         }
	         System.out.println(field.getName()+","+field.get(obj));
		 }
		 return obj;
	}

}
