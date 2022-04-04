package com.namyang.nyorder.cst.service;

import java.util.List;

import com.namyang.nyorder.cst.vo.AgenAreaUntpcVO;
import com.namyang.nyorder.cst.vo.AgenAreaVO;
import com.namyang.nyorder.cst.vo.UntpcHisVO;

public interface UntpcMngService {

    List<AgenAreaVO> selectAreaList(AgenAreaUntpcVO param);

    List<AgenAreaUntpcVO> selectUntpcList(AgenAreaUntpcVO param);

    void saveAgenAreaUntpcList(List<AgenAreaUntpcVO> param) throws Exception;

    List<AgenAreaUntpcVO> selectAgenPrdPopList(AgenAreaUntpcVO param);

    List<UntpcHisVO> selectUntpcHisPopList(UntpcHisVO param);

    List<AgenAreaUntpcVO> selectCstAreaUntpcList(AgenAreaUntpcVO param);

    String deleteAbleCheck(AgenAreaUntpcVO param);
}
