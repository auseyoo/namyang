package com.namyang.nyorder.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.ext.DestinationDataProvider;
import com.namyang.nyorder.config.YamlPropertySourceFactory;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class SapRfcCall {
	
	private ComJCoClient comJCoClient;
	
	@Value(value = "${sap.jcoAshost}")
	private String jcoAshost;
	
	@Value(value = "${sap.jcoMsserv}")
	private String jcoMsserv;
	
	@Value(value = "${sap.jcoSysnr}")
	private String jcoSysnr;
	
	@Value(value = "${sap.jcoClient}")
	private String jcoClient;
	
	@Value(value = "${sap.jcoUser}")
	private String jcoUser;
	
	@Value(value = "${sap.jcoPasswd}")
	private String jcoPasswd;
	
	@Value(value = "${sap.jcoLang}")
	private String jcoLang;
	
	@Value(value = "${sap.jcoGroup}")
	private String jcoGroup;
	
	@Value(value = "${sap.jcoPoolCapacity}")
	private String jcoPoolCapacity;
	
	@Value(value = "${sap.jcoPeakLimit}")
	private String jcoPeakLimit;
	
	@Value(value = "${sap.jcoNycDestName}")
	private String jcoNycDestName;
	
	@Value(value = "${sap.jcoNycDestPooled}")
	private String jcoNycDestPooled;	
		/**
	 * 함수 기능 설명
	 *
	 * @param args
	 *            void
	 * @throws JCoException
	 */
	public HashMap<String, Object> sapTest() throws JCoException {
		
		SapRfcCall sapRfcCall = new SapRfcCall();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		HashMap<String, Object> resultMap = sapRfcCall.getCreditSend(paramMap);				
		return resultMap;
	}

	public HashMap<String, Object> getCreditSend(HashMap<String, Object> paramMap) throws JCoException {
		
		log.debug("getCreditSend paramMap ::" + paramMap);
		
		Properties sysProp = new Properties();

		sysProp.setProperty("JCO.AsHost",  jcoAshost);
		sysProp.setProperty("JCO.MsPort",  jcoMsserv);		
		sysProp.setProperty("JCO.SysNr",   jcoSysnr);
		sysProp.setProperty("JCO.Client",  jcoClient);
		sysProp.setProperty("JCO.User",    jcoUser);
		sysProp.setProperty("JCO.Passwd",  jcoPasswd);
		sysProp.setProperty("JCO.Lang",    jcoLang);		
		sysProp.setProperty("JCO.Group",   jcoGroup);

		//sysProp.setProperty("JCO.CodePage",     "8500");
		sysProp.setProperty("JCO.PoolCapacity", jcoPoolCapacity);
		sysProp.setProperty("JCO.PeakLimit",    jcoPeakLimit);

		sysProp.setProperty("JCO.NYC_DEST_NAME",        jcoNycDestName);
		sysProp.setProperty("JCO.NYC_DEST_NAME_POOLED", jcoNycDestPooled);

		// try {

		// properties 사용 // ngins7512 // 2019-07-22
		// sysProp.load(Resources.getResourceAsReader("egovframework/egovProps/"+profileCls.getGloblasPropertiesSeparator()+"globals.properties"));

		CustomDestinationDataProvider provider = new CustomDestinationDataProvider();
		provider.setDestinationProperties(sysProp);

		comJCoClient = new ComJCoClient();
		comJCoClient.setDestinationDataProvider(provider);

		// } catch (Exception e) {
		// log.debug(e.toString());
		// }		
		
		SapParameter params = new SapParameter();
		params.setSapFuncionName((String)paramMap.get("IF_NAME"));
		
		/* INPUT 값 설정 */
		params.addParameter("I_BSARK", paramMap.get("I_BSARK")); // 주문 시스템 'Z002' 대리점 상온
		params.addParameter("I_KUNNR", paramMap.get("I_KUNNR")); // 주문 시스템 'Z002' 대리점 상온
				
		/* 결과값 설정 */
		SapResult results = new SapResult();
		// results.addResultId(Const.ET_OUTPUT);
		// results.addResultId(Globals.ET_OUTPUT);
		results.addResultId("ET_OUTPUT");

		// try {
		// execute
		//comJCoClient.execute(params, results);
		comJCoClient.execute(params, results, paramMap);

		// } catch (Exception e) {
		// e.printStackTrace();
		// }

		// Map<String, Object> creditSendMap = (Map<String, Object>)
		// results.getSapResult(Const.ET_RESULT);
		// if ("S".equals(creditSendMap.get(Const.RESULT_TYPE))) {
		// List<Map<String, Object>> etOutputList = (List<Map<String, Object>>)
		// results.getSapResult(Const.ET_OUTPUT);
		// creditSendMap.putAll(etOutputList.get(0));
		// }

		// Map<String, Object> creditSendMap = (Map<String, Object>)
		// results.getSapResult(Globals.ET_RESULT);
		// if ("S".equals(creditSendMap.get(Globals.RESULT_TYPE))) {
		// List<Map<String, Object>> etOutputList = (List<Map<String, Object>>)
		// results.getSapResult(Globals.ET_OUTPUT);
		// creditSendMap.putAll(etOutputList.get(0));
		// }

		@SuppressWarnings("unchecked")
		HashMap<String, Object> creditSendMap = (HashMap<String, Object>) results.getSapResult("ET_RESULT");
		
		if ("S".equals(creditSendMap.get("E_TYPE"))) {
			
			@SuppressWarnings("unchecked")
			List<Map<String, Object>> etOutputList = (List<Map<String, Object>>) results.getSapResult("ET_OUTPUT");
			
			creditSendMap.putAll(etOutputList.get(0));
		}

		
	
		log.debug(creditSendMap.toString());
		return creditSendMap;
	}
}
