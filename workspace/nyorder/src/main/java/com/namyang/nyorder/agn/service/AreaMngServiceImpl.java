package com.namyang.nyorder.agn.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.agn.dao.AreaMngMapper;
import com.namyang.nyorder.agn.vo.AreaMngVO;
import com.namyang.nyorder.agn.vo.CstAreaHisVO;
import com.namyang.nyorder.agn.vo.EmplVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.myp.vo.AgenAcctInfoVO;
import com.namyang.nyorder.util.StringUtil;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자관리 - 지역관리
 * 파일명  : AreaMngServiceImpl.java
 * 작성자  : GAIN
 * 작성일  : 2022. 2. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일			 변경자		   변경내역
 * --------------------------------------------------
 * 2022. 2. 11.	GAIN	 최조 프로그램 작성
 * 2022. 3. 17.	   YESOL	이관
 *
 ****************************************************/
@Service
public class AreaMngServiceImpl implements AreaMngService {
	
	private Logger logger = LoggerFactory.getLogger(AreaMngServiceImpl.class);
	
	@Autowired
	private AreaMngMapper areaMngMapper;
	
	@Resource(name="userInfo")
	private UserInfo userInfo;
	
	int prdOrd = 1;

	/**
	 * @Method Name : selectAgenAreaList
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN	-> YeSoL
	 * @Method 설명 : 지역 목록 조회
	 * @param param
	 * @return List<AreaMngVO>
	 */
	public List<AreaMngVO> selectAgenAreaList(AreaMngVO param) {
		return areaMngMapper.selectAgenAreaList(param);
	}
	
	/**
	 * @Method Name : selectAreaMngDetail
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : GAIN
	 * @Method 설명 : 지역 상세 조회
	 * @param param
	 * @return Map<String,Object>
	 */
	@Override
	public AreaMngVO selectAreaMngDetail(AreaMngVO param) {
		return areaMngMapper.selectAreaMngDetail(param);
	}
	
	/**
	 * @Method Name : selectEmplList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 세부 정보 - 판매원명
	 * @param param
	 * @return List<AreaMngVO>
	 */
	public List<EmplVO> selectEmplList(EmplVO param) {
		return areaMngMapper.selectEmplList(param);
	}
	
	/**
	 * 애음자관리 - 지역관리 - 순서 변경 리스트 조회
	 */
	
	public List<AreaMngVO> selectAreaOrdrList(AreaMngVO param) {
		return areaMngMapper.selectAreaOrdrList(param);
	}
	
	/**
	 *	애음자관리 - 지역관리 - 순서 변경 저장
	 */
	@Transactional
	public Map<String, Object> updateAreaOrdrList(List<AreaMngVO> list) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		prdOrd = 1;
		
		List<AreaMngVO> ordrList = new ArrayList<>(); 
		list.forEach(o -> {
			if(StringUtil.isNotEmpty(o.getAreaOrdr())) {
				ordrList.add(o);
			}
		});
		
		Collections.sort(ordrList, new OrdrComparator());
		
		list.forEach(o -> {
			if(StringUtil.isEmpty(o.getAreaOrdr())) {
				ordrList.add(o);
			}
		});
	
		ordrList.forEach(o -> {
			o.setEmplSeq(userInfo.getEmplSeq());
			o.setAgenSeq(userInfo.getAgenSeq());
			
			if(StringUtil.isNotEmpty(o.getAreaOrdr())) {
				o.setAreaOrdr(String.valueOf(prdOrd));
				prdOrd++;
			}else {
				o.setAreaOrdr(null);
			}
			areaMngMapper.updateAreaOrdr(o);
		});
		resultMap.put("res", true);
		resultMap.put("msg", "저장되었습니다." );
		return resultMap;
	}
	
	/**
	 * @Method Name : getNextPuchCd
	 * @작성일 : 2022. 1. 25.
	 * @작성자 : GAIN
	 * @Method 설명 : 신규 지역 코드 조회 
	 * @param vo
	 * @return String
	 */
	public String getNextAgenAreaCd( AreaMngVO vo ) {
		return areaMngMapper.getNextAgenAreaCd(vo);
	}

	/**
	 * @Method Name : saveAreaMng
	 * @작성일 : 2022. 1. 28.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자 관리 - 지역 관리 - 세부정보 수정/등록
	 * @param param
	 * @return Map<String,Object>
	 */
	@Transactional
	public Map<String, Object> saveAreaMng(AreaMngVO vo) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(StringUtil.isEmpty(vo.getAreaSeq())) {
			areaMngMapper.addAreaMngDetail(vo);
		}else {
			areaMngMapper.updateAreaMngDetail(vo);
		}
		resultMap.put("res", true);
		resultMap.put("msg", "저장되었습니다." );
	
		return resultMap;
	}
	
	
	/**
	 * @Method Name : selectEmplAcctList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 세부 정보 - 판매원명(계좌)
	 * @param param
	 * @return List<AgenAcctInfoVO
	 */
	public List<AgenAcctInfoVO> selectEmplAcctList(AreaMngVO param){
		return areaMngMapper.selectEmplAcctList(param);
	}
	
	/**
	 * 애음자관리 - 지역관리 - 지역 애음자 리스트 조회
	 */
	public List<CstAreaHisVO> selectCstAreaChgList(CstAreaHisVO param) {
		return areaMngMapper.selectCstAreaChgList(param);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * @Method Name : selectCstAreaHisList
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 - 지역변경 이력 리스트 조회
	 * @param vO
	 * @return List<CstAreaHisVO>
	 */
	public List<CstAreaHisVO> selectCstAreaHisList(CstAreaHisVO param) {
		return areaMngMapper.selectCstAreaHisList(param);
	}
	/**
	 * @Method Name : selectCstAreaHisList
	 * @작성일 : 2022. 2. 23.
	 * @작성자 : GAIN
	 * @Method 설명 : 애음자관리 - 지역관리 - 애음자 지역변경 저장
	 * @param param
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> saveCstAgenAreaChg(List<CstAreaHisVO> list) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int resultCnt = 0;
		
		for(CstAreaHisVO vo : list) {
			vo.setAgenSeq(userInfo.getAgenSeq());
			vo.setEmplSeq(userInfo.getEmplSeq());
			
			resultCnt = areaMngMapper.addCstAgenAreaChg(vo);
		}
		
		CstAreaHisVO rtnData = areaMngMapper.selectAfterAreaInfo(new CstAreaHisVO() {{
			setAgenSeq(userInfo.getAgenSeq());
			setAreaSeq(list.get(0).getAfterAreaSeq());
		}});
		
		resultMap.put("res", true);
		resultMap.put("resultCnt", resultCnt);
		resultMap.put("rtnData", rtnData);
		return resultMap;
	}
	
}


class OrdrComparator implements Comparator<AreaMngVO> {

	@Override
	public int compare(AreaMngVO o1, AreaMngVO o2) {
		if ( Float.parseFloat(o1.getAreaOrdr()) > Float.parseFloat(o2.getAreaOrdr())) {
				return 1;
		} else if (Float.parseFloat(o1.getAreaOrdr()) < Float.parseFloat(o2.getAreaOrdr())) {
			return -1;
		}
		return 0;
	}
}

