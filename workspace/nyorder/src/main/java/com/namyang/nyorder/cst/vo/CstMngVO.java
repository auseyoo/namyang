package com.namyang.nyorder.cst.vo;

import java.util.List;

import com.namyang.nyorder.comm.vo.CommVO;

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
public class CstMngVO extends CommVO{
	
	private String agenSeq;
	private String areaSeq;
	private String emplSeq;
	private String emplNm;
	private String emplCd;	
	private String areaNm;
	private String agenAreaCd;
	private String cstSeq;
	private String cstAgenCd;
	private String cstNm;
	private String mobNo;
	private String telNo;
	private String dlvAddr1;
	private String dlvAddr2;
	private String dlvAddr;
	private String dlvZipCd;
	private String cntrSecStr;
	private String badnYnStr;		/*수금 불량여부*/
	private String stpgExclYn;
	private String dlvStpgYn;
	private String areaOrdr;
	private String cntrCstStr;		/*계약상태*/
	private String sbscrbCosStr;	/*가입경로*/
	private String cntrCstCd;
	private String sbscrbCosCd;
	private String updDtm;
	private String updSeq;
	private String updEmplNm;
	private String appctNm;
	private String ordr;
	
	private String prdDtlSeq;
	private String prdSeq;
	private String stdPrdNm;
	private String prdNm;
	private String untpc;
	private String regDtm;
	private String stpgDtm;
	private String stdrQty;
	private String stpgYn;
	private String pttnStr;
	private String monQty;
	private String tueQty;
	private String wedQty;
	private String thuQty;
	private String friQty;
	private String satQty;
	private String sunQty;
	private String dayTotQty;
	private String statDt;
	private String endDt;
	private String endAlert;
	private String chgSecCd ;
	private String chgSecCdStr;
	private String poseAlert;
	
	private String prmtEmplSeq;
	private String prmtEmplNm;
	private String hop;
	private String hopUntpc;
	private String priodDt;	/*계약 기간*/
	
	/* agenSeq in 조건 걸기 위함*/
	private String[] areaSeqArr;
	
	/*search*/
	private String selAreaSrh;
	private String inptSrhArea;
	private String targetAreaSeq;
	private String cntrCstType;
	private String sbscrbCosType;
	
	private String prdSearchValue;
	private String selPrdSearch;
	private String prdDtlCd;
	private String shtnNm;
	
	private String prmtLngtrCd;
	private String prmtSecCd;
	private String prmtSeq;
	private String prmtPymDt;
	private String ptrnPymSeq;
	private String prmtCt;
	private String prmtCstCt;
	private String prmtRate;
	private String prmtMonth;
	private String applDt;
	private String inptLc;
	private String rmk;
	private String cstPrdSeq;
	private String puchSeq;
	private String prmtRmk;
	private String cntrSecCd;
	private String prmtDt;
	private String inptDt;
	private String cstCosCd;
	private String cntrMonth;
	private String stpgDt;
	private String stpgRson;
	private String dlvSecCd;
	private String cstBefCd;
	private String prdBefCd;
	private String lastYn;
	private String weeks;	
	private String useYn;
	private String befPttnStr;
	private String migYn;
	private String dfltQty;
	private String prdSapCd;
	private String prmtPrdSeq;		
	private String dlvyMonth;
	private String prtDt;
	private String prtYn;
	private String cntrEndDt;
	
	private List<CstMngVO> pttnData;
	private List<CstMngVO> prmtData;
	
	
}
