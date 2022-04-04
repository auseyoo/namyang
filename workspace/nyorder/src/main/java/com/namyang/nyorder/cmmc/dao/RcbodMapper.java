package com.namyang.nyorder.cmmc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.namyang.nyorder.cmmc.vo.RcbodVO;

@Mapper
public interface RcbodMapper {
	

	/**
	 * @Method Name : selectRcbodList
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 자료실 - 리스트 조회
	 * @param param
	 * @return List<RcbodVO>
	 */
	public List<RcbodVO> selectRcbodList(RcbodVO param);

	/**
	 * @Method Name : selectRcbodDtlList
	 * @작성일 : 2022. 3. 2.
	 * @작성자 : GAIN
	 * @Method 설명 : 커뮤니케이션관리 - 자료실 - 내용 조회
	 * @param param
	 * @return RcbodVO
	 */
	public List<RcbodVO> selectRcbodDtlList(RcbodVO param);

}


