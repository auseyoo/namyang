USE [NY_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[P_SI_MIG]    Script Date: 2022-02-08 오후 6:24:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[P_SI_MIG]
	@I_AGEN_CD nvarchar(20)
	, @O_OUT_MSG NVARCHAR(MAX) OUTPUT
AS
BEGIN
	DECLARE @V_BIZ_NO VARCHAR(10) = ''
			, @V_AGEN_SEQ NUMERIC(13) = null

	SET NOCOUNT ON;

	BEGIN TRY
		/*0. 개인정보 암호화 키 오픈*/
		EXEC P_OPEN_KEY

		/*1. 사업자 등록 번호 - 제거 사용 않함 */
		--SET @V_BIZ_NO = NY_ORDER.dbo.F_TRAN_NO256(@I_BIZ_NO) ;

		/*2. T_AGEN_MST에서 진위 여부를 파악, AGEN_SEQ 받아옴(해당 데이터는 SAP에서 기준정보를 먼저 밀어넣어 받음)*/
		BEGIN
			SELECT 
				@V_AGEN_SEQ = AGEN_SEQ
			from
				T_AGEN_MST
			WHERE 
			1=1
			AND AGEN_CD = @I_AGEN_CD
			--AND BIZ_NO = @V_BIZ_NO
		END
		
		/*2-1 기존 데이터 전체 삭제 */
		BEGIN
			DELETE FROM T_CRTB_RTGD WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ
			DELETE FROM T_ORD_RTGD WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ
			DELETE FROM T_ORD_STUS_PRD WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ
			DELETE FROM T_ORD_DLV_DTL  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ
			DELETE FROM T_ORD_STUS_MST  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ
			DELETE FROM T_ORD_DLV  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ
			DELETE FROM T_ORD_PRD  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ
			DELETE FROM T_ORD_MST  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ
	
			DELETE FROM T_CST_DLV_NTC WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ /*대리점 전달사항*/
			DELETE FROM T_CST_AREA_HIS WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*애음자 지역변경 내역*/
			DELETE FROM T_CST_PRD_UNTPC WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*제품별 계약 단가*/
			DELETE FROM T_CST_PTTN_DTL WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*애음자 패턴 설정 테이블*/
			DELETE FROM T_CST_PTTN  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*패턴 설정*/
			DELETE FROM T_CST_PRD_HIS WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*제품 히스토리*/
			DELETE FROM T_CST_PRD_STPG WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*제품 보류/중지*/
			DELETE FROM T_CST_PRD_PRMT WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*애음자 제품 판촉물*/
			DELETE FROM T_CST_PRD  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*제품*/
			DELETE FROM T_CST_BILCT WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*수금*/
			DELETE FROM T_CST_DLY_ORDR WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*지역/애음자 배달순서*/
			DELETE FROM T_CST_RECP_HIS WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*애음자별 현금영수증 발행 이력*/
			DELETE FROM T_CST_SALE WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*애음자 판매*/
			DELETE FROM T_CST_MST  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*애음자 마스터*/
		
			DELETE FROM T_PRD_BND_CHG WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*제품 일괄변경*/
			DELETE FROM T_PRD_UNTPC_HIS  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*제품 단가 히스토리*/
			DELETE FROM T_PRD_AGEN_GRP WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*제품 대리점 그룹*/
			DELETE FROM T_PRD_DTL WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*제품 상세*/
	
			DELETE FROM T_BA_BILL_TOT WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*방판 수금 집계*/
			DELETE FROM T_BA_SALE_DTL WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*방판 판매 디테일*/
			DELETE FROM T_BA_SALE_MST WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*방판 판매 마스터*/

			DELETE FROM T_SI_BILL_TOT WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*시판 수금 집계*/
			DELETE FROM T_SI_SALE_DTL WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*시판 판매 디테일*/
			DELETE FROM T_SI_SALE_MST WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*시판 판매 마스터*/
			DELETE FROM T_SI_VEND_CHAG WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*시판 거래처(고객) 담당자*/
			DELETE FROM T_SI_VEND_MST WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ    /*시판 거래처(고객) 마스터*/

			DELETE FROM T_AGEN_VEND_SPRT WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*거래처 지원*/
			DELETE FROM T_AGEN_VEND_UNTPC  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*거래처별 단가 관리*/
			DELETE FROM T_AGEN_OTR_PUCH  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*매입처(메이저 x)*/
			DELETE FROM T_AGEN_AREA_PRD  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*지역별 제품 단가*/
			DELETE FROM T_AGEN_AREA  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*지역*/
			DELETE FROM T_AGEN_ACCT_INFO  WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*계좌정보*/
			
			DELETE FROM T_AGEN_EMPL_ROLE WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ 	/*대리점 권한*/
			DELETE FROM T_AGEN_MENU_ROLE WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ 	/*대리점 메뉴권한*/
			DELETE FROM T_AGEN_EMPL_HIS WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ 	/*로그인 히스토리*/
			DELETE FROM T_AGEN_EMPL_PWD WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*비밀번호*/
			
			DELETE FROM T_AGEN_VEND_EMPL WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*거래처 대리점 관리자*/
			DELETE FROM T_AGEN_VEND WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ	/*거래처*/
			DELETE FROM T_AGEN_EMPL WHERE 1=1 AND AGEN_SEQ = @V_AGEN_SEQ --  AND EMPL_SEC_CD <> 'STOR_OWNR' 
		END

		/*3. 대리점 대표 먼저 넣어준다. */
		BEGIN 
			
			INSERT INTO T_AGEN_EMPL(
				EMPL_SEQ
				, AGEN_SEQ
				, EMPL_CD
				, EMPL_SEC_CD
				, EMPL_NM
				, EMPL_RNK
				, TEL_NO
				, MOB_NO
				, FAX_NO
				, EMPL_EML
				, RETE_YN
				, RETE_DT
				, BIZ_NO
				, BIZ_CON
				, BIZ_INDU
				--, EMPL_GTN
				--, STM_DE
				, PYM_MTH
				, ORDR
				--, CASH_RECP_USE_YN
				, SALE_BEF_CD
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_EMPL
				, a.AGEN_SEQ
				, '10001'	 as EMPL_CD
				, 'STOR_OWNR' as EMPL_SEC_CD
				,  a.AGEN_PRST as EMPL_NM
				, 'CVCR' as EMPL_RNK
				, TEL_NO as TEL_NO
				, PRST_TEL_NO as MOB_NO
				, FAX_NO as FAX_NO
				, AGEN_EML as EMPL_EML
				, 'N'
				, NULL 
				, a.BIZ_NO as BIZ_NO
				, a.BIZ_CON	as BIZ_CON
				, a.BIZ_INDU as BIZ_INDU
				--, c.creditLimit as EMPL_GTN
				--, c.approvalDAte as STM_DE
				, null as PYM_MTH
				, 1 as ORDR
				, b.EmpCode as SALE_BEF_CD
				, getdate()
				, 0
				, getdate()
				, 0
			FROM 
			T_AGEN_MST a 
				left outer join 
				SI_MDB...Employee b
				on NY_ORDER.dbo.F_TRAN_NO(b.MobilePhone) = NY_ORDER.dbo.F_GET_DECRYT(a.PRST_TEL_NO)
			WHERE 
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
			
			/*3-1. 대리점 대표(점주) 패스워드 등록 남양1234!@*/
			INSERT INTO T_AGEN_EMPL_PWD(
				EMPL_PWD_SEQ
				, AGEN_SEQ
				, EMPL_SEQ
				, EMPL_PWD
				, LST_PWD_YN
				, REG_DTM
				, REG_SEQ
				, TMP_PWD_YN
			)VALUES(
				NEXT VALUE FOR SQ_EMPL_PWD
				, @V_AGEN_SEQ
				, (SELECT EMPL_SEQ FROM T_AGEN_EMPL WHERE AGEN_SEQ = @V_AGEN_SEQ and EMPL_SEC_CD ='STOR_OWNR' )
				, 'f4590ed85d126d8f0645095fa257052e6e113dc5429903b5cf4037fe4587b645'
				, 'Y'
				, GETDATE()   
				, 0
				, 'Y'
			)
		END

		/*4. 대리점 사원 + 본사, 대리점 판촉 사원을 넣어준다. */
		BEGIN
			INSERT INTO T_AGEN_EMPL(
				EMPL_SEQ
				, AGEN_SEQ
				, EMPL_CD
				, EMPL_SEC_CD
				, EMPL_NM
				, EMPL_RNK
				, TEL_NO
				, MOB_NO
				, EMPL_EML
				, RETE_YN
				, ZIP_CD
				, ADDR1
				, ADDR2
				, ORDR
				, SALE_BEF_CD
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_EMPL
				, @V_AGEN_SEQ
				, case 
					when len(CONVERT(varchar(4), ROW_NUMBER() over (order by EMPCode asc))) = 1 then '7000'+CONVERT(varchar(4), ROW_NUMBER() over (order by EMPCode asc))
					when len(CONVERT(varchar(4), ROW_NUMBER() over (order by EMPCode asc))) = 2 then '700'+CONVERT(varchar(4), ROW_NUMBER() over (order by EMPCode asc))
					when len(CONVERT(varchar(4), ROW_NUMBER() over (order by EMPCode asc))) = 3 then '70'+CONVERT(varchar(4), ROW_NUMBER() over (order by EMPCode asc))
					when len(CONVERT(varchar(4), ROW_NUMBER() over (order by EMPCode asc))) = 4 then '7'+CONVERT(varchar(4), ROW_NUMBER() over (order by EMPCode asc))
					end as empl_cd	/*EMPL_CD*/
				, 'AGEN_EMPL' as EMPL_SEC_CD
				, dbo.F_GET_ENCRYT(a.Name) as EMPL_NM
				, cm.COMM_CD  as EMPL_RNK
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(PhoneNo)) as TEL_NO
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(MobilePhone)) as MOB_NO
				, a.Email as EMPL_EML
				, 'N' as RETE_YN
				, a.ZipCode as ZIP_CD
				, a.Address1 as ADDR1
				, dbo.F_GET_ENCRYT(a.Address2) as ADDR2
				, ROW_NUMBER() over (order by EMPCode asc) as ORDR
				, a.EMPCode as SALE_BEF_CD
				, GETDATE() 
				, 0
				, GETDATE() 
				, 0
			FROM 
				SI_MDB...Employee a
				left outer join 
					T_COMM cm
					on cm.COMM_GRP_CD = 'EMPL_RNK'
					and a.Title = cm.COMM_NM 
				left outer join 
					T_AGEN_EMPL b
					on a.EMPCode = b.SALE_BEF_CD 
					and b.AGEN_SEQ = @V_AGEN_SEQ
			WHERE 
				1=1 
				and b.EMPL_SEQ  is null
		
		END

		/*5. 대리점의 모든 거래처를 넣어준다.(매입,매출,외판원,위탁,대여/차용,비매출*/
		BEGIN
			INSERT INTO T_VEND_MST (
				VEND_SEQ
				, AGEN_SEQ
				, VEND_CD
				, VEND_SEC_CD
				, VEND_NM
				, VEND_COMP_NM
				, VEND_PRST
				, BIZ_NO
				, JUR_NO
				, BIZ_CON
				, BIZ_INDU
				, BIZ_INDU_LV1
				, BIZ_INDU_LV2
				, BIZ_INDU_LV3
				, ZIP_CD
				, ADDR1
				, ADDR2
				, TEL_NO
				, MOB_NO
				, FAX_NO
				, VEND_EML
				, CNTR_STAT_DT
				, CNTR_END_DT
				, GOAL_CT
				, AGEN_SPRT_CT
				, HOFF_SPRT_CT
				, BSIS_REMR_CT
				, DSCT_RATE
				, DELG_STAT_DT
				, DELG_END_DT
				, HOFF_CNSG_CD
				, TXBL_PBCT_YN
				, DAIL_INDCT_YN
				, TAXT_SEPT_YN
				, PCHA_INDCT_YN
				, MRGN_YN
				, BRCD_PRT_YN
				, VEND_STUS_SEC
				, ORDR
				, USE_YN
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT
				NEXT VALUE FOR SQ_VEND	
				, @V_AGEN_SEQ AS AGEN_SEQ
				, a.CustomerCode AS VEND_CD
				, case 
					when a.CustomerType = '1' then 'SELNG'
					when a.CustomerType = '2' then 'PCHA'
					when a.CustomerType = '3' then 'SLEMN'
					when a.CustomerType = '5' then 'CNSG'
					when a.CustomerType = '7' then 'LEND_BRW'
					when a.CustomerType = '6' then 'UN_SELNG'
				end as VEND_SEC_CD	/*시판 거래처 구분 타입*/
				, a.CustomerName AS VEND_NM
				, a.CustomerFullName AS VEND_COMP_NM	
				, dbo.F_GET_ENCRYT(a.President) AS VEND_PRST	/*대표자*/
				, NY_ORDER.dbo.F_TRAN_NO256(a.BusinessCode) AS BIZ_NO
				, null as JUR_NO /*법인번호*/
				, a.BusinessType AS BIZ_CON
				, a.BusinessItem AS BIZ_INDU
				, a.UpJong2 as BIZ_INDU_LV1
				, a.UpJong1 as BIZ_INDU_LV2
				, a.UpJong3 as BIZ_INDU_LV3	
				, a.ZipCode AS ZIP_CD
				, a.Address1 AS ADDR1
				, dbo.F_GET_ENCRYT(a.Address2) AS ADDR2
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.PhoneNo)) AS TEL_NO
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.MobilePhone)) AS MOB_NO
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.Fax)) AS FAX_NO
				, a.Email AS VEND_EML
				, a.MokSDate as CNTR_STAT_DT	/*계약시작일*/
				, a.MokEDate as CNTR_END_DT		/*계약종료일*/
				, a.MokpyoKum as GOAL_CT		/*목표금액*/
				, a.AgentJiwon as AGEN_SPRT_CT	/*대리점지원금*/
				, a.BonsaJiwon as HOFF_SPRT_CT	/*본사지원금*/
				, a.InitMoAmt as BSIS_REMR_CT	/*기초잔여액*/
				, a.DcRate as DSCT_RATE			/*할인율*/
				, a.StartDate AS DELG_STAT_DT 		/*거래시작일*/
				, a.CloseDate AS DELG_END_DT 		/*거래종료일*/
				, a.BonsaCode as HOFF_CNSG_CD		/*본사위탁코드*/
				,  CASE  
					when a.TaxGubun = 1 then 'Y'
					else 'N' END as TXBL_PBCT_YN	/*세금계산서 발행 여부*/	 
				, CASE  
					when a.ViewFlag = 1 then 'Y'
					else 'N' END as DAIL_INDCT_YN	/*대리점일보*/		
				, a.VATFlag as TAXT_SEPT_YN /*판매등록: 과세를 공급가액/세액분리 표시*/
				, a.PGubun as PCHA_INDCT_YN /*판매등록:매입금액 표시*/
				,  CASE  
					when a.MaginGubun = 1 then 'Y'
					else 'N' END as MRGN_YN	/*마진 여부*/	  
				,  CASE  
					when a.BarCodePrint = 1 then 'Y'
					else 'N' END as BRCD_PRT_YN	/*바코드 인쇄여부*/	  
				, 'NORM' as VEND_STUS_SEC  /*거래처 상태*/
				, a.SeqNo AS ORDR
				, 'Y' as USE_YN
				, GETDATE() 
				, 0
				, GETDATE() 
				, 0
			FROM 
				SI_MDB...Customer a
			WHERE 
			1=1
				and a.CustomerType = '1' 
				or (a.CustomerType = '2' and a.CustomerName not like '%남양%')
				or a.CustomerType = '3' 
				or a.CustomerType = '5' 
				or a.CustomerType = '6' 
				or a.CustomerType = '7' 
		END

		/*6. 거래처의 담당자를 매핑*/
		BEGIN
			INSERT INTO T_VEND_CHAG (
				VEND_CHAG_SEQ
				, AGEN_SEQ
				, EMPL_SEQ
				, VEND_SEQ
				, USE_YN
				, ORDR
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_VEND_CHAG over (order by a.VEND_CD desc)	
				, a.AGEN_SEQ
				, a.EMPL_SEQ
				, a.VEND_SEQ
				, a.USE_YN
				, a.ORDR
				, GETDATE() 
				, 0
				, GETDATE() 
				, 0
			FROM 
			(
			SELECT 
				a.AGEN_SEQ
				, case 
					when b.ContactCode1 = null then c.EMPL_SEQ
					when b.ContactCode1 = '' then c.EMPL_SEQ
					else ISNULL(c.EMPL_SEQ, d.EMPL_SEQ)
				end AS EMPL_SEQ 
				, a.VEND_SEQ 
				, 'Y'as USE_YN
				, 1 as ORDR
				, a.VEND_CD
				, b.ContactCode1 as aaaa
			FROM 
			T_VEND_MST a
				inner join 
					SI_MDB...Customer b
					on a.VEND_CD = b.CustomerCode
				left outer JOIN 
					T_AGEN_EMPL c 
					on b.ContactCode1 = c.SALE_BEF_CD 
					and a.AGEN_SEQ = c.AGEN_SEQ
				left outer JOIN 
					T_AGEN_EMPL d
					on a.AGEN_SEQ = d.AGEN_SEQ 
					and d.EMPL_SEC_CD = 'STOR_OWNR'
			WHERE 
			1=1
			and a.AGEN_SEQ  = @V_AGEN_SEQ
			and (b.ContactCode1 is not null and b.ContactCode1 <> '')
			union all 
			SELECT 
				a.AGEN_SEQ
				, case 
					when b.ContactCode2 = null then c.EMPL_SEQ
					when b.ContactCode2 = '' then c.EMPL_SEQ
					else ISNULL(c.EMPL_SEQ, d.EMPL_SEQ)
				end AS EMPL_SEQ 
				, a.VEND_SEQ 
				, 'Y' as USE_YN
				, 2 as ORDR
				, a.VEND_CD
				, b.ContactCode2 as aaaa
			FROM 
			T_VEND_MST a
				inner join 
					SI_MDB...Customer b
					on a.VEND_CD = b.CustomerCode
				left outer JOIN 
					T_AGEN_EMPL c 
					on b.ContactCode2 = c.SALE_BEF_CD 
					and a.AGEN_SEQ = c.AGEN_SEQ
				left outer JOIN 
					T_AGEN_EMPL d
					on a.AGEN_SEQ = d.AGEN_SEQ 
					and d.EMPL_SEC_CD = 'STOR_OWNR'
			WHERE 
			1=1
			and a.AGEN_SEQ  = @V_AGEN_SEQ
			and (b.ContactCode2 is not null and b.ContactCode2 <> '')
			) a 
			order by a.VEND_CD asc
		END

		/*7. 시판 대리점 상세 제품(사용제품)*/
		BEGIN
			INSERT INTO T_PRD_DTL(
				PRD_DTL_SEQ
				, AGEN_SEQ
				, PUCH_SEQ
				, PRD_SEQ
				, PRD_DTL_CD
				, STD_PRD_NM
				, SHTN_NM
				, ABRV_NM
				, PCHA_DC_RATE
				, FALT_CT
				, SALE_ORD_USE_CD
				, TAXT_CD
				, CRTB_CD
				, ORD_PD
				, INVRY_MXMM_RATE
				, SPPRC
				, TAXAT
				, IDDY_PCHA_CT
				, AREA_STD_UNTPC
				, CST_STD_UNTPC
				, SALE_UNTPC
				, PRD_STRD
				, VALD_PD
				, UNTPC_APPL_DT
				, UNTPC_APPL_SEQ
				, PRD_ORDR
				, ORD_ORDR
				, USE_YN
				, LAST_YN
				, STD_PRD_YN
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_PRD_DTL
				, @V_AGEN_SEQ  as AGEN_SEQ
				, b.PUCH_SEQ 
				, b.PRD_SEQ 
				, a.PartCode as PRD_DTL_CD
				, b.prd_nm as STD_PRD_NM
				, (SELECT top 1 Gu_PartName FROM SI_MDB...Parts_Conv WHERE PartCode =a.PartCode )  as SHTN_NM   /*단축명*/
				, null as ABRV_NM /*약어명*/
				, a.DCRate as PCHA_DC_RATE /*매입DC율*/
				, 0 AS FALT_CT/*포장비*/
				, '' AS SALE_ORD_USE_CD/*판매주문사용(방판노출여부)*/
				, case 
					when a.VATFlag = 0 then 'TXET'
					when a.VATFlag = 1 then 'TAXT' end	as TAXT_CD /*과세/면세*/
				, a.CPartCode AS  CRTB_CD/*크레이트*/
				, a.OrderTime AS  ORD_PD	/*주문기간*/   
				, a.StockQty AS INVRY_MXMM_RATE/*재고최대량*/
   				, a.STDCost as SPPRC	/*공급가액*/
   				, a.STDVAT as TAXAT		/*세액*/
   				, a.STDCost+a.STDVAT as IDDY_PCHA_CT	/*매입단가(낱개)*/
				, null AS AREA_STD_UNTPC/*지역표준단가*/
				, null AS CST_STD_UNTPC/*애음자표준단가*/
				, a.STDCost+a.STDVAT as SALE_UNTPC		/*판매단가(시판)*/
				, a.Spec as PRD_STRD		/*규격*/
				, a.StockPeriod as VALD_PD	/*유통기간*/
				, CONVERT(VARCHAR(8), a.CostStartDate, 112) as UNTPC_APPL_DT /*단가적용일*/
				, d.EMPL_SEQ as UNTPC_APPL_SEQ	/*단가적용자*/
				, a.SeqNo as PRD_ORDR	/*제품순서*/
				, a.SeqNo as ORD_ORDR	/*주문순서*/
				, a.useFlag as USE_YN
				, 'N' as LAST_YN
				, case 
					when a.StandardFlag = 1 then 'Y'
					when a.StandardFlag = 0 then 'N'
					else 'N'end as STD_PRD_YN	/*표준제품 여부*/	
				, GETDATE() as REG_DTM
				, 0 as REG_SEQ
				, GETDATE() as UPD_DTM
				, 0 as UPD_SEQ	
			FROM 
				SI_MDB...Parts a
				inner join 
					T_PRD_MST b 
					on a.PartCode = b.PRD_SAP_CD 
				left outer join 
					T_AGEN_EMPL d
					on d.AGEN_SEQ = @V_AGEN_SEQ 
					and d.EMPL_SEC_CD = 'STOR_OWNR'
					and d.EMPL_CD = '10001'
			WHERE 
				1=1	
		END
		
		/*7-1. 시판 대리점 상세 제품(사용제품) LAST_YN 처리*/
		BEGIN
			UPDATE T_PRD_DTL
			SET LAST_YN = 'Y'
			FROM T_PRD_DTL a
			JOIN (SELECT 
					a.PRD_DTL_CD
					, MAX(a.PRD_DTL_SEQ) AS PRD_DTL_SEQ
				FROM 
				T_PRD_DTL a
				WHERE 
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				GROUP BY a.PRD_DTL_CD) b
				ON a.PRD_DTL_SEQ = b.PRD_DTL_SEQ
			WHERE
				1=1
				AND AGEN_SEQ = @V_AGEN_SEQ
		END

		/*8. 시판 대리점 거래처별 제품 단가*/
		BEGIN
			INSERT INTO	NY_ORDER.dbo.T_AGEN_VEND_UNTPC(
				VEND_UNTPC_SEQ
				, VEND_SEQ
				, AGEN_SEQ
				, PRD_SEQ
				, SALE_UNTPC
				, BRCD
				, IDDY_BRCD
				, ETC_BRCD
				, FALT_QTY
				, ORDR
				, USE_YN
				, REG_DTM
				, REG_SEQ
				, UPT_DTM
				, UPT_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_VEND_UNTPC 
				, C.VEND_SEQ
				, @V_AGEN_SEQ
				, B.PRD_SEQ
				, A.SALECOST			/*판매단가*/
				, B.BRCD				/*바코드(박스)*/
				, B.IDDY_BRCD			/*바코드(낱개)*/
				, B.ETC_BRCD			/*기타 바코드*/
				, B.FALT_QTY			/*내입량(포장수량)*/
				, A.SEQNO AS ORDR		/*순서*/
				, A.USEFLAG AS USE_YN	/*사용여부*/
				, GETDATE()
				, 0
				, GETDATE()
				, 0  
			FROM
				SI_MDB...SALECOSTS A 
				INNER JOIN NY_ORDER.DBO.T_PRD_MST B ON A.PARTCODE = B.PRD_SAP_CD 
				INNER JOIN NY_ORDER.DBO.T_VEND_MST C ON A.CUSTOMERCODE = C.VEND_CD AND C.AGEN_SEQ = @V_AGEN_SEQ
		END

		/*9. 판매 마스터 등록*/
		BEGIN
			INSERT INTO T_VEND_SALE_MST (
				VEND_SALE_SEQ
				, AGEN_SEQ
				, VEND_SEQ
				, INVRY_EMPL_SEQ
				, CHAG_EMPL_SEQ
				, DLV_EMPL_SEQ
				, SALE_DTSTN
				, SALE_DT
				, ORDR
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_VEND_SALE OVER (order by a.SaleDate, a.SaleNo, a.SeqNo)	
				, b.AGEN_SEQ AS AGEN_SEQ
				, f.VEND_SEQ 
				, ISNULL(c.EMPL_SEQ, b.EMPL_SEQ) AS INVRY_EMPL_SEQ /*재고 보유처 시퀀스(담당자)*/
				, ISNULL(d.EMPL_SEQ, b.EMPL_SEQ) AS CHAG_EMPL_SEQ /*담당자 시퀀스 없을 시 대표자*/
				, ISNULL(e.EMPL_SEQ, b.EMPL_SEQ) AS DLV_EMPL_SEQ /*배송자 시퀀스*/
				, a.SaleNo AS SALE_DTSTN	/*거래명세표*/
				, NY_ORDER.dbo.F_TRAN_NO(a.SaleDate) AS SALE_DT	/*판매일자*/
				, a.SeqNo AS ORDR /*차수*/
				, GETDATE() as REG_DTM
				, 0 as REG_SEQ
				, GETDATE() as UPD_DTM
				, 0 as UPD_SEQ
			FROM 
				SI_MDB...Sales a
				LEFT OUTER JOIN
					T_AGEN_EMPL b
					on b.AGEN_SEQ = @V_AGEN_SEQ
					and b.EMPL_CD ='10001'
				LEFT OUTER JOIN
					T_AGEN_EMPL c
					on c.AGEN_SEQ = b.AGEN_SEQ
					AND a.Location = c.SALE_BEF_CD 
				LEFT OUTER JOIN
					T_AGEN_EMPL d
					on d.AGEN_SEQ = b.AGEN_SEQ
					AND a.ContactCode = d.SALE_BEF_CD 		
				LEFT OUTER JOIN
					T_AGEN_EMPL e
					on e.AGEN_SEQ = b.AGEN_SEQ
					AND a.MContactCode = e.SALE_BEF_CD 		
				LEFT OUTER JOIN 
					T_VEND_MST f
					on f.AGEN_SEQ = b.AGEN_SEQ 
					and f.VEND_CD = a.CustomerCode
			WHERE 
				1=1
				AND f.VEND_SEQ IS NOT NULL
			ORDER BY a.SaleDate, a.SaleNo, a.SeqNo

		END
		
		/*10. 판매 디테일 */
		BEGIN
			INSERT INTO T_VEND_SALE_DTL(
				VEND_SALE_DTL_SEQ
				, AGEN_SEQ
				, VEND_SEQ
				, PUCH_SEQ
				, PRD_SEQ
				, VEND_SALE_SEQ
				, FALT_QTY
				, PCHA_UNTPC
				, PCHA_SALE_CT
				, SALE_QTY
				, SALE_CT
				, RTGD_QTY
				, RTGD_CT
				, PRSNT_QTY
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT
				NEXT VALUE FOR SQ_VEND_SALE_DTL
				, @V_AGEN_SEQ AS AGEN_SEQ
				, g.VEND_SEQ 
				, f.PUCH_SEQ 
				, f.PRD_SEQ 
				, g.VEND_SALE_SEQ 
				, b.UnitQty AS FALT_QTY	/*내입량*/
				, ISNULL(b.UnitCost, 0) AS PCHA_UNTPC	/*매입단가*/
				, ISNULL(b.SaleCost, 0) AS PCHA_SALE_CT	/*매입판매가*/
				, ISNULL(b.Qty, 0) AS SALE_QTY	/*판매수량*/
				, ISNULL(b.Amount,0)+ISNULL(b.VAT,0) AS SALE_CT	/*판매금액*/
				, ISNULL(c.Qty,0)+ISNULL(d.Qty,0) AS RTGD_QTY	/*반품수량*/
				, ISNULL(c.Amount,0)+ISNULL(c.VAT,0)+ISNULL(d.Amount,0)+ISNULL(d.VAT,0) AS RTGD_CT	/*반품금액*/
				, ISNULL(e.Qty,0) AS PRSNT_QTY	/*증정*/
				, ISNULL(ISNULL(b.psys_ins_date, c.psys_ins_date), d.psys_ins_date) AS REG_DTM /*등록시간*/
				, 0
				, GETDATE() 
				, 0
			FROM 
				SI_MDB...SaleItem b
				LEFT OUTER JOIN 
					SI_MDB...SaleItem c
					on b.SaleNo = c.SaleNo
					and b.PartCode = c.PartCode
					and c.MoveType = '22'	/*반품*/
				LEFT OUTER JOIN 
					SI_MDB...SaleItem d
					on b.SaleNo = d.SaleNo
					and b.PartCode = d.PartCode
					and d.MoveType = '23'	/*폐기*/
				LEFT OUTER JOIN 
					SI_MDB...SaleItem e
					on b.SaleNo = e.SaleNo
					and b.PartCode = e.PartCode
					and d.MoveType = '21'	/*증정*/		
				INNER JOIN 
					T_PRD_MST f
					ON b.PartCode = f.PRD_SAP_CD 
				LEFT OUTER JOIN 	
					T_VEND_SALE_MST g 
					ON b.SaleNo = g.SALE_DTSTN
			WHERE 
				1=1

		END 

		/*11. 미수금 */
		BEGIN
			INSERT INTO NY_ORDER.dbo.T_VEND_BILL_TOT(
				VEND_BILL_SEQ
				, AGEN_SEQ
				, VEND_SEQ
				, SALE_DTSTN
				, SALE_CT
				, RTGD_CT
				, SUM_CT
				, TOT_PCHA_CT
				, DELG_ATMPT_CT
				, RL_SALE_CT
				, CASH_BILCT
				, BILL_BILCT
				, ONLINE_BILCT
				, PRD_DC_RATE
				, PRD_DC_CT
				, TOT_DC_RATE
				, TOT_DC_CT
				, ATMPT_CT
				, FEE
				, BOX_SUM
				, IDDY_SUM
				, MONTH_SALE_TOT_CT
				, MONTH_DSCT_TOT_CT
				, MONTH_BILCT_TOT_CT
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT
				NEXT VALUE FOR SQ_VEND_BILL_TOT
				, @V_AGEN_SEQ AS AGEN_SEQ
				, TVM.VEND_SEQ 	
				, TB.SALENO	AS SALE_DTSTN
				, TB.SALE_CT		/*판매금액*/
				, TB.RTGD_CT		/*반품금액*/
				, TB.SUM_CT			/*합계*/
				, TB.TOT_PCHA_CT	/*총매입금액*/
				, TB.DELG_ATMPT_CT	/*거래전미수*/
				, TB.RL_SALE_CT		/*실판매금액*/
				, TB.CASH_BILCT		/*현금수금*/
				, TB.BILL_BILCT		/*어음수금*/
				, TB.ONLINE_BILCT	/*온라인입금*/
				, TB.PRD_DC_RATE	/*제품DC율(%)*/
				, TB.PRD_DC_CT		/*제품DC금액*/
				, TB.TOT_DC_RATE	/*최종DC율(%)*/
				, TB.TOT_DC_CT		/*최종DC금액*/
				, TB.ATMPT_CT		/*미수잔액*/
				, TB.FEE			/*수수료*/
				, TB.BOX_SUM		/*박스합계*/
				, TB.IDDY_SUM		/*낱개합계*/
				, TB.MONTH_SALE_TOT_CT	/*월판매누계*/
				, TB.MONTH_DSCT_TOT_CT	/*월할인누계*/
				, TB.MONTH_BILCT_TOT_CT	/*월수금누계*/
				, GETDATE()	AS REG_DTM
				, '0' AS REG_SEQ
				, GETDATE() AS UPD_DTM
				, '0' AS UPD_SEQ
			FROM (
				SELECT 
					*
					, (DELG_ATMPT_CT + SALE_CT - RTGD_CT - CASH_BILCT - BILL_BILCT - ONLINE_BILCT - TOT_DC_CT) AS 'ATMPT_CT'
				FROM (
					 SELECT 
	     				A.SALENO
						, (A.SALEAMT + A.SALEVAT) AS 'SALE_CT'
						, (A.BANPUMAMT + A.BANPUMVAT) AS 'RTGD_CT'
						, ((A.SALEAMT + A.SALEVAT) - (A.BANPUMAMT + A.BANPUMVAT)) AS 'SUM_CT'
						, CASE 
		     				WHEN C.PGUBUN = 1 THEN (A.UNITAMT - A.BUNITAMT) 
							ELSE 0 
							END 'TOT_PCHA_CT'
						, (
							SELECT 
								SUM(X.MISU) AS MISU 
							FROM (
	              				SELECT 
	              					ROUND(SUM(SALEAMT + SALEVAT - BANPUMAMT - BANPUMVAT - PEGIAMT - PEGIVAT - CASHAMT - BILLAMT - DCAMT - CARDAMT - ONLINEAMT), 2) AS MISU  		
	              				FROM SI_MDB...CUSTOMERMONTH  		
	              				WHERE 
	              					1=1
	              					AND YEARMONTH BETWEEN CONCAT(SUBSTRING(A.SALEDATE, 1, 4), '01') 
	              					AND CONVERT(CHAR(6), DATEADD("MONTH", -1, CONVERT(DATETIME, A.SALEDATE)), 112)
									AND IOGUBUN = 2  		
									AND CUSTOMERCODE = A.CUSTOMERCODE  		
								UNION ALL  		
								SELECT 
									ROUND(SUM(SALEAMT + SALEVAT - BANPUMAMT - BANPUMVAT - PEGIAMT - PEGIVAT - CASHAMT - BILLAMT - DCAMT - CARDAMT - ONLINEAMT), 2) AS MISU  		
								FROM SI_MDB...SALES  		
								WHERE 
									1=1
									AND CUSTOMERCODE = A.CUSTOMERCODE  		
									AND ((SALEDATE BETWEEN CONCAT(SUBSTRING(A.SALEDATE, 1, 6), '01') 
									AND CONVERT(CHAR(8), DATEADD("DAY", -1, CONVERT(DATETIME, A.SALEDATE)), 112)) OR (SALEDATE = A.SALEDATE AND SEQNO <  A.SEQNO ))
							) X ) AS 'DELG_ATMPT_CT'
						, ((A.SALEAMT + A.SALEVAT) - (A.BANPUMAMT + A.BANPUMVAT) - A.DCAMT) AS 'RL_SALE_CT'
						, CASHAMT AS 'CASH_BILCT'
						, BILLAMT AS 'BILL_BILCT'
						, ONLINEAMT AS 'ONLINE_BILCT'
						, CASE 
							WHEN B.SDCAMT IS NOT NULL THEN (B.SDCAMT / IIF((A.SALEAMT + A.SALEVAT) = 0, 1, (A.SALEAMT + A.SALEVAT))) 
							ELSE ROUND((A.DCAMT / IIF(((SALEAMT + SALEVAT) - (BANPUMAMT + BANPUMVAT)) = 0, 1, ((SALEAMT + SALEVAT) - (BANPUMAMT + BANPUMVAT))) ) * 100, 2)
							END 'PRD_DC_RATE'			     	
						, CASE 
							WHEN B.SDCAMT IS NOT NULL THEN B.SDCAMT 
							ELSE A.DCAMT
							END 'PRD_DC_CT'	     
						, A.DCRATE AS 'TOT_DC_RATE'
						, A.DCAMT AS 'TOT_DC_CT'	
						, A.FEEAMT AS 'FEE'		     
						, D.STOT AS 'MONTH_SALE_TOT_CT'
						, D.DCTOT AS 'MONTH_DSCT_TOT_CT'
						, D.COLLTOT AS 'MONTH_BILCT_TOT_CT'
						, B.ESBOX AS 'BOX_SUM'
						, B.ESQTY AS 'IDDY_SUM'	     
						, C.CUSTOMERCODE 
					 FROM SI_MDB...SALES A 
					 INNER JOIN (
						SELECT 
							SALENO 
							, SUM(A.DCAMT) AS SDCAMT
							, SUM(CONVERT(FLOAT, A.ESBOX)) AS ESBOX
							, SUM(CONVERT(FLOAT, A.ESQTY)) AS ESQTY
						FROM (
							SELECT 
								SALENO 
								, SUM(SDCAMT) AS DCAMT
								, CASE 
									WHEN MOVETYPE = 20 THEN FLOOR(SUM(CONVERT(FLOAT, (QTY / IIF(UNITQTY = 0, 1 ,UNITQTY))))) 	--BOX합계
									ELSE FLOOR(SUM(CONVERT(FLOAT, ((QTY * -1) / IIF(UNITQTY = 0, 1 ,UNITQTY)))))
								END ESBOX 	--BOX합계		                     
								, CASE 
									WHEN MOVETYPE = 20 THEN FLOOR(SUM(CONVERT(FLOAT, (QTY % IIF(UNITQTY = 0, 1 ,UNITQTY))))) 
									ELSE FLOOR(SUM(CONVERT(FLOAT, ((QTY * -1) % IIF(UNITQTY = 0, 1 ,UNITQTY)))))
								END ESQTY	--IDDY_SUM
							FROM SI_MDB...SALEITEM 
						GROUP BY SALENO, MOVETYPE, QTY, UNITQTY
						) A 
						GROUP BY SALENO
					 ) B 
	     				ON A.SALENO = B.SALENO 
					INNER JOIN 
						SI_MDB...CUSTOMER C 
						ON A.CUSTOMERCODE = C.CUSTOMERCODE 
					INNER JOIN (	     
	     				SELECT 
	     					CUSTOMERCODE
							, SALENO
							, SALEDATE
		     				, STOT
		     				, DCTOT
		     				, COLLTOT
						FROM (
							SELECT 
								A.CUSTOMERCODE
								, A.SALENO
								, A.SALEDATE  
								, SUM(B.SALEAMT + B.SALEVAT - B.BANPUMAMT - B.BANPUMVAT - B.PEGIAMT - B.PEGIVAT) AS STOT
								, SUM(DCAMT) AS DCTOT
								, SUM(CASHAMT+BILLAMT+ONLINEAMT) AS COLLTOT 	
							FROM (
								SELECT 
									CUSTOMERCODE
									, SALENO
									, SALEDATE					  
								FROM SI_MDB...SALES
							) A
							INNER JOIN 
								SI_MDB...SALES B 
								ON A.CUSTOMERCODE = B.CUSTOMERCODE 
							WHERE 
								1=1
								AND B.SALEDATE BETWEEN CONCAT(SUBSTRING(A.SALEDATE, 1, 6), '01') 
								AND A.SALEDATE 
							GROUP BY A.CUSTOMERCODE, A.SALENO, A.SALEDATE 
						) TB 
					) D 
					ON A.CUSTOMERCODE = D.CUSTOMERCODE 
					AND A.SALENO = D.SALENO
					WHERE 1=1
					/*AND A.SALENO = @V_SALENO*/
					--AND A.SALENO = 'S202101020032'
					/*AND A.SALEDATE LIKE '20210102%'*/
					AND A.SALEDATE BETWEEN CONCAT(SUBSTRING(CONVERT(NVARCHAR,dateadd(m,-1,getdate()),112 ),1, 6), '01') AND CONVERT(NVARCHAR, GETDATE(),112) 
				) TBL     
			) TB
			INNER JOIN 
				T_VEND_MST TVM 
				ON TB.CUSTOMERCODE = TVM.VEND_CD 
		END 

		PRINT 'Migration compelete'
		SET @O_OUT_MSG = CONCAT(@V_AGEN_SEQ, '::Migration compelete')
		

	END TRY

	BEGIN CATCH
		ROLLBACK TRAN 		-- 실패
		
		SET @O_OUT_MSG = CONCAT(@V_AGEN_SEQ, 'Error, ::@E_NUMBER::', ERROR_NUMBER(), ',::@E_SERVERITY::', ERROR_SEVERITY(),',::@E_STATE::',ERROR_STATE(),',::@E_LINE::', ERROR_LINE(),',::@E_MSG::',ERROR_MESSAGE())
		
        RETURN @O_OUT_MSG
	END CATCH  
	
	SET NOCOUNT OFF
END
