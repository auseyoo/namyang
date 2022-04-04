package com.namyang.nyorder.cmmc.service;

import java.util.List;

import com.namyang.nyorder.cmmc.vo.RcbodVO;


public interface RcbodService {


	/**
	 * @Method Name : selectRcbodList
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : YESOL
	 * @Method 설명 : 커뮤니케이션관리 - 자료실 제목 리스트 조회
	 * @param param
	 * @return List<RcbodVO>
	 */
	public List<RcbodVO> selectRcbodList(RcbodVO param);
	

	/**
	 * @Method Name : selectRcbodDtlList
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : YESOL
	 * @Method 설명 : 커뮤니케이션관리 - 자료실 내용 조회 
	 * @param param
	 * @return List<RcbodVO>
	 */
	public List<RcbodVO> selectRcbodDtlList(RcbodVO param);




	


}
