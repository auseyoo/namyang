package com.namyang.nyorder.cmmc.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.cmmc.service.FileService;
import com.namyang.nyorder.cmmc.service.NotibodService;
import com.namyang.nyorder.cmmc.service.RqbodService;
import com.namyang.nyorder.cmmc.vo.FileVO;
import com.namyang.nyorder.cmmc.vo.NttVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.config.error.exception.BusinessException;
import com.namyang.nyorder.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/cmmc")
public class RqbodController {

	@Autowired
	RqbodService rqbodService;

	@Autowired
	private FileService fileService;
	
	
	@Resource(name="userInfo")
    UserInfo userInfo;

	private Logger logger = LoggerFactory.getLogger(RqbodController.class);

	/**
	 * @Method Name : resc_board
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 요청 게시판 페이지 이동
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/rqbod.do", method = RequestMethod.GET)
	public ModelAndView resc_board(HttpServletRequest request, ModelAndView mv ) {
		mv.setViewName("cmmc/rqbod.view");
		return mv;
	}
	/**
	 * @Method Name : addRqbodPop
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : YESOL
	 * @Method 설명 : 커뮤니케이션관리 - 요청 게시판 등록 팝업
	 * @param param
	 * @param mv
	 * @return
	 * @throws Exception ModelAndView
	 */
	@RequestMapping(value="/addRqbodPop.do", method=RequestMethod.GET)
	public ModelAndView addRqbodPop(NttVO param, ModelAndView mv) throws Exception{
		mv.setViewName("cmmc/addRqbodPop.jsp");
		return mv;
	}
	
	/**
	 * @Method Name : selectRqstList
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 요청사항 - 글 리스트 조회
	 * @param request
	 * @param VO
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/selectRqstList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<NttVO> selectRqstList(HttpServletRequest request, NttVO VO) {
		return rqbodService.selectRqstList(VO);
	}
	
	/**
	 * @Method Name : selectRqst
	 * @작성일 : 2022. 3. 16.
	 * @작성자 : YESOL
	 * @Method 설명 :  커뮤니케이션관리 - 요청사항 관리- 상세 조회
	 * @param request
	 * @param VO
	 * @return NttVO
	 */
	@RequestMapping(value = "/selectRqst.do", method = RequestMethod.POST)
	@ResponseBody
	public NttVO selectRqst(HttpServletRequest request, @RequestBody NttVO VO) {
		return rqbodService.selectRqst(VO);
	}

	/**
	 * @Method Name : saveRqbod
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : YESOL
	 * @Method 설명 : 요청사항 등록
	 * @param vo
	 * @param files
	 * @return Map<String,Object>
	 * @throws Exception 
	 */
	@RequestMapping(value="/saveRqbod.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> saveRqbod(NttVO vo, @RequestParam("file") MultipartFile file) throws Exception {
		vo.setAgenSeq(userInfo.getAgenSeq());
		vo.setEmplSeq(userInfo.getEmplSeq());
		FileVO fileVO = new FileVO();
		if(file.getSize() > 0) {
			if(StringUtil.isEmpty(vo.getNttAtclSeq())) {
				int nttAtclSeq = fileService.addNttAtclMst(new FileVO() {{
					setEmplSeq(userInfo.getEmplSeq());
					setAgenSeq(userInfo.getAgenSeq());
				}});
				vo.setNttAtclSeq(String.valueOf(nttAtclSeq));
			}
			fileVO.setNttAtclSeq(vo.getNttAtclSeq());
			fileVO.setEmplSeq(vo.getEmplSeq());
			fileVO.setOrdr(1);
			
			fileService.upload(file, fileVO);
		}
		if(StringUtil.isEmpty(vo.getNttSeq())) {
			return rqbodService.insertNttRqbod(vo);
		}else {
			return rqbodService.updateNttMst(vo);
		}
	}

	/**
	 * @Method Name : delRqbod
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : YESOL
	 * @Method 설명 : 요청사항 - 삭제
	 * @param vo
	 * @return
	 * @throws Exception String
	 */
	@RequestMapping(value="/delRqbod.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public  String delRqbod(@RequestBody NttVO vo ) throws Exception {
		return rqbodService.delRqbod(vo);
	}
}
