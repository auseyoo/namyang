package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.RtgdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품등록 Mapper
 * 파일명  : RtgdRegMapper.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 03.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 03.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
public interface RtgdRegMapper {

	/**
	 * @Method Name : selectRtgdRegList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 리스트 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<RtgdVO> selectRtgdRegList(RtgdVO param);
	
	/**
	 * @Method Name : selectStdPrdList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 표준제품 불러오기
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<RtgdVO> selectStdPrdList(RtgdVO param);
	
	/**
	 * @Method Name : selectPrevRtgdList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 전월반품 불러오기
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<RtgdVO> selectPrevRtgdList(RtgdVO param);

	/**
	 * @Method Name : megOrdRtgd
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 저장
	 * @param param
	 * @return null
	 */
	public void megOrdRtgd(RtgdVO param);	
	
	/**
	 * @Method Name : sendOrdRtgd
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 전송
	 * @param param
	 * @return null
	 */
	public void sendOrdRtgd(RtgdVO param);	
	
	/**
	 * @Method Name : delOrdRtgd
	 * @작성일 : 2022. 2. 07.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품 삭제
	 * @param param
	 * @return null
	 */
	public void delOrdRtgd(RtgdVO param);		
	
	/**
	 * @Method Name : selectTrnstYn
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 전송여부 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public String selectTrnstYn(RtgdVO param);
	
	/**
	 * @Method Name : selectSavedYn
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 저장여부 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public String selectSavedYn(RtgdVO param);
	
	/**
	 * @Method Name : selectPrevRtgdList
	 * @작성일 : 2022. 2. 07.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 제품등록 팝업창 - 제품리스트
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<RtgdVO> selectPrdList(RtgdVO param);
	
}
