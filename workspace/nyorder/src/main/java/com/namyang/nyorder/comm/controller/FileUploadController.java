package com.namyang.nyorder.comm.controller;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.comm.service.BiznoService;
import com.namyang.nyorder.comm.vo.AccountVO;
import com.namyang.nyorder.comm.vo.BiznoVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FileUploadController {
	
	@Autowired
	BiznoService biznoService;
	
	//private String uploadPath="D:\\temp";
	
	//private String uploadPath="Z:\\MDB";	
	
	//private String uploadPath="E:\\log";
	
	private String uploadPath="\\\\150.1.3.3\\log\\ny_order\\mdb/";
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	


	@RequestMapping("/comm/fileUpload.do")
	public ModelAndView fileUpload(AccountVO loginVO) {
		
		log.debug("fileUpload  ==================================  fileUpload.getId()  :: " + loginVO.getId() );
		
		ModelAndView mv = new ModelAndView();		
		
		mv.setViewName("comm/fileUpload.view");
		return mv;
	}
	
	/*
	@RequestMapping(value="/comm/fileUploadProcess.do", method=RequestMethod.POST)
    public ModelAndView uploadForm(@RequestParam("mdbFile") MultipartFile file, @RequestParam("fAgenCd") String fAgenCd, ModelAndView mv) {
		System.out.println("fAgenCd >> "+ fAgenCd);
        //String oriFileName = file.getOriginalFilename();
        
        String fileName = fAgenCd + ".MDB"; 
        
        File target = new File(uploadPath, fileName);
        
        //경로 생성
		/*
		 * if ( ! new File(uploadPath).exists()) { new File(uploadPath).mkdirs();
		 * log.debug("uploadForm  ==================================  경로 없음" ); }
		 
        //파일 복사
        try {
            FileCopyUtils.copy(file.getBytes(), target);
            
            if (new File(uploadPath + target).isFile()) {
            	log.debug("uploadForm  ==================================  success :: " + uploadPath + target );
            }else {
            	log.debug("uploadForm  ==================================  FAIL :: " + uploadPath + target );
            	
            }
            
            mv.addObject("fileName", file.getOriginalFilename());
        } catch(Exception e) {
            e.printStackTrace();
            mv.addObject("file", "error");
        }
        
        //View 위치 설정
        mv.setViewName("/comm/fileUpload");
        return mv;
    }
	
	
	/**
	 * @Method Name : selectBizno
	 * @작성일 : 2022. 1. 24.
	 * @작성자 : GAIN
	 * @Method 설명 : iznoService.selectBizno 
	 * @param request
	 * @param VO
	 * @return BiznoVO
	 */
	/*
	@RequestMapping(value = "/comm/selectBizno.do" ,method = RequestMethod.POST)
	@ResponseBody
	public BiznoVO selectBizno(HttpServletRequest request, @RequestBody BiznoVO VO) {
		return biznoService.selectBizno(VO);
	}
	*/
}
