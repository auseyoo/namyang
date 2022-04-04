package com.namyang.nyorder.prmt.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉사원 관리
 * 파일명  : PrmtEmplMngVO.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class PrmtEmplMngVO extends CommVO {
	private int prmtEmplHisSeq;			// 판촉사원 근무이력 시퀀스
	private int prmtEmplSeq;			// 판촉사원 시퀀스
	private int bhfcSeq;				// 지점 시퀀스
	private String prmtEmplCd;			// 판촉사원 코드
	private String emplSecCd;			// 판촉사원 구분
	private String emplSecNm;			// 판촉사원 구분명
	private String emplNm;				// 판촉사원 명
	private int chpdyCt;				// 일당
	private int chpdyAgenCt;			// 일당(대리점)
	private int newHoffHop;				// 신규계약 홉단가(본사)
	private int recntrHoffHop;			// 재계약 홉단가(본사)
	private int newAgenHop;				// 신규계약 홉단가(대리점)
	private int recntrAgenHop;			// 재계약 홉단가(대리점)
	private String brthdy;				// 생년월일
	private String telNo;				// 휴대폰번호
	private String cntrDt;				// 계약일
	private String cntrEndDt;			// 종료일
	private String bhfcNm;				// 지점명
	private String cntrYnNm;			// 계약여부
	
	private String startMon;			//조회 시작월
	private String endMon;				//조회 종료월
	
}
