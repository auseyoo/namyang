package com.namyang.nyorder.agn.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.agn.dao.CrtbRtgdMapper;
import com.namyang.nyorder.agn.vo.CrtbRtgdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템 업무명 : 크레이트 반납 관리 Service Implement 파일명 :
 * CrtbRtgdServiceImpl.java 작성자 : JUNGAE 작성일 : 2022. 2. 15.
 *
 * 설 명 : -------------------------------------------------- 변경일 변경자 변경내역
 * -------------------------------------------------- 2022. 2. 15. LEEJUN 최조
 * 프로그램 작성
 * 
 ****************************************************/
@Service
public class CrtbRtgdServiceImpl implements CrtbRtgdService {
	@Autowired
	private CrtbRtgdMapper crtbRtgdMapper;

	@Resource(name = "userInfo")
	UserInfo userInfo;

	@Override
	public Map<String, Object> selectCrtbRtgdList(CrtbRtgdVO param) {
		Map<String, Object> result = new HashMap<String, Object>();

		// 대리점의 크레이트 조회
		List<CrtbRtgdVO> dataCrtbCds = selectCrtbCdList(param);
		
		if(dataCrtbCds.size() == 0) {
			return null;
		}	

		ArrayList<String> crtbCds = new ArrayList<String>();
		for (int i = 0; i < dataCrtbCds.size(); i++) {
			CrtbRtgdVO item = dataCrtbCds.get(i);
			crtbCds.add(item.getCrtbCd());
		}
		
		// 현재날짜
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
        Calendar c1 = Calendar.getInstance();
        String strTodayYM = sdf.format(c1.getTime());
		
        // 조회월
		String yyyyMMdd = param.getReqYm().replace("-", "");
		String year = yyyyMMdd.substring(0, 4);
		String month = yyyyMMdd.substring(4, 6);
		String yyyyMM = year + month;
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(year), Integer.parseInt(month) - 1, 1);
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		//  현재연월을 조회했을때 종료일을 현재날짜로 설정
		if(strTodayYM.equals(yyyyMM)) {
			SimpleDateFormat sdfDD = new SimpleDateFormat("dd");
	        Calendar c2 = Calendar.getInstance();
	        String strTodayDD = sdfDD.format(c2.getTime());
			lastDay = Integer.parseInt(strTodayDD);
		}
		
		// 현재연월 이후 연월 조회시 null return
		if(Integer.parseInt(strTodayYM) < Integer.parseInt(yyyyMM)) {
			return null;
		}
		
		// 데이터조회시 종료일
		String selLastYmd = yyyyMM + String.format("%02d" , lastDay);

		HashMap<String, Object> hashMapParams = new HashMap<String, Object>();
		hashMapParams.put("agenSeq", userInfo.getAgenSeq());
		hashMapParams.put("crtbCds", crtbCds);
		hashMapParams.put("reqYm", param.getReqYm().replace("-", ""));
		hashMapParams.put("selLastYmd", selLastYmd);
		
		// 크레이트 반납 데이터 조회
		List<CrtbRtgdVO> data = crtbRtgdMapper.selectCrtbRtgdList(hashMapParams);

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> myHashMap = new HashMap<String, Object>();

		int iDataIndex = 0;

		// 이전 재고 데이터map 처리
		myHashMap = new HashMap<String, Object>();
		myHashMap.put("day", "이월");
		for (int j = 0; j < crtbCds.size(); j++) {
			CrtbRtgdVO item = data.get(iDataIndex);
			myHashMap.put("rtgdQty" + (j + 1), item.getRtgdQty());
			iDataIndex++;
		}
		list.add(myHashMap);
		
		// 조회월-일별 데이터map 처리
		for (int i = 0; i < lastDay; i++) {
			myHashMap = new HashMap<String, Object>();
			myHashMap.put("day", (i + 1) + "일");

			for (int k = 0; k < crtbCds.size(); k++) {
				CrtbRtgdVO item = data.get(iDataIndex);
				myHashMap.put("crtbRtgdSeq" + (k + 1), item.getCrtbRtgdSeq());
				myHashMap.put("crtbCd" + (k + 1), item.getCrtbCd());
				myHashMap.put("selDt" + (k + 1), item.getSelDt());
				myHashMap.put("rtgdDt" + (k + 1), item.getRtgdDt());
				myHashMap.put("yestdQty" + (k + 1), item.getYestdQty());
				myHashMap.put("dlvyQty" + (k + 1), item.getDlvyQty());
				myHashMap.put("reptQty" + (k + 1), item.getReptQty());
				myHashMap.put("coletQty" + (k + 1), item.getColetQty());
				myHashMap.put("rtgdQty" + (k + 1), item.getRtgdQty());
				myHashMap.put("invryQty" + (k + 1), item.getInvryQty());
				iDataIndex++;
			}

			list.add(myHashMap);
		}
		result.put("list", list);

		return result;
	}

	@Override
	public List<CrtbRtgdVO> selectCrtbCdList(CrtbRtgdVO param) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return crtbRtgdMapper.selectCrtbCdList(param);
	}

	@Override
	@Transactional
	public String saveCrtbRtgd(List<CrtbRtgdVO> list) {
		
		String reqYm = "";
		
		// 1)크레이트 반납 데이터 처리
		for(int i=0; i<list.size(); i++) {
			CrtbRtgdVO data = list.get(i);
			data.setAgenSeq(userInfo.getAgenSeq()); 
			data.setEmplSeq(userInfo.getEmplSeq()); 
			crtbRtgdMapper.megCrtbRtgd(data);
			
			if(i == 0) 
				reqYm = data.getRtgdDt().substring(0,6);
		}

		
		// 2) 위 1번 과정 처리후, 조회월 이후의 데이터 자동업데이트 처리(재고 갱신)
		if(list.size() > 0) {
			
			// 대리점의 크레이트 조회
			CrtbRtgdVO paramCrtbCds = new CrtbRtgdVO();
			paramCrtbCds.setAgenSeq(userInfo.getAgenSeq());
			List<CrtbRtgdVO> dataCrtbCds = selectCrtbCdList(paramCrtbCds);
					
			CrtbRtgdVO paramCrtbAfterUpd = new CrtbRtgdVO();
			for (CrtbRtgdVO data : dataCrtbCds) {
				paramCrtbAfterUpd.setAgenSeq(userInfo.getAgenSeq());
				paramCrtbAfterUpd.setCrtbCd(data.getCrtbCd());
				paramCrtbAfterUpd.setReqYm(reqYm);			
				paramCrtbAfterUpd.setEmplSeq(userInfo.getEmplSeq());
				crtbRtgdMapper.updStdPrdCrtbAfterUpd(paramCrtbAfterUpd);	
			}	
		}
		
		return "정상적으로 저장되었습니다.";
	}
}
