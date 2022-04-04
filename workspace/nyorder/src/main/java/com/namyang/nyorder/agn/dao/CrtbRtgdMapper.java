package com.namyang.nyorder.agn.dao;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.agn.vo.CrtbRtgdVO;
import com.namyang.nyorder.agn.vo.InvryMstVO;
import com.namyang.nyorder.agn.vo.RtgdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 크레이트 반납 관리 Mapper
 * 파일명  : CrtbRtgdMapper.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 2. 15.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
public interface CrtbRtgdMapper {

	/**
	 * @Method Name : selectCrtbRtgdList
	 * * @작성일 : 2022. 2. 15.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 반납 데이터 조회
	 * @param param
	 * @return List<CrtbRtgdVO>
	 */
	public List<CrtbRtgdVO> selectCrtbRtgdList(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectCrtbCdList
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 조회
	 * @param param
	 * @return List<CrtbRtgdVO>
	 */
	public List<CrtbRtgdVO> selectCrtbCdList(CrtbRtgdVO param);
	
	/**
	 * @Method Name : megCrtbRtgd
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 반납 업데이트
	 * @param param
	 * @return void
	 */
	public void megCrtbRtgd(CrtbRtgdVO param);
	
	/**
	 * @Method Name : updStdPrdCrtbAfterUpd
	 * @작성일 : 2022. 2. 22.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 크레이트 반납 변경 이후일자 자동 업데이트
	 * @param param
	 * @return void
	 */
	public void updStdPrdCrtbAfterUpd(CrtbRtgdVO param);	
}
