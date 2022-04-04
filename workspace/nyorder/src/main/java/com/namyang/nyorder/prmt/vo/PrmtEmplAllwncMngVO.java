package com.namyang.nyorder.prmt.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 수당 관리
 * 파일명  : PrmtEmplAllwncMngVO.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 10.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 10.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class PrmtEmplAllwncMngVO extends CommVO {
	private int prmtEmplSeq;			// 판촉사원 시퀀스
	private int prmtEmplHisSeq;			// 판촉사원 근무이력 시퀀스
	private int bhfcSeq;				// 지점 시퀀스
	private String prmtEmplCd;			// 판촉사원 코드
	private String emplNm;				// 판촉사원 명
	private int newHoffHop;				// 신규계약 홉단가(본사)
	private int recntrHoffHop;			// 재계약 홉단가(본사)
	private int newAgenHop;				// 신규계약 홉단가(대리점)
	private int recntrAgenHop;			// 재계약 홉단가(대리점)
	private int chpdyCt;				// 본사 일당
	private int chpdyAgenCt;			// 대리점 일당
	private int newPrdCnt;				// 신규 제품수
	private float newHop;					// 신규 홉수
	private int reCntrPrdCnt;			// 재계약 제품수
	private float reCntrHop;				// 재계약 홉수
	private String speclAllwnc;			// 특별수당
	private String searchMon;			// 검색월
	
	private String emplSecCd;			// 판촉사원 구분
	//private String cntrYn;			// 계약여부
	//private String cntrDt;			// 계약일
}
