package com.namyang.nyorder.cmmc.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.cmmc.vo.NttVO;


public interface RqbodService {


	/**
	 * @Method Name : selectRqstList
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 요청사항 - 글 리스트 조회
	 * @param param
	 * @return List<NttVO>
	 */
	public List<NttVO> selectRqstList(NttVO param);

	/**
	 * @Method Name : selectRqst
	 * @작성일 : 2022. 3. 16.
	 * @작성자 : YESOL
	 * @Method 설명 : 커뮤니케이션관리 - 요청사항 - 글 상세 조회
	 * @param vO
	 * @return NttVO
	 */
	public NttVO selectRqst(NttVO vO);
	
	/**
	 * @Method Name : updateNttMst
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 요청사항 - 수정 - 글 내용 수정
	 * @param vo
	 * @return String
	 */
	public Map<String, Object> updateNttMst(NttVO vo) throws Exception;


	/**
	 * @Method Name : insertNttRqbod
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 요청사항 등록
	 * @param vo
	 * @return Map<String,Object>
	 * @throws Exception 
	 */
	public Map<String, Object> insertNttRqbod(NttVO vo) throws Exception;


	/**
	 * @Method Name : selectNttAtcl
	 * @작성일 : 2022. 3. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 첨부파일 불러오기
	 * @param vO
	 * @return Map<String,Object>
	 */
	public Map<String, Object> selectNttAtcl(NttVO vO);


	/**
	 * @Method Name : delRqbod
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : YESOL
	 * @Method 설명 : 요청사항 삭제
	 * @param vo
	 * @return String
	 * @throws Exception 
	 */
	public String delRqbod(NttVO vo) throws Exception;

}
