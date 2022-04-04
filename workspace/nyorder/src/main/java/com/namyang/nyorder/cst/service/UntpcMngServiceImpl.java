package com.namyang.nyorder.cst.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.cst.dao.PrdBndChgMapper;
import com.namyang.nyorder.cst.dao.UntpcMngMapper;
import com.namyang.nyorder.cst.vo.AgenAreaUntpcVO;
import com.namyang.nyorder.cst.vo.AgenAreaVO;
import com.namyang.nyorder.cst.vo.UntpcHisVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UntpcMngServiceImpl implements UntpcMngService {

    @Autowired
    UntpcMngMapper cstUntpcMngMapper;

    @Autowired
    PrdBndChgMapper prdBndChgMapper;

    @Resource
    UserInfo userInfo;

    public List<AgenAreaVO> selectAreaList(AgenAreaUntpcVO param) {
        param.setAgenSeq(userInfo.getAgenSeq());
        return cstUntpcMngMapper.selectAgenAreaList(param); 
    }

    public List<AgenAreaUntpcVO> selectUntpcList(AgenAreaUntpcVO param) {
        param.setAgenSeq(userInfo.getAgenSeq());
        return cstUntpcMngMapper.selectAgenUntpcList(param);
    }

    public void saveAgenAreaUntpcList(List<AgenAreaUntpcVO> param) throws Exception {
        String agenSeq = userInfo.getAgenSeq();
        String emplSeq = userInfo.getEmplSeq();
        for(AgenAreaUntpcVO vo : param) {
            vo.setAgenSeq(agenSeq);
            vo.setEmplSeq(emplSeq);
            if(("Y").equals(vo.getRemoveYn())) {
                cstUntpcMngMapper.removeAreaPrdUntpc(vo);
                
                if(("BND_CHG").equals(vo.getChgType())) { // 제품 일괄변경 바로적용시 변경 전 제품 미노출
                	cstUntpcMngMapper.updateAgenAreaUntpcLastYn(vo);
                }
            } else {
                if(("Y").equals(vo.getLastYn())) {
                    cstUntpcMngMapper.updateAgenAreaUntpcLastYn(vo);
                    if(("CST").equals(vo.getMrgnPrdCd())) { // 애음자 단가 수정일때
                        // 애음자 제품 단가 변경 히스토리 저장
                        cstUntpcMngMapper.insertCstUntpcHis(vo);
                    	// 지역단가 적용중인 제품 출고 단가 수정
                        cstUntpcMngMapper.updateCstPrdDlvy(vo);
                    }
                }
                
                if(("EMPL").equals(vo.getMrgnPrdCd())) {
                    cstUntpcMngMapper.saveAgenAreaUntpc(vo);
                } else if(("CST").equals(vo.getMrgnPrdCd())){
                    cstUntpcMngMapper.saveCstAreaUntpc(vo);
                }
            }
            
            if(("UNTPC_CHG").equals(vo.getChgType())) { // 단가변경
                cstUntpcMngMapper.saveAreaPrdChg(vo);
            } else if(("BND_CHG").equals(vo.getChgType()) && ("N").equals(vo.getRemoveYn())) { // 제품일괄변경
            	cstUntpcMngMapper.saveAreaPrdBndChg(vo);

                if(("Y").equals(vo.getLastYn()) && ("CST").equals(vo.getMrgnPrdCd()) ) { // 바로 적용시 애음자 제품 관련 테이블 전부 수정
                    // 애음자 제품 추가
                	int rs = prdBndChgMapper.insertCstPrd(vo);
                	if(rs > 0) {
                		// 제품 히스토리
                        prdBndChgMapper.insertCstPrdHis(vo);
                        // 변경 전 제품 수정
                        prdBndChgMapper.updateBefCstPrd(vo);
                        // 변경 후 제품 패턴 저장
                        prdBndChgMapper.insertCstPttn(vo);
                        // 변경 전 패턴 테이블 수정
                        prdBndChgMapper.updateCstPttn(vo);
                        // 계약단가 추가
                        prdBndChgMapper.insertCstPrdUntpc(vo);
                        // 출고 (패턴 저장 후)
                        prdBndChgMapper.insertCstPrdDlvy(vo);
                        prdBndChgMapper.updateBefCstPrdDlvy(vo);
                        // 판촉물
                        prdBndChgMapper.insertCstPrdPrmt(vo);
                	}
                }
            }
        }
    }

    public List<AgenAreaUntpcVO> selectAgenPrdPopList(AgenAreaUntpcVO param) {
        param.setAgenSeq(userInfo.getAgenSeq());
        return cstUntpcMngMapper.selectAgenPrdPopList(param);
    }

    public List<UntpcHisVO> selectUntpcHisPopList(UntpcHisVO param) {
        param.setAgenSeq(userInfo.getAgenSeq());
        return cstUntpcMngMapper.selectUntpcHisPopList(param);
    }

    public List<AgenAreaUntpcVO> selectCstAreaUntpcList(AgenAreaUntpcVO param) {
        param.setAgenSeq(userInfo.getAgenSeq());
        return cstUntpcMngMapper.selectCstAreaUntpcList(param);
    }
    
    public String deleteAbleCheck(AgenAreaUntpcVO param) {
        param.setAgenSeq(userInfo.getAgenSeq());
        List<Map<String,Object>> result = cstUntpcMngMapper.deleteAbleCheck(param);
        for (Map<String,Object> map : result) {
            if((Integer) map.get("CNT") > 0) {
                return (String) map.get("RSON");
            }
        }
        
        return "";
    }
}
