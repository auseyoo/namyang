package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : T_AGEN_EMPL VO
 * 파일명  : EmplVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 3. 17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 17.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class EmplVO extends CommVO{
	//T_AGEN_EMPL 대리점 사원
	private String emplCd;		//사원 구분 공통 코드
	private String emplSecCd;	//사원 구분 코드
	private String emplNm;		//사원 이름
	private String zipCd;		//우편번호
	private String addr1;		//주소1
	private String addr2;		//주소2
	private String mobNo;		//핸드폰 번호
	private String clsYn;		//마감여부
	private String agenNm;		//대리점명
	private String reteYn;		//퇴사여부 - 상태
	private String reteYnNm;	//퇴사여부 - 상태명
	
	private String emplRnk;
	private String bizNo;
	private String telNo;
	private String faxNo;
	private String emplEml;
	private String reteDt;
	private String bizCon;
	private String bizIndu;
	private String emplGtn;
	private String stmDe;
	private String pymMth;
	private String ordr;
	private String prmtFrm;
	private String prmtHoffCt;
	private String prmtAgentCt;
	private String emplRm;
	private String prmtHoffCd;
	private String saleBefCd;
	private String confmDt;
	private String confmYn;
}
