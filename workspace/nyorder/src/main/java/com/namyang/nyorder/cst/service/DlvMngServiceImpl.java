package com.namyang.nyorder.cst.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.cst.dao.DlvMngMapper;
import com.namyang.nyorder.cst.vo.CstDlvNtcVO;
import com.namyang.nyorder.cst.vo.CstPrdDlvyVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 배달 관리 Service Implement
 * 파일명  : DlvMngServiceImpl.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 28.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 28.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class DlvMngServiceImpl implements DlvMngService {

	@Autowired
	private DlvMngMapper dlvMngMapper;
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 * 지역 배달 리스트 조회
	 */
	public List<CstPrdDlvyVO> selectDailDlvAreaList(CstPrdDlvyVO param) {
		return dlvMngMapper.selectDailDlvAreaList(param);
	}

	/**
	 * 배달 품목 리스트 조회
	 */
	public List<CstPrdDlvyVO> selectDailDlvDetailList(CstPrdDlvyVO param) {
		return dlvMngMapper.selectDailDlvDetailList(param);
	}

	/**
	 * 배달 고객 정보 조회
	 */
	public List<CstPrdDlvyVO> selectDailDlvCstDetailList(CstPrdDlvyVO param) {
		return dlvMngMapper.selectDailDlvCstDetailList(param);
	}
	
	/**
	 * 배달 전달사항 리스트 조회
	 */
	public List<CstDlvNtcVO> selectCstDlvNtcList(CstDlvNtcVO param) {
		return dlvMngMapper.selectCstDlvNtcList(param);
	}

	/**
	 *	배달 고객 리스트 조회  (SELECT BOX)
	 */
	public List<CstPrdDlvyVO> selectDlvCstList(CstPrdDlvyVO param) {
		return dlvMngMapper.selectDlvCstList(param);
	}

	/**
	 * 배달 지역 리스트 조회  (SELECT BOX)
	 */
	public List<CstPrdDlvyVO> selectDlvAreaList(CstPrdDlvyVO param) {
		return dlvMngMapper.selectDlvAreaList(param);
	}

	/**
	 * 배달 전달사항 저장
	 */
	@Transactional
	public int addCstDlvNtc(CstDlvNtcVO vo) {
		return dlvMngMapper.addCstDlvNtc(vo);
	}

	/**
	 * 배달 전달사항 삭제
	 */
	public String rmvCstDlvNtc(List<CstDlvNtcVO> list) {
		for(CstDlvNtcVO vo : list) {
			dlvMngMapper.rmvCstDlvNtc(vo);
		}
		return "삭제되었습니다.";
	}

	/**
	 * 지역 순서 변경
	 */
	@Transactional
	public String saveAreaDlvOrdr(List<CstPrdDlvyVO> list) {
		for(CstPrdDlvyVO vo : list) {
			dlvMngMapper.saveAreaDlvOrdr(vo);
		}
		return "저장되었습니다.";
	}

	/**
	 * 고객 배송 정보 수정
	 */
	@Transactional
	public String saveDlvCstDtl(List<CstPrdDlvyVO> list) {
		for(CstPrdDlvyVO vo : list) {
			vo.setEmplSeq(userInfo.getEmplSeq());
			vo.setAgenSeq(userInfo.getAgenSeq());
			dlvMngMapper.saveDlvCstDtl(vo);	// 배송 순서 변경 저장
			if(StringUtils.equals("Y", vo.getUndlvYn())) {
				// 미배송 처리 추가 해야함.
			}
		}
		return "저장되었습니다.";
	}

}
