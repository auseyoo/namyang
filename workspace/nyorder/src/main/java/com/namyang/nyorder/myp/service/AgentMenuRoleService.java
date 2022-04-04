package com.namyang.nyorder.myp.service;

import java.util.List;
import java.util.Map;

import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 권한 관리 Service
 * 파일명  : AgentMenuRoleService.java
 * 작성자  : YESOL
 * 작성일  : 2021. 12. 31.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 12. 31.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
public interface AgentMenuRoleService {
	/**
	 * 그룹별 권한 리스트 조회
	 */
	/**
	 * @Method Name : selectAgentMenuRoleGrpList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectAgentMenuRoleGrpList(AgentMenuRoleVO param);
	
	/**
	 * 직원별 권한 리스트 조회  
	 */
	/**
	 * @Method Name : selectAgentMenuList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 
	 * @param param
	 * @return List<HashMap>
	 */
	public Map<String, Object> selectAgentMenuRoleEmpList(AgentMenuRoleVO param);
	
	
	/**
	 * 직원 리스트 조회
	 */
	public List<CommCodeVO> selectEmplSeqList(AgentMenuRoleVO param);
	
	/**
	 * 직원별 권한 저장
	 */
	public String saveEmplList(List<AgentMenuRoleVO> vo) throws Exception;
	/**
	 * 그룹별 권한 저장
	 */
	public String saveEmplGrpList(List<AgentMenuRoleVO> vo) throws Exception;
}
