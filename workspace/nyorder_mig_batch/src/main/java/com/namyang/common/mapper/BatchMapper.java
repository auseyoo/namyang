package com.namyang.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 배치 Mapper.
 */
@Mapper
public interface BatchMapper {

    /**
     * sqlSession 데이터 등록
     *
     * @param param the param
     */
    void insertSqlSession(Map<String, Object> param);

    /**
     * forEach 데이터 등록
     *
     * @param param the param
     */
    void insertForEach(Map<String, Object> param);

}
