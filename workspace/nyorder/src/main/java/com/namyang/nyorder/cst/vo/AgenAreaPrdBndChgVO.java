package com.namyang.nyorder.cst.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AgenAreaPrdBndChgVO {

    private String agenPrdChgSeq;
    private String agenSeq;
    private String areaSeq;
    private String emplSeq;
    private String emplNm;
    private String puchSeq;
    
    private String befPrdDtlSeq;
    private String befPrdSapCd;
    private String befPrdNm;
    private String befAreaNm;
    private String befEmplUntpc;
    private String befCstUntpc;
    
    private String aftPrdAftSeq;
    private String aftPrdSapCd;
    private String aftPrdNm;
    private String aftAreaNm;
    private String aftEmplUntpc;
    private String aftCstUntpc;
    
    private String untpcSecCd;
    private String chgType;
    private String applDt;
    private String applYn;
    private String useYn;
    private String regDtm;
    private String regSeq;
    
    private String startDt;
    private String endDt;
}
