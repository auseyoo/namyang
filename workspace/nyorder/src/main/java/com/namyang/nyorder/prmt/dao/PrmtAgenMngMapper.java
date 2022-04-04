package com.namyang.nyorder.prmt.dao;

import java.util.List;

import com.namyang.nyorder.prmt.vo.PrmtAgenMngVO;
import com.namyang.nyorder.prmt.vo.PrmtAgenRqstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 입고 관리 Mapper
 * 파일명  : PrmtAgenMngMapper.java
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
public interface PrmtAgenMngMapper {
	
	/**
	 * @Method Name : selectPrmtAgenRqstList
	 * * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 조회
	 * @param param
	 * @return List<PrmtAgenRqstVO>
	 */
	public List<PrmtAgenMngVO> selectPrmtAgenMngList(PrmtAgenMngVO param);

	/**
	 * @Method Name : insPrmtAgenRqst
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 등록
	 * @param param
	 * @return void
	 */
	public void insPrmtAgenMng(PrmtAgenMngVO param);
	
	/**
	 * @Method Name : insPrmtAgenMngOthCom
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 - 타사 판촉물 등록
	 * @param param
	 * @return void
	 */
	public void insPrmtAgenMngOthCom(PrmtAgenMngVO param);
	
	/**
	 * @Method Name : updPrmtAgenMng
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 등록/수정
	 * @param param
	 * @return void
	 */
	public void updPrmtAgenMng(PrmtAgenMngVO param);
	
	/**
	 * @Method Name : updPrmtAgenMngOthCom
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 - 타사 판촉물 수정
	 * @param param
	 * @return void
	 */
	public void updPrmtAgenMngOthCom(PrmtAgenMngVO param);
	
	/**
	 * @Method Name : delPrmtAgenMng
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 삭제
	 * @param param
	 * @return void
	 */
	public void delPrmtAgenMng(PrmtAgenMngVO param);
	
	/**
	 * @Method Name : delPrmtAgenMng
	 * @작성일 : 2022. 2. 24.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 입고 - 타사 판촉물 삭제
	 * @param param
	 * @return void
	 */
	public void delPrmtAgenMngOthCom(PrmtAgenMngVO param);
	
	/**
	 * @Method Name : selectPrmtList
	 * * @작성일 : 2022. 3. 2.
	 * @작성자 : JUNGAE
	 * @Method 설명 : 판촉물 조회
	 * @param param
	 * @return List<PrmtAgenRqstVO>
	 */
	public List<PrmtAgenMngVO> selectPrmtList(PrmtAgenMngVO param);

}
