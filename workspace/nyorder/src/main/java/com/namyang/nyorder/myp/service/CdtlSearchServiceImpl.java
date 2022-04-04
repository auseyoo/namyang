package com.namyang.nyorder.myp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.myp.dao.CdtlSearchMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 여신 조회 Service Implement
 * 파일명  : CdtlSearchServiceImpl.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 7.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Service
public class CdtlSearchServiceImpl implements CdtlSearchService {
	@Autowired
	CdtlSearchMapper cdtlSearchMapper;
}
