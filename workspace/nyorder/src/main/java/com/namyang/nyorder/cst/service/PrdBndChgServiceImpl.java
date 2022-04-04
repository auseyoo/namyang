package com.namyang.nyorder.cst.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.cst.dao.PrdBndChgMapper;
import com.namyang.nyorder.cst.dao.UntpcMngMapper;
import com.namyang.nyorder.cst.vo.AgenAreaPrdBndChgVO;
import com.namyang.nyorder.cst.vo.AgenAreaUntpcVO;

@Service
public class PrdBndChgServiceImpl implements PrdBndChgService {

    @Autowired
    PrdBndChgMapper prdBndChgMapper;
    
    @Autowired
    UntpcMngMapper untpcMngMapper;

    @Resource
    UserInfo userInfo;
    
    @Override
    public List<AgenAreaUntpcVO> searchAgenBngChgPrdPopList(AgenAreaUntpcVO param) {
    	param.setAgenSeq(userInfo.getAgenSeq());
        return prdBndChgMapper.searchAgenBngChgPrdPopList(param);
    }
    
    @Override
    public List<AgenAreaUntpcVO> searchPrdAreaUntpcList(AgenAreaUntpcVO param) {
        param.setAgenSeq(userInfo.getAgenSeq());
        return prdBndChgMapper.searchPrdAreaUntpcList(param);
    }

	@Override
	public List<AgenAreaPrdBndChgVO> selectAgenAreaPrdBndChgHis(AgenAreaPrdBndChgVO param) {
		param.setAgenSeq(userInfo.getAgenSeq());
		return prdBndChgMapper.selectAgenAreaPrdBndChgHis(param);
	}
    
    
}
