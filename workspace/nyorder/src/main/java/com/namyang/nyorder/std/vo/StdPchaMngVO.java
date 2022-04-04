package com.namyang.nyorder.std.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입처 관리 VO
 * 파일명  : StdPchaMngVO.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class StdPchaMngVO extends CommVO{
	private int puchSeq;
	private String puchCd;
	private String puchNm;
	private String bizNo;
	private String compNm;
	private String bizCon;
	private String bizIndu;
	private String zipCd;
	private String addr1;
	private String addr2;
	private String mobNo;
	private String faxNo;
	private String puchEml;
	private String puchChag;
	private String useCd;
	private String statDt;
	private String endDt;
	private String regDtm;
	private String regSeq;
	private String updDtm;
	private String updSeq;
	private String prstNm;
	private String crudMode;
	private String telNo;
	private String nextPuchCd;
	
	private String telNo1;
	private String telNo2;
	private String telNo3;
	private String mobNo1;
	private String mobNo2;
	private String mobNo3;
	private String faxNo1;
	private String faxNo2;
	private String faxNo3;
	
}
