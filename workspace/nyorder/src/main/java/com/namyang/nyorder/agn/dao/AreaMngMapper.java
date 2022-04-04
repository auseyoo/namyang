package com.namyang.nyorder.agn.dao;

import java.util.List;

import com.namyang.nyorder.agn.vo.AreaMngVO;
import com.namyang.nyorder.agn.vo.CstAreaHisVO;
import com.namyang.nyorder.agn.vo.EmplVO;
import com.namyang.nyorder.myp.vo.AgenAcctInfoVO;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자관리 - 지역관리
 * 파일명  : AreaMngMapper.java
 * 작성자  : GAIN
 * 작성일  : 2022. 2. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 11.    GAIN     최조 프로그램 작성
 * 2022. 3. 17.	   YESOL	이관
 *
 ****************************************************/
public interface AreaMngMapper {

	
	/**
	 * @Method Name : selectAgenAreaList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 지역 목록 조회
	 * @param param
	 * @return List<AreaMngVO>
	 */
	public List<AreaMngVO> selectAgenAreaList(AreaMngVO param);
	
	/**
	 * @Method Name : selectAgenAreaListByOrdr
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자 관리 - 지역관리 - 순서 변경 리스트
	 * @param param
	 * @return List<AreaMngVO>
	 */
	
	public List<AreaMngVO> selectAreaOrdrList(AreaMngVO param);
	
	/**
	 * @Method Name : selectAreaMngDetail
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : GAIN
	 * @Method 설명 : 지역 상세 조회
	 * @param param
	 * @return AreaMngVO
	 */
	public AreaMngVO selectAreaMngDetail(AreaMngVO param);
	
	/**
	 * @Method Name : updateAgenAreaListByOrdr
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자 관리 - 지역관리 - 순서 번경 저장
	 * @param param
	 * @return List<AreaMngVO>
	 */
	public int updateAreaOrdr(AreaMngVO param);
	
	/**
	 * @Method Name : updateAreaMngDetail
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : YESOL
	 * @Method 설명 : 
	 * @param param void
	 */
	public void updateAreaMngDetail(AreaMngVO vo);
	/**
	 * @Method Name : addAreaMngDetail
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : YESOL
	 * @Method 설명 : 
	 * @param param void
	 */
	public void addAreaMngDetail(AreaMngVO vo);
	
	/**
	 * @Method Name : getNextAgenAreaCd
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 지역 코드 생성
	 * @param param
	 * @return String
	 */
	public String getNextAgenAreaCd( AreaMngVO param );
	
	/**
	 * @Method Name : selectEmplList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 세부 정보 - 판매원명
	 * @param param
	 * @return List<AreaMngVO>
	 */
	public List<EmplVO> selectEmplList(EmplVO param);
	/**
	 * @Method Name : selectEmplAcctList
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자 관리 - 지역관리 - 순서 변경 - 계좌 관련 
	 * @param param
	 * @return List<AreaMngVO>
	 */
	public List<AgenAcctInfoVO> selectEmplAcctList(AreaMngVO param);
	
	/**
	 * @Method Name : selectCstAreaChgList
	 * @작성일 : 2022. 2. 17.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 리스트 조회
	 * @param vO
	 * @return List<CstAreaHisVO>
	 */
	public List<CstAreaHisVO> selectCstAreaChgList(CstAreaHisVO vO);
	
	/**
	 * @Method Name : selectCstAreaHisList
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 - 지역변경 이력 리스트조회
	 * @param vO
	 * @return List<AreaMngVO>
	 */
	public List<CstAreaHisVO> selectCstAreaHisList(CstAreaHisVO param);

	/**
	 * @Method Name : addCstAgenAreaChg
	 * @작성일 : 2022. 3. 24.
	 * @작성자 : YESOL
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 - 저장
	 * @param vo
	 * @return Integer
	 */
	public Integer addCstAgenAreaChg(CstAreaHisVO vo);

	/**
	 * @Method Name : selectAfterAreaInfo
	 * @작성일 : 2022. 3. 24.
	 * @작성자 : YESOL
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 - 변경 지역 정보 조회
	 * @param cstAreaHisVO
	 * @return CstAreaHisVO
	 */
	public CstAreaHisVO selectAfterAreaInfo(CstAreaHisVO cstAreaHisVO);
	
	
	
}
