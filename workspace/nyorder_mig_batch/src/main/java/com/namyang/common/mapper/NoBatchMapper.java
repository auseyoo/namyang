package com.namyang.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * NoN 배치 mapper.
 */
@Mapper
public interface NoBatchMapper {

    /**
     * 테이블 생성
     */
    void create();

    /**
     * 테이블 삭제
     */
    void delete();

    List<Map<String, Object>> select();

}
