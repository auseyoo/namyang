package com.namyang.nyorder.comm.controller;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.view.RedirectView;

import com.namyang.nyorder.comm.service.LoginService;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.config.exception.CustomAjaxException;
import com.namyang.nyorder.myp.vo.AgentMngVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : Login Controller
 * 파일명  : LoginController.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일			 변경자		   변경내역
 * --------------------------------------------------
 * 2022. 1. 4.	YESOL	 최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;


//	@Value("#{messageProperties['alert.test2']}")
//	private String alertTest;
//
//	@Value("#{messageProperties}")
//	Properties properties;

	@Autowired
	MessageSource messageSource;

	@Resource(name="userInfo")
	UserInfo userInfo;

	@RequestMapping("/login.do")
	public ModelAndView login(HttpServletRequest request, AgentMngVO agentMngVO) throws Exception {

		//log.debug("alertTest====== ::" + messageSource.getMessage("alert.test2", new String[]{"Leica","지성"}, Locale.getDefault()));
		//log.debug("alertTest====== ::" + properties.getProperty("alert.test2"));

		String serverType = System.getProperty("server.type");

		HashMap<String, Object> hm = new HashMap<String, Object>();

		hm = (HashMap<String, Object>) request.getAttribute("param");

		ModelAndView mv = new ModelAndView();
		if(hm != null) {
			mv.addObject("status", hm.get("status"));
		}

		log.debug("tcomm  ::" + agentMngVO.getAgenSeq());

//		TComm param = new TComm();
//		param.setCommGrpCd("EMPL_RNK");
//
//		List<TComm> tList = TCommService.listTComm(param);
//
//		for(TComm tcomm : tList) {
//			log.debug("tcomm  ::" + tcomm.getCommSeq());
//			log.debug("tcomm  ::" + tcomm.getCommgrpNm());
//			log.debug("tcomm  ::" + tcomm.getCommNm());
//		}




		mv.setViewName("/login");
		//throw new Exception();
		return mv;
	}

	@RequestMapping("/changePassword.do")
	public ModelAndView changePassword(HttpServletRequest request, AccountVO loginVO, @SessionAttribute("userInfo") AccountVO account) {

		ModelAndView mv = new ModelAndView();
		log.debug("loginVO====== ::" + account.getAgenSeq() + ", ::" + account.getEmplSeq());

		//loginService.setSessionInfo(account);

		mv.addObject("userInfo", account);
		mv.setViewName("/changePassword");
		return mv;
	}

	@RequestMapping("/loginCertified.do")
	public ModelAndView loginCertified(AccountVO loginVO) {

		log.debug("loginCertified  ==================================  loginCertified.getId()  :: " + loginVO.getId() );

		ModelAndView mv = new ModelAndView();

		AccountVO account = null;

		try {
			account = (AccountVO) loginService.selectLoginList(loginVO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		log.debug("ModelAndView  ==================================  account  :: " + account.getRolecode() );

		mv.setViewName("comm/mainList");
		return mv;
	}


	@RequestMapping("/loginProcess.do")
	public ModelAndView loginProcess(AccountVO loginVO) {

		log.debug("login  ==================================  loginVO.getId()  :: " + loginVO.getId() );

		ModelAndView mv = new ModelAndView();

		AccountVO account = null;
		String loginStr = loginVO.getBizNo() + "," + loginVO.getEmplCd();

		try {
			//account = (AccountVO) accountService.loadUserByUsername(loginStr);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		log.debug("ModelAndView  ==================================  account  :: " + account );

		mv.setViewName("comm/mainList");
		return mv;
	}

	@RequestMapping(value="/agenSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public List<AccountVO> agenSearch(AccountVO loginVO) throws Exception {

		log.debug("login  ==================================  loginVO.getId()  :: " + loginVO.getBizNo() );

		return loginService.selectAgenList(loginVO);
	}

	@RequestMapping(value="/savePassword.do")
	public String savePassword(AccountVO loginVO) throws Exception {

		log.debug("login  ==================================  loginVO.getId()  :: " + loginVO.getPassword() );

		log.debug("login  ==================================  loginVO.getId()  :: " + loginVO.getAgenSeq() + ", :: " + loginVO.getEmplSeq() );

		ModelAndView mv = new ModelAndView();

		int cnt = loginService.savePassword(loginVO);


		return "redirect:/comm/main.do";
	}

	@RequestMapping(value="/sessionDestroyedLogout.do")
	public ModelAndView sessionDestroyedLogout(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws Exception {


//		response.setContentType("text/html; charset=UTF-8");
//		response.setHeader("Content-Type", "text/html; charset=utf-8");
//
//		try {
//			ServletOutputStream out = response.getOutputStream();
//			out.print("<html>");
//			out.print("<script type='text/javascript'>");
//			out.print("location.href = '/login.do'");
//			out.print("</script>");
//			out.print("</html>");
//			out.flush();
//		} catch ( Exception e ) {
//			e.printStackTrace();
//		}




		//return "redirect:/logout.do";

//		RedirectView redirectView = new RedirectView();
//		redirectView.setUrl("/login.do");
//		return redirectView;

//		URI redirectUri = new URI("/logout.do");
//	    HttpHeaders httpHeaders = new HttpHeaders();
//	    httpHeaders.setLocation(redirectUri);
//	    return new ResponseEntity<>(httpHeaders, HttpStatus.SEE_OTHER);

	 // New Java Interceptor

		mv.setViewName("/logout");

//	    response.setStatus(399);
//	    response.setHeader("Access-Control-Allow-Credentials", "true");
//	    response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
//	    response.setHeader("Connection", "close");
//	    response.setContentType("application/json");
//	    response.setCharacterEncoding("UTF-8");
//	    mv.setViewName("/logout");

		throw new CustomAjaxException();


	}

	@RequestMapping(value="/errorPage.do")
	public ModelAndView errorPage(ModelAndView mv, NoHandlerFoundException ex) {

		log.debug("handle404  Exception........" + ex.getMessage());

		mv.setViewName("error/404");

		return mv;

	}
	/**
	 * @Method Name : bcncInfoPop
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 이웅일
	 * @Method 설명 : 대리점 정보 조회 팝업
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/bcncInfoPop.do", method = RequestMethod.GET)
	public ModelAndView bcncInfoPop(ModelAndView mv ) throws Exception{
		mv.setViewName("comm/bcncInfoPop.jsp");
		return mv;
	}

}
