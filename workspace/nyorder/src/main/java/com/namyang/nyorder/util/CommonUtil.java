package com.namyang.nyorder.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.support.JdbcUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CommonUtil {

	
	public static HashMap<String, Object> setMapKeyToCamelCase(HashMap<String, Object> param){
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>(); 
		
		for (Map.Entry<String, Object> entry : param.entrySet()) {
			
			resultMap.put(JdbcUtils.convertUnderscoreNameToPropertyName(entry.getKey()), entry.getValue());
			
			System.out.println("[key]:" + JdbcUtils.convertUnderscoreNameToPropertyName(entry.getKey()) + ", [value]:" + entry.getValue());
		}
		
		return resultMap;
	}

}
