package com.namyang.common.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.common.mapper.NoBatchMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * Non 배치 Service
 */
@Slf4j
@Service
public class NoBatchService {
    // Non 배치 Mapper
	@Autowired
	public NoBatchMapper noBatchMapper;

    /**
     * Instantiates a new No batch service.
     *
     * @param noBatchMapper
     */
    private NoBatchService(NoBatchMapper noBatchMapper) {
        this.noBatchMapper = noBatchMapper;
    }

    /**
     * 테이블 등록 처리
     */
    public void create() {
        noBatchMapper.create();
    }

    /**
     * 데이터 삭제 처리
     */
    public void delete() {
        noBatchMapper.delete();
    }

}
