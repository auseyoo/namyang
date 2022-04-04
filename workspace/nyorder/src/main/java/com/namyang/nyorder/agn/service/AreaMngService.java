package com.namyang.nyorder.agn.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.agn.vo.AreaMngVO;
import com.namyang.nyorder.agn.vo.CstAreaHisVO;
import com.namyang.nyorder.agn.vo.EmplVO;
import com.namyang.nyorder.agn.vo.VendVO;
import com.namyang.nyorder.myp.vo.AgenAcctInfoVO;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자관리 - 지역관리
 * 파일명  : AreaMngService.java
 * 작성자  : GAIN	-> 박예솔
 * 작성일  : 2022. 2. 11.	->	2022.3.17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 11.    GAIN     최조 프로그램 작성
 * 2022. 3. 17.	   YESOL	이관
 ****************************************************/
public interface AreaMngService {

	
	/**
	 * @Method Name : selectAgenAreaList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN	-> YeSoL
	 * @Method 설명 : 지역 목록 조회
	 * @param param
	 * @return List<AreaMngVO>
	 */
	public List<AreaMngVO> selectAgenAreaList(AreaMngVO param);
	
	/**
	 * @Method Name : selectAreaMngDetail
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : GAIN
	 * @Method 설명 : 지역 상세 조회
	 * @param param
	 * @return List<AreaMngVO> 
	 */
	public AreaMngVO selectAreaMngDetail(AreaMngVO param);
	
	/**
	 * @Method Name : selectAreaOrdrList
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 순서 변경 리스트
	 * @param param
	 * @return Map<String,Object>
	 */
	public List<AreaMngVO> selectAreaOrdrList(AreaMngVO param);
	
	/**
	 * @Method Name : updateAreaOrdr
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 순서 변경 저장
	 * @param param
	 * @return Map<String,Object>
	 * @throws Exception 
	 */
	public Map<String, Object> updateAreaOrdrList(List<AreaMngVO> param) throws Exception;
	
	/**
	 * @Method Name : saveAreaMng
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자 관리 - 지역 관리 - 세부정보 수정/등록
	 * @param param
	 * @return Map<String,Object>
	 * @throws Exception 
	 */
	public Map<String, Object> saveAreaMng(AreaMngVO param) throws Exception;	
	
	/**
	 * @Method Name : getNextPuchCd
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 신규 지역 코드 조회
	 * @param vo
	 * @return String
	 */
	public String getNextAgenAreaCd( AreaMngVO vo );	
	
	/**
	 * @Method Name : selectEmplList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자 관리 - 지역관리 - 상세보기 - 판매원명 (모달)
	 * @param param
	 * @return List<AreaMngVO>
	 */
	public List<EmplVO> selectEmplList(EmplVO param);
	/**
	 * @Method Name : selectEmplAcctList
	 * @작성일 : 2022. 2. 7.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자 관리 - 지역관리 - 상세보기 - 판매원명 (모달 - 계좌) 
	 * @param param
	 * @return List<AgenAcctInfoVO>
	 */
	public List<AgenAcctInfoVO> selectEmplAcctList(AreaMngVO param);

	/**
	 * @Method Name : selectCstAreaChgList
	 * @작성일 : 2022. 2. 17.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 지역 애음자 리스트 조회
	 * @param param
	 * @return List<CstAreaHisVO>
	 */
	public List<CstAreaHisVO> selectCstAreaChgList(CstAreaHisVO param);
	
	/**
	 * @Method Name : selectCstAreaHisList
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 - 지역변경 이력 리스트 조회
	 * @param param
	 * @return Map<String,Object>
	 */
	public List<CstAreaHisVO> selectCstAreaHisList(CstAreaHisVO param);
	
	
	
	
	
	
	
	
	
	
	
	
	


	
	/**
	 * @Method Name : saveCstAgenAreaChg
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 저장
	 * @param param
	 * @return Map<String,Object>
	 */
	public Map<String, Object> saveCstAgenAreaChg(List<CstAreaHisVO> list);
	
}
