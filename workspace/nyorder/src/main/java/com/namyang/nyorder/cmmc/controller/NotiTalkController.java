package com.namyang.nyorder.cmmc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.cmmc.vo.NttVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/cmmc")
public class NotiTalkController {
		
	@Value(value = "${bizPpurid.url}")
	private String bizPpuridUrl;
	
	
	
	@RequestMapping(value="/notiTalk.do", method = RequestMethod.GET)
	public ModelAndView notiTalk(HttpServletRequest request, ModelAndView mv) throws Exception {
		mv.setViewName("cmmc/notiTalk.view");
		mv.addObject("bizPpuridUrl", bizPpuridUrl);
		return mv;
	}
	
	@RequestMapping("/talkTest.do")
	@ResponseBody
	public String selectNotiList(HttpServletRequest request, NttVO VO) {
		
		

		return "";
	}

}
