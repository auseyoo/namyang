package com.namyang.nyorder.cmmc.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : T_NTT_MST - 게시판 마스터 VO
 * 파일명  : NttVO.java
 * 작성자  : GAIN
 * 작성일  : 2022. 1. 12.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 12.    GAIN     최조 프로그램 작성
 *
 ****************************************************/

 @Getter
 @Setter
public class NttVO extends CommVO {
	private String nttSeq;
	private String nttCd;
	private String nttSub;
	private String nttCntt;
	private String nttAtclSeq;
	private String useYn;
	private String regDtm;
	private String regSeq;
	private String updDtm;
	private String updSeq;
	private String cfmYn;
	private String resSecCd;
	private String appPushYn;
	private String agenSeq;
	private String notiYn;
	private String nttOrdr;

	private String srcType;
	private String srcKeyword;
	private String agenNm;
}
