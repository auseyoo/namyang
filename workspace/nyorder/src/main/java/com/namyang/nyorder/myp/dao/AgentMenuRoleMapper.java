package com.namyang.nyorder.myp.dao;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 권한 관리 Mapper
 * 파일명  : AgentMenuRoleMapper.java
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
public interface AgentMenuRoleMapper {
	/**
	 * @Method Name : selectAgentMenuRoleGrpList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 그룹별 권한 리스트 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public List<HashMap> selectAgentMenuRoleGrpList(AgentMenuRoleVO param);
	
	/**
	 * @Method Name : selectAgentMenuRoleGrpLastUpd
	 * @작성일 : 2022. 1. 4.
	 * @작성자 : YESOL
	 * @Method 설명 : 그룹별 권한 리스트 최종수정일 조회
	 * @param param
	 * @return AgentMenuRoleVO
	 */
	public AgentMenuRoleVO selectAgentMenuRoleGrpLastUpd(AgentMenuRoleVO param);
	
	
	/**
	 * @Method Name : selectAgentMenuRoleEmpList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 직원별 권한 리스트 조회
	 * @param param
	 * @return List<HashMap>
	 */
	public List<HashMap> selectAgentMenuRoleEmpList(AgentMenuRoleVO param);

	/**
	 * @Method Name : selectAgentMenuRoleEmpLastUpd
	 * @작성일 : 2022. 1. 4.
	 * @작성자 : YESOL
	 * @Method 설명 : 직원별 권한 리스트 최종수정일 조회
	 * @param param
	 * @return AgentMenuRoleVO
	 */
	public AgentMenuRoleVO selectAgentMenuRoleEmpLastUpd(AgentMenuRoleVO param);
	
	/**
	 * @Method Name : selectEmplSeqList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 직원 리스트 조회
	 * @param param
	 * @return List<CommCodeVO>
	 */
	public List<CommCodeVO> selectEmplSeqList(AgentMenuRoleVO param);
	

	/**
	 * @Method Name : updateEmpl
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 직원 권한 저장
	 * @param vo
	 * @return int
	 */
	public int updateEmpl(AgentMenuRoleVO vo);
	
	/**
	 * @Method Name : updateEmplGrp
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 그룹 권한 저장
	 * @param vo
	 * @return int
	 */
	public int updateEmplGrp(AgentMenuRoleVO vo);

}
