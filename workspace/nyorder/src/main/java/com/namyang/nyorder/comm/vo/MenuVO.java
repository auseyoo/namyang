package com.namyang.nyorder.comm.vo;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 공통 메뉴 VO
 * 파일명  : MenuVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 3.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 3.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class MenuVO extends CommVO{
	private String menuSeq;
	private String menuId;
	private String menuNm;
	private String menuParentSeq;
	private String menuUrl;
	private String menuDesc;
	private String menuType;
	private String menuOrdr;
	private String level;
	private String menuCurrent;
	private String menuCurrentGbn;
	private String useYn;
	private String regDtm;
	private String regSeq;
	private String updDtm;
	private String updSeq;
	private String bkmkYn;
	private String roleYn;
	private String parentSeq;	
}
