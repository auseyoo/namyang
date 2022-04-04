package com.namyang.nyorder.cmmc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.cmmc.dao.RqbodMapper;
import com.namyang.nyorder.cmmc.vo.NttVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class RqbodServiceImpl implements RqbodService{

	@Autowired
	private RqbodMapper rqbodMapper;
	

	/* 요청사항 게시판 리스트 조회 */
	public List<NttVO> selectRqstList(NttVO param) {
		return rqbodMapper.selectRqstList(param);
	};

	/* 요청사항 게시판 - 상세 조회 */
	public NttVO selectRqst(NttVO param) {
		return rqbodMapper.selectRqst(param);
	};

	/**
	 * 요청 게시판 글 등록하기
	 */
	@Transactional
	public Map<String, Object> insertNttRqbod(NttVO vo) throws Exception{
		Map<String, Object> result 	= new HashMap<String, Object>();
		result.put("res", true);
		result.put("updateCnt", rqbodMapper.insertNttRqbod(vo));
		return result;
	}
	
	/**
	 * 커뮤니케이션 관리 - 요청 게시판 삭제
	 */
	@Transactional
	public String delRqbod(NttVO vo) throws Exception {
		rqbodMapper.delRqbod(vo);
		return "삭제되었습니다";
	}

	/**
	 * 커뮤니케이션 관리 - 요청 게시판 내용 수정
	 */
	@Transactional
	public Map<String, Object> updateNttMst(NttVO vo) throws Exception {
		Map<String, Object> result 	= new HashMap<String, Object>();
		result.put("res", true);
		result.put("updateCnt", rqbodMapper.updateNttMst(vo));
		return result;
	}

	/**
	 *	첨부파일 불러오기
	 */
	@Override
	public Map<String, Object> selectNttAtcl(NttVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", rqbodMapper.selectNttAtcl(param));
		return result;
	}
}
