package com.namyang.nyorder.sample.service;

import java.util.HashMap;
import java.util.List;

public interface SampleService {
	
	List<HashMap> selectSampleList(HashMap<String, Object> param);
	
	void insSample(List<HashMap> param);

}
