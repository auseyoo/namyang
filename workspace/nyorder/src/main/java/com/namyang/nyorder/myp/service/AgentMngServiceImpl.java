package com.namyang.nyorder.myp.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.config.aop.SessionInfo;
import com.namyang.nyorder.myp.dao.AgentMngMapper;
import com.namyang.nyorder.myp.vo.AgentMngVO;
import com.namyang.nyorder.util.SapRfcCall;
import com.sap.conn.jco.JCoException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AgentMngServiceImpl implements AgentMngService{
	
	@Autowired
	private AgentMngMapper agentMngMapper;
	
	@SessionInfo
	public HashMap<String, Object> selectAgentMngList(AgentMngVO param) throws Exception{
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		log.debug("selectAgentMngList   == :: " + param.getAgenSeq() + ", ::" + param.getEmplSeq());
		
		HashMap<String, Object> ifParam = new HashMap<String, Object>();
		
		ifParam.put("IF_NAME", "ZFC_SD_IF_CREDIT_SEND");
		ifParam.put("I_BSARK", "Z002");
		ifParam.put("I_KUNNR", "1200295");
		
		SapRfcCall sapRfcCall = new SapRfcCall();		
		HashMap<String, Object> ifResult = sapRfcCall.getCreditSend(ifParam);
				
		log.debug("selectAgentMngList   ifResult :: " + ifResult.toString());
				
		
		List<List<AgentMngVO>> resultList = agentMngMapper.selectAgentMngList(param);		
		
		result.put("list", resultList.get(0));
		result.put("totalRow", resultList.get(1).get(0).getTotalRow());
				
		return result;
		
		
	}
	
	@SessionInfo	
	public int insertAgentMng(AgentMngVO param) {
		
		return agentMngMapper.insertAgentMng(param);
		
	}
	
	public HashMap<String, Object> selectAxis(AgentMngVO param){
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
//		SapRfcCall sapRfcCall = new SapRfcCall();
//		HashMap<String, Object> sapResult = new HashMap<String, Object>();
//		
//		try {
//			sapResult = (HashMap<String, Object>) sapRfcCall.sapTest();
//		} catch (JCoException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//				
//		log.debug("sapResult ::"+sapResult);		
						
		return result;
		
		
	}

}
