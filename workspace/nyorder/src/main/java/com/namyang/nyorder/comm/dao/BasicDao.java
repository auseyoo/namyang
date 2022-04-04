package com.namyang.nyorder.comm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.namyang.nyorder.comm.vo.BasicVO;

@Repository
public class BasicDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public <E> List<E> basicSelectList(BasicVO param) throws Exception{		
		return sqlSessionTemplate.selectList(param.getQueryId(), param.getParamClass());
	}
	
	public <T> Object basicSelectOne(BasicVO param) throws Exception{		
		return sqlSessionTemplate.selectOne(param.getQueryId(), param.getParamClass());
	}
	
	public int basicInsert(BasicVO param) throws Exception{		
		return sqlSessionTemplate.insert(param.getQueryId(), param.getParamClass());
	}
	
	public int basicUpdate(BasicVO param) throws Exception{		
		return sqlSessionTemplate.update(param.getQueryId(), param.getParamClass());
	}


}
