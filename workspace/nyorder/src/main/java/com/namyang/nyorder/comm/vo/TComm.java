package com.namyang.nyorder.comm.vo;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Indexed;

import lombok.Data;

@Data
@Entity
@Table(name = "T_COMM")
@Indexed
public class TComm {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "COMM_SEQ")
	private int commSeq;
	 
	@Field
	@Column(name = "COMM_GRP_CD")
	private String commGrpCd;
	 
	@Column(name = "COMM_GRP_NM")
	private String commgrpNm;
	 
	@Column(name = "COMM_CD")
	private String commCd;
	
	@Column(name = "COMM_NM")
	private String commNm;
	
	@Column(name = "COMM_USE_YN")
	private String commUseYn;
	
	@Column(name = "COMM_DESC1")
	private String commDesc1;
	
	@Column(name = "COMM_DESC2")
	private String commDesc2;
	
	@Column(name = "COMM_DESC3")
	private String commDesc3;
	
	@Column(name = "COMM_DESC4")
	private String commDesc4;
	
	@Column(name = "COMM_DESC5")
	private String commDesc5;
	
	@Column(name = "COMM_DESC6")
	private String commDesc6;
	
	@Column(name = "REG_DTM")
	private Date regDtm ;
	
	@Column(name = "REG_SEQ")
	private int regSeq ;
	
	@Column(name = "UPD_DTM")
	private Date updDtm ;
	
	@Column(name = "UPD_SEQ")
	private int updSeq ;
	
	@Column(name = "ORDR")
	private int ordr;
	
	public TComm() {
		
	}
	
	public TComm(int commSeq, String commGrpCd, String commgrpNm, String commCd, String commNm, String commUseYn, String commDesc1, String commDesc2
			, String commDesc3, String commDesc4, String commDesc5, String commDesc6, Date regDtm, int regSeq, Date updDtm, int updSeq, int ordr) {
		
		this.commSeq = commSeq;
		this.commGrpCd = commGrpCd;
		this.commgrpNm = commgrpNm;
		this.commCd = commCd;
		this.commgrpNm = commNm;
		this.commUseYn = commUseYn;
		this.commDesc1 = commDesc1;
		this.commDesc2 = commDesc2;
		this.commDesc3 = commDesc3;
		this.commDesc4 = commDesc4;
		this.commDesc5 = commDesc5;
		this.commDesc6 = commDesc6;
		this.regDtm = regDtm;
		this.regSeq = regSeq;
		this.updDtm = updDtm;
		this.updSeq = updSeq;
		this.ordr = ordr;
		
	}

}
