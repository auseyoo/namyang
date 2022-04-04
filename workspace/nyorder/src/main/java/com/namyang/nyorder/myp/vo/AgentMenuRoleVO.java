package com.namyang.nyorder.myp.vo;

import com.namyang.nyorder.comm.vo.MenuVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : T_AGEN_MENU_ROLE - 대리점 메뉴 권한 VO
 * 파일명  : AgentMenuRoleVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 4.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class AgentMenuRoleVO extends MenuVO{
	private String menuSeq;
	private String emplSec;
	private String menuType;
	
	//LvL
	private String lvl1;
	private String lvl2;
	private String lvl3;
	
	private String regDtm;
	private String regSeq;
	private String updDtm;
	private String updSeq;
	
	private String crudMode;
	private String useYn;
}
