package com.namyang.nyorder.cst.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.namyang.nyorder.cst.vo.AgenAreaUntpcVO;
import com.namyang.nyorder.cst.vo.AgenAreaVO;
import com.namyang.nyorder.cst.vo.UntpcHisVO;

@Mapper
public interface UntpcMngMapper {

    List<AgenAreaVO> selectAgenAreaList(AgenAreaUntpcVO param);
    
    List<AgenAreaUntpcVO> selectAgenUntpcList(AgenAreaUntpcVO param);

    int saveAgenAreaUntpc(AgenAreaUntpcVO param);

    int updateAgenAreaUntpc(AgenAreaUntpcVO param);

    List<AgenAreaUntpcVO> selectAgenPrdPopList(AgenAreaUntpcVO param);

    List<UntpcHisVO> selectUntpcHisPopList(UntpcHisVO param);

    int updateAgenAreaUntpcLastYn(AgenAreaUntpcVO param);
    
    int saveMrgnPrd(AgenAreaUntpcVO param);

    List<AgenAreaUntpcVO> selectCstAreaUntpcList(AgenAreaUntpcVO param);

    int saveCstAreaUntpc(AgenAreaUntpcVO param);

    int removeAreaPrdUntpc(AgenAreaUntpcVO param);

    int saveAreaPrdChg(AgenAreaUntpcVO param);

    List<Map<String, Object>> deleteAbleCheck(AgenAreaUntpcVO param);

    int saveAreaPrdBndChg(AgenAreaUntpcVO param);

    int updateCstPrdDlvy(AgenAreaUntpcVO param);

    int insertCstUntpcHis(AgenAreaUntpcVO param);
}
