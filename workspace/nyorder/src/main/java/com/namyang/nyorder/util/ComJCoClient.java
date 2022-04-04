package com.namyang.nyorder.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.namyang.nyorder.config.db.DatabaseConfig;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoField;
import com.sap.conn.jco.JCoFieldIterator;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.sap.conn.jco.ext.DestinationDataProvider;
import com.sap.conn.jco.ext.Environment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ComJCoClient {
	
	/* static 함수 내부 에서 사용하기 위해 static로 선언함. */
	//protected Logger log = LoggerFactory.getLogger(ComJCoClient.class);

	public void setDestinationDataProvider(DestinationDataProvider provider) {

		try {
			if (!Environment.isDestinationDataProviderRegistered()) {
				Environment.registerDestinationDataProvider(provider);
			}
		} catch (IllegalStateException providerAlreadyRegisteredException) {
			throw new Error(providerAlreadyRegisteredException);
		}
	}

	/**
	 * 결과값이 Table 인 경우 처리
	 * 
	 * @param funcName
	 *            실행함수명
	 * @param params
	 *            파라미터
	 * @return list
	 * @throws JCoException
	 */
	public void execute(SapParameter params, SapResult results, Map<String,Object> paramMap) throws JCoException {

		// JCoDestination destination = JCoDestinationManager.getDestination(Const.NYC_DEST_NAME_POOLED);
		// JCoDestination destination = JCoDestinationManager.getDestination(Globals.NYC_DEST_NAME_POOLED);
		JCoDestination destination = JCoDestinationManager.getDestination("NYC_SAP_POOL");
		
//		SapParameter params = new SapParameter();
//		params.setSapFuncionName("ZFC_SD_IF_CREDIT_SEND");		
		//JCoDestination destination = JCoDestinationManager.getDestination(params.getParameter("Globals.NYC_DEST_NAME_POOLED").toString());
		
		JCoFunction function = destination.getRepository().getFunction(params.getSapFuncionName());

		if (function == null)
			throw new RuntimeException(params.getSapFuncionName() + " not found in SAP.");

		/* parameter 설정 */
		if (!params.isParmeterEmpty()) {

			/* parameter 설정 */
			for (String key : params.getParmeterSet()) {
				function.getImportParameterList().setValue(key, params.getParameter(key));
			}
		}

		/* input table 설정 */
		if (!params.isSapTableEmpty()) {

			for (String key : params.getSapTableSet()) {

				JCoTable table = function.getTableParameterList().getTable(key);

				List<Map<String, Object>> tableParamList = params.getSapTable(key);

				for (Map<String, Object> tableParam : tableParamList) {

					table.appendRow();

					/* 각 파라미터 설정 */
					for (String name : tableParam.keySet()) {
						table.setValue(name, tableParam.get(name));
					}
				}
			}
		}

		/* FUNCTION 실행 */
//		try {
			function.execute(destination);
//		} catch (AbapException e) {
//			log.error(e.getMessageText());
//			throw e;
//		}

		/* 실행결과 Meta(성공/실패) 정보처리 */
		// String rstType = function.getExportParameterList().getValue(Const.RESULT_TYPE).toString();
		//String rstType = function.getExportParameterList().getValue(Globals.RESULT_TYPE).toString();
		String rstType = function.getExportParameterList().getValue("E_TYPE").toString();
		

		// if (!("".equals(rstType) || "S".equals(rstType)))
		// {
		// throw new
		// RuntimeException(function.getExportParameterList().getValue(Const.RESULT_MESSAGE).toString());
		// }

		Map<String, Object> rstTypeMap = new HashMap<String, Object>();

		// rstTypeMap.put(Const.RESULT_TYPE, rstType);
		// rstTypeMap.put(Const.RESULT_MESSAGE, function.getExportParameterList().getValue(Const.RESULT_MESSAGE));
		// results.addResultMap(Const.ET_RESULT, rstTypeMap);

//		rstTypeMap.put(Globals.RESULT_TYPE, rstType);
//		rstTypeMap.put(Globals.RESULT_MESSAGE, function.getExportParameterList().getValue(Globals.RESULT_MESSAGE));
//		results.addResultMap(Globals.ET_RESULT, rstTypeMap);
		
		
		log.debug("getResultIds rstType  :: " + rstType);
		
		log.debug("getResultIds E_MESSAGE  :: " + function.getExportParameterList().getValue("E_MESSAGE"));
		
		rstTypeMap.put("E_TYPE", rstType);
		rstTypeMap.put("E_MESSAGE", function.getExportParameterList().getValue("E_MESSAGE"));
		results.addResultMap("ET_RESULT", rstTypeMap);

		log.debug("results  :: " + results);
		
		/* 결과 설정 */
		if (results != null && !results.isEmpty()) {

			for (String id : results.getResultIds()) {
				
				log.debug("getResultIds id  :: " + id);

				JCoTable tables = function.getTableParameterList().getTable(id);

				/* 결과데이터 처리 */
				List<Map<String, Object>> rstMapList = new ArrayList<Map<String, Object>>();
				
				log.debug("getResultIds getNumRows  :: " + tables.getNumRows());

				for (int i = 0; i < tables.getNumRows(); i++) {
					tables.setRow(i);
					
					JCoFieldIterator fieldIterator = tables.getFieldIterator();

					Map<String, Object> rstMap = new HashMap<String, Object>();

					while (fieldIterator.hasNextField()) {
						
						JCoField field = fieldIterator.nextField();
						log.debug("getResultIds field  :: " + field.getName() + ", ::" + field.getValue());

						rstMap.put(field.getName(), field.getValue());
					}
					rstMapList.add(rstMap);
				}
				
				results.addResultMap(id, rstMapList);
			}
		}
	}

}
