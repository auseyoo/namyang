-- NY_ORDER.dbo.IF_AGENT definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_AGENT;

CREATE TABLE NY_ORDER.dbo.IF_AGENT (
	IFGNUM nvarchar(12) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VKORG nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VTWEG nvarchar(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SPART nvarchar(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
	BUKRS nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KTOKD nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	NAME1 nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	NAME2 nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	SORT1 nvarchar(60) COLLATE Korean_Wansung_CI_AS NULL,
	SORT2 nvarchar(60) COLLATE Korean_Wansung_CI_AS NULL,
	STREET nvarchar(180) COLLATE Korean_Wansung_CI_AS NULL,
	POST_CODE1 nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	CITY1 nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	COUNTRY nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	TELF1 nvarchar(16) COLLATE Korean_Wansung_CI_AS NULL,
	TELF2 nvarchar(16) COLLATE Korean_Wansung_CI_AS NULL,
	TELFX nvarchar(31) COLLATE Korean_Wansung_CI_AS NULL,
	SMTP_ADDR nvarchar(241) COLLATE Korean_Wansung_CI_AS NULL,
	STCD1 nvarchar(16) COLLATE Korean_Wansung_CI_AS NULL,
	STCD2 nvarchar(11) COLLATE Korean_Wansung_CI_AS NULL,
	J_1KFREPRE nvarchar(30) COLLATE Korean_Wansung_CI_AS NULL,
	J_1KFTBUS nvarchar(90) COLLATE Korean_Wansung_CI_AS NULL,
	J_1KFTIND nvarchar(90) COLLATE Korean_Wansung_CI_AS NULL,
	BPEXT nvarchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	AUFSD nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	LOEVM_X nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	SPERR_X nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	AKONT nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	ZTERM nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	ZWELS nvarchar(30) COLLATE Korean_Wansung_CI_AS NULL,
	ZAHLS nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	LOEVM_B nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	SPERR_B nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	KDGRP nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	BZIRK nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	VKBUR nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	VKGRP nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	VWERK nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	KALKS nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	PARVW_SP nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	PARVW_BP nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	PARVW_PY nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	PARVW_SH nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	PARVW_SE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	PARVW_Z1 nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	PARVW_Z2 nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	ZZTEMPFG nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	ZZCLOSE nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	ZZORDSYS nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	ZZDATAB_DL nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	ZZDATBI_DL nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	ZZAGENT nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	ZZSAREA nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	ZZLEADTY nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	KVGR1 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	KVGR2 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	KVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	IFFLAG nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	IFDATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	IFTIME nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	IFUSER nvarchar(12) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_AGENT PRIMARY KEY (IFGNUM,KUNNR,VKORG,VTWEG,SPART,BUKRS)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF_대리점정보', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공통 I/F 전송 채번(NR)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'IFGNUM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업조직', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'VKORG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유통경로', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'VTWEG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품군', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'SPART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회사코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'BUKRS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계정그룹', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'KTOKD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름1', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'NAME1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이름2', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'NAME2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색어 1', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'SORT1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색어 2', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'SORT2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상세주소', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'STREET';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'POST_CODE1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'CITY1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'국가', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'COUNTRY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전화', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'TELF1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'휴대폰', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'TELF2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'팩스', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'TELFX';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'E-메일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'SMTP_ADDR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'법인등록번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'STCD1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사업자등록번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'STCD2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대표자명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'J_1KFREPRE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업태', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'J_1KFTBUS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종목', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'J_1KFTIND';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이전거래처번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'BPEXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객에 대한 중앙 오더 보류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'AUFSD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'삭제표시-중앙', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'LOEVM_X';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전기보류-중앙', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'SPERR_X';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조정계정', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'AKONT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지급조건', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZTERM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지급방법', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZWELS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지급보류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZAHLS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'삭제표시-회사코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'LOEVM_B';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전기보류-회사코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'SPERR_B';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'KDGRP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매구역(지점)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'BZIRK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업소(부문)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'VKBUR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업그룹(영업팀)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'VKGRP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'VWERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가격결정절차', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'KALKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처(Sold-to party)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'PARVW_SP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'청구처(Bill-to party)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'PARVW_BP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지급인(Payer)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'PARVW_PY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품처(Ship-to party)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'PARVW_SH';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업사원', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'PARVW_SE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단가거래처', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'PARVW_Z1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직원판매사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'PARVW_Z2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'온도수신여부', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZZTEMPFG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문마감시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZZCLOSE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문시스템', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZZORDSYS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'거래시작일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZZDATAB_DL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'거래종료일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZZDATBI_DL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'귀속대리점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZZAGENT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상온주문연계방식(판매권역) E01 : Real, E02 : Batch', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZZSAREA';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문종류(리드타임구분)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'ZZLEADTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객대분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'KVGR1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객중분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'KVGR2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객소분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'KVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 유형(I, U)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'IFFLAG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'IFDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'IFTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'IFUSER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENT', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_AGENTCLASS definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_AGENTCLASS;

CREATE TABLE NY_ORDER.dbo.IF_AGENTCLASS (
	IFGNUM nvarchar(12) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KVGR1 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KVGR2 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KVGR1TXT nvarchar(60) COLLATE Korean_Wansung_CI_AS NULL,
	KVGR2TXT nvarchar(60) COLLATE Korean_Wansung_CI_AS NULL,
	KVGR3TXT nvarchar(60) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XUSER nvarchar(12) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_AGENTCLASS PRIMARY KEY (IFGNUM,KVGR1,KVGR2,KVGR3)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF고객계층구조', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'일련번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'IFGNUM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹1', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'KVGR1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹2', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'KVGR2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'KVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹1 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'KVGR1TXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹2 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'KVGR2TXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹3 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'KVGR3TXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 발신인 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'XUSER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_AGENTCLASS', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_CMMNCD definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_CMMNCD;

CREATE TABLE NY_ORDER.dbo.IF_CMMNCD (
	IFGNUM nvarchar(12) COLLATE Korean_Wansung_CI_AS NOT NULL,
	BUKRS nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MODU nvarchar(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZCODEH nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZCODEV nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZCODEHT nvarchar(120) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZCODEVT nvarchar(240) COLLATE Korean_Wansung_CI_AS NULL,
	SORTSEQ tinyint NULL,
	VALUEC1 nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	VALUEC2 nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	VALUEC3 nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	VALUEC4 nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	VALUEC5 nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	IFCHKI nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	IFFLAG nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	IFDATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	IFTIME nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	IFUSER nvarchar(12) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_CMMNCD PRIMARY KEY (IFGNUM,BUKRS,MODU,ZCODEH,ZCODEV,ZCODEHT)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF공통코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공통 I/F 전송 채번(NR)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'IFGNUM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회사코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'BUKRS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'모듈', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'MODU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F CODE ID', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'ZCODEH';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F CODE VALUE', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'ZCODEV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CODE ID 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'ZCODEHT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CODE VALUE 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'ZCODEVT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'정렬 순서', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'SORTSEQ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'필드값 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'VALUEC1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'필드값 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'VALUEC2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'필드값 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'VALUEC3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'필드값 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'VALUEC4';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'필드값 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'VALUEC5';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IF 미사용 (X, Null)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'IFCHKI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 유형(I, U)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'IFFLAG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'IFDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'IFTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'IFUSER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CMMNCD', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_CRREPAY_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_CRREPAY_RCV;

CREATE TABLE NY_ORDER.dbo.IF_CRREPAY_RCV (
	AUDAT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VBELN nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	POSNR int NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	KWMENG numeric(15,0) NULL,
	VRKME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	NETWR numeric(18,0) NULL,
	MWSBP numeric(18,0) NULL,
	WAERK nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_CRREPAY_RCV PRIMARY KEY (AUDAT,VBELN,POSNR)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF크레이트변제', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'일자(변제일자)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'AUDAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문서번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'VBELN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문서품목', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'POSNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'거래처', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품(크레이트)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수량단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'VRKME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'NETWR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'MWSBP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'통화', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'WAERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRREPAY_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_CRSAPINVEN_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_CRSAPINVEN_RCV;

CREATE TABLE NY_ORDER.dbo.IF_CRSAPINVEN_RCV (
	[DATE] nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(40) COLLATE Korean_Wansung_CI_AS NOT NULL,
	QTY_BEGIN numeric(18,0) NULL,
	QTY_GR numeric(18,0) NULL,
	QTY_GI numeric(18,0) NULL,
	QTY_GI_REPAY numeric(18,0) NULL,
	QTY_CLOSE numeric(18,0) NULL,
	UNIT nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_CRSAPINVEN_RCV PRIMARY KEY ([DATE],KUNNR,MATNR)
);
 CREATE NONCLUSTERED INDEX IX_IF_CRSAPINVEN_RCV_01 ON dbo.IF_CRSAPINVEN_RCV (  XSTAT ASC  , XDATS ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF크레이트SAP수불', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수불일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처 (거래처)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기초재고', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'QTY_BEGIN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'거래처 입고(출고수량-반송수량)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'QTY_GR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'거래처 출고(반품(회수)수량)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'QTY_GI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변제 출고', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'QTY_GI_REPAY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기말재고', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'QTY_CLOSE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'UNIT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_CRSAPINVEN_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_DEPTINFO_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_DEPTINFO_RCV;

CREATE TABLE NY_ORDER.dbo.IF_DEPTINFO_RCV (
	ENTER_CD nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ORG_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ORG_NM nvarchar(200) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRIOR_ORG_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	PRIOR_ORG_NM nvarchar(200) COLLATE Korean_Wansung_CI_AS NULL,
	PRIOR_ORG_SABUN nvarchar(13) COLLATE Korean_Wansung_CI_AS NULL,
	SDATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	EDATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_DEPTINFO_RCV PRIMARY KEY (ENTER_CD,ORG_CD,ORG_NM)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF남양부서정보', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회사구분코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'ENTER_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조직코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'ORG_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조직명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'ORG_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상위조직코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'PRIOR_ORG_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상위조직명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'PRIOR_ORG_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조직장사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'PRIOR_ORG_SABUN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조직시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'SDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조직종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'EDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DEPTINFO_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_DLVRTN_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_DLVRTN_RCV;

CREATE TABLE NY_ORDER.dbo.IF_DLVRTN_RCV (
	DELIVERY_DATE nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	RTN_ORD_NO nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	RTN_ORD_ITEM nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(40) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	WERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_DATE nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_QTY numeric(15,0) NULL,
	RTN_QTY_UNIT nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_CODE nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_CODE_TX nvarchar(60) COLLATE Korean_Wansung_CI_AS NULL,
	NETPR numeric(18,0) NULL,
	PRICE numeric(18,0) NULL,
	MWSBP numeric(18,0) NULL,
	WAERK nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	AUART nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	MTART nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	UMREZ numeric(5,0) NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_DLVRTN_RCV PRIMARY KEY (DELIVERY_DATE,RTN_ORD_NO,RTN_ORD_ITEM,MATNR)
);
 CREATE NONCLUSTERED INDEX IX_IF_DLVRTN_RCV_01 ON dbo.IF_DLVRTN_RCV (  XSTAT ASC  , XDATS ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF반납정보', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'DELIVERY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반품오더번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'RTN_ORD_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반품오더품목', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'RTN_ORD_ITEM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처 (거래처)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'WERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반품입고일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'RTN_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반품 수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'RTN_QTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반품 수량 단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'RTN_QTY_UNIT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반품 사유', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'RTN_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반품 사유명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'RTN_CODE_TX';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단가(NETPR/KPEIN)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'NETPR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'MWSBP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'통화', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'WAERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 문서 유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'AUART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'MTART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BOX 입수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'UMREZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVRTN_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_DLVSENDBACK_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_DLVSENDBACK_RCV;

CREATE TABLE NY_ORDER.dbo.IF_DLVSENDBACK_RCV (
	DELIVERY_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ROUTE_NO nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ROUTE_NO_SEQ nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ORD_NO nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ORD_ITEM nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	WERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_QTY numeric(15,0) NULL,
	RTN_QTY_UNIT nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_CODE nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_CODE_TX nvarchar(60) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_QTY_C numeric(15,0) NULL,
	RTN_QTY_UNIT_C nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_ORD_NO nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	RTN_ORD_ITEM nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	NETPR numeric(18,0) NULL,
	PRICE numeric(18,0) NULL,
	MWSBP numeric(18,0) NULL,
	WAERK nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	AUART nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	MTART nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	UMREZ numeric(5,0) NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_DLVSENDBACK_RCV PRIMARY KEY (DELIVERY_DATE,ROUTE_NO,ROUTE_NO_SEQ,ORD_NO,ORD_ITEM,MATNR)
);
 CREATE NONCLUSTERED INDEX IX_IF_DLVSENDBACK_RCV_01 ON dbo.IF_DLVSENDBACK_RCV (  XSTAT ASC  , XDATS ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF배송반송정보', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'DELIVERY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코스번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'ROUTE_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEQ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'ROUTE_NO_SEQ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오더번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'ORD_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오더품목', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'ORD_ITEM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처 (거래처)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'WERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반송 수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'RTN_QTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반송 수량 단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'RTN_QTY_UNIT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반송 사유', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'RTN_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반송 사유 명 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'RTN_CODE_TX';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반송 확정 수량(재고적용수량)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'RTN_QTY_C';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반송 확정 수량 단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'RTN_QTY_UNIT_C';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반품오더번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'RTN_ORD_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오더품목', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'RTN_ORD_ITEM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단가(NETPR/KPEIN)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'NETPR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'MWSBP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'통화', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'WAERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 문서 유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'AUART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'MTART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BOX 입수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'UMREZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLVSENDBACK_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_DLV_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_DLV_RCV;

CREATE TABLE NY_ORDER.dbo.IF_DLV_RCV (
	DELIVERY_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ROUTE_NO nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ROUTE_NO_SEQ nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ORD_NO nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ORD_ITEM nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	CAR_NO nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	CAR_DRIVER nvarchar(30) COLLATE Korean_Wansung_CI_AS NULL,
	CAR_DRIVER_PHONE nvarchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	TO_BUP nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	FROM_BUP nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	UMREZ numeric(5,0) NULL,
	LOAD_QTY_ACTUAL numeric(20,0) NULL,
	LOAD_UNIT_ACTUAL nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	LOAD_QTY_DLV numeric(20,0) NULL,
	LOAD_UNIT_DLV nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	DOCNO nvarchar(35) COLLATE Korean_Wansung_CI_AS NULL,
	ITEMNO nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	NETPR numeric(18,0) NULL,
	PRICE numeric(18,0) NULL,
	MWSBP numeric(18,0) NULL,
	WAERK nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	CRATE_CODE nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	QUANTITY_CRATE numeric(20,0) NULL,
	LEAVE_TIME nvarchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	ARRIVE_TIME nvarchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	AUART nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	MTART nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	GI_STATUS nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_DLV_RCV PRIMARY KEY (DELIVERY_DATE,ROUTE_NO,ROUTE_NO_SEQ,ORD_NO,ORD_ITEM,MATNR)
);
 CREATE NONCLUSTERED INDEX IX_IF_DLV_RCV_01 ON dbo.IF_DLV_RCV (  XSTAT ASC  , XDATS ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF배송정보', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품예정일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'DELIVERY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코스번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'ROUTE_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEQ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'ROUTE_NO_SEQ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오더번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'ORD_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오더품목', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'ORD_ITEM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'차량번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'CAR_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기사명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'CAR_DRIVER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기사 연락처', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'CAR_DRIVER_PHONE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처(거래처)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'TO_BUP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'FROM_BUP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BOX 입수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'UMREZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'실적재 수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'LOAD_QTY_ACTUAL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'실적재 수량 단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'LOAD_UNIT_ACTUAL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'배차 확정 수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'LOAD_QTY_DLV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'배차 확정 단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'LOAD_UNIT_DLV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품문서번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'DOCNO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품문서품목', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'ITEMNO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단가(NETPR/KPEIN)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'NETPR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'MWSBP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'통화', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'WAERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'크레이트코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'CRATE_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'크레이트수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'QUANTITY_CRATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출발일자, 시간(미사용)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'LEAVE_TIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도착일자, 시간(미사용)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'ARRIVE_TIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 문서 유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'AUART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'MTART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출고 확정 여부', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'GI_STATUS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태R:수신완료(PO세팅)P:수신 측 처리작업 중S:수신 측 처리완료E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_DLV_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_EDIDLVINFO_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_EDIDLVINFO_RCV;

CREATE TABLE NY_ORDER.dbo.IF_EDIDLVINFO_RCV (
	EDI_MANDT nvarchar(5) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_MESG_NAME nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_MESG_ID nvarchar(35) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_DELV_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_LINE_NO numeric(6,0) NOT NULL,
	EDI_MESG_NO nvarchar(35) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_GR_TYPE nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_DELV_BINS_NO nvarchar(35) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_DELV_NAME1 nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_DELV_CHAR_DEPT nvarchar(60) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_PROD_CODE nvarchar(35) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_PROD_NAME nvarchar(210) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_PURC_UNIT_PRICE numeric(18,2) NULL,
	EDI_PURC_PRICE numeric(18,2) NULL,
	EDI_PURC_VAT numeric(18,2) NULL,
	EDI_RECV_QTY numeric(15,2) NULL,
	EDI_RECV_UNIT nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_REG_DATE nvarchar(14) COLLATE Korean_Wansung_CI_AS NULL,
	KUNNR nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	KUNSB nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	MATNR nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	KWMENG numeric(15,3) NULL,
	VRKME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_EDIDLVINFO_RCV PRIMARY KEY (EDI_MANDT,EDI_MESG_NAME,EDI_MESG_ID,EDI_DELV_DATE,EDI_LINE_NO)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF EDI납품정보수신', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'내부코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_MANDT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문서명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_MESG_NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문서참조번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_MESG_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상품인수일(매입일) - PK 로 변경', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_DELV_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'라인번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_LINE_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문서번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_MESG_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입고구분', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_GR_TYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품처식별번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_DELV_BINS_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품처업체명1', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_DELV_NAME1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품처담당자/부서명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_DELV_CHAR_DEPT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'품목번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_PROD_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상품명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_PROD_NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품단가', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_PURC_UNIT_PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_PURC_PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품세액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_PURC_VAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인도수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_RECV_QTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인도단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_RECV_UNIT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'EDI_REG_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 유통위탁거래처코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 귀속대리점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'KUNSB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 제품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 납품수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 납품단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'VRKME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIDLVINFO_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_EDIORDER_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_EDIORDER_RCV;

CREATE TABLE NY_ORDER.dbo.IF_EDIORDER_RCV (
	EDI_MANDT nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_MESG_NAME nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_MESG_ID nvarchar(35) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_ORDR_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_LINE_NO nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	CRTNDATE nvarchar(17) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDI_ORDR_MP_CODE nvarchar(35) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_ORDR_MP_NAME nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_DELV_MP_CODE nvarchar(35) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_DELV_MP_NAME nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_PROD_CODE nvarchar(35) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_PROD_NAME nvarchar(210) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_COST_UNIT_PRICE numeric(18,2) NULL,
	EDI_ORDR_PCB numeric(15,0) NULL,
	EDI_PACK_QTY numeric(8,0) NULL,
	EDI_ORDR_QTY numeric(15,0) NULL,
	EDI_COST_PRICE numeric(18,2) NULL,
	EDI_MESG_NO nvarchar(35) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_ORDR_CHAR nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_DELV_DUE_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_PMENT_REF_CODE nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	EDI_REG_DATE nvarchar(14) COLLATE Korean_Wansung_CI_AS NULL,
	KUNNR nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	KUNSB nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	MATNR nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	KWMENG numeric(15,3) NULL,
	VRKME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	APPLYTIME datetime NULL,
	APPLYMSG nvarchar(3000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_EDIORDER_RCV PRIMARY KEY (CRTNDATE,EDI_MANDT,EDI_MESG_NAME,EDI_MESG_ID,EDI_ORDR_DATE,EDI_LINE_NO)
);
 CREATE NONCLUSTERED INDEX IX_IF_EDIORDER_RCV_01 ON dbo.IF_EDIORDER_RCV (  XDATS ASC  , XSTAT ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF EDI주문정보 수신', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'내부코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_MANDT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문서명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_MESG_NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문서참조번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_MESG_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'발주일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_ORDR_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'라인번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_LINE_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'CRTNDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)발주점포코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_ORDR_MP_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)발주점포명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_ORDR_MP_NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)납품점포코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_DELV_MP_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)납품점포명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_DELV_MP_NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)유통사 상품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_PROD_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)유통사 상품명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_PROD_NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)발주단가', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_COST_UNIT_PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)발주단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_ORDR_PCB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)입수(Lot)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_PACK_QTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)발주수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_ORDR_QTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)발주금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_COST_PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)문서번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_MESG_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)발주담당자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_ORDR_CHAR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품요청일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_DELV_DUE_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)주문수단코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_PMENT_REF_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(미사용)등록일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'EDI_REG_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 유통위탁거래처코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 귀속대리점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'KUNSB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 제품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 주문수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(남양유업) 주문단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'VRKME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 [R(수신)->W(처리중)->S(완료), E(오류)]', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'APPLYTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영중 발생한 오류 메시지', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV', @level2type=N'Column', @level2name=N'APPLYMSG';


-- NY_ORDER.dbo.IF_EDIORDER_RCV_2 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_EDIORDER_RCV_2;

CREATE TABLE NY_ORDER.dbo.IF_EDIORDER_RCV_2 (
	EDIORDERNO nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	EDIORDERDT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	AGENTCD nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	CNSNCD nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRODCD nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	CNSNUNITQTY numeric(18,0) NULL,
	SHIPREQDT nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT_IN nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS_IN nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS_IN nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_EDIORDER_RCV_2 PRIMARY KEY (EDIORDERNO,EDIORDERDT,AGENTCD,CNSNCD,PRODCD)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Interface EDI주문정보 수신', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'EDI 주문번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'EDIORDERNO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'EDI 주문일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'EDIORDERDT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'위탁유통점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'AGENTCD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'귀속대리점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'CNSNCD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'PRODCD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'CNSNUNITQTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품요청일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'SHIPREQDT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'XSTAT_IN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'XDATS_IN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EDIORDER_RCV_2', @level2type=N'Column', @level2name=N'XTIMS_IN';


-- NY_ORDER.dbo.IF_EMPINFO_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_EMPINFO_RCV;

CREATE TABLE NY_ORDER.dbo.IF_EMPINFO_RCV (
	SABUN nvarchar(13) COLLATE Korean_Wansung_CI_AS NOT NULL,
	NAME nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	JIKWEE_CD nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	JIKWEE_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	JIKGUB_CD nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	JIKGUB_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	JIKCHAK_CD nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	JIKCHAK_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	ORG_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	ORG_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	PAY_BIZ_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	PAY_BIZ_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	LOCATION_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	LOCATION_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	GEMP_YMD nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	EMP_YMD nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	RET_YMD nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	CURR_ORG_YMD nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	CONTACT_NO nvarchar(14) COLLATE Korean_Wansung_CI_AS NULL,
	EMAIL nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	BANK_NM nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	ACCOUNT_NO nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	COST_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	COST_NM nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	MANAGE_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	MANAGE_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	MANAGE_DTL_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	MANAGE_DTL_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	POSITION_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	POSITION_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	PRIOR_ORG_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	PRIOR_ORG_NM nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	ERP_ENTER_CD nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	ENTER_NM nvarchar(200) COLLATE Korean_Wansung_CI_AS NULL,
	CHANGE_YMD nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_EMPINFO_RCV PRIMARY KEY (SABUN)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF남양직원정보', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'SABUN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'성명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직위코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'JIKWEE_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직위명 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'JIKWEE_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직급코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'JIKGUB_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직급명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'JIKGUB_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직책코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'JIKCHAK_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직책명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'JIKCHAK_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조직코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'ORG_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조직명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'ORG_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'급여장코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'PAY_BIZ_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'급여사업장', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'PAY_BIZ_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'근무지코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'LOCATION_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'근무지사업장', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'LOCATION_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'그룹입사일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'GEMP_YMD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입사일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'EMP_YMD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퇴사일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'RET_YMD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현조직부임일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'CURR_ORG_YMD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전화번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'CONTACT_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이메일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'EMAIL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계좌은행', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'BANK_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계좌번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'ACCOUNT_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코스트센터코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'COST_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코스트센터명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'COST_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사원구분코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'MANAGE_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사원구분명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'MANAGE_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고용세부코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'MANAGE_DTL_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고용세부명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'MANAGE_DTL_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'POSITION코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'POSITION_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'POSITION명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'POSITION_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상위조직코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'PRIOR_ORG_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상위조직명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'PRIOR_ORG_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP회사코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'ERP_ENTER_CD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회사명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'ENTER_NM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최근변경일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'CHANGE_YMD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EMPINFO_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_EVENTPOPUP_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_EVENTPOPUP_RCV;

CREATE TABLE NY_ORDER.dbo.IF_EVENTPOPUP_RCV (
	WORK_DT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	WORK_SEQ numeric(13,0) NOT NULL,
	WORK_TYPE nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	POPUP_NO numeric(13,0) NULL,
	DEPT_CODE nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	POPUP_NAME nvarchar(100) COLLATE Korean_Wansung_CI_AS NULL,
	ANNOUNCE_STR_DT datetime NULL,
	ANNOUNCE_END_DT datetime NULL,
	CUST_CLASS2 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	CONTENT nvarchar(400) COLLATE Korean_Wansung_CI_AS NULL,
	PC_FILE_ID nvarchar(250) COLLATE Korean_Wansung_CI_AS NULL,
	PC_IMG_HOR numeric(10,0) NULL,
	PC_IMG_VER numeric(10,0) NULL,
	MOBI_FILE_ID nvarchar(250) COLLATE Korean_Wansung_CI_AS NULL,
	MOBI_IMG_HOR numeric(10,0) NULL,
	MOBI_IMG_VER numeric(10,0) NULL,
	ENTRY_ID nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	ENTRY_DATE datetime NULL,
	MODIFY_ID nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	MODIFY_DATE datetime NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_EVENTPOPUP_RCV PRIMARY KEY (WORK_DT,WORK_SEQ)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF행사팝업', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'WORK_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'WORK_SEQ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업유형 (I : INSERT, D: DELETE)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'WORK_TYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'팝업번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'POPUP_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소속부서', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'DEPT_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'팝업명(제목)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'POPUP_NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'게시시작일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'ANNOUNCE_STR_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'게시종료일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'ANNOUNCE_END_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객계층중분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'CUST_CLASS2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'내용', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'CONTENT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PC파일ID', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'PC_FILE_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PC 이미지 가로크기', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'PC_IMG_HOR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PC 이미지 세로크기', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'PC_IMG_VER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MOBILE파일ID', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'MOBI_FILE_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MOBILE 이미지 가로크기', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'MOBI_IMG_HOR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MOBILE 이미지 세로크기', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'MOBI_IMG_VER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성자사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'ENTRY_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력일시(작성시간)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'ENTRY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정자사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'MODIFY_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'MODIFY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EVENTPOPUP_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_EXPIRWRNT_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_EXPIRWRNT_RCV;

CREATE TABLE NY_ORDER.dbo.IF_EXPIRWRNT_RCV (
	INQ_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATA_TYPENM nvarchar(60) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SEQ int NOT NULL,
	CLOSE_DT nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	SETUP_AMT numeric(15,0) NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_EXPIRWRNT_RCV PRIMARY KEY (INQ_DATE,KUNNR,DATA_TYPENM,SEQ)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF담보만료예정정보수신', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기준일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'INQ_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대리점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'담보종류 명칭', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'DATA_TYPENM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'담보차수', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'SEQ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'만료예정일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'CLOSE_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'담보금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'SETUP_AMT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_EXPIRWRNT_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_KOTG901 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_KOTG901;

CREATE TABLE NY_ORDER.dbo.IF_KOTG901 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZTABLE nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KSCHL nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZKVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZPRODH1 nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATBI nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATAB nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_KOTG901 PRIMARY KEY (SEND_DATE,ZZTABLE,KSCHL,ZZKVGR3,ZZPRODH1,DATBI)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF주문허용3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'ZZTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'KSCHL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹 3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'ZZKVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-대분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'ZZPRODH1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'DATBI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'DATAB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG901', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_KOTG902 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_KOTG902;

CREATE TABLE NY_ORDER.dbo.IF_KOTG902 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZTABLE nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KSCHL nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZPRODH1 nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATBI nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATAB nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_KOTG902 PRIMARY KEY (SEND_DATE,ZZTABLE,KSCHL,KUNNR,ZZPRODH1,DATBI)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF주문허용2', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'ZZTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'KSCHL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-대분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'ZZPRODH1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'DATBI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'DATAB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG902', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_KOTG903 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_KOTG903;

CREATE TABLE NY_ORDER.dbo.IF_KOTG903 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZTABLE nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KSCHL nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATBI nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATAB nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_KOTG903 PRIMARY KEY (SEND_DATE,ZZTABLE,KSCHL,KUNNR,MATNR,DATBI)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF주문허용1', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'ZZTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'KSCHL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'DATBI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'DATAB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG903', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_KOTG904 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_KOTG904;

CREATE TABLE NY_ORDER.dbo.IF_KOTG904 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZTABLE nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KSCHL nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZPRODH1 nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATBI nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATAB nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_KOTG904 PRIMARY KEY (SEND_DATE,ZZTABLE,KSCHL,KUNNR,ZZPRODH1,DATBI)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF주문제외2', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'ZZTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'KSCHL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-대분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'ZZPRODH1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'DATBI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'DATAB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG904', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_KOTG905 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_KOTG905;

CREATE TABLE NY_ORDER.dbo.IF_KOTG905 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZTABLE nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KSCHL nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATBI nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATAB nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_KOTG905 PRIMARY KEY (SEND_DATE,ZZTABLE,KSCHL,KUNNR,MATNR,DATBI)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF주문제외1', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'ZZTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'KSCHL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'DATBI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'DATAB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG905', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_KOTG906 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_KOTG906;

CREATE TABLE NY_ORDER.dbo.IF_KOTG906 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZTABLE nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KSCHL nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZKVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZPRODH1 nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATBI nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATAB nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_KOTG906 PRIMARY KEY (SEND_DATE,ZZTABLE,KSCHL,ZZKVGR3,ZZPRODH1,DATBI)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF주문제외3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'ZZTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'KSCHL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹 3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'ZZKVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-대분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'ZZPRODH1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'DATBI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'DATAB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG906', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_KOTG909 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_KOTG909;

CREATE TABLE NY_ORDER.dbo.IF_KOTG909 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZTABLE nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KSCHL nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZKVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATBI nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATAB nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_KOTG909 PRIMARY KEY (SEND_DATE,ZZTABLE,KSCHL,ZZKVGR3,MATNR,DATBI)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'주문허용3(KOTG909)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'ZZTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'KSCHL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'ZZKVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'DATBI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'DATAB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG909', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_KOTG910 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_KOTG910;

CREATE TABLE NY_ORDER.dbo.IF_KOTG910 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZTABLE nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KSCHL nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZZKVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATBI nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DATAB nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_KOTG910 PRIMARY KEY (SEND_DATE,ZZTABLE,KSCHL,ZZKVGR3,MATNR,DATBI)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'주문제외3(KOTG910)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'ZZTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'KSCHL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'ZZKVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'DATBI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'DATAB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_KOTG910', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_MONCLSRPDF_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_MONCLSRPDF_RCV;

CREATE TABLE NY_ORDER.dbo.IF_MONCLSRPDF_RCV (
	DOCTP nvarchar(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VKORG nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SPMON nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	USERID nvarchar(12) COLLATE Korean_Wansung_CI_AS NULL,
	FILE_NAME nvarchar(800) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_MONCLSRPDF_RCV PRIMARY KEY (DOCTP,VKORG,SPMON,KUNNR)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF월마감장PDF', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문서구분', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'DOCTP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업조직', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'VKORG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'정산년월', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'SPMON';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'거래처코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용자ID', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'USERID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'FILE명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'FILE_NAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_MONCLSRPDF_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_NOTICEAUTH_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_NOTICEAUTH_RCV;

CREATE TABLE NY_ORDER.dbo.IF_NOTICEAUTH_RCV (
	WORK_DT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	WORK_SEQ numeric(13,0) NOT NULL,
	WORK_TYPE nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	BRANCH_CODE nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	ANNOUNCE_DT nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	SERIAL_NO numeric(13,0) NULL,
	CUST_CODE nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	NEW_YN nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	ENTRY_DATE datetime NULL,
	ENTRY_ID nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	MODIFY_DATE datetime NULL,
	MODIFY_ID nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_NOTICEAUTH_RCV PRIMARY KEY (WORK_DT,WORK_SEQ)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF공지사항권한', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'WORK_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'WORK_SEQ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업유형(I:INSERT, D:DELETE)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'WORK_TYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'BRANCH_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'ANNOUNCE_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'일련번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'SERIAL_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대리점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'CUST_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'신규여부', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'NEW_YN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'ENTRY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력자사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'ENTRY_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'MODIFY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정자사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'MODIFY_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICEAUTH_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_NOTICE_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_NOTICE_RCV;

CREATE TABLE NY_ORDER.dbo.IF_NOTICE_RCV (
	WORK_DT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	WORK_SEQ numeric(13,0) NOT NULL,
	WORK_TYPE nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	BRANCH_CODE nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	ANNOUNCE_DT nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	SERIAL_NO numeric(13,0) NULL,
	ANNOUNCE_STR_DT datetime NULL,
	ANNOUNCE_END_DT datetime NULL,
	ANNOUNCE_SUBJECT nvarchar(300) COLLATE Korean_Wansung_CI_AS NULL,
	ANNOUNCE_DTL nvarchar(2000) COLLATE Korean_Wansung_CI_AS NULL,
	CUST_CLASS2 nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	ENTRY_DATE datetime NULL,
	ENTRY_ID nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	MODIFY_DATE datetime NULL,
	MODIFY_ID nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_NOTICE_RCV PRIMARY KEY (WORK_DT,WORK_SEQ)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF공지사항', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'WORK_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'WORK_SEQ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작업유형(I:INSERT, D:DELETE)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'WORK_TYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'BRANCH_CODE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'ANNOUNCE_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'일련번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'SERIAL_NO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지시작일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'ANNOUNCE_STR_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지종료일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'ANNOUNCE_END_DT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지사항제목', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'ANNOUNCE_SUBJECT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지내용', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'ANNOUNCE_DTL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객계층중분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'CUST_CLASS2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'ENTRY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력자사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'ENTRY_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'MODIFY_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정자사번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'MODIFY_ID';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_NOTICE_RCV', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_ORDERCFM_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_ORDERCFM_RCV;

CREATE TABLE NY_ORDER.dbo.IF_ORDERCFM_RCV (
	CRTNDATE nvarchar(17) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VKORG nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VBELN nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	POSNR nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	BSARK nvarchar(4) COLLATE Korean_Wansung_CI_AS DEFAULT '0000' NOT NULL,
	AUDAT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(40) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZAUART nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SUBSYS_ORDERNO nvarchar(24) COLLATE Korean_Wansung_CI_AS NULL,
	AUGRU nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	VSART nvarchar(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNWE nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	EDATU nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	KWMENG nvarchar(15) COLLATE Korean_Wansung_CI_AS NULL,
	CONF_KWMENG nvarchar(15) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VRKME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	NETPR nvarchar(13) COLLATE Korean_Wansung_CI_AS NULL,
	KPEIN nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	NETWR nvarchar(15) COLLATE Korean_Wansung_CI_AS NULL,
	MWSBP nvarchar(13) COLLATE Korean_Wansung_CI_AS NULL,
	WAERK nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	PROC_TYPE nvarchar(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ABGRU nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	ZSO_CHGCD nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	ZSO_CHGTEXT nvarchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	FREEG_MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	KVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	KUNRG nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	APPLYTIME datetime NULL,
	APPLYMSG nvarchar(3000) COLLATE Korean_Wansung_CI_AS NULL,
	WERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	UMREZ nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_ORDERCFM_RCV PRIMARY KEY (CRTNDATE,VKORG,VBELN,POSNR)
);
 CREATE NONCLUSTERED INDEX IX_IF_ORDERCFM_RCV_01 ON dbo.IF_ORDERCFM_RCV (  XDATS ASC  , XSTAT ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'주문확정수신 - SAP 주문확정정보 수신 (SAP 주문확정후 1일1회 수신 받음)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'CRTNDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업조직. 남양유업 = 1000', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'VKORG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'VBELN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문품목순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'POSNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문입력경로(SD0024)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'BSARK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'AUDAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처코드 예) 1000029', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'<레거시 주문유형 CODE >', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'ZAUART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'외부주문 참조키', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'SUBSYS_ORDERNO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오더사유코드(SD0018)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'AUGRU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출하유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'VSART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품처코드 예) 1000029', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'KUNWE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품요청일 (YYYYMMDD)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'EDATU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대리점 요청 주문 수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'낱봉 판매수량 (확정수량)  ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'CONF_KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단위_낱개', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'VRKME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단가  (정수 13자리)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'NETPR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단가에 대한 소수점 표현시 사용', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'KPEIN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공급금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'NETWR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'MWSBP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매통화.  KRW', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'WAERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공백(정상), D(삭제)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'PROC_TYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'거부사유', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'ABGRU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문변경사유 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'ZSO_CHGCD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변경사유명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'ZSO_CHGTEXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'덤 부모제품코드(덤이면, 부모 제품코드를 지정)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'FREEG_MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객소분류 (학교급식: 401)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'KVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지급처 (급식처의 대리점코드)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'KUNRG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 [R(수신)->W(처리중)->S(완료), E(오류)]', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신 시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'APPLYTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영중 발생한 오류 메시지', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'APPLYMSG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'WERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDERCFM_RCV', @level2type=N'Column', @level2name=N'UMREZ';


-- NY_ORDER.dbo.IF_ORDER_BATCH_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_ORDER_BATCH_RCV;

CREATE TABLE NY_ORDER.dbo.IF_ORDER_BATCH_RCV (
	CRTNDATE nvarchar(17) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VKORG nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	BSARK nvarchar(4) COLLATE Korean_Wansung_CI_AS DEFAULT '0000' NOT NULL,
	AUDAT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZAUART nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SUBSYS_ORDERNO nvarchar(24) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VBELN nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	POSNR nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	KWMENG nvarchar(15) COLLATE Korean_Wansung_CI_AS NULL,
	PROC_TYPE nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	STATUS nvarchar(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	FREEG_MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	MESSAGE nvarchar(3000) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	APPLYTIME datetime NULL,
	APPLYMSG nvarchar(3000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK__IF_ORDER__0430B8B847EB75B3 PRIMARY KEY (CRTNDATE,VKORG,BSARK,AUDAT,KUNNR,MATNR,ZAUART,SUBSYS_ORDERNO)
);
 CREATE NONCLUSTERED INDEX IX_IF_ORDER_BATCH_RCV_01 ON dbo.IF_ORDER_BATCH_RCV (  XDATS ASC  , XSTAT ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IF 주문배치 결과수신', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'CRTNDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업조직. 남양유업 = 1000', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'VKORG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문입력경로(SD0024)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'BSARK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'AUDAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'레거시 주문유형 (SD0016)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'ZAUART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'외부주문 참조키', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'SUBSYS_ORDERNO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'VBELN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문품목순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'POSNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'총판매수량(낱봉기준)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'C(신규), U(수정), D(삭제) ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'PROC_TYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (S : 성공 , E : 실패)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'STATUS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'덤 부모제품코드(덤이면, 부모 제품코드를 지정)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'FREEG_MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신 메시지', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'MESSAGE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 [R(수신)->W(처리중)->S(완료), E(오류)]', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'APPLYTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영중 발생한 오류 메시지', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_BATCH_RCV', @level2type=N'Column', @level2name=N'APPLYMSG';


-- NY_ORDER.dbo.IF_ORDER_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_ORDER_RCV;

CREATE TABLE NY_ORDER.dbo.IF_ORDER_RCV (
	CRTNDATE nvarchar(17) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VKORG nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VBELN nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	POSNR nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	BSARK nvarchar(4) COLLATE Korean_Wansung_CI_AS DEFAULT '0000' NOT NULL,
	AUDAT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZAUART nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SUBSYS_ORDERNO nvarchar(24) COLLATE Korean_Wansung_CI_AS NULL,
	AUGRU nvarchar(3) COLLATE Korean_Wansung_CI_AS DEFAULT '000' NULL,
	VSART nvarchar(2) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNWE nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	EDATU nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	CONF_KWMENG nvarchar(15) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VRKME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	NETPR nvarchar(13) COLLATE Korean_Wansung_CI_AS NULL,
	KPEIN nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	NETWR nvarchar(15) COLLATE Korean_Wansung_CI_AS NULL,
	MWSBP nvarchar(13) COLLATE Korean_Wansung_CI_AS NULL,
	WAERK nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	PROC_TYPE nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	ABGRU nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	ZSO_CHGCD nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	ZSO_CHGTEXT nvarchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	KVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	KUNRG nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	APPLYTIME datetime NULL,
	APPLYMSG nvarchar(3000) COLLATE Korean_Wansung_CI_AS NULL,
	WERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	UMREZ nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_ORDER_RCV PRIMARY KEY (CRTNDATE,VKORG,VBELN,POSNR)
);
 CREATE NONCLUSTERED INDEX IX_IF_ORDER_RCV_01 ON dbo.IF_ORDER_RCV (  XDATS ASC  , XSTAT ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'주문 정보(변경 및 생성) 수신', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'CRTNDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업조직. 남양유업 = 1000', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'VKORG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'VBELN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문품목순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'POSNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문입력경로(SD0024)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'BSARK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'AUDAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처코드 예) 1000029', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'<레거시 주문유형 >', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'ZAUART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'외부주문 참조키', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'SUBSYS_ORDERNO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오더사유코드(SD0018)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'AUGRU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출하유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'VSART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품처코드 예) 1000029', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'KUNWE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품요청일 (YYYYMMDD)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'EDATU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'낱봉 판매수량 (확정수량) ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'CONF_KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단위_낱개', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'VRKME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단가  (VAT 포함)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'NETPR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단가에 대한 소수점 표현시 사용', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'KPEIN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공급금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'NETWR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'MWSBP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매통화.  KRW', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'WAERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'C(신규), U(수정), D(삭제) ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'PROC_TYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'거부사유', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'ABGRU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문변경사유 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'ZSO_CHGCD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변경사유명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'ZSO_CHGTEXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객소분류 (학교급식: 401)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'KVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'지급처 (급식처의 대리점코드)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'KUNRG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 [R(수신)->W(처리중)->S(완료), E(오류)]', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'APPLYTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영중 발생한 오류 메시지', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'APPLYMSG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'WERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_RCV', @level2type=N'Column', @level2name=N'UMREZ';


-- NY_ORDER.dbo.IF_ORDER_SND definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_ORDER_SND;

CREATE TABLE NY_ORDER.dbo.IF_ORDER_SND (
	VKORG nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	BSARK nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	AUDAT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZAUART nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SUBSYS_ORDERNO nvarchar(24) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VBELN nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	POSNR nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	AUGRU nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	VSART nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	KUNWE nvarchar(7) COLLATE Korean_Wansung_CI_AS NULL,
	WERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	EDATU nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	REQ_MONTH nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	KWMENG nvarchar(15) COLLATE Korean_Wansung_CI_AS NULL,
	VRKME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	NETPR nvarchar(13) COLLATE Korean_Wansung_CI_AS NULL,
	KPEIN nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	NETWR nvarchar(15) COLLATE Korean_Wansung_CI_AS NULL,
	MWSBP nvarchar(13) COLLATE Korean_Wansung_CI_AS NULL,
	WAERK nvarchar(5) COLLATE Korean_Wansung_CI_AS NULL,
	PROC_TYPE nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT_IN nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS_IN nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS_IN nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_ORDER_SND PRIMARY KEY (VKORG,BSARK,AUDAT,KUNNR,MATNR,ZAUART,SUBSYS_ORDERNO)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'주문송신(제품, 판촉물, 판촉물소요량, 급식), 반품송신(정기,특별), 주문확정수신, 출하수신, 배송완료수신, 반품확정수신', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업조직. 남양유업 = 1000', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'VKORG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객 구매 주문 유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'BSARK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'증빙일.Document date(레거시 시스템주문생성일)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'AUDAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처코드 예) 1000029', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품코드 예) 2100001', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'<레거시 주문유형 CODE>', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'ZAUART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'외부주문 참조키', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'SUBSYS_ORDERNO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문번호.', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'VBELN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문품목순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'POSNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[주문사유]', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'AUGRU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출하유형 10: 일반 20: 직배송, 30 :택배배송', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'VSART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품처코드 예) 1000029 급식인 경우) 급식처코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'KUNWE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출고 물류센터.*영업사원 모바일만 사용', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'WERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품요청일 (YYYYMMDD)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'EDATU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'요청년월(YYYYMM)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'REQ_MONTH';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'총 판매수량(낱봉기준))  ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단위_낱개', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'VRKME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단가  (정수 13자리)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'NETPR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단가에 대한 소수점 표현시 사용', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'KPEIN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매금액(정수 15자리) - 부가세 제외금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'NETWR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'MWSBP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매통화.  KRW', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'WAERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'C(신규), U(수정), D(삭제) ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'PROC_TYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'XSTAT_IN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'XDATS_IN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_ORDER_SND', @level2type=N'Column', @level2name=N'XTIMS_IN';


-- NY_ORDER.dbo.IF_OUTPUT definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_OUTPUT;

CREATE TABLE NY_ORDER.dbo.IF_OUTPUT (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	WERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZBOXQT numeric(13,0) NULL,
	ZSBXQT numeric(13,0) NULL,
	ZMAXQT numeric(13,0) NULL,
	ZRTEXT nvarchar(150) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_OUTPUT PRIMARY KEY (SEND_DATE,KVGR3,WERKS,MATNR)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF낱봉가능', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹 3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'KVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'WERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입수량 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'ZBOXQT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'ZSBXQT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'낱봉주문 최대수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'ZMAXQT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'적용사유', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'ZRTEXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_OUTPUT2 definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_OUTPUT2;

CREATE TABLE NY_ORDER.dbo.IF_OUTPUT2 (
	SEND_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KVGR3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZBOXQT numeric(13,0) NULL,
	ZSBXQT numeric(13,0) NULL,
	ZDAYQT numeric(13,0) NULL,
	ZRTEXT nvarchar(150) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_OUTPUT2 PRIMARY KEY (SEND_DATE,KVGR3,MATNR)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF최대허용수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'SEND_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고객그룹 3', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'KVGR3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입수량 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'ZBOXQT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'ZSBXQT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1일 최대 주문가능 수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'ZDAYQT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'적용사유', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'ZRTEXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_OUTPUT2', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_PRICE definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_PRICE;

CREATE TABLE NY_ORDER.dbo.IF_PRICE (
	SENDDT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	SAPTABLE nvarchar(20) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRCTYPE nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	COND1 nvarchar(10) COLLATE Korean_Wansung_CI_AS DEFAULT '*' NOT NULL,
	COND2 nvarchar(10) COLLATE Korean_Wansung_CI_AS DEFAULT '*' NOT NULL,
	PRODCD nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRODDLVAMT numeric(13,0) NOT NULL,
	PRCDCNUNIT numeric(10,0) NOT NULL,
	KONWA nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	DELYN nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	STARTDT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ENDDT nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_PRICE PRIMARY KEY (SENDDT,SAPTABLE,PRCTYPE,COND1,COND2,PRODCD,ENDDT)
);
 CREATE NONCLUSTERED INDEX IX_PRICE ON dbo.IF_PRICE (  XSTAT ASC  , SENDDT ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF가격테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MSDESCRIPTION', @value=N'IF가격테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전송일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'SENDDT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SAP테이블', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'SAPTABLE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가격유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'PRCTYPE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조건1', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'COND1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조건2', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'COND2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'PRODCD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품공급금액', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'PRODDLVAMT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단가(가격)결정단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'PRCDCNUNIT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'통화단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'KONWA';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'삭제여부', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'DELYN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'효력시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'STARTDT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'효력종료일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'ENDDT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRICE', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_PRMTCFM_SND definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_PRMTCFM_SND;

CREATE TABLE NY_ORDER.dbo.IF_PRMTCFM_SND (
	VKORG nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	REQ_MONTH nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZGR_DATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZGR_KWMENG numeric(15,0) NULL,
	VRKME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	VBELN nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	POSNR nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_PRMTCFM_SND PRIMARY KEY (VKORG,REQ_MONTH,KUNNR,MATNR,ZGR_DATE)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF판촉물(직납)입고확인', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업조직(남양유업:1000)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'VKORG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판촉물소요량,반품 요청 연월YYYYMM', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'REQ_MONTH';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처코드 예) 1000029', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품코드 예) 2100001', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판촉물 입고일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'ZGR_DATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'낱봉 입고수량(0이면 삭제)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'ZGR_KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단위_낱개(자재마스터MEINS)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'VRKME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SAP주문번호(판촉물소요량SAP주문번호)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'VBELN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SAP주문품목 순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'POSNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'송신상태 R:전송요청(Ready) D:전송 완료(Done)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'송신 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'송신 시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRMTCFM_SND', @level2type=N'Column', @level2name=N'XTIMS';


-- NY_ORDER.dbo.IF_PROD definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_PROD;

CREATE TABLE NY_ORDER.dbo.IF_PROD (
	IFGNUM nvarchar(12) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(40) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MTART nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	BISMT nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	MAKTX_KO nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	MAKTX_Z1 nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	MAKTX_EN nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	MATKL nvarchar(9) COLLATE Korean_Wansung_CI_AS NULL,
	PRODH1 nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	PRODH2 nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	PRODH3 nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	PRODH4 nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	MSTAE nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	MSTDE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	MEINS nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	BRGEW numeric(13,3) NULL,
	GEWEI nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	VOLUM numeric(13,3) NULL,
	VOLEH nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	UMREZ_PAL int NULL,
	UMREZ_BOX int NULL,
	UMREZ_CS int NULL,
	EAN11_BOX nvarchar(18) COLLATE Korean_Wansung_CI_AS NULL,
	EAN11_CS nvarchar(18) COLLATE Korean_Wansung_CI_AS NULL,
	EAN11_EA nvarchar(18) COLLATE Korean_Wansung_CI_AS NULL,
	ZZVATTY nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	ZZPPUNIT int NULL,
	ZZIMPLANT nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	ZZMILKTY nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	ZZPBVN nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	ZZWERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	ZZPBFG nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEXTY nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	ZZFOODTY nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	ZZFOOD_STD nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	ZZCONV numeric(15,3) NULL,
	ZZEQNAME nvarchar(500) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEQSIZE nvarchar(500) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEQSYNM nvarchar(500) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEQSUP_MAT nvarchar(20) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEQSUP nvarchar(300) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEQMFR nvarchar(300) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEQCLS1 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEQCLS2 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	ZZEQCLS3 nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	DWERK nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	TAXM1 nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	SCMNG numeric(13,0) NULL,
	KONDM nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	KTGRM nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	MTPOS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	PMATA nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	XCHPF nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	BSTME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	TEMPB nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	MHDRZ int NULL,
	MHDHB int NULL,
	WZEIT int NULL,
	ZZPLIFZ int NULL,
	ZZBSTRF numeric(13,3) NULL,
	LVORM nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	IFFLAG nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	IFDATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	IFTIME nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	IFUSER nvarchar(12) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_PROD PRIMARY KEY (IFGNUM,MATNR)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF_제품마스터', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공통 I/F 전송 채번(NR)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'IFGNUM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MTART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기존자재번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'BISMT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재내역(한글)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MAKTX_KO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재내역(약어)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MAKTX_Z1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재내역(영문)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MAKTX_EN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재그룹', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MATKL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-대분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'PRODH1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-중분류 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'PRODH2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-소분류 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'PRODH3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-세분류 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'PRODH4';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재상태', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MSTAE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 상태의 효력 시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MSTDE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기본단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MEINS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'중량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'BRGEW';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'중량단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'GEWEI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'부피', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'VOLUM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'부피단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'VOLEH';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입수수량-팔레트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'UMREZ_PAL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입수수량-박스', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'UMREZ_BOX';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입수수량-소포장', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'UMREZ_CS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'바코드-박스', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'EAN11_BOX';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'바코드-소포장', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'EAN11_CS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'바코드-낱봉', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'EAN11_EA';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'VAT공제구분', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZVATTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생산출고단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZPPUNIT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직수입 자재사업장', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZIMPLANT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'취급유종', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZMILKTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PB 사급업체', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZPBVN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대표생산플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZWERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유통점 PB 구분', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZPBFG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수출 구분', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEXTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'식품 구분', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZFOODTY';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'법적유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZFOOD_STD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대표제품 환산치', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZCONV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 품명', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQNAME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 표준규격', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQSIZE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 동의어', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQSYNM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 공급사 상품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQSUP_MAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 공급사', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQSUP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 제조사', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQMFR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 대분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQCLS1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 중분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQCLS2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기자재 소분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZEQCLS3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'DWERK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세금분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'TAXM1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'납품단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'SCMNG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재가격결정그룹', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'KONDM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계정지정그룹', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'KTGRM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'품목범주그룹', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MTPOS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가격결정참조자재', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'PMATA';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'배치관리', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'XCHPF';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매오더단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'BSTME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'온도조건', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'TEMPB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최소 잔존 셸프 라이프 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MHDRZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'총 셸프 라이프 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'MHDHB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'총보충 리드타임', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'WZEIT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'표준리드타임', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZPLIFZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최소발주수량', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'ZZBSTRF';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 삭제 지시자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'LVORM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 유형(I, U)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'IFFLAG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'IFDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'IFTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'IFUSER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅) P:수신 측 처리작업 중 S:수신 측 처리완료 E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PROD', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_PRODLEVEL definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_PRODLEVEL;

CREATE TABLE NY_ORDER.dbo.IF_PRODLEVEL (
	IFGNUM nvarchar(12) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRODH1 nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRODH2 nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRODH3 nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRODH4 nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	PRODH1TXT nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	PRODH2TXT nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	PRODH3TXT nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	PRODH4TXT nvarchar(120) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XUSER nvarchar(12) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_PRODLEVEL PRIMARY KEY (IFGNUM,PRODH1,PRODH2,PRODH3,PRODH4)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF제품계층구조', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'일련번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'IFGNUM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-대분류', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'PRODH1';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-중분류 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'PRODH2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-소분류 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'PRODH3';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품분류-세분류 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'PRODH4';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대분류 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'PRODH1TXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'중분류 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'PRODH2TXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소분류 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'PRODH3TXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'세분류 내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'PRODH4TXT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 발신인 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'XUSER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 R:수신완료(PO세팅), P:수신 측 처리작업 중, S:수신 측 처리완료, E:수신 측 에러', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODLEVEL', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_PRODPLNT definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_PRODPLNT;

CREATE TABLE NY_ORDER.dbo.IF_PRODPLNT (
	IFGNUM nvarchar(12) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(40) COLLATE Korean_Wansung_CI_AS NOT NULL,
	WERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MTART nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	BISMT nvarchar(40) COLLATE Korean_Wansung_CI_AS NULL,
	MAKTX_KO nvarchar(240) COLLATE Korean_Wansung_CI_AS NULL,
	ZZWERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	WZEIT_P int NULL,
	XCHPF_P nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	MMSTA nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	MMSTD nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	DISMM nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	DISPO nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	DISLS nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	BSTMI numeric(13,3) NULL,
	BSTMA numeric(13,3) NULL,
	BSTFE numeric(13,3) NULL,
	MABST numeric(13,3) NULL,
	BESKZ nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XCHAR nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	SOBSL nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	RGEKZ nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	LGPRO nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	LGFSB nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	WEBAZ int NULL,
	FRTME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	AUSME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	ZMATC nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	FEVOR nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	UEETK nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	MTVFP nvarchar(2) COLLATE Korean_Wansung_CI_AS NULL,
	EKGRP nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	ZMTAR nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	ZPLT nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	LVORM nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	IFFLAG nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	IFDATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	IFTIME nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	IFUSER nvarchar(12) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	XERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_PRODPLNT PRIMARY KEY (IFGNUM,MATNR,WERKS)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF자재플랜트별속성', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공통 I/F 전송 채번(NR)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'IFGNUM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SAP자재번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'WERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'MTART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기존자재번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'BISMT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재내역(한글)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'MAKTX_KO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대표생산플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'ZZWERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'총보충리드타임', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'WZEIT_P';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트별 배치관리 지시자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'XCHPF_P';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트별 자재 상태', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'MMSTA';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트별 자재 상태 효력시작일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'MMSTD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MRP 유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'DISMM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MRP 관리자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'DISPO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'로트 크기 결정 절차', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'DISLS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최소 로트 크기', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'BSTMI';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최대 로트 크기', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'BSTMA';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고정 로트 크기', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'BSTFE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최대 재고 레벨', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'MABST';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'조달 유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'BESKZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'뱃치관리 지시자 (내부)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'XCHAR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'특별조달유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'SOBSL';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'백플러시 지시자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'RGEKZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출고 저장 장소', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'LGPRO';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'외부 조달의 기본 저장 장소', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'LGFSB';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입고소요일수 (일)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'WEBAZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생산단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'FRTME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출고단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'AUSME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'품목관리자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'ZMATC';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생산 감독자 ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'FEVOR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'무제한 초과 납품 허용', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'UEETK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가용성점검', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'MTVFP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매 그룹', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'EKGRP';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생산 자재유형', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'ZMTAR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'팔레트 단위', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'ZPLT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트레벨 삭제지시자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'LVORM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 유형(I, U)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'IFFLAG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신일', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'IFDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'IFTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 송신자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'IFUSER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리상태 R : 처리준비 (Ready) D : 처리완료 (Done) E : 처리에러 (Error)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'I/F 시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_PRODPLNT', @level2type=N'Column', @level2name=N'XERRMSG';


-- NY_ORDER.dbo.IF_RETCFM_RCV definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_RETCFM_RCV;

CREATE TABLE NY_ORDER.dbo.IF_RETCFM_RCV (
	CRTNDATE nvarchar(17) COLLATE Korean_Wansung_CI_AS NOT NULL,
	VKORG nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	REQ_MONTH nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ZAUART nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	AUGRU nvarchar(3) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KUNNR nvarchar(10) COLLATE Korean_Wansung_CI_AS NOT NULL,
	MATNR nvarchar(40) COLLATE Korean_Wansung_CI_AS NOT NULL,
	KWMENG nvarchar(15) COLLATE Korean_Wansung_CI_AS NULL,
	CONF_KWMENG nvarchar(15) COLLATE Korean_Wansung_CI_AS NULL,
	VRKME nvarchar(3) COLLATE Korean_Wansung_CI_AS NULL,
	MTPOS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	ZCONF_DATE2 nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	VBELN nvarchar(10) COLLATE Korean_Wansung_CI_AS NULL,
	POSNR nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	BSARK nvarchar(4) COLLATE Korean_Wansung_CI_AS DEFAULT '0000' NULL,
	UMREZ nvarchar(5) COLLATE Korean_Wansung_CI_AS DEFAULT 0 NULL,
	WERKS nvarchar(4) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NOT NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NOT NULL,
	APPLYTIME datetime NULL,
	APPLYMSG nvarchar(3000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_RETCFM_RCV PRIMARY KEY (CRTNDATE,VKORG,REQ_MONTH,ZAUART,AUGRU,KUNNR,MATNR)
);
 CREATE NONCLUSTERED INDEX IX_IF_RETCFM_RCV_01 ON dbo.IF_RETCFM_RCV (  XDATS ASC  , XSTAT ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF반품/판촉소용량요청 확정정보 수신', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성일시', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'CRTNDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'영업조직. 남양유업 = 1000', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'VKORG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판촉물소요량,반품 요청 연월', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'REQ_MONTH';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문유형(SD0016)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'ZAUART';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'오더 사유 코드(SD0018 - 201:반품-정기, 202:반품-특별 외)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'AUGRU';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매처코드 예) 1000029', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'KUNNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제품코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'MATNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'총 요청수량(낱봉단위)  ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'확정 수량(낱봉단위)  ', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'CONF_KWMENG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매단위_낱개', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'VRKME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자재 마스터의 품목 범주 그룹', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'MTPOS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'본사 확정일자  YYYYMMDD', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'ZCONF_DATE2';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문번호', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'VBELN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERP 주문품목 순번', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'POSNR';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문입력경로(SD0024)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'BSARK';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'량입수', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'UMREZ';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플랜트', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'WERKS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신상태 [R(수신)->W(처리중)->S(완료), E(오류)]', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신 날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신 시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'XTIMS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'APPLYTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'반영중 발생한 오류 메시지', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RETCFM_RCV', @level2type=N'Column', @level2name=N'APPLYMSG';


-- NY_ORDER.dbo.IF_RSTLRTN definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_RSTLRTN;

CREATE TABLE NY_ORDER.dbo.IF_RSTLRTN (
	IFGNUM nvarchar(12) COLLATE Korean_Wansung_CI_AS NOT NULL,
	IFSYS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	IFDATE nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	IFTIME nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	IFUSER nvarchar(12) COLLATE Korean_Wansung_CI_AS NULL,
	IFSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	IFERRMSG nvarchar(1000) COLLATE Korean_Wansung_CI_AS NULL,
	XSTAT nvarchar(1) COLLATE Korean_Wansung_CI_AS NULL,
	XDATS nvarchar(8) COLLATE Korean_Wansung_CI_AS NULL,
	XTIMS nvarchar(6) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_RSTLRTN PRIMARY KEY (IFGNUM)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'IF결과반환', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공통 I/F 전송 채번(NR)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'IFGNUM';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리시스템 고유 ID', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'IFSYS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 수행일자', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'IFDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 수행시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'IFTIME';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'처리 USER ID', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'IFUSER';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 수행결과(S,E)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'IFSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'인터페이스 처리에러내역', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'IFERRMSG';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'송신상태(R, D)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'XSTAT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'송신날짜', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'XDATS';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'송신시각', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_RSTLRTN', @level2type=N'Column', @level2name=N'XTIMS';


-- NY_ORDER.dbo.IF_TRNM_H definition

-- Drop table

-- DROP TABLE NY_ORDER.dbo.IF_TRNM_H;

CREATE TABLE NY_ORDER.dbo.IF_TRNM_H (
	TRNM_SEQ numeric(18,0) NOT NULL,
	MODULE nvarchar(50) COLLATE Korean_Wansung_CI_AS NOT NULL,
	AGENTCD nvarchar(7) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ORDKIND nvarchar(4) COLLATE Korean_Wansung_CI_AS NOT NULL,
	ORDERCNT int NOT NULL,
	STRDATE datetime NOT NULL,
	ENDDATE datetime NULL,
	REMARK nvarchar(3000) COLLATE Korean_Wansung_CI_AS NULL,
	CONSTRAINT PK_IF_TRNM_H PRIMARY KEY (TRNM_SEQ)
);

-- Extended properties

EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(임시)주문 송신 시간 기록', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_TRNM_H';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문 모듈(PC, MOB, NYC)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_TRNM_H', @level2type=N'Column', @level2name=N'MODULE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대리점코드', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_TRNM_H', @level2type=N'Column', @level2name=N'AGENTCD';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문유형(SD0016 - Y001일반주문 외)', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_TRNM_H', @level2type=N'Column', @level2name=N'ORDKIND';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문 건수', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_TRNM_H', @level2type=N'Column', @level2name=N'ORDERCNT';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'송신시작시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_TRNM_H', @level2type=N'Column', @level2name=N'STRDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'송신종료시간', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_TRNM_H', @level2type=N'Column', @level2name=N'ENDDATE';
EXEC NY_ORDER.sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비고', @level0type=N'Schema', @level0name=N'dbo', @level1type=N'Table', @level1name=N'IF_TRNM_H', @level2type=N'Column', @level2name=N'REMARK';