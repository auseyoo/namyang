package com.namyang.nyorder.prdbndchg.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StdPrdBndChgServiceImpl implements StdPrdBndChgService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 표준제품 일괄 변경
	 */
	@Transactional
	public void update() {
		log.debug("==========================표준제품 일괄 변경 START===========================");
		sqlSessionTemplate.update("com.namyang.nyorder.prdbndchg.mapper.StdPrdBndChgMapper.update");
		log.debug("==========================표준제품 일괄 변경 END===========================");
	}

}
