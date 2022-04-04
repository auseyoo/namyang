package com.namyang.nyorder.prmt.dao;

import java.util.List;

import com.namyang.nyorder.prmt.vo.PrmtAgenMngVO;
import com.namyang.nyorder.prmt.vo.PrmtAgenRqstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 소요량 요청 관리 Mapper
 * 파일명  : PrmtAgenRqstMapper.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 2. 23.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
public interface PrmtAgenRqstMapper {
	
	
	/**
	 * @Method Name : selectDvyfgRqstMonth
	 * * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청월 조회
	 * @param param
	 * @return List<PrmtRqstMngVO>
	 */
	public PrmtAgenRqstVO selectDvyfgRqstMonth(PrmtAgenRqstVO param);
	
	/**
	 * @Method Name : selectPrmtAgenRqstList
	 * * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 조회
	 * @param param
	 * @return List<PrmtAgenRqstVO>
	 */
	public List<PrmtAgenRqstVO> selectPrmtAgenRqstList(PrmtAgenRqstVO param);
	
	/**
	 * @Method Name : selectAgenRqstLastSend
	 * * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 최종전송시각
	 * @param param
	 * @return List<PrmtRqstMngVO>
	 */
	public PrmtAgenRqstVO selectAgenRqstLastSend(PrmtAgenRqstVO param);
	
	/**
	 * @Method Name : updPrmtAgenRqst
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 수정
	 * @param param
	 * @return void
	 */
	public void updPrmtAgenRqst(PrmtAgenRqstVO param);	
	
	/**
	 * @Method Name : insPrmtAgenRqst
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 등록
	 * @param param
	 * @return void
	 */
	public void insPrmtAgenRqst(PrmtAgenRqstVO param);
	
	/**
	 * @Method Name : selectSavedYn
	 * @작성일 : 2022. 3. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 저장여부 조회
	 * @param param
	 * @return String
	 */
	public String selectSavedYn(PrmtAgenRqstVO param);
	
	/**
	 * @Method Name : updPrmtAgenRqstSend
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청 대리점 주문 전송
	 * @param param
	 * @return void
	 */
	public void updPrmtAgenRqstSend(PrmtAgenRqstVO param);
	
	
	/**
	 * @Method Name : merStdPrdDetail
	 * @작성일 : 2022. 3. 23.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 소요량 요청(남양제품)시에 판촉물 제품이 제품상세(T_PRD_DRL)에 존재하지 않을때, INSERT 하기
	 * @param param
	 * @return void
	 */
	public void merStdPrdDetail(PrmtAgenRqstVO param);	
}
