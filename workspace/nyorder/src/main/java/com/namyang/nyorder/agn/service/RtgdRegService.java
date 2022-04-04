package com.namyang.nyorder.agn.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.OrdRegVO;
import com.namyang.nyorder.agn.vo.RtgdVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품등록 Service
 * 파일명  : RtgdRegService.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 1. 04.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 04.    LEEJUN     최조 프로그램 작성
 *
 ****************************************************/
public interface RtgdRegService {
	
	/**
	 * 반품등록 리스트 조회
	 */
	/**
	 * @Method Name : selectRtgdRegList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 리스트 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectRtgdRegList(RtgdVO param);
	
	/**
	 * 반품등록 - 표준제품 불러오기
	 */
	/**
	 * @Method Name : selectStdPrdList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 표준제품 불러오기
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectStdPrdList(RtgdVO param);
	
	/**
	 * 반품등록 - 전월반품 불러오기
	 */
	/**
	 * @Method Name : selectPrevRtgdList
	 * @작성일 : 2022. 2. 03.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 전월반품 불러오기
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectPrevRtgdList(RtgdVO param);	
	
	/**
	 * @Method Name : saveRtgdRegList
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 저장
	 * @param param
	 * @return RtgdVO
	 */
	public String saveRtgdRegList(List<RtgdVO> param);	
	
	/**
	 * @Method Name : sendRtgdReg
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 전송
	 * @param param
	 * @return RtgdVO
	 */
	public String sendRtgdReg(List<RtgdVO> param);
	
	/**
	 * @Method Name : selectTrnstYn
	 * @작성일 : 2022. 2. 04.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 전송여부 조회
	 * @param param
	 * @return RtgdVO
	 */
	public String selectTrnstYn(RtgdVO param);
	
	/**
	 * @Method Name : selectSavedYn
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 저장여부 조회
	 * @param param
	 * @return RtgdVO
	 */
	public String selectSavedYn(RtgdVO param);
	
	/**
	 * @Method Name : selectPrdList
	 * @작성일 : 2022. 2. 07.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 제품등록 팝업창 - 제품리스트
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectPrdList(RtgdVO param);
}
