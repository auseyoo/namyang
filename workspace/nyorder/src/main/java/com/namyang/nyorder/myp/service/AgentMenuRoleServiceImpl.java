package com.namyang.nyorder.myp.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.comm.vo.CommCodeVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.dao.AgentMenuRoleMapper;
import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 권한 관리 Service Implement
 * 파일명  : AgentMenuRoleServiceImpl.java
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
@Service
public class AgentMenuRoleServiceImpl implements AgentMenuRoleService{

	@Autowired
	private AgentMenuRoleMapper agentMenuRoleMapper;

	@Resource(name="userInfo")
	private UserInfo userInfo;
	
	/**
	 *	그룹별 권한 리스트 조회
	 */
	public Map<String, Object> selectAgentMenuRoleGrpList(AgentMenuRoleVO param) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", agentMenuRoleMapper.selectAgentMenuRoleGrpList(param));
		result.put("lastUpd", agentMenuRoleMapper.selectAgentMenuRoleGrpLastUpd(param));
		return result;
	}
	
	/**
	 *	직원별 권한 리스트 조회
	 */
	public Map<String, Object> selectAgentMenuRoleEmpList(AgentMenuRoleVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", agentMenuRoleMapper.selectAgentMenuRoleEmpList(param));
		result.put("lastUpd", agentMenuRoleMapper.selectAgentMenuRoleEmpLastUpd(param));
		return result;
	}
	
	
	/**
	 *	직원 리스트 조회
	 */
	public List<CommCodeVO> selectEmplSeqList(AgentMenuRoleVO param) {
		return agentMenuRoleMapper.selectEmplSeqList(param);
	}
	
	/**
	 *	직원 권한 리스트 저장
	 */
	@Transactional
	public String saveEmplList(List<AgentMenuRoleVO> list) throws Exception {
		for(AgentMenuRoleVO one : list) {
			one.setAgenSeq(userInfo.getAgenSeq());
			one.setEmplSeq(userInfo.getEmplSeq());
			agentMenuRoleMapper.updateEmpl(one);
		}
		return "저장되었습니다.";
	}
	
	/**
	 *	그룹별 권한 리스트 저장
	 */
	@Transactional
	public String saveEmplGrpList(List<AgentMenuRoleVO> list) throws Exception {
		for(AgentMenuRoleVO one : list) {
			one.setAgenSeq(userInfo.getAgenSeq());
			one.setEmplSeq(userInfo.getEmplSeq());
			agentMenuRoleMapper.updateEmplGrp(one);
		}
		return "저장되었습니다.";
	}
	
}
