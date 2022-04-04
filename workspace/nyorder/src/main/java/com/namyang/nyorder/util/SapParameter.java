package com.namyang.nyorder.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SapParameter {
	
	public SapParameter() {
		params = new HashMap<String, Object>();
		sapTable = new HashMap<String, List<Map<String, Object>>>();
	}

	/* function 정보 설정 */
	private String funcName;

	public void setSapFuncionName(String functionName) {

		funcName = functionName;
	}

	public String getSapFuncionName() {

		return funcName;
	}

	/* parameter 정보 설정 */
	private Map<String, Object> params; // 파라미터 정보

	public boolean isParmeterEmpty() {

		return params == null || params.isEmpty();
	}

	public void addParameter(String param, Object value) {

		params.put(param, value);
	}

	public Set<String> getParmeterSet() {
		return params.keySet();
	}

	public Object getParameter(String key) {
		return params.get(key);
	}

	/* input table 정보 설정 */
	private Map<String, List<Map<String, Object>>> sapTable;

	public boolean isSapTableEmpty() {

		return sapTable == null || sapTable.isEmpty();
	}

	public void makeNewSapTable(String tableName) {

		sapTable.put(tableName, new ArrayList<Map<String, Object>>());
	}

	public void addSapTable(String tableName, Map<String, Object> table) {

		sapTable.get(tableName).add(table);
	}

	public Set<String> getSapTableSet() {
		return sapTable.keySet();
	}

	public List<Map<String, Object>> getSapTable(String key) {

		return sapTable.get(key);
	}

}
