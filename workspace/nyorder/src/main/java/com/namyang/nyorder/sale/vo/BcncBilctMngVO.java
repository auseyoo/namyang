package com.namyang.nyorder.sale.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 수금관리 VO
 * 파일명  : BcncBilctMngVO.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 2. 8.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class BcncBilctMngVO extends CommVO{
	private String targetEmplSeq;
	private String emplNm;
	private String vendSeq;
	private String vendCd;
	private String vendNm;
	private String useYn;
	private String regDtm;
	private String regSeq;
	private String updDtm;
	private String updSeq;
	private String removeYn;

	private String schType;
	private String schTxt;


}
