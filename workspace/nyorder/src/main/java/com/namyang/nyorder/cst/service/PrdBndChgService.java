package com.namyang.nyorder.cst.service;

import java.util.List;

import com.namyang.nyorder.cst.vo.AgenAreaPrdBndChgVO;
import com.namyang.nyorder.cst.vo.AgenAreaUntpcVO;

public interface PrdBndChgService {
	
    List<AgenAreaUntpcVO> searchAgenBngChgPrdPopList(AgenAreaUntpcVO param);

    List<AgenAreaUntpcVO> searchPrdAreaUntpcList(AgenAreaUntpcVO param);
    
    List<AgenAreaPrdBndChgVO> selectAgenAreaPrdBndChgHis(AgenAreaPrdBndChgVO param);
}
