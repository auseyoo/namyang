package com.namyang.nyorder.sale.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.namyang.nyorder.sale.vo.BcncUntpcVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처별 단가 관리 Service
 * 파일명  : BcncUntpcMngService.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 1. 18.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 18.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
public interface BcncUntpcMngService {
	public List<BcncUntpcVO> selectUntpcMngList(BcncUntpcVO param);
	public String saveAgenVendUntpc(BcncUntpcVO param) throws Exception;
	public List<BcncUntpcVO> selectAllBcncUntpc(BcncUntpcVO param);
	public List<BcncUntpcVO> selectBcncPrdChgHis(BcncUntpcVO param);
	public List<Map<String, Object>> selectStdrPrdList(Map<String, Object> param);
}
