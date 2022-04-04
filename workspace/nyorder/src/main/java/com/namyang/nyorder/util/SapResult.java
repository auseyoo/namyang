package com.namyang.nyorder.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SapResult {
	
	/* 결과 ID */
	private List<String> resultIdList;
	/* 결과 Map */
	private Map<String, Object> resultMap;

	public SapResult() {
		resultIdList = new ArrayList<String>();
		resultMap = new HashMap<String, Object>();
	}

	public boolean isEmpty() {

		return resultIdList == null || resultIdList.isEmpty();
	}

	public void addResultId(String id) {
		resultIdList.add(id);
	}

	public List<String> getResultIds() {
		return resultIdList;
	}

	public void addResultMap(String id, Object result) {
		resultMap.put(id, result);
	}

	public Object getSapResult(String id) {
		return resultMap.get(id);
	}

}
