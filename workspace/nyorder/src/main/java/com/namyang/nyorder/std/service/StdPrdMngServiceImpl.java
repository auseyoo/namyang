package com.namyang.nyorder.std.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.std.dao.StdPrdMngMapper;
import com.namyang.nyorder.std.vo.StdPrdBndChgVO;
import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;
import com.namyang.nyorder.std.vo.StdPrdMngVO;
import com.namyang.nyorder.util.StringUtil;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  :  기준벙보관리 - 표준 제품 관리 Service Implement
 * 파일명  : StdPrdMngServiceImpl.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 11.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class StdPrdMngServiceImpl implements StdPrdMngService {
	
	@Autowired
	private StdPrdMngMapper stdPrdMngMapper;
	
	@Resource(name="userInfo")
	private UserInfo userInfo;
	
	/**
	 * 제품 마스터 조회
	 */
	public List<StdPrdMngVO> selectPrdMstList(StdPrdMngVO param) {
		return stdPrdMngMapper.selectPrdMstList(param);
	}
	/**
	 * 표준 제품 조회
	 */
	public List<StdPrdMngVO> selectStdPrdMngList(StdPrdMngVO param) {
		return stdPrdMngMapper.selectStdPrdMngList(param);
	}

	/**
	 * 표준 제품 상세 조회
	 */
	public StdPrdMngDetailVO selectStdPrdMngDetail(StdPrdMngDetailVO param) {
		return stdPrdMngMapper.selectStdPrdMngDetail(param);
	}
	
	/**
	 *표준 제품 저장
	 */
	@Transactional
	public String saveStdPrdDetail(StdPrdMngDetailVO vo) {
		if(StringUtil.isEmpty(vo.getPrdOrdr())){
			vo.setPrdOrdr(null);
		}
		stdPrdMngMapper.updateStdAllPrdOrdr(vo);
		if(StringUtil.isEmpty(vo.getPrdDtlSeq())) {
			stdPrdMngMapper.updateStdPRdYn(vo);
			stdPrdMngMapper.insertStdPrdDetail(vo);
		}else {
			stdPrdMngMapper.UpdateStdPrdDetail(vo);
		}
		return "저장되었습니다.";
	}
	/**
	 * 표준 제품 삭제
	 */
	@Transactional
	public String delStdPrdDetail(StdPrdMngDetailVO vo) {
		stdPrdMngMapper.delStdPrdDetail(vo);
		return "삭제되었습니다.";
	}
	/**
	 * 표준 제품 순서 저장
	 */
	@Transactional
	public String saveStdPrdOrdr(List<StdPrdMngDetailVO> list) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		prdOrd = 1;

		List<StdPrdMngDetailVO> ordrList = new ArrayList<>(); 
		list.forEach(o -> {
			if(StringUtil.isNotEmpty(o.getPrdOrdr())) {
				ordrList.add(o);
			}
		});
		Collections.sort(ordrList, new StdPrdOrdrComparator());
		list.forEach(o -> {
			if(StringUtil.isEmpty(o.getPrdOrdr())) {
				ordrList.add(o);
			}
		});
		
		ordrList.forEach(o -> {
			o.setEmplSeq(userInfo.getEmplSeq());
			o.setAgenSeq(userInfo.getAgenSeq());
			if(StringUtil.isNotEmpty(o.getPrdOrdr())) {
				o.setPrdOrdr(String.valueOf(prdOrd));
				prdOrd++;
			}else {
				o.setPrdOrdr(null);
			}
			stdPrdMngMapper.updateStdPrdOrdr(o);
		});
		
		return "저장되었습니다.";
	}
	int prdOrd = 1;

	/**
	 * 표준 제품 리스트 저장
	 */
	@Transactional
	public String addStdPrdList(List<StdPrdMngDetailVO> list) {
		int result = 0;
		for(StdPrdMngDetailVO vo : list) {
			vo.setAgenSeq(userInfo.getAgenSeq());
			vo.setEmplSeq(userInfo.getEmplSeq());
			vo.setPrdOrdr(null);
			// 표준 제품 동일 번호 해제
			stdPrdMngMapper.updateStdPRdYn(vo);
			
			result += stdPrdMngMapper.insertStdPrdDetail(vo);
		}
		return result+"건 저장되었습니다.";
	}
	/**
	 * 표준 제품 일괄 변경 - 저장
	 */
	@Transactional
	public String saveStdPrdBndChgList(List<StdPrdBndChgVO> list) {
		int result = 0;
		String today = new SimpleDateFormat("yyyyMMdd").format( Calendar.getInstance().getTime());
		
		String tmpDate = "";
		for(StdPrdBndChgVO vo : list) {
			vo.setAgenSeq(userInfo.getAgenSeq());
			vo.setEmplSeq(userInfo.getEmplSeq());
			if("C".equals(vo.getCrudMode())) {
				result += stdPrdMngMapper.insertStdPrdBndChg(vo);
				tmpDate = vo.getApplDt().replaceAll("-", "");
			}else if("U".equals(vo.getCrudMode())) {
				result += stdPrdMngMapper.updateStdPrdBndChg(vo);
				
			}else if("D".equals(vo.getCrudMode())) {
				result += stdPrdMngMapper.delStdPrdBndChg(vo);
			}
		}
		if(StringUtil.isNotEmpty(tmpDate)) {
			if(today.equals(tmpDate)) {
				stdPrdMngMapper.updateStdPrdBndChgProc();
			}
		}
		return result+"건 저장되었습니다.";
	}
	/**
	 * 표준제품 일괄변경 - 리스트 조회
	 */
	public List<StdPrdBndChgVO> selectStdPrdBndChgList(StdPrdBndChgVO param) {
		return stdPrdMngMapper.selectStdPrdBndChgList(param);
	}
}



class StdPrdOrdrComparator implements Comparator<StdPrdMngDetailVO> {

	@Override
	public int compare(StdPrdMngDetailVO s1, StdPrdMngDetailVO s2) {
		if ( Float.parseFloat(s1.getPrdOrdr()) > Float.parseFloat(s2.getPrdOrdr())) {
				return 1;
		} else if (Float.parseFloat(s1.getPrdOrdr()) < Float.parseFloat(s2.getPrdOrdr())) {
			return -1;
		}
		return 0;
	}
}

