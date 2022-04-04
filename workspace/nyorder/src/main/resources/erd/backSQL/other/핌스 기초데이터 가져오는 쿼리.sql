/*제품 마스터 팜스*/
--------------제품 마스터------------------------
INSERT INTO T_PRD_MST(
	PRD_SEQ
	, PUCH_SEQ
	, PRD_SAP_CD
	, PRD_NM
	, SHTN_NM
	, PRD_TYPE 
	, LCLS
	, MCLS
	, SCLS
	, DCLS
	, PRMT_CD
	, FALT_CT
	, BRCD
	, IDDY_BRCD
	, FALT_QTY
	, PRD_STRD
	, PUCH_YN
	, TAXT_CD
	, ORD_USE_YN
	, FEE_UNTPC
	, IDDY_UNTPC
	, UNTPC
	, SPPRC
	, VAT_SPPRC
	--, VALD_PD
	, PRD_UNIT
	, RTGD_PERM_TN
	, UNTPC_APPL_DT
	, ORD_PD
	, USE_YN
	, REG_DTM
	, REG_SEQ
	, UPD_DTM
	, UPD_SEQ
)
SELECT 
	NEXT VALUE FOR SQ_PRD	
	, 1
	, a.PROD_CODE
	, a.PROD_NAME
	, a.PROD_ABBR1
	, a.PROD_TYPE
	, a.PROD_CLASS1
	, a.PROD_CLASS2
	, a.PROD_CLASS3
	, a.PROD_CLASS4
	, 'NONE' -- 판촉여부
	, 0
	, a.BARCODE1
	, a.BARCODE2
	, a.BOX_QTY	
	, a.VOLUME
	, 'Y' --메이저 매입처 여부
	, a.TAXATION --과세면세여부
	, a.PRODUCE_YN --주문가능여부(팜스 생산가능여부)
	, 0
	, 0
	, b.PRICE+b.VAT
	, b.PRICE
	, b.VAT
	--, a.BALIDITY_TERM
	, a.UNIT
	, 'Y' --, a.RTN_YN	--반품적용여부
	, b.PRICE_ADAPT_DT --단가적용일
	, a.ORDER_LEADTIME
	, 'Y'
	, GETDATE() 
	, 0
	, GETDATE() 
	, 0
FROM 
parms.namyang.dbo.smcode01 a
	left outer join 
	parms.namyang.dbo.smcode03 b 
	on a.prod_code = b.prod_code
WHERE 
1=1
;

------공통코드

INSERT INTO T_COMM(
COMM_SEQ
,COMM_GRP_CD
,COMM_GRP_NM
,COMM_CD
,COMM_NM
,COMM_DESC1
,COMM_USE_YN
,ORDR
,REG_DTM
,REG_SEQ
,UPD_DTM
,UPD_SEQ
)
SELECT 
	NEXT VALUE FOR SQ_COMM
	, a.code_part
	, a.code_part_name
	, b.code_no
	, b.code_name
	, b.etc_code1
	, 'Y'
	, ROW_NUMBER() over(PARTITION by b.code_part order by b.code_no asc) 
	, GETDATE()
	, 0
	, GETDATE()
	, 0
FROM 
parms.namyang.dbo.ct_code00 a
	left outer join
	parms.namyang.dbo.ct_code01 b 
	on a.code_part = b.code_part
	and a.xstat = b.xstat
	and a.eai = b.eai
WHERE 
1=1
--and a.code_part ='SD0001'
and b.code_no is not null
and a.xstat = 'R'
and a.eai = 'N'
----------------대리점 마스터

exec P_OPEN_KEY;

INSERT INTO T_AGEN_MST(
	AGEN_SEQ
	, AGEN_CD
	, AGEN_NM
	, BIZ_NO
	, JUR_NO
	, SALE_CD
	, AGEN_PRST
	, BIZ_CON
	, BIZ_INDU
	, ZIP_CD
	, ADDR1
	, ADDR2
	, TEL_NO
	, PRST_TEL_NO
	, FAX_NO
	, AGEN_EML
	, AGEN_USE_YN
	, REG_DTM
	, REG_SEQ
	, UPD_DTM
	, UPD_SEQ
) 
SELECT 
	NEXT VALUE FOR ny_order.dbo.SQ_AGEN 
	, agn.CUST_CODE	as AGEN_CD
	, agn.CUST_NAME	as AGEN_NM
	, agn.BUSINESS_ID as BIZ_NO
	, '' AS JUR_NO
 	, case
    	when agn.KVGR2 = '220' then 'BA'
		when agn.KVGR2 = '210' then 'SI'
	 end AS SALE_CD
	, NY_ORDER.dbo.F_GET_ENCRYT(agn.PRESIDENT)	as AGEN_PRST
	, agn.BUSINESS_COND as BIZ_CON
	, agn.BUSINESS_TYPE	as BIZ_INDU
	, replace(agn.ZIP_CODE, '-', '') AS ZIP_CD
	, agn.city1	as ADDR1
	, NY_ORDER.dbo.F_GET_ENCRYT(agn.ADDRESS)	as ADDR2
 	, case
	    when agn.PHONE is null or len(replace(PHONE, '-', '')) = 0 then NY_ORDER.dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(agn.HANDPHONE))
			else NY_ORDER.dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(PHONE))
	 		end as TEL_NO
	 , NY_ORDER.dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(agn.HANDPHONE)) AS PRST_TEL_NO
	 , NY_ORDER.dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(fax)) as FAX_NO
 	, agn.EMAIL as AGEN_EML    
	, 'Y' as AGEN_USE_YN
	, GETDATE() 
	,0
	, GETDATE() 
	,0
  FROM
     parms.namyang.dbo.smcode07 agn
  WHERE
     1 = 1
	and ZZLEADTY = 'L01'
	and KDGRP = '10'
	and KVGR1 = '200'
	and KVGR2 in ('220', '210')
	and KVGR3 in ('205', '201')