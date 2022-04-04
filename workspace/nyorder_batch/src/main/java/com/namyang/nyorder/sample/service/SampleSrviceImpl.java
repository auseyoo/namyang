package com.namyang.nyorder.sample.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.common.service.TestService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SampleSrviceImpl implements SampleService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Resource(name="pamsSqlSessionTemplate")
	private SqlSessionTemplate pamsSqlSessionTemplate;
	
	@Resource(name="oracleSqlSessionTemplate")
	private SqlSessionTemplate oracleSqlSessionTemplate;
	
	
	public List<HashMap> selectSampleList(HashMap<String, Object> param){
		
		pamsSqlSessionTemplate.selectList("com.namyang.nyorder.pams.sample.mapper.SampleMapper.selectSampleList", param);
		
		oracleSqlSessionTemplate.selectList("com.namyang.nyorder.ora.sample.mapper.SampleMapper.selectSampleList", param);		
		
		return sqlSessionTemplate.selectList("com.namyang.nyorder.sample.mapper.SampleMapper.selectSampleList", param);
		
	}
	
	public void insSample(List<HashMap> param) {
		
		int cnt = 0;
		
		for(HashMap<String, Object> hm : param) {
			
			cnt = cnt + sqlSessionTemplate.insert("com.namyang.nyorder.sample.mapper.SampleMapper.insSample", hm);
		}
		log.debug("insSample  cnt :: " + cnt);
	}

}
