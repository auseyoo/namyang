package com.namyang.nyorder.agn.vo;

import com.namyang.nyorder.comm.vo.CstMstVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 애음자 지역변경 내역 VO
 * 파일명  : CstAreaHisVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 3. 22.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 22.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class CstAreaHisVO extends CstMstVO {
	private String cstAreaSeq;		//	지역변경 이력 시퀀스
	private String areaSeq;			//	지역 시퀀스
	private String cstSeq;			//	고객 시퀀스
	private String chgDt;			//	적용일
	private String chgYnNm;			//	최종여부
	private String lstYn;			//	최종여부

	private String srcCstNm;		//	고객명
	private String srcAddr;			//	주소
	private String srcStartDate;
	private String srcEndDate;
	
	private String beforeAreaSeq;	//	변경전 지억 시퀀스
	private String beforeAreaNm;	//	변경전 지역명
	private String beforeAreaCd;	//	변경전 지역코드
	private String beforeEmplCd;	//	변경전 직원코드
	private String beforeEmplNm;	//	변경전 직원명
	private String afterAreaSeq;	//	변경후 지억 시퀀스
	private String afterAreaNm;		//	변경후 지역명
	private String afterAreaCd;		//	변경후 지역코드
	private String afterEmplCd;	//	변경전 직원코드
	private String afterEmplNm;	//	변경전 직원명
	
}
