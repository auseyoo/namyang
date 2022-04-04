package com.namyang.nyorder.sale.controller;

import java.lang.reflect.Field;
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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.namyang.nyorder.comm.service.CommCodeService;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.PrdClsVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.service.AgentMngService;
import com.namyang.nyorder.sale.service.BcncBilctMngService;
import com.namyang.nyorder.sale.service.SaleRegService;
import com.namyang.nyorder.sale.vo.AgenVendVO;
import com.namyang.nyorder.sale.vo.BcncUntpcVO;
import com.namyang.nyorder.sale.vo.SaleRegVO;
import com.namyang.nyorder.std.vo.StdPrdBndChgVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판매관리 - 판매등록 Controller
 * 파일명  : SaleRegController.java
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
public class SaleRegController {

	@Autowired
	CommCodeService commCodeService;

	@Autowired
	AgentMngService agentMngService;

	@Autowired
	SaleRegService saleRegService;

	@Autowired
	BcncBilctMngService bcncBilctMngService;

	@Resource(name="userInfo")
	UserInfo userInfo;
	/**
	 * @Method Name : saleReg
	 * @작성일 : 2022. 1. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : 판매등록 페이지 이동
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/sale/saleReg.do", method = RequestMethod.GET)
	public ModelAndView saleReg(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("sale/saleReg.view");
		return mv;
	}

	/**
	 * @Method Name : selectStdPrdPopList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : 이웅일
	 * @Method 설명 : 표준제품 조회 (팝업)
	 * @param request
	 * @param param
	 * @return List<SaleRegVO>
	 */
	@RequestMapping(value="/sale/selectStdPrdPopList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<SaleRegVO> selectStdPrdPopList(HttpServletRequest request, SaleRegVO param) {

		List<SaleRegVO> stdPrdPopList = saleRegService.selectStdPrdPopList(param);
		return stdPrdPopList;
	}
	/**
	 * @Method Name : selectSaleRegList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매조회
	 * @param request
	 * @param param
	 * @return List<SaleRegVO>
	 */
	@RequestMapping(value="/sale/selectSaleRegList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<SaleRegVO> selectSaleRegList(HttpServletRequest request, SaleRegVO param) {

		List<SaleRegVO> saleRegList = saleRegService.selectSaleRegList(param);
		return saleRegList;
	}
	/**
	 * @Method Name : selectBaBillTot
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 수금 조회
	 * @param request
	 * @param param
	 * @return SaleRegVO
	 */
	@RequestMapping(value="/sale/selectBaBillTot.do", method = RequestMethod.POST)
	@ResponseBody
	public SaleRegVO selectBaBillTot(HttpServletRequest request, SaleRegVO param) {

		SaleRegVO baBillTot = bcncBilctMngService.selectBaBillTot(param);
		return baBillTot;
	}
	/**
	 * @Method Name : saveSaleReg
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 등록
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/sale/saveSaleReg.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public String saveSaleReg(@RequestBody Map<String,Object> param ,@SessionAttribute("userInfo") AccountVO account) throws Exception {
		Object mapper = new ObjectMapper();
		List<SaleRegVO> saleData = ((ObjectMapper) mapper).convertValue(param.get("saleData"), new TypeReference<List<SaleRegVO>>(){});
		SaleRegVO billData = ( (ObjectMapper) mapper).convertValue(param.get("billData"), new TypeReference<SaleRegVO>(){});
		for ( SaleRegVO saleUpd : saleData) {
			saleUpd.setEmplSeq(account.getEmplSeq());
			saleRegService.saveSaleReg((SaleRegVO)emptyIsNull(saleUpd));
		}
		bcncBilctMngService.saveBaBillTot((SaleRegVO)emptyIsNull(billData));

		return "저장되었습니다.";
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
	         if(field.getName().contains("saleDt") ||field.getName().contains("saleDt")){
	        	 field.set(obj, ((String) value).replaceAll("-",""));
	         }
	         System.out.println(field.getName()+","+field.get(obj));
		 }
		 return obj;
	}

	/**
	 * @Method Name : searchBcncPrdPop
	 * @작성일 : 2022. 3. 7.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 표준 제품 등록 팝업
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/sale/searchBcncPrdPop.do", method = RequestMethod.GET)
	public ModelAndView searchBcncPrdPop(ModelAndView mv ) throws Exception{
		mv.setViewName("sale/searchBcncPrdPop.jsp");
		return mv;
	}
}
