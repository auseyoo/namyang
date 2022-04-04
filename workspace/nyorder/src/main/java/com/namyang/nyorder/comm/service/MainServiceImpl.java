package com.namyang.nyorder.comm.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.agn.service.OrdrDcsnDlyService;
import com.namyang.nyorder.agn.vo.OrdrDcsnDlyVO;
import com.namyang.nyorder.cmmc.vo.NttVO;
import com.namyang.nyorder.comm.dao.MainMapper;
import com.namyang.nyorder.comm.vo.CommVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.util.SapRfcCall;
import com.sap.conn.jco.JCoException;

@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	private MainMapper mainMapper;
	
	@Autowired
	private OrdrDcsnDlyService ordrDcsnDlyService;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	@Autowired
	SapRfcCall sapRfcCall;
	
	public List<NttVO> selectMainNotice(){
		List<NttVO> data = mainMapper.selectMainNotice();
		return data;
	}
	
	public Map<String, Object> selectMainCredit(){
		
		// 여신 조회
		HashMap<String, Object> ifParam = new HashMap<String, Object>();
		
		ifParam.put("IF_NAME", "ZFC_SD_IF_CREDIT_SEND");
		ifParam.put("I_BSARK", "Z002");
		ifParam.put("I_KUNNR", userInfo.getAgenCd());
						
		HashMap<String, Object> ifResult = new HashMap<String, Object>();
		try {
			ifResult = sapRfcCall.getCreditSend(ifParam);
		} catch (JCoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 현재 주문 합계 조회
		CommVO paramOrdTotAmount = new CommVO();
		paramOrdTotAmount.setAgenSeq(userInfo.getAgenSeq());
		int ordTotAmount = mainMapper.selectOrdTotAmount(paramOrdTotAmount);

		// 조회 기준 시간
		Date nowDate = new Date(); 
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
		String reloadTime = simpleDateFormat.format(nowDate); 
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		// 조회 기준 시간
		result.put("reloadTime", reloadTime);
		
		// 현재 여신 금액
		result.put("creditLimit", ifResult.get("CREDIT_LIMIT"));
		
		// 현재 주문 합계
		result.put("ordTotAmount", ordTotAmount);
		
		return result;
	}
	
	public Map<String, Object> selectMainDly(){
		
		Map<String, Object> result = new HashMap<String, Object>();		
		OrdrDcsnDlyVO param = new OrdrDcsnDlyVO();
		param.setAgenSeq(userInfo.getAgenSeq());
		param.setOrdType("GNRL");
		param.setSearchType("main");
		return ordrDcsnDlyService.selectOrdrDcsnDlyList( param );
	}
}
