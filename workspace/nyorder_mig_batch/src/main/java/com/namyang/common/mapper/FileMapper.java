package com.namyang.common.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FileMapper {
	
	void insertFileName(Map<String, Object> param);

}
