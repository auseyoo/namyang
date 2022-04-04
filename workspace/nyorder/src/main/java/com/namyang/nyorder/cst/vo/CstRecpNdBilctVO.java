package com.namyang.nyorder.cst.vo;

import java.util.List;

import com.namyang.nyorder.comm.vo.CommVO;
import com.namyang.nyorder.cst.vo.CstMngVO;
import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자관리 VO
 * 파일명  : cstMngVO.java
 * 작성자  : Dong Joo
 * 작성일  : 2022. 2. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *	변경일			 변경자			변경내역
 * --------------------------------------------------
 * 2022. 1. 11.	YESOL	 최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class CstRecpNdBilctVO extends CstMngVO{

	private String bilctMth;
	private String rpmyMonth;
	private String rqestCt;

	private String bilctMthNm;
	private String fullAddr;

	private String schType;
	private String schTxt;

}
