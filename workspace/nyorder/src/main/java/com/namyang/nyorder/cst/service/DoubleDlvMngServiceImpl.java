package com.namyang.nyorder.cst.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.config.error.exception.BusinessException;
import com.namyang.nyorder.cst.dao.DoubleDlvMngMapper;
import com.namyang.nyorder.cst.vo.DoubleDlvMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 더블 작업 Service Implement
 * 파일명  : DoubleDlvMngServiceImpl.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 3. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 14.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class DoubleDlvMngServiceImpl implements DoubleDlvMngService {

	@Autowired
	private DoubleDlvMngMapper doubleDlvMngMapper;
	@Resource(name="userInfo")
	UserInfo userInfo;


    public String startDoubleProc(Map<String, Object> param) throws BusinessException {
    	DoubleDlvMngVO doubleDlvMngVo = new DoubleDlvMngVO();
    	SimpleDateFormat dateForm = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = dateForm.format(c1.getTime());


    	if(param.get("legacyDlvDt").equals(param.get("chgDlvDt"))) {
    		throw new BusinessException("alert.doubleMsg01");
    	}
    	if(Integer.parseInt(((String)param.get("legacyDlvDt")).replaceAll("-", "")) >Integer.parseInt(((String)param.get("chgDlvDt")).replaceAll("-", ""))) {
    		throw new BusinessException("alert.doubleMsg02");
    	}
    	if(Integer.parseInt(strToday) >Integer.parseInt(((String)param.get("chgDlvDt")).replaceAll("-", "")) ||
    			Integer.parseInt(strToday) >Integer.parseInt(((String)param.get("legacyDlvDt")).replaceAll("-", "")) ) {
    		throw new BusinessException("alert.doubleMsg04");
    	}
    	List<String> areaSeqArr= (List<String>) param.get("areaSeqArr");
    	List<String> prdDtlSeqArr= (List<String>) param.get("prdDtlSeqArr");
    	doubleDlvMngVo.setAreaSeq(StringUtils.join(areaSeqArr,","));
    	doubleDlvMngVo.setPrdDtlSeq(StringUtils.join(prdDtlSeqArr,","));

    	doubleDlvMngVo.setAgenSeq((String)param.get("agenSeq"));
    	doubleDlvMngVo.setEmplSeq((String)param.get("emplSeq"));
    	doubleDlvMngVo.setLegacyDlvDt((String)param.get("legacyDlvDt"));
    	doubleDlvMngVo.setChgDlvDt((String)param.get("chgDlvDt"));
    	doubleDlvMngVo.setDoubleSecCd((String)param.get("doubleSecCd"));
    	/*물량 빠질 날짜 출고 데이터 INSERT*/
    	doubleDlvMngVo.setDlvyDt((String)param.get("legacyDlvDt"));
    	doubleDlvMngMapper.megCstPrdDlvy(doubleDlvMngVo);

    	/*물량 합쳐질 날짜 출고 데이터 INSERT*/
    	doubleDlvMngVo.setDlvyDt((String)param.get("chgDlvDt"));
    	doubleDlvMngMapper.megCstPrdDlvy(doubleDlvMngVo);


    	/*더블 작업 진행*/
		for( String areaSeq : areaSeqArr ) {
			doubleDlvMngVo.setAreaSeq(areaSeq);
			for( String prdDtlSeq : prdDtlSeqArr ) {
				doubleDlvMngVo.setPrdDtlSeq(prdDtlSeq);
				doubleDlvMngVo.setDoubleSecCd("DOUBLE");
				List<DoubleDlvMngVO> doubleList = doubleDlvMngMapper.selectDoubleList(doubleDlvMngVo);
				if(doubleList.size() ==0) {
					List<DoubleDlvMngVO> legacyData= doubleDlvMngMapper.selectLegacyDlvData(doubleDlvMngVo);
					if(legacyData.size() >0) {
						doubleDlvMngMapper.updateLegacyQtyZero(doubleDlvMngVo);
						doubleDlvMngMapper.insDoubleMst(doubleDlvMngVo);
						for(DoubleDlvMngVO tempDoubleVO : legacyData) {
							tempDoubleVO.setEmplSeq(doubleDlvMngVo.getEmplSeq());
							tempDoubleVO.setDlvyDt((String)param.get("chgDlvDt"));
							tempDoubleVO.setCstDoubleMstSeq(doubleDlvMngVo.getCstDoubleMstSeq());

							doubleDlvMngMapper.megStatDoubleDlv(tempDoubleVO);
							doubleDlvMngMapper.insDoubleDtl(tempDoubleVO);
						}
					}
				}
			}
		}
		return "완료되었습니다.";
    }

    public String returnDoubleProc(Map<String, Object> param) throws BusinessException {
    	DoubleDlvMngVO doubleDlvMngVo = new DoubleDlvMngVO();
    	SimpleDateFormat dateForm = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = dateForm.format(c1.getTime());

    	if(param.get("legacyDlvDt").equals(param.get("chgDlvDt"))) {
    		throw new BusinessException("alert.doubleMsg01");
    	}
    	if(Integer.parseInt(((String)param.get("legacyDlvDt")).replaceAll("-", "")) <Integer.parseInt(((String)param.get("chgDlvDt")).replaceAll("-", ""))) {
    		throw new BusinessException("alert.doubleMsg03");
    	}
    	if(Integer.parseInt(strToday) >Integer.parseInt(((String)param.get("chgDlvDt")).replaceAll("-", "")) ||
    			Integer.parseInt(strToday) >Integer.parseInt(((String)param.get("legacyDlvDt")).replaceAll("-", "")) ) {
    		throw new BusinessException("alert.doubleMsg04");
    	}
    	List<String> areaSeqArr= (List<String>) param.get("areaSeqArr");
    	List<String> prdDtlSeqArr= (List<String>) param.get("prdDtlSeqArr");
    	doubleDlvMngVo.setAreaSeq(StringUtils.join(areaSeqArr,","));
    	doubleDlvMngVo.setPrdDtlSeq(StringUtils.join(prdDtlSeqArr,","));

    	doubleDlvMngVo.setAgenSeq((String)param.get("agenSeq"));
    	doubleDlvMngVo.setEmplSeq((String)param.get("emplSeq"));
    	doubleDlvMngVo.setLegacyDlvDt((String)param.get("chgDlvDt"));
    	doubleDlvMngVo.setChgDlvDt((String)param.get("legacyDlvDt"));

    	/*더블 작업 진행*/
		for( String areaSeq : areaSeqArr ) {
			doubleDlvMngVo.setAreaSeq(areaSeq);
			for( String prdDtlSeq : prdDtlSeqArr ) {
				doubleDlvMngVo.setPrdDtlSeq(prdDtlSeq);

				List<DoubleDlvMngVO> doubleList = doubleDlvMngMapper.selectDoubleList(doubleDlvMngVo);
				if(doubleList.size() >0) {
					for(DoubleDlvMngVO tempDoubleVO : doubleList) {
						tempDoubleVO.setEmplSeq(doubleDlvMngVo.getEmplSeq());
						tempDoubleVO.setQtyUpdateType("PLUS");
						tempDoubleVO.setCstPrdDlvySeq(tempDoubleVO.getSendDlvSeq());
						doubleDlvMngMapper.updateDlvyQty(tempDoubleVO);

						tempDoubleVO.setQtyUpdateType("MINUS");
						tempDoubleVO.setCstPrdDlvySeq(tempDoubleVO.getRcivDlvSeq());
						doubleDlvMngMapper.updateDlvyQty(tempDoubleVO);

						tempDoubleVO.setDoubleSecCd("RETURN");
						doubleDlvMngMapper.updateReturnYn(tempDoubleVO);
					}
				}
			}
		}
    	return "완료되었습니다.";
    }

}
