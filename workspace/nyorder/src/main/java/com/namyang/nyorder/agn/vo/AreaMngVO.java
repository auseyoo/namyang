package com.namyang.nyorder.agn.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Getter
@Setter
public class AreaMngVO extends EmplVO {
	//T_AGEN_AREA 대리점 지역
	private String areaSeq;//대리점 지역 시퀀스
	
	private String areaNm;//지역명
	private String areaRm;//비고
	private String saleEmplSeq;// 판매원 
	private String stpgExclYn;//인쇄시 중지지역 제외 여부
	private String dlvStpgYn;//배달중지
	private String agenAreaCd;//대리점 지역 코드
	private String dlvOrdr;//배달 순서 --순서
	private String areaOrdr;//지역 언번 -- 코스
	private String rmk;
	
	
	//T_CST_MST 애음자 마스터
	private String cstSeq;
	private String cstAgenCd;
	private String cstNm;
	
	private String addr;
	private String crudMode;
	private String mobNo1;
	private String mobNo2;
	private String mobNo3;
	private String searchNm;
	private String searchAddr;
	private String addrSelectBef;
	private String addrSelectAft;
	private String dateBef;
	private String dateAft;
	private String agenPrst;
	private String prstTelNo;
	private String agenUseYn;

}
