package com.namyang.nyorder.prmt.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.prmt.vo.PrmtAgenRqstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 소요량 요청 관리 Service
 * 파일명  : PrmtAgenRqstService.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 23.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
public interface PrmtAgenRqstService {

	/**
	 * 판촉물 소요량 요청월 조회
	 */
	/**
	 * @Method Name : selectDvyfgRqstMonth
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청월 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public PrmtAgenRqstVO selectDvyfgRqstMonth(PrmtAgenRqstVO param);	
	
	/**
	 * 판촉물 소요량 요청 조회
	 */
	/**
	 * @Method Name : selectPrmtAgenRqstList
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectPrmtAgenRqstList(PrmtAgenRqstVO param);	
	
	/**
	 * 판촉물 소요량 요청 최종전송시각
	 */
	/**
	 * @Method Name : selectAgenRqstLastSend
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 최종전송시각
	 * @param param
	 * @return List<HashMap>
	 */
	public PrmtAgenRqstVO selectAgenRqstLastSend(PrmtAgenRqstVO param);	
	
	/**
	 * @Method Name : savePrmtAgenRqst
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 저장
	 * @param param
	 * @return PrmtAgenRqstVO
	 */
	public String savePrmtAgenRqst(List<PrmtAgenRqstVO> list);		
	
	/**
	 * @Method Name : selectSavedYn
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 반품등록 - 저장여부 조회
	 * @param param
	 * @return RtgdVO
	 */
	public String selectSavedYn(PrmtAgenRqstVO param);

	/**
	 * @Method Name : sendPrmtAgenRqst
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 전송
	 * @param param
	 * @return PrmtAgenRqstVO
	 */
	public String sendPrmtAgenRqst(PrmtAgenRqstVO list);	
}


