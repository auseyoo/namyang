package com.namyang.nyorder.cst.dao;

import java.util.List;

import com.namyang.nyorder.cst.vo.AgenAreaPrdBndChgVO;
import com.namyang.nyorder.cst.vo.AgenAreaUntpcVO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PrdBndChgMapper {

    List<AgenAreaUntpcVO> searchAgenBngChgPrdPopList(AgenAreaUntpcVO param);
    
    List<AgenAreaUntpcVO> searchPrdAreaUntpcList(AgenAreaUntpcVO param);
    
    List<AgenAreaPrdBndChgVO> selectAgenAreaPrdBndChgHis(AgenAreaPrdBndChgVO param);

    int insertCstPrd(AgenAreaUntpcVO param);

    int updateBefCstPrd(AgenAreaUntpcVO param);

    int insertCstPrdHis(AgenAreaUntpcVO param);

    int insertCstPttn(AgenAreaUntpcVO param);

    int updateCstPttn(AgenAreaUntpcVO param);

    int insertCstPrdUntpc(AgenAreaUntpcVO param);

    int insertCstPrdDlvy(AgenAreaUntpcVO param);

    int updateBefCstPrdDlvy(AgenAreaUntpcVO param);

    int insertCstPrdPrmt(AgenAreaUntpcVO param);
}