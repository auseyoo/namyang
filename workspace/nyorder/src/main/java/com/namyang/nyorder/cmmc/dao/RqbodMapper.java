package com.namyang.nyorder.cmmc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.servlet.ModelAndView;

import com.namyang.nyorder.cmmc.vo.NttVO;



@Mapper
public interface RqbodMapper {
	

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
	 * @param param
	 * @return NttVO
	 */
	public NttVO selectRqst(NttVO param);
	
	/**
	 * @Method Name : delRqbod
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 요청게시판 글 삭제
	 * @param vo
	 * @return int
	 */
	public int delRqbod(NttVO vo);



	/**
	 * @Method Name : updateNttMst
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 요청사항 게시판 - 수정 - 글 내용 수정
	 * @param vo
	 * @return int
	 */
	public int updateNttMst(NttVO vo);



	/**
	 * @Method Name : insertNttRqbod
	 * @작성일 : 2022. 3. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 요청 사항 등록
	 * @param vo
	 * @return int
	 */
	public int insertNttRqbod(NttVO vo);



	/**
	 * @Method Name : selectNttAtcl
	 * @작성일 : 2022. 3. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 첨부파일 글 불러오기
	 * @param param
	 * @return Object
	 */
	public Object selectNttAtcl(NttVO param);

}


