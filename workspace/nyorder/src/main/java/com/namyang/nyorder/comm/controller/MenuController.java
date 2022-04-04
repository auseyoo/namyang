package com.namyang.nyorder.comm.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.MenuService;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.MenuRoleVO;
import com.namyang.nyorder.comm.vo.MenuVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 메뉴 관리
 * 파일명  : MenuController.java
 * 작성자  : YESOL
 * 작성일  : 2021. 12. 31.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 12. 31.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
@RequestMapping("/comm")
public class MenuController {
	
private Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@Autowired
    private MenuService menuService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	
	/**
	 * @Method Name : left
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 메뉴 리스트 조회  ( 개인 권한 )
	 * @param menuParam
	 * @param model
	 * @param request
	 * @return String
	 */
	@RequestMapping(value="/menu/left.do", method = RequestMethod.GET)
    public String left(@ModelAttribute("params") MenuVO menuParam, ModelMap model, HttpServletRequest request, @SessionAttribute("userInfo") AccountVO account) {
		//menuParam.setMenuUrl(request.getAttribute("javax.servlet.forward.request_uri").toString());
		
		String reqUri = request.getAttribute("javax.servlet.forward.request_uri").toString();
		
		List<MenuVO> menuVOList = account.getMenuVOList();
		
		for(MenuVO menuVO : menuVOList) {			
			if(reqUri.equals(menuVO.getMenuUrl())){
				model.addAttribute("activeParentSeq", menuVO.getParentSeq());
				model.addAttribute("activeSeq", menuVO.getMenuSeq());				
			}
		}
		
		model.addAttribute("frontMenu", menuVOList);
		
		return "comm/layout/left.comm";
    }

	/**
	 * @Method Name : breadcrumb
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 요청 페이지 메뉴 위치 조회  ( Location )
	 * @param menuParam
	 * @param model
	 * @param request
	 * @return String
	 */
	@RequestMapping(value="/menu/breadcrumb.do", method = RequestMethod.GET)
	public String breadcrumb(@ModelAttribute("params") MenuVO menuParam, ModelMap model, HttpServletRequest request) {
		menuParam.setMenuUrl(request.getAttribute("javax.servlet.forward.request_uri").toString());
		menuParam.setAgenSeq(userInfo.getAgenSeq());
		menuParam.setEmplSeq(userInfo.getEmplSeq());
		model.addAttribute("menu", menuService.selectBreadcrumb(menuParam));
		return "comm/layout/breadcrumb.comm";
	}
	
	
	/**
	 * @Method Name : menuList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 메뉴 설정 페이지 이동
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value="/menuList.do", method = RequestMethod.GET)
    public ModelAndView menuList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("comm/menuList.view");
		return mv;
    }
	
	/**
	 * @Method Name : selectMenuAllList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 메뉴 전체 리스트 조회  
	 * @param param
	 * @param request
	 * @return List<MenuRoleVO>
	 */
	@RequestMapping(value="/selectMenuAllList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<MenuRoleVO> selectMenuAllList(MenuVO param, HttpServletRequest request) {
		return menuService.selectMenuAllList(param);
	}
	
	/**
	 * @Method Name : saveMenueList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 메뉴 리스트 저장
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/saveMenuList.do", method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	@ResponseBody
	public String saveMenueList(@RequestBody List<MenuRoleVO> vo) throws Exception {
		return menuService.saveMenueList(vo);
	}
	
	
	/**
	 * @Method Name : updateBkmk
	 * @작성일 : 2022. 1. 10.
	 * @작성자 : YESOL
	 * @Method 설명 : 즐겨찾기 등록/수정
	 * @param menu
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/updateBkmk.do", method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	@ResponseBody
	public String updateBkmk(@RequestBody MenuRoleVO menu) throws Exception {
		menu.setAgenSeq(userInfo.getAgenSeq());
		menu.setEmplSeq(userInfo.getEmplSeq());
		menuService.updateBkmk(menu);
		return "저장완료";
	}
	
}
