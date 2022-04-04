package com.namyang.nyorder.prmt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.agn.dao.InvryMstMapper;
import com.namyang.nyorder.agn.vo.InvryMstVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.prmt.dao.PrmtAgenMngMapper;
import com.namyang.nyorder.prmt.vo.PrmtAgenMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 입고 관리 Service Implement
 * 파일명  : PrmtAgenMngServiceImpl.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 23.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class PrmtAgenMngServiceImpl implements PrmtAgenMngService {
	
	@Autowired
	private PrmtAgenMngMapper prtmAgenMngMapper;
	
	@Autowired
	private InvryMstMapper invryMstMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 *	판촉물 입고 조회
	 */
	@Override
	public Map<String, Object> selectPrmtAgenMngList(PrmtAgenMngVO param) {
		List<PrmtAgenMngVO> data = prtmAgenMngMapper.selectPrmtAgenMngList(param); 
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", data);
		result.put("cnt", data.size());
		return result;
	}
	
	@Override
	@Transactional
	public String savePrmtAgenMng(List<PrmtAgenMngVO> list) {
		for(PrmtAgenMngVO param : list) {
			param.setAgenSeq(userInfo.getAgenSeq());
			param.setEmplSeq(userInfo.getEmplSeq());
			param.setDvyfgRqstMonth(param.getReqYm());

			if(param.getCrudMode().equals("C")) {
				if(!param.getPrmtAgenSeq().equals("0")) {
					prtmAgenMngMapper.insPrmtAgenMng(param);
				}else {
					prtmAgenMngMapper.insPrmtAgenMngOthCom(param);
				} 
			} 
			else if(param.getCrudMode().equals("U")) {
				
				updateInvryWrhsBefPrmtChg(param);
				if(!param.getPrmtAgenSeq().equals("0")) {										
					prtmAgenMngMapper.updPrmtAgenMng(param);
				}else {
					prtmAgenMngMapper.updPrmtAgenMngOthCom(param);
				} 
			} 
			else if(param.getCrudMode().equals("D")) {
				
				updateInvryWrhsBefPrmtChg(param);
				if(!param.getPrmtAgenSeq().equals("0")) {
					prtmAgenMngMapper.delPrmtAgenMng(param);
				}else {
					prtmAgenMngMapper.delPrmtAgenMngOthCom(param);
				} 
			}
			
			updateInvryWrhsAfterPrmtChg(param);
		}
		return "정상적으로 저장되었습니다.";
	}
	
	/**
	 *	재고마스터 - 입고수량 수정
	 *	판촉물 입고 데이터 수정/삭제 이전에 재고 - 입고수량 '-' 처리
	 */
	@Override
	public void updateInvryWrhsBefPrmtChg(PrmtAgenMngVO param) {
		
		List<PrmtAgenMngVO> prtmAgenMngList = null; 
		PrmtAgenMngVO prtmAgenMngData = null;
		param.setSaleCd(userInfo.getSaleCd());
		
		if(!param.getPrmtAgenSeq().equals("0")) {
			param.setSearchPrmtAgenMngSeq(param.getPrmtAgenMngSeq());
			prtmAgenMngList = prtmAgenMngMapper.selectPrmtAgenMngList(param); 
		}else {
			param.setSearchOthComPrmtSeq(param.getOthComPrmtSeq());
			prtmAgenMngList = prtmAgenMngMapper.selectPrmtAgenMngList(param); 
		} 
		if(prtmAgenMngList != null)
			prtmAgenMngData = prtmAgenMngList.get(0);
	
		// 재고테이블 - 입고수량 '-' 처리
		InvryMstVO invryParam = new InvryMstVO();
		invryParam.setAgenSeq(prtmAgenMngData.getAgenSeq());
		invryParam.setPuchSeq(prtmAgenMngData.getPuchSeq());
		invryParam.setPrdDtlSeq(prtmAgenMngData.getPrdDtlSeq());
		invryParam.setFaltQty(param.getFaltQty());
		invryParam.setStdrDt(prtmAgenMngData.getWrhsDt());
		invryParam.setWrhsBoxQty(prtmAgenMngData.getWrhsBoxQty());
		invryParam.setWrhsIddyQty(prtmAgenMngData.getWrhsIddyQty());		
		invryParam.setEmplSeq(param.getEmplSeq());
		invryMstMapper.updInvryWrhsBefPrmtChg(invryParam);
		
		invryMstMapper.updStdPrdInvryAfterUpd(invryParam);
	}
	
	/**
	 *	재고마스터 - 입고수량 수정
	 *	판촉물 입고 데이터 등록/수정/삭제 이후에 재고테이블 - 입고수량 적용
	 */
	@Override
	public void updateInvryWrhsAfterPrmtChg(PrmtAgenMngVO param) {
	
		// 재고테이블 - 입고수량 적용
		InvryMstVO invryParam = new InvryMstVO();
		invryParam.setAgenSeq(param.getAgenSeq());
		invryParam.setPuchSeq(param.getPuchSeq());
		invryParam.setPrdDtlSeq(param.getPrdDtlSeq());		
		invryParam.setFaltQty(param.getFaltQty());
		invryParam.setStdrDt(param.getWrhsDt());
		invryParam.setWrhsBoxQty(param.getWrhsBoxQty());
		invryParam.setWrhsIddyQty(param.getWrhsIddyQty());
		invryParam.setEmplSeq(param.getEmplSeq());
		invryMstMapper.merInvryWrhsAfterPrmtChg(invryParam);
		
		// 입고수량 적용일 포함, 이후일자 재고 갱신 프로시저 호출
		invryMstMapper.updStdPrdInvryAfterUpd(invryParam);
	}
	
		
	/**
	 *	판촉물 조회
	 */
	@Override
	public Map<String, Object> selectPrmtList(PrmtAgenMngVO param) {
		List<PrmtAgenMngVO> data = prtmAgenMngMapper.selectPrmtList(param); 
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", data);
		return result;
	}
}
