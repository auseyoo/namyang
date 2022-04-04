USE [NY_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[P_BA_MIG]    Script Date: 2022-03-15 오후 1:30:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[P_BA_MIG]
(
	@I_AGEN_CD nvarchar(20)
	, @O_OUT_MSG NVARCHAR(MAX) OUTPUT
)
AS
BEGIN

	DECLARE @V_BIZ_NO VARCHAR(10) = ''
			, @V_AGEN_SEQ NUMERIC(13) = null
			
	SET NOCOUNT ON;
			
	BEGIN TRY

		/*0. 개인정보 암호화 키 오픈*/
		EXEC P_OPEN_KEY
	
		/*1. T_AGEN_MST에서 진위 여부를 파악, AGEN_SEQ 받아옴(해당 데이터는 SAP에서 기준정보를 먼저 밀어넣어 받음)*/
		BEGIN
			SELECT 
				@V_AGEN_SEQ = AGEN_SEQ
			from
				T_AGEN_MST
			WHERE 
			1=1
			AND AGEN_CD = @I_AGEN_CD
			
			IF (@V_AGEN_SEQ = null) 
			BEGIN 
				RAISERROR('Error',16,1)
			END 			
		END
		/*2-1 데이터 전체 삭제*/
		BEGIN
			EXEC dbo.P_DEL_AGEN_DATA @V_AGEN_SEQ
		END
		
		/*2-4 대리점 지로번호(고유번호) 업데이트*/
		BEGIN
			DECLARE @V_GIRO_NO VARCHAR(10) = ''
			
			SET @V_GIRO_NO = (SELECT SetValue1 FROM BA_MDB...USERSET  WHERE setName = 'GiroNo')

			UPDATE T_AGEN_MST
				SET	GIRO_NO = @V_GIRO_NO
			WHERE
			1=1
			AND AGEN_SEQ = @V_AGEN_SEQ
		END
		/*2-3 대리점 대표 먼저 넣어준다. */
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
				, EMPL_GTN
				, STM_DE
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
				, a.AGEN_PRST as EMPL_NM
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
				, c.creditLimit as EMPL_GTN
				, c.approvalDAte as STM_DE
				, null as PYM_MTH
				, 1 as ORDR
				, CustomerCode as SALE_BEF_CD
				, getdate()
				, 0
				, getdate()
				, 0
			FROM 
			T_AGEN_MST a 
				left outer join 
					BA_MDB...Customer c 
					on c.customerclass = '1'
					and c.CustomerType = '0'
					and NY_ORDER.dbo.F_GET_DECRYT(a.PRST_TEL_NO) = NY_ORDER.dbo.F_TRAN_NO(c.PhoneNo)
			WHERE 
			1=1
			AND a.AGEN_SEQ = @V_AGEN_SEQ
			;
			/*2-1. 대리점 대표(점주) 패스워드 등록 남양1234!@*/
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

		/*2-2. 점주 개인 권한 등록*/
		BEGIN
			INSERT INTO T_AGEN_EMPL_ROLE (
				MENU_SEQ
				, AGEN_SEQ
				, EMPL_SEQ
				, USE_YN
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				a.MENU_SEQ
				, b.AGEN_SEQ
				, b.EMPL_SEQ
				, 'Y' AS USE_YN
				, GETDATE() AS REG_DTM
				, 0 AS REG_SEQ
				, GETDATE() AS UPD_DTM
				, 0 AS UPD_SEQ
			FROM 
			T_COMM_MENU a
				LEFT OUTER JOIN 
					T_AGEN_EMPL	 b
					on b.EMPL_CD = '10001'
					and b.AGEN_SEQ = @V_AGEN_SEQ
		END

		/*2-3. 대리점 메뉴 권한*/
		BEGIN
			INSERT INTO T_AGEN_MENU_ROLE(
				MENU_SEQ
				, AGEN_SEQ
				, EMPL_SEC
				, USE_YN
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				MENU_SEQ 
				, AGEN_SEQ 
				, 'STOR_OWNR' AS EMPL_SEC 
				, 'Y' AS USE_YN
				, GETDATE() AS REG_DTM
				, 0 AS REG_SEQ
				, GETDATE() AS UPD_DTM
				, 0 AS UPD_SEQ
			FROM 
				T_AGEN_EMPL_ROLE a
			WHERE 
			1=1
			AND AGEN_SEQ = @V_AGEN_SEQ
		END

		/*3. 대리점 사원 + 본사, 대리점 판촉 사원을 넣어준다. */
		BEGIN 
			INSERT INTO T_AGEN_EMPL 
			(
				EMPL_SEQ
				, AGEN_SEQ
				, EMPL_CD
				, EMPL_SEC_CD
				, EMPL_NM
				, EMPL_RNK
				, MOB_NO
				, RETE_YN
				, ORDR
				, PRMT_HOFF_CD
				, SALE_BEF_CD
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT
				NEXT VALUE FOR SQ_EMPL
				, @V_AGEN_SEQ				/*AGEN_SEQ*/
				, case when empl_cd is null 
				then 
				case 
					when len(CONVERT(varchar(4), ROW_NUMBER() over (order by empl_cd asc))) = 1 then '7000'+CONVERT(varchar(4), ROW_NUMBER() over (order by empl_cd asc))
					when len(CONVERT(varchar(4), ROW_NUMBER() over (order by empl_cd asc))) = 2 then '700'+CONVERT(varchar(4), ROW_NUMBER() over (order by empl_cd asc))
					when len(CONVERT(varchar(4), ROW_NUMBER() over (order by empl_cd asc))) = 3 then '70'+CONVERT(varchar(4), ROW_NUMBER() over (order by empl_cd asc))
					when len(CONVERT(varchar(4), ROW_NUMBER() over (order by empl_cd asc))) = 4 then '7'+CONVERT(varchar(4), ROW_NUMBER() over (order by empl_cd asc))
					end
				else empl_cd end as empl_cd	/*EMPL_CD*/
				, EMPL_SEC_CD	/*EMPL_SEC_CD*/
				, NY_ORDER.dbo.F_GET_ENCRYT(empl_nm)		/*EMPL_NM*/
				, 'EMPL'		/*EMPL_RNK*/
				, NY_ORDER.dbo.F_GET_ENCRYT(moblNo)		/*MOB_NO*/
				, RETE_YN		/*RETE_YN*/
				, 2				/*ORDR */
				, empl_cd as PRMT_HOFF_CD	/*PRMT_HOFF_CD*/
				, BEF_CD 		/*BEF_CD*/
				, getdate()	as REG_DTM
				, 0	as REG_SEQ
				, getdate()	as UPD_DTM
				, 0	as UPD_SEQ
			from
			(
				SELECT 
				empl_nm
				, moblNo
				, empl_cd
				, 'AGEN_EMPL' as EMPL_SEC_CD
				, 'N' as RETE_YN
				, null as BEF_CD
				FROM 
				(
				SELECT 
				a.president as empl_nm
				, a.mobilePhone 
				, NY_ORDER.dbo.F_TRAN_NO(a.MobilePhone)  as moblNo
				, b.id as empl_cd
				FROM 
				(
				SELECT 
				president
				, mobilePhone
				FROM 
				BA_MDB...customer
				where
				1=1
				and customerclass = '4'
				and customerType = '3'
				and bankaccountNo <> ''
				and useFlag = '1'
				AND mobilePhone <> ''
				group by  president, mobilePhone
				) a
				left outer join 
					BA_MDB...salesman b
					on a.mobilePhone = b.mobile
					and b.useFlag = '1'
				--order by a.president desc	
				) a
				WHERE 
				1=1
				and len(moblNo) = 11
				and empl_cd is NULL
				and moblNo != (SELECT NY_ORDER.dbo.F_TRAN_NO(phoneNo) FROM BA_MDB...customer WHERE 1=1 and customerClass = '1' and CustomerType ='0')
				union all
				select
					salesname as empl_nm
					, NY_ORDER.dbo.F_TRAN_NO(mobile) as mobNo
					, id as empl_cd
					, case
						when LEFT(id, 1) = 'P' then 'HOFF_PRMT_EMPL'
						when LEFT(id, 1) = 'A' then 'AGEN_PRMT_EMPL'
						when LEFT(id, 1) = '5'  then 
							case when len(id) = 7 then 'WEK_EMPL'
							else 'AGEN_EMPL' end
						else 'AGEN_EMPL'
						END  as EMPL_SEC_CD
					, case
						when useFlag = 0 then 'Y'
						else 'N'
						END  as RETE_YN
					, SalesCode as BEF_CD
				FROM 
				BA_MDB...salesman
				where 
				1=1
				--and useFlag = '1'
				--and len(id) = 6
				and ID is not null 
				and ID <> ''
				and ID_Name <> ''
				and ID_Name is not null	
			) a
		END


		/*4. 대리점 거래처 */
		BEGIN 
			INSERT INTO DBO.T_AGEN_VEND ( 
				VEND_SEQ,		--거래처 시퀀스
				AGEN_SEQ,		--대리점 시퀀스
				VEND_CD,		--거래처 코드
				VEND_SEC_CD,	--거래처 구분 코드(공통코드)
				VEND_NM,		--거래처명
				INDT_CL,		--업종분류(공통코드)
				VEND_PRST,		--대표자
				BIZ_NO,			--사업자등록번호
				JUR_NO,			--법인번호
				BIZ_CON,		--업태
				BIZ_INDU,		--업종
				VEND_CHAG,		--거래처 담당자
				TEL_NO,			--전화번호
				MOB_NO,			--담당자 휴대폰 번호
				FAX_NO,			--팩스번호
				ZIP_CD,			--우편번호
				ADDR1,			--주소1
				ADDR2,			--주소2
				CNTR_CD,		--계약조건(공통코드)
				VEND_GTN,		--보증금 
				BANK_CD,		--은행코드(공통코드)
				STM_ACCT_NO,	--결재계좌번호
				SALE_UNTPC,		--판매단가적용
				HOFF_CNSG_YN,	--본사위탁여부
				CNSG_VEND_CD,	--위탁업체코드(SAP 코드)
				TXBL_PBCT_YN,	--세금계산서발행 여부
				MRGN_YN,		--마진여부
				BRCD_PRT_YN,	--바코드인쇄여부	
				VEND_STUS_SEC,	--거래처 상태(공통코드)
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)
			SELECT 
				NEXT VALUE FOR SQ_AGEN_VEND,						--거래처 시퀀스
				@V_AGEN_SEQ AS AGEN_SEQ,							--대리점 시퀀스
				A.CUSTOMERCODE,										--거래처 코드
				'' AS VEND_SEC_CD,									--거래처 구분 코드(공통코드) : 매입처는 학교/위탁 등의 구분 필요없음
				A.CUSTOMERNAME AS VEND_NM,							--거래처명
				'' AS INDT_CL,										--업종분류(공통코드)
				dbo.F_GET_ENCRYT(A.PRESIDENT) AS VEND_PRST,			--대표자
				A.BUSINESSCODE AS BIZ_NO,							--사업자등록번호
				'' AS JUR_NO,										--법인번호
				A.BUSINESSITEM AS BIZ_CON,							--업태
				A.BUSINESSTYPE AS BIZ_INDU,							--업종
				dbo.F_GET_ENCRYT(A.CONTACT) AS VEND_CHAG,								--거래처 담당자
				dbo.F_GET_ENCRYT(A.PHONENO) AS TEL_NO,								--전화번호
				dbo.F_GET_ENCRYT(A.MOBILEPHONE) AS MOB_NO,							--담당자 휴대폰 번호
				dbo.F_GET_ENCRYT(A.FAX) AS FAX_NO,									--팩스번호
				A.ZIPCODE AS ZIP_CD,								--우편번호
				A.ADDRESS1 AS ADDR1,								--주소1
				dbo.F_GET_ENCRYT(A.ADDRESS2) AS ADDR2,								--주소2
				'' AS CNTR_CD,										--계약조건(공통코드)
				A.CREDITLIMIT AS VEND_GTN,							--보증금 
				TC.COMM_CD AS BANK_CD,								--은행코드(공통코드)
				dbo.F_GET_ENCRYT(A.BANKACCOUNTNO) AS STM_ACCT_NO,						--결재계좌번호
				A.SALECOSTLEVEL AS SALE_UNTPC,						--판매단가적용
				'' AS HOFF_CNSG_YN,									--본사위탁여부
				A.CUSTOMERTCODE AS CNSG_VEND_CD,					--위탁업체코드(SAP 코드)
				'' AS TXBL_PBCT_YN,									--세금계산서발행 여부
				'' AS MRGN_YN,										--마진여부
				'' AS BRCD_PRT_YN,									--바코드인쇄여부	
				'NORM' AS VEND_STUS_SEC,							--거래처 상태(공통코드), MIG 데이터는 정상(NORM)으로 설정함
				GETDATE(),
				'0',
				GETDATE(),
				'0' 
			FROM (
				SELECT
					CUSTOMERCODE,									--거래처 코드
					CUSTOMERNAME,									--거래처명
					PRESIDENT,										--대표자
					DBO.F_TRAN_NO(BUSINESSCODE) AS BUSINESSCODE,	--사업자등록번호
					BUSINESSITEM,									--업태
					BUSINESSTYPE,									--업종
					CONTACT,										--거래처 담당자
					DBO.F_TRAN_NO(ZIPCODE) AS ZIPCODE,				--우편번호
					ADDRESS1,										--주소1
					ADDRESS2,										--주소2
					DBO.F_TRAN_NO(PHONENO) AS PHONENO,				--전화번호
					DBO.F_TRAN_NO(MOBILEPHONE) AS MOBILEPHONE,		--담당자 휴대폰 번호
					DBO.F_TRAN_NO(FAX) AS FAX,						--팩스번호
					BANKNAME,										--은행코드
					PAYMENTMETHOD,									--지불방법
					SALECOSTLEVEL,									--판매단가적용
					BANKACCOUNTNO,									--결재계좌번호
					APPROVALDATE,									--결재일
					CREDITLIMIT,									--보증금
					CUSTOMERTCODE									--위탁업체코드
				FROM
					BA_MDB...CUSTOMER 
				WHERE
					CUSTOMERCLASS = 0
			) A 
			LEFT OUTER JOIN DBO.T_COMM TC ON TC.COMM_GRP_CD = 'BANK_CD' AND TC.COMM_DESC1 = A.BANKNAME
			LEFT OUTER JOIN DBO.T_COMM TC_PYM ON TC_PYM.COMM_GRP_CD = 'PYM_MTH' AND TC.COMM_DESC1 = A.PAYMENTMETHOD	
		END

		/*5. 제품 상세(대리점이 사용하는 약어 등)를 넣어준다. */
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
				, SALE_ORD_USE_CD
				, PRD_ORDR
				, USE_YN
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
				, REG_DTM
			)
			SELECT 
				NEXT VALUE FOR SQ_PRD_DTL 
				, @V_AGEN_SEQ 
				, a.PUCH_SEQ 
				, a.PRD_SEQ 
				, b.PartCode AS PRD_DTL_CD	/*PRD_DTL_CD 대리점 자체코드*/
				, b.GroupPartName AS STD_PRD_NM
				, b.PartName AS SHTN_NM
				, b.PartShortName AS ABRV_NM
				, 'Y' as SALE_ORD_USE_CD /*SALE_ORD_USE_CD 판매주문사용(방판노출여부)*/
				, b.PartSeqNo as PRD_ORDR
				, case 
					when b.UseFlag = 1 then 'Y'
					when b.UseFlag = 0 then 'N' end
					as USE_YN 
				, 0 as REG_SEQ 
				, GETDATE() as REG_DTM 
				, 0 as UPD_SEQ 
				, GETDATE() as UPD_DTM 
			FROM 
			t_prd_mst a
				inner join 
					BA_MDB...parts b 
					on a.prd_sap_cd = b.partCode
					and b.PartClass in (0, 1, 6) --제품분류(0:크레이트,1: 우유류,5:판촉물,6:본사판촉물)
				left outer join 
					(
						SELECT 
							a.Partcode
							, a.ApplyDate
							, b.InCost
							, b.OutCost	as AREA_STD_UNTPC
							, b.SpendingCost as CST_STD_UNTPC
							, c.PRD_SEQ
						FROM 
						(
						SELECT 
							Partcode
							, max(ApplyDate) as ApplyDate
						FROM 
							BA_MDB...stdPrice 
						where
							1=1
						group by Partcode
						) a
						left outer join 
							BA_MDB...stdPrice b
							on a.Partcode = b.Partcode
							and a.ApplyDate = b.ApplyDate
						inner join 
							T_PRD_MST c
							on c.PRD_SAP_CD = a.Partcode
					) c
					on a.PRD_SEQ = c.PRD_SEQ
		END
		
		/*6. 제품 그룹(표준 제품명)을 넣어준다. */
		BEGIN
			INSERT INTO T_PRD_AGEN_GRP (
				PRD_GRP_SEQ
				, AGEN_SEQ
				, PUCH_SEQ
				, PRD_SEQ
				, PRD_DTL_SEQ
				, STD_PRD_NM
				, REP_PRD_YN
				, ORDR
				, USE_YN
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
				, REG_DTM
			)
			SELECT
				NEXT VALUE FOR SQ_PRD_GRP
				, @V_AGEN_SEQ
				, 1			/*남양 매입처 코드*/
				, PRD_SEQ
				, PRD_DTL_SEQ 
				, STD_PRD_NM
				, 'N'
				, ROW_NUMBER() over(PARTITION by STD_PRD_NM order by SHTN_NM asc) 
				, 'Y'
				, 0
				, GETDATE() 
				, 0
				, GETDATE() 
			FROM
				T_PRD_DTL
			WHERE 
				1=1
				and AGEN_SEQ  = @V_AGEN_SEQ
				and STD_PRD_NM <> ''
				
		END

		/*7. 대리점 지역을 넣어준다. */
		BEGIN
			INSERT INTO T_AGEN_AREA(
				AREA_SEQ
				, AGEN_SEQ
				, EMPL_SEQ
				, AREA_NM
				, AREA_RM
				, STPG_EXCL_YN
				, DLV_STPG_YN
				, AGEN_AREA_CD
				, DLV_ORDR
				, AREA_ORDR
				, USE_YN
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
				, REG_DTM
			)
			SELECT 
				NEXT VALUE FOR SQ_AGEN_AREA
				, ISNULL(b.agen_seq, @V_AGEN_SEQ) as AGEN_SEQ
				, ISNULL(b.empl_seq, (SELECT empl_seq FROM t_agen_empl WHERE agen_seq = @V_AGEN_SEQ and empl_sec_cd ='STOR_OWNR')) as EMPL_SEQ
				, a.AREA_NM
				, a.AREA_RM
				, a.STPG_EXCL_YN
				, a.DLV_STPG_YN
				, a.AGEN_AREA_CD
				, a.DLV_ORDR
				, a.AREA_ORDR
				, 'Y'
				, 0
				, getdate()
				, 0
				, getdate()
			FROM 
			(
			SELECT 
					a.regionCode as AGEN_AREA_CD
					, a.regionName as AREA_NM
					, NY_ORDER.dbo.F_TRAN_NO(b.mobilePhone) as MOB_NO
					, b.ContractDescription as AREA_RM
					, 'N' as DLV_STPG_YN
					, 'N' as STPG_EXCL_YN
					, a.Course AS DLV_ORDR
					, a.SeqNo as AREA_ORDR
				FROM 
				BA_MDB...region a
					left outer join
						BA_MDB...customer b
						on a.customerCode = b.customerCode
				WHERE 
				1=1
				and a.useFlag= 1
				and a.customerCode <> '0'
			) a
			left outer join 
				(
					select 
						max(empl_seq) as empl_seq
						, NY_ORDER.dbo.F_GET_DECRYT(MOB_NO) AS MOB_NO
						, agen_seq
					from
						T_AGEN_EMPL
					WHERE 
						1=1
						and agen_seq = @V_AGEN_SEQ
					group by agen_seq, NY_ORDER.dbo.F_GET_DECRYT(MOB_NO)
				) b
				on a.MOB_NO = b.MOB_NO

		END

		/*8. 대리점 사원의 계좌정보를 넣어준다.. */
		BEGIN
			INSERT INTO T_AGEN_ACCT_INFO(
				ACCT_SEQ
				, AGEN_SEQ
				, EMPL_SEQ
				, ACCT_CD
				, BANK_CD
				, ACCT_DPSR
				, ORDR
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_ACCT
				, ISNULL(a.agen_seq, @V_AGEN_SEQ) as AGEN_SEQ
				, ISNULL(a.empl_seq, (SELECT empl_seq FROM t_agen_empl WHERE agen_seq = @V_AGEN_SEQ and empl_sec_cd ='STOR_OWNR')) as EMPL_SEQ
				, a.ACCT_CD
				, a.BANK_CD
				, a.ACCT_DPSR
				, ROW_NUMBER() over(PARTITION by a.EMPL_SEQ order by STM_ACCT_NO asc) as ORDR
				, GETDATE() 
				, 0
				, GETDATE() 
				, 0
			FROM 
			(
			SELECT 
				b.AGEN_SEQ 
				, b.EMPL_SEQ 
				, 'EMPL_BANK_CD' AS ACCT_CD
				, t.comm_cd AS BANK_CD
				, a.bankAccountNo AS STM_ACCT_NO
				, a.BankCust AS ACCT_DPSR
			FROM 
			BA_MDB...customer a
				LEFT OUTER JOIN
					T_COMM t
					on a.bankName = t.comm_desc1
				LEFT OUTER JOIN 
					T_AGEN_EMPL b
					on b.AGEN_SEQ = @V_AGEN_SEQ
					and b.MOB_NO = NY_ORDER.dbo.F_TRAN_NO(a.mobilePhone)
			WHERE 
			1=1
			and a.bankAccountNo <> ''
			and a.useFlag = 1
			)a
		END

		/*9. 대리점 매입처 등록. */
		BEGIN
			INSERT INTO T_AGEN_OTR_PUCH (
				PUCH_SEQ
				, AGEN_SEQ
				, PUCH_CD
				, PUCH_NM
				, BIZ_NO
				, BIZ_CON
				, BIZ_INDU
				, ZIP_CD
				, ADDR1
				, ADDR2
				, TEL_NO
				, MOB_NO
				, FAX_NO
				, PUCH_EML
				, PUCH_CHAG
				, USE_CD
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_PUCH
				, @V_AGEN_SEQ /* AGEN_SEQ */
				, a.customerCode /* PUCH_CD*/
				, a.customerName /* PUCH_NM*/
				, NY_ORDER.dbo.F_TRAN_NO256(a.BusinessCode) /* BIZ_NO*/
				, a.BusinessType /* BIZ_CON*/
				, a.BusinessItem /* BIZ_INDU*/
				, a.ZipCode /* ZIP_CD*/
				, a.Address1 /* ADDR1*/
				, dbo.F_GET_ENCRYT(a.Address2) /* ADDR2*/
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.PhoneNo)) /* TEL_NO*/
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.MobilePhone)) /* MOB_NO*/
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.Fax)) /* FAX_NO*/
				, null /* PUCH_EML*/
				, dbo.F_GET_ENCRYT(a.Contact) /* PUCH_CHAG*/
				, CASE WHEN a.useFlag = 1 THEN 'USE'
					ELSE 'UN_USED' END AS USE_CD  /* USE_CD*/
				, GETDATE() /* REG_DTM*/
				, 0 /* REG_SEQ*/
				, GETDATE() /* UPD_DTM*/
				, 0 /* UPD_SEQ*/
			FROM 
				BA_MDB...customer a
			WHERE 
			1=1
			and a.customerType = 2
			--and a.useFlag = 1
			and a.customerName not like '%남양%'
		END

		/*10. 대리점 애음자 등록. */
		BEGIN
			INSERT INTO T_CST_MST(
				CST_SEQ
				, AGEN_SEQ
				, AREA_SEQ
				, CST_AGEN_CD
				, CST_NM
				, APPCT_NM
				, TEL_NO
				, MOB_NO
				, MOB_NO2
				, CST_EML
				, BILCT_MTH
				, STPG_DT
				, STPG_RSON
				, STPG_YN
				, DLV_ZIP_CD
				, DLV_ADDR1
				, DLV_ADDR2
				, REPT_ZIP_CD
				, REPT_ADDR1
				, REPT_ADDR2
				, CASH_RECP_YN
				, USE_YN
				, BADN_YN
				, CNTR_CST_CD
				, SBSCRB_COS_CD
				, ORDR
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_CST
				, @V_AGEN_SEQ AS AGEN_SEQ
				, b.AREA_SEQ 
				, a.DCustomerCode as CST_AGEN_CD	/*대리점 고객 코드*/
				, dbo.F_GET_ENCRYT(a.DCustomerName) AS CST_NM		/*애음자명*/
				, CASE 
					when a.ApplyName is null then dbo.F_GET_ENCRYT(a.DCustomerName)
					else dbo.F_GET_ENCRYT(a.ApplyName)
					end as APPCT_NM	/*신청인명*/
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.Phone1)) as TEL_NO /*전화번호*/
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.CellPhone)) as MOB_NO /*핸드폰번호*/
				, dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(a.CellPhone2)) as MOB_NO2 /*핸드폰번호*/
				, null as CST_EML	/*고객이메일*/
				, CASE 
					WHEN PaymentMethod = '1. 지로' then 'MTH_1'
					WHEN PaymentMethod = '2. 방문' then 'MTH_2'
					WHEN PaymentMethod = '3. 직수' then 'MTH_3'
					WHEN PaymentMethod = '4. 통장' then 'MTH_4'
					WHEN PaymentMethod = '5. CMS' then 'MTH_5'
					WHEN PaymentMethod = '6. 카드CMS' then 'MTH_6'
					WHEN PaymentMethod = '7. 기타' then 'MTH_7'
					WHEN PaymentMethod = '9. 카드' then 'MTH_9'
				end AS BILCT_MTH /*수금방법*/
				, NY_ORDER.dbo.F_TRAN_NO(a.StopDate) AS STPG_DT /*중지일*/
				, a.StopDescription AS STPG_RSON /*중지사유*/
				, CASE 
					WHEN a.Status = 0 then 'Y'
					WHEN a.Status = 1 then 'N' END AS STPG_YN /*중지여부*/
				, CASE	
					WHEN LEN(NY_ORDER.dbo.F_TRAN_NO(a.ZipCode)) > 6 THEN SUBSTRING(NY_ORDER.dbo.F_TRAN_NO(a.ZipCode), 1, 5) 
					ELSE NY_ORDER.dbo.F_TRAN_NO(a.ZipCode) 
					END AS DLV_ZIP_CD /*배달장소 - 우편번호*/
				, a.Addr1 as DLV_ADDR1
				, dbo.F_GET_ENCRYT(a.Addr2) as DLV_ADDR2
				, CASE	
					WHEN LEN(NY_ORDER.dbo.F_TRAN_NO(a.ZipCode)) > 6 THEN SUBSTRING(NY_ORDER.dbo.F_TRAN_NO(a.ZipCode), 1, 5) 
					ELSE NY_ORDER.dbo.F_TRAN_NO(a.ZipCode) 
					END AS REPT_ZIP_CD /*우편물수령 - 우편번호*/				
				, a.Addr1 as REPT_ADDR1
				, dbo.F_GET_ENCRYT(a.Addr2) as REPT_ADDR2	
				, CASE  
					when a.CashUse = 1 then 'Y'
					else 'N' END as CASH_RECP_YN	/*현금 영수증 사용여부*/
				, CASE  
					when a.Status = 3 then 'N'
					else 'Y' END as USE_YN	/*사용여부*/
				, CASE
					WHEN a.CState = 1 THEN 'Y'
					ELSE 'N' END as BADN_YN /*불량 여부*/
				, 'BEF' AS CNTR_SEC_CD
				, 'BEF' AS SBSCRB_COS_CD
				, a.DeliverySeqNo AS ORDR
				, GETDATE() AS REG_DTM
				, 0
				, GETDATE() AS UPD_DTM
				, 0
			from
			BA_MDB...Dcustomer a
				inner join 
				T_AGEN_AREA b 
				on b.agen_seq = @V_AGEN_SEQ
				and b.AGEN_AREA_CD = a.RegionCode
			WHERE 
			1=1
			and a.DCustomerName <> '-'
			and (a.Phone1 is not null or a.CellPhone is not null)
		END

		/*10-1. 대리점 애음자 중지일 . */
		BEGIN
			UPDATE T_CST_MST
			SET STPG_YN = 'Y'
			WHERE
			1=1
			AND AGEN_SEQ = @V_AGEN_SEQ
			AND STPG_DT IS NOT NULL
			AND STPG_YN = 'N'
		END


		/*11. 애음자 제품 */
		BEGIN
			INSERT INTO T_CST_PRD (
				CST_PRD_SEQ
				, agen_seq
				, AREA_SEQ
				, CST_SEQ
				, PUCH_SEQ
				, PRD_SEQ
				, PRD_DTL_SEQ
				, PRMT_EMPL_SEQ
				, PRMT_RMK
				, UNTPC
				, PRMT_DT
				, INPT_DT
				, CNTR_MONTH
				, STPG_YN
				, STPG_DT
				, STPG_RSON
				, CST_BEF_CD
				, DLV_SEC_CD
				, PRD_BEF_CD
				, HOP
				, HOP_UNTPC	
				, CNTR_SEC_CD
				, STDR_QTY
				, CST_COS_CD
				, LAST_YN
				, reg_dtm
				, reg_seq
				, upd_dtm
				, upd_seq
			)
			SELECT 
				NEXT VALUE FOR SQ_CST_PRD
				, @V_AGEN_SEQ as agen_seq 
				, b.AREA_SEQ 
				, c.CST_SEQ 
				, 1
				, d.PRD_SEQ 
				, d.PRD_DTL_SEQ 
				, e.EMPL_SEQ  AS PTRM_EMPL_SEQ
				, f.partName as PRTM_RMK
				, a.UnitPrice as UNTPC /*기준단가*/
				, CONVERT(VARCHAR(8), a.GiftDate, 112) as PRMT_DT /*판촉일*/
				, CONVERT(VARCHAR(8), a.StartDate, 112) as INPT_DT /*최초투입일*/
				, a.ContextPeriod as CNTR_MONTH /*계약월*/
				, case 
					when a.Status = 0 then 'Y'	/*중지*/
					when a.Status = 3 then 'Y'	/*삭제*/
					when a.Status = 2 then 'N'	/*보류*/
					when a.Status = 1 then 'N'	/*애음중*/
					end as STPG_YN
				, CONVERT(VARCHAR(8), a.EndDate, 112) as STPG_DT /*맞는 컬럼이없어서 마이그레이션에선 대체*/
				, a.StopDescription as STPG_RSON
				, a.DCustomerCode AS CST_BEF_CD
				, case
					when a.ExptHoliday = 0 then	'RSTDE_DLV'		/*휴일배달*/
					when a.ExptHoliday = 1 then	'RSTDE_EXCL'	/*휴일제외*/
					when a.ExptHoliday = 2 then	'HODY_EXCL'		/*명절제외*/
					end as DLV_SEC_CD
				, a.PartSeq
				, ISNULL(a.HopUnitQty, 0) --홉수
				, ISNULL(a.SalesCost, 0)	--홉단가		
				--, a.HopUnitQty
				--, a.SalesCost
				, 'BEF'
				, CONVERT(numeric, a.DefaultQty) as DefaultQty
				, 'BEF' AS CST_COS_CD
				, 'N'
				, GETDATE()  as reg_dtm
				, 0  as reg_seq
				, GETDATE()  as upd_dtm
				, 0  as upd_seq
			FROM 
			BA_MDB...DCustomerPart a
				inner join
					T_AGEN_AREA b
					on b.AGEN_SEQ  = @V_AGEN_SEQ
					and b.AGEN_AREA_CD = a.RegionCode
				inner JOIN 
					T_CST_MST c 
					on a.DCustomerCode = c.CST_AGEN_CD
					and b.AGEN_SEQ  = c.AGEN_SEQ 
				inner JOIN 	
					T_PRD_DTL d 
					on a.PartCode = d.PRD_DTL_CD 
					and b.AGEN_SEQ = d.AGEN_SEQ
				inner JOIN 
					T_AGEN_EMPL e 
					on a.SalesCode = e.SALE_BEF_CD 
					and b.AGEN_SEQ = e.AGEN_SEQ 
				inner JOIN 
					BA_MDB...parts f
					--on f.PartCode = a.GPartCode
					on f.PartCode = a.PartCode
					and f.PartClass not in (5, 6) /*판촉 제외*/
			WHERE 
			1=1
			--and e.EMPL_SEQ is not null
			--AND d.PRD_SEQ is not null
			--and c.CST_SEQ is not null
			--and a.HopUnitQty = 1.5
		END

		/*11-2. 애음자 제품 마지막 Y*/
		BEGIN
			UPDATE T_CST_PRD
				SET LAST_YN = 'Y'
			FROM T_CST_PRD a
			JOIN (SELECT 
					AGEN_SEQ, AREA_SEQ, CST_SEQ, PRD_SEQ 
				, MAX(CST_PRD_SEQ) AS CST_PRD_SEQ
				FROM 
				T_CST_PRD a
				WHERE 
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				GROUP BY AGEN_SEQ, AREA_SEQ, CST_SEQ, PRD_SEQ  ) b
				ON a.CST_PRD_SEQ = b.CST_PRD_SEQ
			WHERE
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				--AND a.USE_YN = 'Y'

		END

		/*12. 애음자 제품 패턴*/
		BEGIN
			INSERT INTO T_CST_PTTN(
				PTTN_SEQ
				,AGEN_SEQ
				,AREA_SEQ
				,CST_SEQ
				,CST_PRD_SEQ
				,PRD_DTL_SEQ
				,PUCH_SEQ 
				,WEEKS
				,MON_QTY
				,TUE_QTY
				,WED_QTY
				,THU_QTY
				,FRI_QTY
				,SAT_QTY
				,SUN_QTY
				,USE_YN
				,LAST_YN
				,BEF_PTTN_STR
				,MIG_YN
				,REG_DTM
				,REG_SEQ
				,UPD_DTM
				,UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_CST_PTTN
				, a.AGEN_SEQ 
				, a.AREA_SEQ 
				, a.CST_SEQ 
				, a.CST_PRD_SEQ 
				, a.PRD_DTL_SEQ 
				, 1
				, 1 AS WEEKS -- 1주로 데이터를 넣어줌
				, c.PQty1	as MON_QTY
				, c.PQty2	as TUE_QTY
				, c.PQty3	as WED_QTY
				, c.PQty4	as THU_QTY
				, c.PQty5	as FRI_QTY
				, c.PQty6	as SAT_QTY
				, c.PQty7	as SUN_QTY
				, case 	when c.Status = '0' then 'N'	/*중지*/
						when c.Status = '3' then 'N'	/*삭제*/
						when c.Status = '2' then 'Y'	/*보류*/
						when c.Status = '1' then 'Y'	/*애음중*/
					else 'N' end USE_YN 
				, 'N' AS LAST_YN
				, e.PatternName
				,'Y'
				, GETDATE()  as reg_dtm
				, 0  as reg_seq
				, GETDATE()  as upd_dtm
				, 0  as upd_seq	
			FROM 
			T_CST_PRD a
				LEFT OUTER JOIN
					T_PRD_DTL b
					on a.PRD_SEQ = b.PRD_SEQ
					AND a.AGEN_SEQ = B.AGEN_SEQ
				LEFT OUTER JOIN 
					T_AGEN_EMPL d 
					on d.EMPL_SEQ  = a.PRMT_EMPL_SEQ 
				LEFT OUTER JOIN
					BA_MDB...DCustomerPart c
					on b.PRD_DTL_CD = c.PartCode	
					AND a.CST_BEF_CD  = c.DCustomerCode
					AND d.SALE_BEF_CD  = c.SalesCode
				LEFT OUTER JOIN
					BA_MDB...OrderPattern e
					ON c.OrderPattern = e.OrderPattern
			WHERE 
			1=1
			and a.AGEN_SEQ = @V_AGEN_SEQ
			and a.LAST_YN = 'Y'
		END
		
		/*12-1. 패턴 라스트 업데이트*/
		BEGIN
			UPDATE T_CST_PTTN
			SET LAST_YN = 'Y'
			FROM T_CST_PTTN a
			JOIN (SELECT 
					AGEN_SEQ , AREA_SEQ , CST_SEQ , CST_PRD_SEQ ,PRD_DTL_SEQ 
				, MAX(PTTN_SEQ) AS PTTN_SEQ
				FROM 
				T_CST_PTTN a
				WHERE 
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				GROUP BY AGEN_SEQ , AREA_SEQ , CST_SEQ , CST_PRD_SEQ ,PRD_DTL_SEQ ) b
				ON a.PTTN_SEQ = b.PTTN_SEQ
			WHERE
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				AND a.USE_YN = 'Y'
		END

		/* 13. 제품별 지역 단가 등록*/
		BEGIN
			INSERT INTO T_AGEN_PRD_UNTPC(
				AREA_PRD_SEQ
				, AGEN_SEQ
				, AREA_SEQ
				, PUCH_SEQ 
				, PRD_SEQ
				, PRD_DTL_SEQ 
				, UNTPC
				, APPL_DT
				, LAST_YN
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_AREA_PRD over (order by a.applyDate asc)	
				, b.AGEN_SEQ 	
				, b.AREA_SEQ 
				, 1
				, c.PRD_SEQ 
				, d.PRD_DTL_SEQ 
				, a.UnitPrice as UNTPC
				, CONVERT(VARCHAR(8), a.ApplyDate, 112) as APPL_DT
				, 'N' AS LAST_YN
				, GETDATE() 
				, 0
				, GETDATE() 
				, 0
			FROM 
			BA_MDB...regionPrice a
				inner join
					T_AGEN_AREA b
					on b.AGEN_SEQ = @V_AGEN_SEQ
					and a.RegionCode = b.AGEN_AREA_CD
				inner join
					T_PRD_MST c
					on a.PartCode = c.PRD_SAP_CD
				inner join
					T_PRD_DTL d
					on d.AGEN_SEQ = @V_AGEN_SEQ
					AND c.PRD_SEQ = d.PRD_SEQ 
			WHERE 
			1=1
			order by a.applyDate asc
		END
		
		/*13-1 대리점 지역별 단가 마지막 여부 */
		BEGIN
			UPDATE T_AGEN_PRD_UNTPC
				SET LAST_YN = 'Y'
			FROM T_AGEN_PRD_UNTPC a
			JOIN (SELECT 
					MAX(a.AREA_PRD_SEQ) AS AREA_PRD_SEQ
					, AREA_SEQ, AGEN_SEQ, PRD_SEQ, PRD_DTL_SEQ
				FROM 
				T_AGEN_PRD_UNTPC a
				WHERE 
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				GROUP BY AREA_SEQ, AGEN_SEQ, PRD_SEQ, PRD_DTL_SEQ) b
				ON a.AREA_PRD_SEQ = b.AREA_PRD_SEQ
			WHERE
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				AND a.USE_YN = 'Y'
		END

		/*13-2 애음자 표준 단가*/
		BEGIN
			INSERT INTO T_CST_PRD_SPPRC(
				CST_SPPRC_SEQ
				, AGEN_SEQ
				, AREA_SEQ
				, PUCH_SEQ
				, PRD_SEQ
				, PRD_DTL_SEQ
				, UNTPC
				, APPL_DT
				, LAST_YN
				, REG_DTM
				, REG_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_CST_SPPRC over (order by b.applyDate asc)	
				, a.AGEN_SEQ 
				, c.AREA_SEQ 
				, 0 as PUCH_SEQ 
				, a.PRD_SEQ 
				, a.PRD_DTL_SEQ 
				, b.SpendingCost AS UNTPC
				, CONVERT(VARCHAR(8), b.ApplyDate, 112) as APPL_DT
				, 'N' AS LAST_YN
				, GETDATE() 
				, 0
			FROM 
			T_AGEN_AREA c
				LEFT OUTER JOIN
					T_PRD_DTL a 
					ON c.AGEN_SEQ = a.AGEN_SEQ 
				INNER JOIN
					BA_MDB...STDPrice b
					ON a.PRD_DTL_CD = b.PartCode
					AND b.SpendingCost is not null		
			WHERE 
			1=1
			AND a.AGEN_SEQ = @V_AGEN_SEQ
			order by b.applyDate asc
		END

		/*13-3 애음자 표준단가 마지막 여부*/
		BEGIN
			UPDATE T_CST_PRD_SPPRC
				SET LAST_YN = 'Y'
			FROM T_CST_PRD_SPPRC a
			JOIN (SELECT 
					MAX(a.CST_SPPRC_SEQ) AS CST_SPPRC_SEQ,
					 AGEN_SEQ, PRD_SEQ, PRD_DTL_SEQ
				FROM 
				T_CST_PRD_SPPRC a
				WHERE 
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				GROUP BY  AGEN_SEQ, PRD_SEQ, PRD_DTL_SEQ) b
				ON a.CST_SPPRC_SEQ = b.CST_SPPRC_SEQ
			WHERE
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ
				AND a.USE_YN = 'Y'
		END

		/*14. 애음자 제품별 계약 단가*/
		BEGIN
			INSERT INTO T_CST_PRD_UNTPC
			(
				UNTPC_SEQ
				, AGEN_SEQ
				, AREA_SEQ
				, CST_SEQ
				, PRD_DTL_SEQ
				, CST_PRD_SEQ
				, PTTN_SEQ
				, PUCH_SEQ
				, DFLT_QTY
				, UNTPC
				, STAT_DT
				, END_DT
				, LAST_YN
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_CST_UNTPC over (order by a.DCustomerCode desc, a.seq desc, a.ordr asc)	
				, b.AGEN_SEQ 
				, b.AREA_SEQ 
				, b.CST_SEQ 
				, b.PRD_DTL_SEQ 
				, b.CST_PRD_SEQ 
				, b.PTTN_SEQ 	
				, 1
				, DefaultQty as DFLT_QTY
 				, UnitPrice as UNTPC
 				, STAT_DT
 				, END_DT
				, 'N'
 				, GETDATE() as REG_DTM
 				, 0 as REG_SEQ
 				, GETDATE() as UPD_DTM
 				, 0 as UPD_SEQ
			FROM 
			(
				SELECT 
					a.PartSeq as seq 
					, 1 as ordr
					, a.partCode
					, a.SalesCode
					, a.DCustomerCode
					, a.UnitPrice
					, a.DefaultQty
					, null as upd_dt
					, CONVERT(VARCHAR(8), a.StartDate, 112) as STAT_DT
					, CONVERT(VARCHAR(8), a.EndDate, 112) as END_DT
				FROM 
				BA_MDB...DCustomerPart a
				union
				SELECT 
					a.seqNo1 as seq
					, 2 as ordr
					, b.partCode
					, b.SalesCode
					, a.DCustomerCode
					, a.itemBefore as UnitPrice
					, b.DefaultQty
					, CONVERT(VARCHAR(8), a.StartDate, 112) as upd_dt
					, CONVERT(VARCHAR(8), b.StartDate, 112) as STAT_DT
					, CONVERT(VARCHAR(8), b.EndDate, 112) as END_DT
				from
				BA_MDB...Delivery a
					left outer join
						BA_MDB...DCustomerPart b
						on a.DCustomerCode = b.DCustomerCode
						and a.seqNo1 = b.PartSeq
				WHERE 
				1=1
				and a.DeliveryCode = '13' --변경 한거
				and itemBefore <> ''
			) a 
				left outer join 
				(
					SELECT 
						b.AGEN_SEQ 
						, b.AREA_SEQ 
						, b.CST_SEQ 
						, b.CST_PRD_SEQ 
						, b.PRD_DTL_SEQ 
						, b.PTTN_SEQ 
						, a.CST_BEF_CD
						, a.prd_bef_cd
					FROM 
					T_CST_PRD a
						left outer join
						T_CST_PTTN b
						on b.CST_PRD_SEQ  = a.CST_PRD_SEQ 
						and b.PRD_DTL_SEQ 	= a.PRD_DTL_SEQ
						AND a.agen_seq = @V_AGEN_SEQ
				) b
				on a.DCustomerCode = b. CST_BEF_CD
				and a.seq = b.prd_bef_cd
			WHERE 
			1=1
			and b.AGEN_SEQ is not null
			and b.AREA_SEQ is not null
			and b.CST_SEQ is not null
			and b.CST_PRD_SEQ is not null
			and b.PRD_DTL_SEQ is not null
			and b.PTTN_SEQ is not null
			order by a.DCustomerCode desc, a.seq desc, a.ordr asc
		END

		/* 14-2. 제품별 계약 단가 마지막 체크*/
		BEGIN
			UPDATE T_CST_PRD_UNTPC
			SET LAST_YN = 'Y'
			FROM T_CST_PRD_UNTPC a
			JOIN (SELECT 
					PTTN_SEQ
					, MAX(a.UNTPC_SEQ) AS UNTPC_SEQ
				FROM 
				T_CST_PRD_UNTPC a
				WHERE 
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ 
				GROUP BY a.PTTN_SEQ) b
				ON a.UNTPC_SEQ = b.UNTPC_SEQ
			WHERE
				1=1
				AND AGEN_SEQ = @V_AGEN_SEQ 
				--AND a.USE_YN = 'Y'
		END

		/*14-3 제품 기준 단가*/
		BEGIN
			INSERT INTO T_STDR_PRD_SPPRC(
				STDR_SPPRC_SEQ
				, AGEN_SEQ
				, PUCH_SEQ
				, PRD_DTL_SEQ
				, PRD_SEQ
				, UNTPC
				, SPPRC
				, VAT
				, EMPL_UNTPC
				, CST_UNTPC
				, APPL_DT
				, LAST_YN
				, REG_DTM
				, REG_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_STDR_PRD
				, b.AGEN_SEQ 
				, b.PUCH_SEQ 
				, b.PRD_DTL_SEQ 
				, b.PRD_SEQ 
				, a.InCost AS UNTPC
				, 0 AS SPPRC
				, 0 AS VAT
				, a.OutCost AS EMPL_UNTPC
				, a.SpendingCost AS CST_UNTPC
				, CONVERT(VARCHAR(8), a.ApplyDate, 112) as APPL_DT
				, 'Y' AS LAST_YN
				, GETDATE() 
				, 0
			FROM 
				BA_MDB...STDPrice a
				INNER JOIN 
					T_PRD_DTL b
					ON b.AGEN_SEQ = @V_AGEN_SEQ
					AND a.PartCode = b.PRD_DTL_CD 
			WHERE 
				1=1
				and (InCost is not null and InCost <> 0)
				and (OutCost is not NULL and OutCost <> 0)
				and (SpendingCost is not null and SpendingCost <> 0)
				and ApplyDate = ( SELECT top(1) ApplyDate FROM BA_MDB...STDPrice ORDER BY ApplyDate DESC )
		END

		/*14-4 제품별 마진율(판매원)*/
		BEGIN
			INSERT INTO T_MRGN_PRD(
				MRGN_PRD_SEQ
				, AGEN_SEQ
				, AREA_SEQ
				, PUCH_SEQ
				, PRD_DTL_SEQ
				, PRD_SEQ
				, MRGN_PRD_CD
				, MRGN_RATE
				, MRGN_CT
				, LAST_YN
				, REG_DTM
				, REG_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_MRGN_PRD
				, a.AGEN_SEQ 
				, b.AREA_SEQ 
				, a.PUCH_SEQ 
				, a.PRD_DTL_SEQ 
				, a.PRD_SEQ 
				, 'EMPL' AS PRD_MRGN_CD
				, ROUND(((a.EMPL_UNTPC-a.UNTPC)/a.EMPL_UNTPC) * 100, 1) as MRGN_RATE
				, a.EMPL_UNTPC-a.UNTPC AS MRGN_CT
				, 'Y' AS LAST_YN 
				, GETDATE() 
				, 0
			FROM  
			T_STDR_PRD_SPPRC a
				LEFT OUTER JOIN
					T_AGEN_AREA b
					ON a.AGEN_SEQ = b.AGEN_SEQ 
			WHERE 
			1=1
			AND a.AGEN_SEQ = @V_AGEN_SEQ
			AND a.LAST_YN = 'Y'
		END

		/*14-5 제품별 마진율(애음자)*/
		BEGIN
			INSERT INTO T_MRGN_PRD(
				MRGN_PRD_SEQ
				, AGEN_SEQ
				, AREA_SEQ
				, PUCH_SEQ
				, PRD_DTL_SEQ
				, PRD_SEQ
				, MRGN_PRD_CD
				, MRGN_RATE
				, MRGN_CT
				, LAST_YN
				, REG_DTM
				, REG_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_MRGN_PRD
				, a.AGEN_SEQ 
				, b.AREA_SEQ 
				, a.PUCH_SEQ 
				, a.PRD_DTL_SEQ 
				, a.PRD_SEQ 
				, 'CST' AS PRD_MRGN_CD 
				, a.CST_UNTPC - a.EMPL_UNTPC AS MRGN_CT
				, ROUND(((a.CST_UNTPC - a.EMPL_UNTPC)/a.CST_UNTPC * 100), 1) AS MRGN_RATE
				, 'Y' AS LAST_YN 
				, GETDATE() 
				, 0
			FROM  
			T_STDR_PRD_SPPRC a
				LEFT OUTER JOIN
					T_AGEN_AREA b
					ON a.AGEN_SEQ = b.AGEN_SEQ 
			WHERE 
			1=1
			AND a.AGEN_SEQ = @V_AGEN_SEQ
			AND a.LAST_YN = 'Y'
		END

		/*15. 애음자 중지/보류/완전중지 */
		BEGIN
			INSERT INTO T_CST_PRD_STPG (
				CST_STPG_SEQ
				, AGEN_SEQ
				, AREA_SEQ
				, CST_SEQ
				, PRD_DTL_SEQ
				, CST_PRD_SEQ
				, PUCH_SEQ
				, CHG_SEC_CD
				, RMK
				, PRT_MSG
				, PRT_DT
				--, PRT_YN	
				, STAT_DT
				, END_DT
				, USE_YN
				, LAST_YN
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_CST_PRD_STPG over (order by a.seqNo desc, a.InputDate desc)	
				, c.AGEN_SEQ
				, c.AREA_SEQ
				, c.CST_SEQ
				, c.PRD_DTL_SEQ
				, c.CST_PRD_SEQ
				, c.PUCH_SEQ
				, b.COMM_CD  AS CHG_SEC_CD
				, a.Description as RMK
				, a.PrtMsg as PRT_MSG
				, CONVERT(VARCHAR(8), a.PrtSDate, 112) as PRT_DT
				--, 'N' as PRT_YN
				, CONVERT(VARCHAR(8), a.StartDate, 112) as STAT_DT
				, CONVERT(VARCHAR(8), a.EndDate, 112) as END_DT
				, 'Y' as USE_YN
				, 'N' AS LAST_YN
				, GETDATE() 
				, 0
				, GETDATE() 
				, 0
			FROM 
			BA_MDB...Delivery a
				left outer join 
					T_COMM b 
					on b.COMM_GRP_CD = 'CHG_SEC_CD'
					and CONVERT(NVARCHAR(20),a.deliverycode) = b.COMM_DESC1 
				inner JOIN 
					t_cst_prd c 
					on a.DCustomerCode = c.CST_BEF_CD
					and c.agen_seq = @V_AGEN_SEQ
					and a.seqNo1 = c.PRD_BEF_CD 
			WHERE 
			1=1
			and a.deliverycode  in (2, 6, 7, 22)
			order by a.seqNo desc, a.InputDate desc
		END
		
		/*15-1. 애음자 중지/보류/완전중지 LAST_YN */
		BEGIN
			UPDATE T_CST_PRD_STPG
			SET LAST_YN = 'Y'
			FROM T_CST_PRD_STPG a
			JOIN (SELECT 
					AGEN_SEQ, AREA_SEQ, CST_SEQ, PRD_DTL_SEQ, CST_PRD_SEQ
					, MAX(a.CST_STPG_SEQ) AS CST_STPG_SEQ
				FROM 
				T_CST_PRD_STPG a
				WHERE 
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ 
				GROUP BY AGEN_SEQ, AREA_SEQ, CST_SEQ, PRD_DTL_SEQ, CST_PRD_SEQ) b
				ON a.CST_STPG_SEQ = b.CST_STPG_SEQ
			WHERE
				1=1
				AND a.AGEN_SEQ = @V_AGEN_SEQ 
				AND a.USE_YN = 'Y'

		END


		/*16. 애음자 수금*/
		BEGIN
			INSERT INTO T_CST_BILCT(
				CST_BILCT_SEQ				/*애음자 수금 시퀀스*/
				, CST_SEQ					/*애음자 시퀀스*/
				, AGEN_SEQ					/*대리점 시퀀스*/
				, AREA_SEQ					/*지역 시퀀스*/
				, RPMY_MONTH				/*입금월*/
				, RPMY_DTM					/*입금일자*/
				, BILCT_MTH					/*수금방법*/
				, LSMTH_CT					/*전월미수액*/
				, DRKWT_CT					/*애음액*/
				, RQEST_CT					/*청구액*/
				, BILCT_CT					/*수금액*/
				, BILCT_FEE					/*수수료*/
				, VIR_ACCT_NO				/*계좌번호*/
				, VIR_ACCT_RPMY_DTM			/*가상계좌입금일*/
				, VIR_ACCT_BANK_CD			/*가상계좌은행*/
				, RPMY_NM					/*입금자명*/	
				, DELG_NO 					/*거래번호*/
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ)
			SELECT 
				NEXT VALUE FOR SQ_CST_BILCT						/*애음자 수금 시퀀스*/
				, TCM.CST_SEQ 									/*애음자 시퀀스*/
				, @V_AGEN_SEQ AS AGEN_SEQ 						/*대리점 시퀀스*/
				, B.AREA_SEQ									/*지역 시퀀스*/
				, TB.YEARMONTH 									/*입금월*/
				, TB.INDATE										/*입금일자*/
				, TB.BILCT_MTH									/*수금방법*/
				, (TB.PREV_AMM - TB.PREV_BILLCOST)  AS AMOUNT 	/*전월미수*/
				, TB.REQAMOUNT									/*애음액*/
				, TB.MAINAMOUNT									/*청구액*/
				, TB.BILLCOST									/*수금액*/
				, TB.FEE										/*수수료*/
				, TB.GASBANKACC  								/*가상계좌번호*/
				, TB.GASINDATE									/*가상계좌입금일*/	
				, TB.GASBANKCODE								/*가상계좌은행*/
				, dbo.F_GET_ENCRYT(TB.BIGO) AS RPMY_NM 			/*입금자명*/
				, TB.GASKRNO 									/*거래번호*/
				, GETDATE()
				, '0'
				, GETDATE()
				, '0'
			FROM 
			(
				SELECT 
					A.REGIONCODE
					, A.DCUSTOMERCODE	
					, A.YEARMONTH									/*입금월*/
					, A.INDATE										/*입금일자*/		
					, CASE 
						WHEN A.PAYMETHOD = '1' THEN 'MTH_1'			/*이전 구분 : 지로*/ 
						WHEN A.PAYMETHOD = '2' THEN 'MTH_2'			/*이전 구분 : 방문*/
						WHEN A.PAYMETHOD = '3' THEN 'MTH_3'			/*이전 구분 : 직수*/	
						WHEN A.PAYMETHOD = '4' THEN 'MTH_4'			/*이전 구분 : 통장*/
						WHEN A.PAYMETHOD = '5' THEN 'MTH_5'			/*이전 구분 : CMS*/
						WHEN A.PAYMETHOD = '6' THEN 'MTH_10'		/*이전 구분 : 정산*/
						WHEN A.PAYMETHOD = '7' THEN 'MTH_7'			/*이전 구분 : 기타*/
						WHEN A.PAYMETHOD = '8' THEN 'MTH_8'			/*이전 구분 : 정리*/
						WHEN A.PAYMETHOD = '9' THEN 'MTH_9'			/*이전 구분 : 카드*/
						WHEN A.PAYMETHOD = 'A' THEN 'MTH_11'		/*이전 구분 : 가상*/
						WHEN A.PAYMETHOD = 'Z' THEN 'MTH_12'		/*이전 구분 : 포인트*/
						WHEN A.PAYMETHOD = 'B' THEN 'MTH_13'		/*이전 구분 : CMS제외*/
						WHEN A.PAYMETHOD = 'C' THEN 'MTH_6'			/*이전 구분 : 카드CMS*/
					END AS BILCT_MTH 								/*수금방법*/		
					, (
						SELECT SUM(IIF(BILLCOST = NULL,0,BILLCOST)+IIF(FEE = NULL,0,FEE)) 
	                     FROM BA_MDB...BILLCOLLECTION F 
	                     WHERE F.YEARMONTH <= CONVERT(VARCHAR(6), DATEADD(MONTH, -1, CONVERT (DATETIME, CONVERT(VARCHAR(8), A.YEARMONTH) + '01')), 112)
	                     AND DCUSTOMERCODE = A.DCUSTOMERCODE 
	                     GROUP BY DCUSTOMERCODE 
					) AS PREV_BILLCOST	/*전달수금*/
					, (
						SELECT SUM(REQAMOUNT) 
	                     FROM BA_MDB...DCOLLECTION G 
	                     WHERE G.YEARMONTH <=  CONVERT(VARCHAR(6), DATEADD(MONTH, -1, CONVERT (DATETIME, CONVERT(VARCHAR(8), A.YEARMONTH) + '01')), 112)
	                     AND DCUSTOMERCODE = A.DCUSTOMERCODE 
	                     GROUP BY DCUSTOMERCODE 
					) AS PREV_AMM 		/*전달애음*/					
					, B.REQAMOUNT									/*애음액*/
					, B.MAINAMOUNT									/*청구액*/
					, A.BILLCOST									/*수금액*/
					, A.FEE											/*수수료*/	
					, CASE WHEN SUBSTRING(A.GASKRNO, 1, 2) = C.GASBANKCODE THEN C.GASBANKACC 
							WHEN SUBSTRING(A.GASKRNO, 1, 2) = C.GASBANKCODE2 THEN C.GASBANKACC2
							WHEN SUBSTRING(A.GASKRNO, 1, 2) = C.GASBANKCODE3 THEN C.GASBANKACC3 
						END GASBANKACC  							/*가상계좌번호*/
					, IsNULL(A.GASINDATE, '') AS GASINDATE			/*가상계좌입금일*/	
					, C.GASBANKCODE									/*가상계좌은행*/
					, A.BIGO 										/*입금자명*/
					, A.GASKRNO 									/*거래번호*/	
				FROM BA_MDB...BILLCOLLECTION A
					INNER JOIN BA_MDB...DCOLLECTION B ON A.YEARMONTH = B.YEARMONTH AND A.INDATE = B.INDATE 
															AND A.DCUSTOMERCODE = B.DCUSTOMERCODE 
															AND A.REGIONCODE = B.REGIONCODE 
					INNER JOIN BA_MDB...DCUSTOMER C ON A.DCUSTOMERCODE = C.DCUSTOMERCODE
				WHERE
					A.YEARMONTH = B.YEARMONTH AND A.INDATE = B.INDATE 
					AND A.DCUSTOMERCODE = B.DCUSTOMERCODE 
					AND A.REGIONCODE = B.REGIONCODE 
					AND A.INDATE BETWEEN CONVERT(VARCHAR(8), DATEADD(MONTH, -3, GETDATE()), 112)  AND CONVERT(VARCHAR(8), GETDATE(), 112) /*3개월내 데이터만 처리*/ 
			) TB 
			INNER JOIN T_AGEN_AREA B ON B.AGEN_SEQ = @V_AGEN_SEQ 
										AND B.AGEN_AREA_CD = TB.REGIONCODE
			INNER JOIN T_CST_MST TCM ON TCM.CST_AGEN_CD = TB.DCUSTOMERCODE AND TCM.AGEN_SEQ = @V_AGEN_SEQ 
		END

		/*16-1.	가상계좌번호 없는 데이터, 가상계좌입금일 null로 변경하기		*/
		BEGIN
			UPDATE T_CST_BILCT
				SET VIR_ACCT_RPMY_DTM = NULL
			WHERE (VIR_ACCT_NO IS NULL OR VIR_ACCT_NO = '') 
				AND AGEN_SEQ = @V_AGEN_SEQ
		END	

		/*17. 애음자 제품 히스트리*/
		BEGIN
			INSERT INTO T_CST_PRD_HIS
			(
				CST_PRD_HIS_SEQ,
				AGEN_SEQ,
				AREA_SEQ,
				CST_SEQ,
				PRD_DTL_SEQ,
				CST_PRD_SEQ,
				PUCH_SEQ,
				CHG_SEC_CD,
				RMK,
				BEF_RMK,
				AFT_RMK,
				APPL_STAT_DT,
				APPL_END_DT,
				DLVY_DT,
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)
			SELECT 
			NEXT VALUE FOR SQ_CST_PRD_HIS,
			@V_AGEN_SEQ AS AGEN_SEQ,
			TAA.AREA_SEQ,
			TCM.CST_SEQ,
			TPD.PRD_DTL_SEQ,
			TCP.CST_PRD_SEQ,
			TPD.PUCH_SEQ,
			TC.COMM_CD,
		
			CASE WHEN TB.DELIVERYCODE = '1' OR TB.DELIVERYCODE = '3' OR TB.DELIVERYCODE = '11' OR TB.DELIVERYCODE = '13' OR TB.DELIVERYCODE = '19' THEN ''
				WHEN TB.DELIVERYCODE = '2' THEN CONCAT(DATEDIFF(DD, TB.STARTDATE, TB.ENDDATE)+1, ' 일 보류') 
				WHEN TB.DELIVERYCODE = '17' THEN DBO.F_GET_HLD_DLV_OLD(ISNULL(TB.ITEM2, '00000'))  
				ELSE CONVERT(NVARCHAR(400), TPM_ITM2.PRD_SEQ) 
				END ITEM2,
		
			TB.ITEMBEFORE,		--변경전
			CASE WHEN TB.DELFLAG = 'Y' AND (TB.ITEMAFTER IS NOT NULL AND TB.ITEMAFTER != '') THEN CONCAT(TB.ITEMAFTER, '(취소)')
					ELSE TB.ITEMAFTER
					END ITEMAFTER, --변경후
		
			CONVERT(CHAR(8), TB.STARTDATE, 112) AS STARTDATE,		--적용시작일
			CONVERT(CHAR(8), TB.ENDDATE, 112) AS ENDDATE,			--적용종료일
			CONVERT(CHAR(8), TB.PRINTDATE, 112) AS PRINTDATE,		--출고증인쇄
			TB.INPUTDATE + CAST(TB.INPUTTIME AS DATETIME),
			'0',
			GETDATE(),
			'0' 
			FROM (
				SELECT
					A.PARTCODE1,	
					A.INPUTDATE,		--처리일자
					A.INPUTTIME,		--처리시간
					A.DCUSTOMERCODE,	--애음자코드
					A.REGIONCODE,		--지역코드
					A.ADDRESS,			--주소
					D.DELIVERYCODE,
					A.ITEM2,			--항목2
					A.ITEMBEFORE,		--변경전
					A.ITEMAFTER,		--변경후
					A.STARTDATE,		--적용시작일
					A.ENDDATE,			--적용종료일
					A.PRINTDATE,		--출고증인쇄
					A.DELFLAG
				FROM
					BA_MDB...DELIVERY A
					LEFT OUTER JOIN BA_MDB...DCUSTOMERPART B ON	A.DCUSTOMERCODE = B.DCUSTOMERCODE AND B.PARTSEQ = A.SEQNO1
					LEFT OUTER JOIN BA_MDB...PARTS C ON A.PARTCODE1 = C.PARTCODE
					LEFT OUTER JOIN BA_MDB...DELIVERYCODE D ON A.DELIVERYCODE = D.DELIVERYCODE    
			) TB
			INNER JOIN DBO.T_AGEN_AREA TAA ON TB.REGIONCODE = TAA.AGEN_AREA_CD  
			INNER JOIN DBO.T_CST_MST TCM ON TB.DCUSTOMERCODE = TCM.CST_AGEN_CD AND TCM.AGEN_SEQ = @V_AGEN_SEQ 
			INNER JOIN DBO.T_PRD_MST TPM ON TB.PARTCODE1 = TPM.PRD_SAP_CD  
			INNER JOIN DBO.T_PRD_DTL TPD ON TPM.PRD_SEQ = TPD.PRD_SEQ  
			LEFT OUTER JOIN DBO.T_PRD_MST TPM_ITM2 ON TB.ITEM2 = TPM_ITM2.PRD_SAP_CD 
			INNER JOIN DBO.T_CST_PRD TCP ON TCP.AGEN_SEQ = @V_AGEN_SEQ AND TCP.AREA_SEQ = TAA.AREA_SEQ AND TCP.CST_SEQ =  TCM.CST_SEQ AND TCP.PRD_SEQ = TPM.PRD_SEQ AND TCP.STPG_YN = 'N'
			LEFT OUTER JOIN DBO.T_COMM TC ON TC.COMM_GRP_CD = 'CHG_SEC_CD' AND TC.COMM_DESC1 = TB.DELIVERYCODE 
		END
		/*17-1. 애음자 배송 현황*/
		DECLARE @CST_CNT INT
				, @CST_YM nvarchar(25) = ''
				, @CST_YMV nvarchar(4) = ''
				, @CST_DQty nvarchar(20) = ''
				, @CST_Danga nvarchar(20) = ''
				, @CST_BMonth nvarchar(30) = '201901 AND '
				, @CST_AGEN_SEQ nvarchar(26) = ''
				, @CST_YN varchar(1) 	= N'Y'
				, @CST_Month nvarchar(6) = CONVERT(VARCHAR(6), DATEADD(MONTH, -1, GETDATE()), 112);
				;
		
		SET @CST_CNT = 1
		SET @CST_AGEN_SEQ = CONVERT(VARCHAR(26), @V_AGEN_SEQ)
		SET @CST_BMonth = CONCAT(@CST_BMonth, @CST_Month)

		WHILE @CST_CNT <= 31
		BEGIN
			SET @CST_YMV = CONVERT(VARCHAR(2),@CST_CNT)
			SET @CST_DQty	= CONCAT(N'DQty', CONVERT(VARCHAR(2),@CST_YMV))
			SET @CST_Danga	= CONCAT(N'Danga', CONVERT(VARCHAR(2),@CST_YMV))
			
			EXEC (N'INSERT INTO T_CST_PRD_DLVY (
				CST_PRD_DLVY_SEQ
				, AGEN_SEQ
				, AREA_SEQ
				, CST_SEQ
				, PRD_DTL_SEQ
				, CST_PRD_SEQ
				, PTTN_SEQ
				, PUCH_SEQ
				, DLVY_QTY
				, DLVY_DT
				, DLVY_UNTPC
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				AGEN_SEQ
				, AREA_SEQ
				, CST_SEQ
				, PRD_DTL_SEQ
				, CST_PRD_SEQ
				, PTTN_SEQ
				, PUCH_SEQ
				, SUM(DLVY_QTY) AS DLVY_QTY
				, DLVY_DT
				, DLVY_UNTPC
				, GETDATE()  AS REG_DTM
				, 0 AS REG_SEQ
				, GETDATE()  AS UPD_DTM
				, 0 AS UPD_SEQ
			FROM (
				SELECT
					NEXT VALUE FOR SQ_CST_PRD_DLVY
					, b.AGEN_SEQ 
					, c.AREA_SEQ 
					, c.CST_SEQ 
					, b.PRD_DTL_SEQ 
					, d.CST_PRD_SEQ
					, e.PTTN_SEQ
					, b.PUCH_SEQ
					, '+@CST_DQty+' AS DLVY_QTY					/*출고 수량*/
					, CASE 
						WHEN LEN('+@CST_CNT+') = 1 THEN CONCAT(a.YearMonth, ''0'', '+@CST_CNT+')
						ELSE CONCAT(a.YearMonth, '+@CST_CNT+') END as DLVY_DT 	/*출고 일*/
					, CASE 
						WHEN '+@CST_Danga+' = 0 THEN UnitPrice
						ELSE '+@CST_Danga+' END AS DLVY_UNTPC		/*출고시 단가*/
				FROM 
					BA_MDB...DCustomerMonth a
					INNER JOIN
						T_PRD_DTL b
						on b.AGEN_SEQ = '+@CST_AGEN_SEQ+' 
						and a.PartCode = b.PRD_DTL_CD
					INNER JOIN 
						T_CST_MST c 
						on a.DCustomerCode = c.CST_AGEN_CD		
						AND c.AGEN_SEQ = b.AGEN_SEQ 
					INNER JOIN 
						(
							SELECT 
								MAX(CST_PRD_SEQ) AS CST_PRD_SEQ
			 					, CST_SEQ
			 					, PRD_DTL_SEQ
							FROM 
							T_CST_PRD d
							WHERE 
							1=1
							GROUP BY CST_SEQ, PRD_DTL_SEQ
						) d
						ON c.CST_SEQ = d.CST_SEQ
						AND b.PRD_DTL_SEQ  = d.PRD_DTL_SEQ
					INNER JOIN 
						T_CST_PTTN e
						ON c.CST_SEQ = e.CST_SEQ
						AND b.PRD_DTL_SEQ = e.PRD_DTL_SEQ
						AND e.LAST_YN = ''Y''
				WHERE 
				1=1
				AND a.YearMonth BETWEEN '+@CST_BMonth+' 
				AND a.'+@CST_DQty+' <> 0
				) a
				GROUP BY AGEN_SEQ, AREA_SEQ, CST_SEQ, PRD_DTL_SEQ, CST_PRD_SEQ, PTTN_SEQ, PUCH_SEQ, DLVY_DT, DLVY_UNTPC');

			--AND a.YearMonth = '202205'
			set @CST_CNT = @CST_CNT +1
		END	

		/*17-2 애음자 배송이력 날짜 업데이트*/
		BEGIN
			UPDATE T_CST_PRD_DLVY 
			SET	
				REG_DTM = GETDATE()
				, UPD_DTM = GETDATE()
			WHERE
				1=1
				AND AGEN_SEQ = @V_AGEN_SEQ
		END

		/*17-3 애음자 배송이력 배송일 업데이트*/
		BEGIN
			UPDATE T_CST_PRD_DLVY
				SET DLVY_DT = CONCAT(LEFT(b.DLVY_DT,6), '0', RIGHT(b.DLVY_DT,1))
			FROM T_CST_PRD_DLVY b
			WHERE 
				1=1
				AND CST_PRD_DLVY_SEQ = b.CST_PRD_DLVY_SEQ
				AND len(b.DLVY_DT) = 7
				AND AGEN_SEQ = @V_AGEN_SEQ
		END


		/*18. 제품 단가 히스토리 */
		BEGIN
			INSERT INTO T_PRD_UNTPC_HIS(
				PRD_UNTPC_SEQ
				, AGEN_SEQ
				, PUCH_SEQ
				, PRD_SEQ
				, PRD_DTL_SEQ 
				, UNTPC_SEC_CD
				, UNTPC
				, APPL_STAT_DT
				, APPL_END_DT
				, REG_DTM
				, REG_SEQ
				, UPD_DTM
				, UPD_SEQ
			)
			SELECT 
				NEXT VALUE FOR SQ_PRD_UNTPC over (order by a.applyDate desc)	
				, @V_AGEN_SEQ AS AGEN_SEQ
				, a.PUCH_SEQ as PUCH_SEQ
				, a.PRD_SEQ
				, a.PRD_DTL_SEQ
				, a.UNTPC_SEC_CD
				, a.UNTPC
				, a.APPL_STAT_DT
				, null as APPL_END_DT
				, applyDate as REG_DTM
				, 0 as REG_SEQ
				, applyDate as UPD_DTM
				, 0 as UPD_SEQ
			FROM 
			(
			SELECT 
				Partcode	as prd_sap_cd
				, 'PCHA_UNTPC'	as UNTPC_SEC_CD
				, inCost	as UNTPC
				, CONVERT(VARCHAR(8), applyDate, 112) as APPL_STAT_DT
				, applyDate
				, b.PUCH_SEQ 
				, b.PRD_SEQ
				, c.PRD_DTL_SEQ 
			FROM 	
				BA_MDB...stdPrice a
				inner JOIN 
				T_PRD_MST	b 
				on a.Partcode = b.PRD_SAP_CD
				left outer join 
				T_PRD_DTL c
				ON c.AGEN_SEQ = @V_AGEN_SEQ
				AND b.PRD_SEQ = c.PRD_SEQ 	
			WHERE 
				1=1
				and applyDate > CONVERT (DATETIME2, '2019-01-01 00:10:01') 
				and (inCost is not null or inCost <> '')
			union ALL 
			SELECT 
				Partcode	as prd_sap_cd
				, 'AREA_STD_UNTPC'	as UNTPC_SEC_CD
				, OutCost	as UNTPC
				, CONVERT(VARCHAR(8), applyDate, 112) as APPL_STAT_DT
				, applyDate
				, b.PUCH_SEQ 
				, b.PRD_SEQ
				, c.PRD_DTL_SEQ 
			FROM 	
				BA_MDB...stdPrice a
				inner JOIN 
				T_PRD_MST	b 
				on a.Partcode = b.PRD_SAP_CD
				left outer join 
				T_PRD_DTL c
				ON c.AGEN_SEQ = @V_AGEN_SEQ
				AND b.PRD_SEQ = c.PRD_SEQ 	
			WHERE 
				1=1
				and applyDate > CONVERT (DATETIME2, '2019-01-01 00:10:01') 
				and (OutCost is not null or OutCost <> '')
			union ALL 	
			SELECT 
				Partcode	as prd_sap_cd
				, 'CST_STD_UNTPC'	as UNTPC_SEC_CD
				, SpendingCost	as UNTPC
				, CONVERT(VARCHAR(8), applyDate, 112) as APPL_STAT_DT
				, applyDate
				, b.PUCH_SEQ 
				, b.PRD_SEQ
				, c.PRD_DTL_SEQ 
			FROM 	
				BA_MDB...stdPrice a
				inner JOIN 
				T_PRD_MST	b 
				on a.Partcode = b.PRD_SAP_CD
				left outer join 
				T_PRD_DTL c
				ON c.AGEN_SEQ = @V_AGEN_SEQ
				AND b.PRD_SEQ = c.PRD_SEQ 	
			WHERE 
				1=1
				and applyDate > CONVERT (DATETIME2, '2019-01-01 00:10:01') 
				and (SpendingCost is not null or SpendingCost <> '')
			) a 
			order by applyDate, PRD_SEQ, UNTPC_SEC_CD
			--PCHA_UNTPC 매입단가
			--AREA_STD_UNTPC 지역표준단가
			--CST_STD_UNTPC 애음자표준단가
		END

		/*19. 주문 마스터*/
		BEGIN
			INSERT INTO T_ORD_MST
			(
				ORD_SEQ,			--주문 시퀀스
				AGEN_SEQ,			--대리점 시퀀스
				ORD_DT,				--주문일
				ORD_STUS,			--주문상태
				DLV_DT,				--납품요청일
				REG_DTM,	
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)
			SELECT
				NEXT VALUE FOR SQ_ORD,				--주문 시퀀스
				TAM.AGEN_SEQ,						--대리점 시퀀스
				CONVERT(VARCHAR(8), ORM.ORDER_DT), 	--주문일
				ISNULL(ORM.ORDER_ADVNC_CODE, 99),	--주문상태	(null일때 99값으로 처리)
				CONVERT(VARCHAR(8), ORM.ORDER_DT), 	--납품요청일
				GETDATE(),
				'0',
				GETDATE(),
				'0'
			FROM
				PARMS.NAMYANG.DBO.SMORDR04 ORM, DBO.T_AGEN_MST TAM 
				WHERE ORM.CUST_CODE = TAM.AGEN_CD 	
				AND TAM.SALE_CD = 'BA'
				AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
		END


		/*20. 주문 제품*/
		BEGIN
			INSERT INTO	T_ORD_PRD
			(
				ORD_PRD_SEQ,		--주문제품 시퀀스
				ORD_SEQ,			--주문 시퀀스
				AGEN_SEQ,			--대리점 시퀀스
				PRD_DTL_SEQ,		--제품 상세 시퀀스
				--EMPL_SEQ,			--대리점 판매자 시퀀스
				REQ_BOX_QTY,		--주문신청 수량(박스)
				DSCN_BOX_QTY,		--주문확정 수량(박스)
				REQ_IDDY_QTY,		--주문신청 수량(낱봉)
				DCSN_IDDY_QTY,		--주문확정 수량(낱봉)
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)
			SELECT
				NEXT VALUE FOR SQ_ORD_PRD,		--주문제품 시퀀스
				ORM.ORD_SEQ,					--주문 시퀀스
				TB.AGEN_SEQ,					--대리점 시퀀스
				TB.PRD_DTL_SEQ,					--제품 상세 시퀀스
				--TB.EMPL_SEQ,					--대리점 판매자 시퀀스
				TB.BOX_QTY,						--주문신청 수량(박스)
				TB.CR_ADJ_QTY,					--주문확정 수량(박스)
				TB.PIECE_QTY,					--주문신청 수량(낱봉)
				TB.PIECE_ADJ_QTY,				--주문확정 수량(낱봉)
				GETDATE(),
				'0',
				GETDATE(),
				'0' 
			FROM (
				SELECT 
					SOR5.ORDER_DT,						--주문 시퀀스
					TAM.AGEN_SEQ,						--대리점 시퀀스
					PTBL.PRD_DTL_SEQ,					--제품 상세 시퀀스
					ISNULL(SOR4.SALESMAN_CODE, 0) AS 'EMPL_SEQ',		--대리점 판매자 시퀀스
					ISNULL(SOR5.BOX_QTY, 0) AS 'BOX_QTY',				--주문신청 수량(박스)
					ISNULL(SOR5.CR_ADJ_QTY, 0) AS 'CR_ADJ_QTY', 		--주문확정 수량(박스)		
					ISNULL(SOR5.PIECE_QTY, 0) AS 'PIECE_QTY',			--주문신청 수량(낱봉)
					ISNULL(SOR5.PIECE_ADJ_QTY, 0) AS 'PIECE_ADJ_QTY'	--주문확정 수량(낱봉)	
				FROM
					PARMS.NAMYANG.DBO.SMORDR05 SOR5 INNER JOIN PARMS.NAMYANG.DBO.SMORDR04 SOR4 ON SOR5.ORDER_DT = SOR4.ORDER_DT AND SOR5.CUST_CODE = SOR4.CUST_CODE  
					INNER JOIN DBO.T_AGEN_MST TAM ON SOR5.CUST_CODE = TAM.AGEN_CD AND TAM.SALE_CD = 'BA' AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
					INNER JOIN (
						SELECT
							TPD.PRD_DTL_SEQ,
							TPM.PRD_SAP_CD
						FROM
						T_PRD_DTL TPD 
						INNER JOIN T_PRD_MST TPM ON TPM.PRD_SEQ = TPD.PRD_SEQ
						WHERE
						1=1
					) PTBL ON PTBL.PRD_SAP_CD = SOR5.PROD_CODE
			) TB 
			INNER JOIN T_ORD_MST ORM ON ORM.ORD_DT = TB.ORDER_DT AND ORM.AGEN_SEQ = TB.AGEN_SEQ
		END

		/*21. 배송 정보:윤주원 과장님이 배송은 sap에있어서 가져올 필요가 없다 했지만 데이터를 위해 마이그레이션함*/
		BEGIN
			INSERT INTO	T_ORD_DLV(
				DLV_SEQ,				--배송 시퀀스
				ORD_SEQ,				--주문 시퀀스
				AGEN_SEQ,				--대리점 시퀀스
				WARE_NM,				--창고명
				CAR_NO,					--차량번호
				DRIV_NM,				--기사명
				PRAT_TM,				--예정시간
				START_TM,				--출발시간
				TEL_NO,					--연락처
				COS_DT,					--배송일
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ
			)	
			SELECT 
				NEXT VALUE FOR SQ_DLV,	--배송 시퀀스
				'0',					--주문 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
				TB.*,
				GETDATE(),
				'0',
				GETDATE(),
				'0' 
			FROM (
				SELECT DISTINCT 
					TAM.AGEN_SEQ,									--대리점 시퀀스
					OFFICE_CODE,									--창고명
					CAR_NO,											--차량번호
					dbo.F_GET_ENCRYT(CAR_DRIVER) AS CAR_DRIVER,		--기사명
					ARRIVE_DATE,									--예정시간
					LEAVE_DATE,										--출발시간
					REPLACE(REPLACE(CAR_DRIVER_PHONE, '-',''), ' ','') AS CAR_DRIVER_PHONE,		--연락처	
					DELIVER_DATE									--배송일	
				FROM
				PARMS.NAMYANG.DBO.LGDELV10 DEL INNER JOIN T_AGEN_MST TAM ON DEL.CUST_CODE = TAM.AGEN_CD AND TAM.SALE_CD = 'BA' AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
				INNER JOIN (
							SELECT
								TPD.PRD_DTL_SEQ,
								TPM.PRD_SAP_CD
							FROM
							T_PRD_DTL TPD 
							INNER JOIN T_PRD_MST TPM ON TPM.PRD_SEQ = TPD.PRD_SEQ
							WHERE
							1=1
						) PTBL ON PTBL.PRD_SAP_CD = DEL.PROD_CODE 
				--WHERE DEL.CAR_NO IS NOT NULL AND DEL.CAR_DRIVER IS NOT NULL AND DEL.CAR_DRIVER_PHONE IS NOT NULL 	이 조건 넣을지..???						
			) TB
		END


		/*22. 배송 상세*/
		BEGIN
			INSERT INTO T_ORD_DLV_DTL
			(
				DLV_DTL_SEQ,						--배송 상세 시퀀스
				AGEN_SEQ,							--대리점 시퀀스
				ORD_SEQ,							--주문 시퀀스
				DLV_SEQ,							--배송 시퀀스
				ORD_PRD_SEQ,						--주문 제품 시퀀스
				UNTPC,								--단가
				BOX_DLV_QTY,							--박스-배송
				IDDY_DLV_QTY,							--낱봉-배송
				TAXT,								--과세
				TXET,								--면세
				RETN_YN,							--반송 여부
				CRTB_CD,							--크레이트-코드
				CRTB_DLV_QTY,							--크레이트-배송
				CRTB_RETN_QTY,							--크레이트-반송
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)	
			SELECT 
				NEXT VALUE FOR SQ_DLV_DTL,					--배송 상세 시퀀스
				TB.AGEN_SEQ, 								--대리점 시퀀스
				'0' AS ORD_SEQ,								--주문 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
				TB.DLV_SEQ,									--배송 시퀀스
				PDL.PRD_DTL_SEQ AS	ORD_PRD_SEQ,			--주문 제품 시퀀스 ** 제품테이블하고 조인해야할거 같은데, 조인 조건&컬럼 모르겠음!!!!
				CONVERT(NUMERIC(13,2), TB.UNIT_PRICE) AS UNIT_PRICE,					--단가
				CONVERT(NUMERIC(13), (CONVERT(NUMERIC(13), TB.QUANTITY_PIECE) / CONVERT(NUMERIC(13), TB.UNIT_QTY))) AS BOX_DLV_QTY,		--박스-배송
				CONVERT(NUMERIC(13), (CONVERT(NUMERIC(13), TB.QUANTITY_PIECE) % CONVERT(NUMERIC(13), TB.UNIT_QTY))) AS IDDY_DLV_QTY,	--낱봉-배송
				CONVERT(NUMERIC(13,2), TB.PRICE) AS PRICE,	--과세
				CONVERT(NUMERIC(13,2), TB.VAT) AS VAT,		--면세
				'0' AS RETN_YN,								--반송 여부 : 0 배송 1 반송
				TB.CRATE_CODE,								--크레이트-코드
				CONVERT(NUMERIC(5), TB.QUANTITY_CRATE) AS CRTB_DLV_QTY,	--크레이트-배송
				'0' AS CRTB_RETN_QTY,											--크레이트-반송
				GETDATE() AS REG_DTM,
				'0' AS REG_SEQ,
				GETDATE() AS UPD_DTM,
				'0'  AS UPD_SEQ			
			FROM (
		
				SELECT 
					DEL.PROD_CODE,
					DEL.UNIT_PRICE,
					DEL.QUANTITY_PIECE,
					DEL.UNIT_QTY,
					DEL.PRICE, 
					DEL.VAT,
					DEL.CRATE_CODE, 
					DEL.QUANTITY_CRATE,
					DTL.AGEN_SEQ, DTL.DLV_SEQ
				FROM 
				(
					SELECT 
						DTL.DLV_SEQ, 
						DTL.AGEN_SEQ, 
						DTL.COS_DT, 
						DTL.WARE_NM,
						DTL.CAR_NO,
						DTL.DRIV_NM,
						DTL.PRAT_TM,
						DTL.START_TM,
						DTL.TEL_NO,
						TAM.AGEN_CD 
					FROM 
					T_ORD_DLV DTL,  T_AGEN_MST TAM 
					WHERE DTL.AGEN_SEQ = TAM.AGEN_SEQ
					AND TAM.SALE_CD = 'BA' 
					AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
				) DTL
				INNER JOIN PARMS.NAMYANG.DBO.LGDELV10 DEL ON DEL.DELIVER_DATE = DTL.COS_DT 
																	AND DEL.CUST_CODE = DTL.AGEN_CD
															 		AND DEL.OFFICE_CODE = DTL.WARE_NM
																	AND DEL.CAR_NO = DTL.CAR_NO
																	AND DEL.CAR_DRIVER = DTL.DRIV_NM
																	AND ISNULL(DEL.ARRIVE_DATE,0) = ISNULL(DTL.PRAT_TM,0)
																	AND ISNULL(DEL.LEAVE_DATE,0) = ISNULL(DTL.START_TM,0)
																	AND REPLACE(REPLACE(DEL.CAR_DRIVER_PHONE, '-', ''), ' ', '') = DTL.TEL_NO
																					 
			) TB  INNER JOIN (
				SELECT
					TPD.PRD_DTL_SEQ,
					TPM.PRD_SAP_CD
				FROM
				T_PRD_DTL TPD 
				INNER JOIN T_PRD_MST TPM ON TPM.PRD_SEQ = TPD.PRD_SEQ
				WHERE
				1=1
			) PDL ON PDL.PRD_SAP_CD = TB.PROD_CODE
		END


		/*23. 매입 마스터*/
		BEGIN
			INSERT	INTO	T_ORD_STUS_MST
			(
				ORD_STUS_SEQ,	--매입/반품/반송 시퀀스
				AGEN_SEQ,		--대리점 시퀀스
				ORD_SEQ,		--주문 시퀀스
				ORD_PRD_SEQ,	--주문 제품 시퀀스	
				PRD_DTL_SEQ,	--제품 상세 시퀀스
				--EMPL_SEQ,		--대리점 판매자 시퀀스
				ORD_STUS_CD,	--매입/반품/반송 구분
				ORD_STUS_DT,	--매입/반품/반송일
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)
			SELECT 
				NEXT VALUE FOR SQ_ORD_STUS,			--매입/반품/반송 시퀀스
				TB.*,
				GETDATE(),
				'0',
				GETDATE(),
				'0' 
			FROM (
				SELECT DISTINCT 
					TAM.AGEN_SEQ,								--대리점 시퀀스
					'0' AS ORD_SEQ,								--주문 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
					'0' AS ORD_PRD_SEQ,							--주문 제품 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
					PTBL.PRD_DTL_SEQ,							--제품 상세 시퀀스
					--'99' AS EMPL_SEQ,							--대리점 판매자 시퀀스(알수 없어서 99로 데이터 넣음)
					'PCHA' AS ORD_STUS_CD,						--매입/반품/반송 구분
					DELIVER_DATE								--매입/반품/반송일	
				FROM
				PARMS.NAMYANG.DBO.LGDELV10 DEL INNER JOIN T_AGEN_MST TAM ON DEL.CUST_CODE = TAM.AGEN_CD AND TAM.SALE_CD = 'BA' AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
				INNER JOIN (
							SELECT
								TPD.PRD_DTL_SEQ,
								TPM.PRD_SAP_CD
							FROM
							T_PRD_DTL TPD 
							INNER JOIN T_PRD_MST TPM ON TPM.PRD_SEQ = TPD.PRD_SEQ
							WHERE
							1=1
						) PTBL ON PTBL.PRD_SAP_CD = DEL.PROD_CODE 
			) TB     
		END


		/*24. 매입 제품*/
		BEGIN
			INSERT	INTO	T_ORD_STUS_PRD
			(
				ORD_STUS_PRD_SEQ,	--매입/반품/반송 제품 시퀀스
				ORD_PRD_SEQ,		--주문 제품 시퀀스
				PRD_DTL_SEQ,		--제품 상세 시퀀스
				--EMPL_SEQ,			--대리점 판매자 시퀀스
				ORD_STUS_SEQ,		--매입/반품/반송 시퀀스
				AGEN_SEQ,			--대리점 시퀀스
				ORD_SEQ,			--주문 시퀀스
				IDDY_QTY,				--매입/반품/반송 수량
				UNTPC,				--매입/반품/반송 단가
				CRTB_CD,			--크레이트
				CRTB_QTY,			--크레이트 수량
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)	
			SELECT 
				NEXT VALUE FOR SQ_ORD_STUS_PRD,				--매입/반품/반송 제품 시퀀스
				'0' AS ORD_PRD_SEQ,							--주문 제품 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
				TB.PRD_DTL_SEQ,								--제품 상세 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
				--'99' AS EMPL_SEQ,							--대리점 판매자 시퀀스(알 수 없어서 99으로 설정함)
				TB.ORD_STUS_SEQ,							--매입/반품/반송 시퀀스
				TB.AGEN_SEQ, 								--대리점 시퀀스
				'0' AS ORD_SEQ,								--주문 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
				TB.QUANTITY_PIECE,							--매입/반품/반송 수량
				TB.UNIT_PRICE,								--매입/반품/반송 단가
				TB.CRATE_CODE,								--크레이트
				TB.QUANTITY_CRATE,							--크레이트 수량
				GETDATE() AS REG_DTM,
				'0' AS REG_SEQ,
				GETDATE() AS UPD_DTM,
				'0'  AS UPD_SEQ			
			FROM (
		
				SELECT 
					DTL.AGEN_SEQ, 
					DTL.ORD_STUS_SEQ,		
					DTL.PRD_DTL_SEQ,
					DEL.QUANTITY_PIECE,
					DEL.QUANTITY_CRATE,		
					DEL.UNIT_PRICE,
					DEL.CRATE_CODE
				FROM 
				(
					SELECT  
						TOSM.ORD_STUS_SEQ, 
						TOSM.AGEN_SEQ, 
						TOSM.ORD_STUS_DT, 
						TOSM.PRD_DTL_SEQ, 
						TAM.AGEN_CD
					FROM 
					T_ORD_STUS_MST TOSM,  T_AGEN_MST TAM 
					WHERE TOSM.AGEN_SEQ = TAM.AGEN_SEQ
					AND TOSM.ORD_STUS_CD = 'PCHA' 
					AND TAM.SALE_CD = 'BA' 
					AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
				) DTL
				INNER JOIN PARMS.NAMYANG.DBO.LGDELV10 DEL ON DEL.DELIVER_DATE = DTL.ORD_STUS_DT AND DEL.CUST_CODE = DTL.AGEN_CD
				INNER JOIN (
					SELECT
						TPD.PRD_DTL_SEQ,
						TPM.PRD_SAP_CD
					FROM
					T_PRD_DTL TPD 
					INNER JOIN T_PRD_MST TPM ON TPM.PRD_SEQ = TPD.PRD_SEQ
					WHERE
					1=1
				) PDL ON PDL.PRD_SAP_CD = DEL.PROD_CODE AND PDL.PRD_DTL_SEQ = DTL.PRD_DTL_SEQ
			) TB  
		END

		/*25. 반송 마스터*/
		BEGIN
			INSERT	INTO	T_ORD_STUS_MST
			(
				ORD_STUS_SEQ,	--매입/반품/반송 시퀀스
				AGEN_SEQ,		--대리점 시퀀스
				ORD_SEQ,		--주문 시퀀스
				ORD_PRD_SEQ,	--주문 제품 시퀀스	
				PRD_DTL_SEQ,	--제품 상세 시퀀스
				--EMPL_SEQ,		--대리점 판매자 시퀀스
				ORD_STUS_CD,	--매입/반품/반송 구분
				ORD_STUS_DT,	--매입/반품/반송일
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)
			SELECT 
				NEXT VALUE FOR SQ_ORD_STUS,			--매입/반품/반송 시퀀스
				TB.*,
				GETDATE(),
				'0',
				GETDATE(),
				'0' 
			FROM (
				SELECT DISTINCT 
					TAM.AGEN_SEQ,								--대리점 시퀀스
					'0' AS ORD_SEQ,								--주문 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
					'0' AS ORD_PRD_SEQ,							--주문 제품 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
					PTBL.PRD_DTL_SEQ,							--제품 상세 시퀀스
					--'99' AS EMPL_SEQ,							--대리점 판매자 시퀀스(알수 없어서 99로 데이터 넣음)
					'RET' AS ORD_STUS_CD,						--매입/반품/반송 구분
					DELIVER_DATE								--매입/반품/반송일	
				FROM
				PARMS.NAMYANG.DBO.LGDELV10_RET DEL INNER JOIN T_AGEN_MST TAM ON DEL.CUST_CODE = TAM.AGEN_CD AND TAM.SALE_CD = 'BA' AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
				INNER JOIN (
							SELECT
								TPD.PRD_DTL_SEQ,
								TPM.PRD_SAP_CD
							FROM
							T_PRD_DTL TPD 
							INNER JOIN T_PRD_MST TPM ON TPM.PRD_SEQ = TPD.PRD_SEQ
							WHERE
							1=1
						) PTBL ON PTBL.PRD_SAP_CD = DEL.PROD_CODE 
			) TB
		END


		/*26. 반송 제품*/
		BEGIN
			INSERT	INTO	T_ORD_STUS_PRD
			(
				ORD_STUS_PRD_SEQ,	--매입/반품/반송 제품 시퀀스
				ORD_PRD_SEQ,		--주문 제품 시퀀스
				PRD_DTL_SEQ,		--제품 상세 시퀀스
				--EMPL_SEQ,			--대리점 판매자 시퀀스
				ORD_STUS_SEQ,		--매입/반품/반송 시퀀스
				AGEN_SEQ,			--대리점 시퀀스
				ORD_SEQ,			--주문 시퀀스
				IDDY_QTY,				--매입/반품/반송 수량
				UNTPC,				--매입/반품/반송 단가
				CRTB_CD,			--크레이트
				CRTB_QTY,			--크레이트 수량
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)	
			SELECT 
				NEXT VALUE FOR SQ_ORD_STUS_PRD,				--매입/반품/반송 제품 시퀀스
				'0' AS ORD_PRD_SEQ,							--주문 제품 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
				TB.PRD_DTL_SEQ,								--제품 상세 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
				--'99' AS EMPL_SEQ,							--대리점 판매자 시퀀스(알 수 없어서 99으로 설정함)
				TB.ORD_STUS_SEQ,							--매입/반품/반송 시퀀스
				TB.AGEN_SEQ, 								--대리점 시퀀스
				'0' AS ORD_SEQ,								--주문 시퀀스(출고테이블에서 주문연동정보 알 수 없어서 0으로 설정함)
				TB.RTN_QTY_C,								--매입/반품/반송 수량
				TB.UNIT_PRICE,								--매입/반품/반송 단가
				TB.CRATE_CODE,								--크레이트
				TB.QUANTITY_CRATE,							--크레이트 수량
				GETDATE() AS REG_DTM,
				'0' AS REG_SEQ,
				GETDATE() AS UPD_DTM,
				'0'  AS UPD_SEQ			
			FROM (
		
				SELECT 
					DTL.AGEN_SEQ, 
					DTL.ORD_STUS_SEQ,		
					DTL.PRD_DTL_SEQ,
					DEL.RTN_QTY_C,		
					DEL.UNIT_PRICE,
					DELV.CRATE_CODE,
					DELV.QUANTITY_CRATE
				FROM 
				(
					SELECT  
						TOSM.ORD_STUS_SEQ, 
						TOSM.AGEN_SEQ, 
						TOSM.ORD_STUS_DT, 
						TOSM.PRD_DTL_SEQ, 
						TAM.AGEN_CD
					FROM 
					T_ORD_STUS_MST TOSM,  T_AGEN_MST TAM 
					WHERE TOSM.AGEN_SEQ = TAM.AGEN_SEQ
					AND TOSM.ORD_STUS_CD = 'RET' 
					AND TAM.SALE_CD = 'BA' 
					AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
				) DTL
				INNER JOIN PARMS.NAMYANG.DBO.LGDELV10_RET DEL ON DEL.DELIVER_DATE = DTL.ORD_STUS_DT AND DEL.CUST_CODE = DTL.AGEN_CD
				LEFT JOIN PARMS.NAMYANG.DBO.LGDELV10 DELV ON DEL.DELIVER_DATE = DELV.DELIVER_DATE 
																		  AND DEL.OFFICE_CODE = DELV.OFFICE_CODE 
																		  AND DEL.SLIP_NO = DELV.ORD_NO 
																		  AND DEL.PROD_CODE = DELV.PROD_CODE 	
				INNER JOIN (
					SELECT
						TPD.PRD_DTL_SEQ,
						TPM.PRD_SAP_CD
					FROM
					T_PRD_DTL TPD 
					INNER JOIN T_PRD_MST TPM ON TPM.PRD_SEQ = TPD.PRD_SEQ
					WHERE
						1=1
				) PDL ON PDL.PRD_SAP_CD = DEL.PROD_CODE AND PDL.PRD_DTL_SEQ = DTL.PRD_DTL_SEQ
			) TB  
		END

		/*27. 반품 정보*/
		BEGIN
			INSERT	INTO	T_ORD_RTGD
			(
				ORD_RTGD_SEQ,		--반품 시퀀스
				AGEN_SEQ,			--대리점 시퀀스
				--EMPL_SEQ,			--대리점 사원 시퀀스
				PRD_DTL_SEQ,		--제품 상세 시퀀스
				--REQ_YM,				--반품의뢰월
				REQ_IDDY_QTY,			--반품의뢰수량(낱봉)
				UNTPC,				--반품단가
				SPPRC,				--반품금액
				VAT_SPPRC,			--반품금액 VAT
				ORD_STUS_CD,			--반품유형
				TRNST_YN,			--전송여부
				REQ_DT,				--의뢰일자
				DCSN_YN,			--확정여부
				DCSN_QTY,			--반품확정수량
				DCSN_DT,			--확정일자
				REG_DTM,
				REG_SEQ,
				UPD_DTM,
				UPD_SEQ)
			SELECT
				NEXT VALUE FOR SQ_ORD_RTGD,			--반품 시퀀스
				TAM.AGEN_SEQ,						--대리점 시퀀스
				--'99' AS EMPL_SEQ,					--대리점 사원 시퀀스
				PTBL.PRD_DTL_SEQ,					--제품 상세 시퀀스
				--TB.REQ_MONTH,						--반품의뢰월
				TB.TOT_REQ_QTY,						--반품의뢰수량
				0 AS UNTPC,							--반품단가
				0 AS SPPRC,						--반품금액
				0 AS VAT_SPPRC,					--반품금액 VAT
				'RTGD' AS ORD_STUS_CD,						--반품유형
				CASE WHEN TB.XSTAT = 'R' THEN 'Y'
					ELSE 'N'
				END TRNST_YN,						--전송여부(마이그레이션 데이터 전송여부 데이터 없어서 XSTAT값으로 판단함)
				TB.ZCONF_DATE2,	--의뢰일자
				CASE WHEN TB.XSTAT = 'R' THEN 'Y'
					ELSE 'N'
				END DCSN_YN,						--확정여부(XSTAT 컬럼값이 'R'일때 수신으로 판단하여 컬럼값 설정, 추후 EAI 전송코드값 확인하기)
				TB.TOT_CONFIRM_QTY,					--반품확정수량
				CONVERT(DATETIME, CONCAT(TB.XDATS, ' ', CONCAT(SUBSTRING(TB.XTIMS,1,2), ':', SUBSTRING(TB.XTIMS,3,2), ':', SUBSTRING(TB.XTIMS,5,2)))),	--확정일자		
				GETDATE(),
				'0',
				GETDATE(),
				'0' 	
			FROM
				PARMS.NAMYANG.DBO.SMORDR04_2 TB 
				INNER JOIN DBO.T_AGEN_MST TAM ON TB.CUST_CODE = TAM.AGEN_CD 
												AND TAM.SALE_CD = 'BA' 
												AND TAM.AGEN_SEQ = @V_AGEN_SEQ 
				INNER JOIN (
					SELECT
						TPD.PRD_DTL_SEQ,
						TPM.PRD_SAP_CD
					FROM
					T_PRD_DTL TPD 
					INNER JOIN T_PRD_MST TPM ON TPM.PRD_SEQ = TPD.PRD_SEQ
					WHERE
						1=1
				) PTBL ON PTBL.PRD_SAP_CD = TB.PROD_CODE 
			WHERE ORD_TYPE = 'YR01'	
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
;
