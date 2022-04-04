package com.namyang.nyorder.comm.controller;

import java.io.File;
import java.util.Map;

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

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : MDB파일업로드 페이지
 * 파일명  : MDBFileUploadController.java
 * 작성자  : GAIN
 * 작성일  : 2022. 2. 25.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 25.    GAIN     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Controller
@RequestMapping("/comm")
public class MDBFileUploadController {
	
	@Autowired
	BiznoService biznoService;
	
	private String uploadPath="\\\\150.1.3.3\\log\\ny_order\\mdb/";
	
	@Resource(name="userInfo")
	UserInfo userInfo;

	/**
	 * @Method Name : fileUpload
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : MDB파일 업로드 페이지 호출
	 * @param loginVO
	 * @return ModelAndView
	 */
	@RequestMapping("/MDBfileUpload.do")
	public ModelAndView fileUpload(AccountVO loginVO) {
		
		log.debug("fileUpload  ==================================  fileUpload.getId()  :: " + loginVO.getId() );
		
		ModelAndView mv = new ModelAndView();		
		
		mv.setViewName("comm/MDBfileUpload.view");
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
	@RequestMapping(value = "/selectBizno.do" ,method = RequestMethod.POST)
	@ResponseBody
	public BiznoVO selectBizno(HttpServletRequest request, @RequestBody BiznoVO VO) {
		return biznoService.selectBizno(VO);
	}
	
	/**
	 * @Method Name : uploadForm
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : fileUploadProcess
	 * @param file
	 * @param fAgenCd
	 * @param mv
	 * @return ModelAndView
	 */
	@RequestMapping(value="/fileUploadProcess.do", method=RequestMethod.POST)
    public ModelAndView uploadForm(@RequestParam("mdbFile") MultipartFile file, @RequestParam("fAgenCd") String fAgenCd, ModelAndView mv) {
		System.out.println("fAgenCd >> "+ fAgenCd);
        String fileName = fAgenCd + ".MDB"; 
        File target = new File(uploadPath, fileName);
        //경로 생성
		  if ( ! new File(uploadPath).exists()) {
			  new File(uploadPath).mkdirs();
		  log.debug("uploadForm  ==================================  경로 없음" ); }
	  //파일 복사
        try {
            FileCopyUtils.copy(file.getBytes(), target);
            
            if (new File(uploadPath + target).isFile()) {
            	log.debug("uploadForm  ==================================  success :: " + uploadPath + target );
            }else {
            	log.debug("uploadForm  ==================================  FAIL :: " + uploadPath + target );
            }
            mv.addObject("file", file);
            mv.addObject("fileName", file.getOriginalFilename());
        } catch(Exception e) {
            e.printStackTrace();
            mv.addObject("file", "error");
        }
        //View 위치 설정
        mv.setViewName("/comm/MDBfileUpload");
        return mv;
    }
	
	/**
	 * @Method Name : selectBiznoList
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 사업자번호- 대리점 코드 조회
	 * @param request
	 * @param VO
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/selectBiznoList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectBiznoList(HttpServletRequest request, BiznoVO VO){
		VO.setAgenSeq(userInfo.getAgenSeq());
		return biznoService.selectBiznoList(VO);
	}
	 
}
