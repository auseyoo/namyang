package com.namyang.nyorder.cst.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.cst.controller.CstMngController;
import com.namyang.nyorder.cst.dao.CstMngMapper;
import com.namyang.nyorder.cst.vo.CstMngVO;
import com.namyang.nyorder.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자 관리  Service CstMngService
 * 파일명  : CstMngServiceImpl.java
 * 작성자  : DongJoo
 * 작성일  : 2022. 2. 8.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    DongJoo     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Service
public class CstMngServiceImpl implements CstMngService {
	
	@Autowired
	private CstMngMapper cstMngMapper;
		
	@Resource(name="userInfo")
	UserInfo userInfo;

	/**
	 * @Method Name : selectArea
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : DongJoo
	 * @Method 설명 : area 조회
	 * @param param
	 * @return List<CstMngVO>
	 */
	@Override
	public List<CstMngVO> selectArea(CstMngVO param) {
		return cstMngMapper.selectArea(param);
	}

	
	/**
	 * @Method Name : selectCstArea
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : DongJoo
	 * @Method 설명 : area - 애음자 조회
	 * @param param
	 * @return List<CstMngVO>
	 */
	@Override
	public List<CstMngVO> selectCstArea(CstMngVO param) {
		
		if(!StringUtil.isEmpty(param.getTargetAreaSeq())){
			param.setAreaSeqArr(param.getTargetAreaSeq().split(","));
		}
		return cstMngMapper.selectCstArea(param);
	}


	/** 
	 * @Method Name : selectCstContract
	 * @작성일 : 2022. 2. 15.
	 * @작성자 : DongJoo
	 * @Method 설명 : 애음자 관리 - 배달 정보(탭) - 지역, 애음자 검색 -> 계약 정보
	 * @param param
	 * @return List<CstMngVO>
	 */
	@Override
	public List<CstMngVO> selectCstContract(CstMngVO param) {
		return cstMngMapper.selectCstContract(param);
	}
	
	public int saveFreeDsctPop(List<CstMngVO> list) throws Exception{
		
		int cnt =0;
		for(CstMngVO cstMngVO : list) {		
			
			cnt = cnt + cstMngMapper.saveFreeDsctPop(cstMngVO);
			
		}
		
		return cnt;
	}
	
	public List<CstMngVO> selectPopPrdSearchList(CstMngVO param){
		
		return cstMngMapper.selectPopPrdSearchList(param);
	}
	
	public int saveCstPrd(CstMngVO param) {
		int cnt =0;
		
		param.setAgenSeq(userInfo.getAgenSeq());		
		param.setEmplSeq(userInfo.getEmplSeq());
		
		
		cnt = cnt + cstMngMapper.saveCstPrd(param);
		cnt = cnt + cstMngMapper.saveCstPrdUntpc(param);
		
		for(CstMngVO cstMngVO : param.getPttnData()) {
			
			cstMngVO.setAgenSeq(userInfo.getAgenSeq());
			cstMngVO.setEmplSeq(userInfo.getEmplSeq());
			cstMngVO.setAreaSeq(param.getAreaSeq());
			cstMngVO.setPuchSeq(param.getPuchSeq());
			cstMngVO.setCstSeq(param.getCstSeq());
			cstMngVO.setPrdDtlSeq(param.getPrdDtlSeq());
			cstMngVO.setCstPrdSeq(param.getCstPrdSeq());
			
			cnt = cnt + cstMngMapper.saveCstPttn(cstMngVO);			
		}
		
		for(CstMngVO cstMngVO : param.getPrmtData()) {
									
			cstMngVO.setAgenSeq(userInfo.getAgenSeq());
			cstMngVO.setEmplSeq(userInfo.getEmplSeq());
			cstMngVO.setAreaSeq(param.getAreaSeq());
			cstMngVO.setPuchSeq(param.getPuchSeq());
			cstMngVO.setCstSeq(param.getCstSeq());
			cstMngVO.setPrdDtlSeq(param.getPrdDtlSeq());
			cstMngVO.setCstPrdSeq(param.getCstPrdSeq());
			
			cnt = cnt + cstMngMapper.saveCstPrdPrmt(cstMngVO);			
		}
		
		return cnt;
	}
	
	public int savePdRerv(List<CstMngVO> list) throws Exception{
		
		int cnt =0;
		for(CstMngVO cstMngVO : list) {		
			
			cnt = cnt + cstMngMapper.savePdRerv(cstMngVO);
			
		}
		
		return cnt;
		
	}
	
	public int saveReDlv(CstMngVO cstMngVO) throws Exception{
		return cstMngMapper.saveReDlv(cstMngVO);
	}
	
	public int saveCntrEnd (List<CstMngVO> list) throws Exception{
		int cnt =0;
		for(CstMngVO cstMngVO : list) {					
			cnt = cnt + cstMngMapper.updCstPrdUntpc(cstMngVO);			
		}		
		return cnt;
		
	}
	
}
