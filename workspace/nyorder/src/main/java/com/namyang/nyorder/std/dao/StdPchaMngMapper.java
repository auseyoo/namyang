package com.namyang.nyorder.std.dao;

import java.util.List;

import com.namyang.nyorder.comm.vo.MenuRoleVO;
import com.namyang.nyorder.std.vo.StdPchaMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 기준정보관리 - 매입처 관리 Mapper
 * 파일명  : StdPchaMngMapper.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
public interface StdPchaMngMapper {
	/**
	 * @Method Name : selectPchaList
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 리스트 조회
	 * @param param
	 * @return List<RtgdVO>
	 */
	public List<StdPchaMngVO> selectPchaList(StdPchaMngVO param);
	
	/**
	 * @Method Name : selectPchaDetail
	 * @작성일 : 2022. 1. 11.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 상세 조회
	 * @param param
	 * @return PchaVO
	 */
	public StdPchaMngVO selectPchaDetail(StdPchaMngVO param);
	
	/**
	 * @Method Name : updatePchaDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 정보 수정
	 * @param vo
	 * @return int
	 */
	public int updatePchaDetail(StdPchaMngVO vo);
	
	/**
	 * @Method Name : updatePchaDetail
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 정보 저장
	 * @param vo
	 * @return int
	 */
	public int insertPchaDetail(StdPchaMngVO vo);
	
	/**
	 * @Method Name : removePcha
	 * @작성일 : 2022. 1. 12.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 삭제
	 * @param vo
	 * @return int
	 */
	public int removePcha(StdPchaMngVO vo);
	
	/**
	 * @Method Name : getNextPuchCd
	 * @작성일 : 2022. 1. 13.
	 * @작성자 : 윤이준
	 * @Method 설명 : 매입처 코드 생성
	 * @param StdPchaMngVO
	 * @return String
	 */
	public String getNextPuchCd( StdPchaMngVO vo );
}
