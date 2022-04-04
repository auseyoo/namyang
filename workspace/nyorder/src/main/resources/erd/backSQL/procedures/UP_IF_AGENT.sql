USE [NY_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[UP_IF_AGENT]    Script Date: 2022-03-28 오후 2:31:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[UP_IF_AGENT]
( 
    @IFGNUM       NVARCHAR(12)     --일련번호
)
AS
BEGIN
  ----------------------------------------------------------------------------------
  -- Author     : 김동주
  -- Create Date: 2022-03-25
  -- Description: IF_AGENT 대리점(고객)I/F 처리
  -- 수신상태  - R:수신완료(PO세팅), P:수신 측 처리작업 중, S:수신 측 처리완료, E:수신 측 에러
  ----------------------------------------------------------------------------------

  SET NOCOUNT ON;
  
  DECLARE
   	@V_AGEN_CD			NVARCHAR(20)	
	, @V_AGEN_NM		NVARCHAR(60)
	, @V_AGEN_FUL_NM	NVARCHAR(60)
	, @V_BSN_ORGZ		NVARCHAR(20)
	, @V_CST_GRP		NVARCHAR(20)
	, @V_SALE_ZONE		NVARCHAR(20)
	, @V_PC_DECSN		NVARCHAR(20)
	, @V_ACCT_GRP		NVARCHAR(20)
	, @V_PRD_SAP_TYPE	NVARCHAR(20)
	, @V_BHFC_AGEN_CD	NVARCHAR(20)
	, @V_BIZ_NO			VARCHAR(10)
	, @V_JUR_NO			VARCHAR(13)
	, @V_SALE_CD		NVARCHAR(20)
	, @V_AGEN_PRST		VARBINARY(256)
	, @V_BIZ_CON		NVARCHAR(100)
	, @V_BIZ_INDU		NVARCHAR(100)
	, @V_ZIP_CD			VARCHAR(6)
	, @V_ADDR1			NVARCHAR(200)
	, @V_TEL_NO			VARBINARY(256)
	, @V_PRST_TEL_NO	VARBINARY(256)
	, @V_FAX_NO			VARBINARY(256)
	, @V_AGEN_EML		NVARCHAR(100)
	, @V_AGEN_USE_YN	VARCHAR(1)
	, @V_CLS_DE			VARCHAR(2)
	, @V_CLS_TM			VARCHAR(4)
	, @V_DELG_END_DT	VARCHAR(8)
	, @V_AGEN_TYPE1		NVARCHAR(20)
	, @V_AGEN_TYPE2		NVARCHAR(20)
	, @V_AGEN_TYPE3		NVARCHAR(20)
	, @V_IFFLAG			NVARCHAR(1)
    , @V_IFDATE	    	NVARCHAR(8)
    , @V_IFTIME	    	NVARCHAR(6)
    , @V_IFUSER	    	NVARCHAR(12)
    , @V_IFSYS          NVARCHAR(8)     = 'OOS'   --대리점상온주문시스템       
    , @V_RTN_IFDATE     NVARCHAR(8)
    , @V_RTN_IFTIME     NVARCHAR(6)
    , @V_ERRMSG         NVARCHAR(1000)
    , @V_MODPGMID       NVARCHAR(30)    = 'IF_AGENT'
    , @V_ERROR_LINE     INT
    , @V_ERROR_MESSAGE  NVARCHAR(2048)
    , @V_ERROR_NUMBER   INT
    , @V_ERROR_PROCEDURE	NVARCHAR(300)
    , @V_ERROR_SEVERITY INT
    , @V_ERROR_STATE    INT
	

	/*1.EAI에서 전송 된 DATA를 'R' -> 'P' 상태변환 */
	BEGIN
		UPDATE IF_AGENT
			SET XSTAT = 'P'
		WHERE 
			1=1
			AND IFGNUM = @IFGNUM
			AND XSTAT = 'R'; 
	END;     

	/*2. 암호화 펑션 사용*/
	BEGIN
		EXEC P_OPEN_KEY
	END 

	BEGIN TRAN   
	SAVE TRAN SAVE_UP_TRAN;
	
	
	BEGIN TRY
		/*3.커서선언*/		
		BEGIN
			DECLARE CUR_1 CURSOR FOR
				SELECT 
					KUNNR		AS AGEN_CD		/*AGEN_CD*/		
					, NAME1		AS AGEN_NM		/*AGEN_NM*/
					, NAME2		AS AGEN_FUL_NM	/*AGEN_FUL_NM*/
					, VKORG		AS BSN_ORGZ		/*BSN_ORGZ 영업조직*/
					, KDGRP 	As CST_GRP		/*CST_GRP 고객그룹*/
					, BZIRK		AS SALE_ZONE	/*SALE_ZONE 지점*/
					, KALKS		AS PC_DECSN		/*PC_DECSN 가격결정구분*/
					, KTOKD		AS ACCT_GRP		/*ACCT_GRP 계정그룹*/
					, SPART		AS PRD_SAP_TYPE	/*PRD_SAP_TYPE 제품군*/
					, REPLICATE('0',6 - LEN(PARVW_SE)) + PARVW_SE AS BHFC_AGEN_CD	/*BHFC_AGEN_CD 대리점 담당자*/
					, STCD2		AS BIZ_NO		/*BIZ_NO 대리점 사업자번호*/
					, STCD1		AS JUR_NO		/*JUR_NO 대리점 법인번호*/
					, case
    					WHEN KVGR2 = '220' THEN 'BA'
						WHEN KVGR2 = '210' THEN 'SI'
						WHEN KVGR2 = '110' THEN 'SA'
						WHEN KVGR2 = '120' THEN 'SA'
						WHEN KVGR2 = '130' THEN 'SA'
						WHEN KVGR2 = '230' THEN 'SA'
						WHEN KVGR2 = '240' THEN 'SA'
						WHEN KVGR2 = '250' THEN 'SA'
						WHEN KVGR2 = '260' THEN 'SA'
						ELSE 'ETC'
					 END AS SALE_CD	
					, NY_ORDER.dbo.F_GET_ENCRYT(J_1KFREPRE)	AS AGEN_PRST	/*암호화 대표자명 AGEN_PRST*/
					, J_1KFTBUS		AS BIZ_CON		/*업태 BIZ_CON*/
					, J_1KFTIND		AS BIZ_INDU		/*업종 BIZ_INDU*/
					, POST_CODE1 	AS ZIP_CD		/*우편번호 ZIP_CD*/
					, CITY1 		AS ADDR1		/*주소 ADDR1*/
					, NY_ORDER.dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(TELF1)) AS TEL_NO		/*전화번호 TEL_NO*/
					, NY_ORDER.dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(TELF2)) AS PRST_TEL_NO	/*대표자 전화번호 PRST_TEL_NO*/
					, NY_ORDER.dbo.F_GET_ENCRYT(NY_ORDER.dbo.F_TRAN_NO(TELFX)) AS FAX_NO		/*팩스번호 FAX_NO*/
					, SMTP_ADDR 	AS AGEN_EML		/*이메일 주소 AGEN_EML*/
					, 'Y' 			AS AGEN_USE_YN
					, ZZORDSYS 		AS CLS_DE		/*마감일 CLS_DE*/
					, SUBSTRING(ZZCLOSE,1,4) AS  CLS_TM		/*마감시간 CLS_TM*/
					, CASE WHEN ZZDATBI_DL = '00000000' THEN NULL ELSE ZZDATBI_DL END AS DELG_END_DT -- SAP에선 일자가 공백이 아니라 '00000000'으로 관리되어 NULL로 치환 함(2019.06.27)
					, KVGR1 AS AGEN_TYPE1
					, KVGR2 AS AGEN_TYPE2
					, KVGR3 AS AGEN_TYPE3
					, IFFLAG 
					, IFDATE 
					, IFTIME
					, IFUSER
				FROM IF_AGENT(NOLOCK)
				WHERE 
					1=1
					AND IFGNUM = @IFGNUM
					AND XSTAT = 'P';
			OPEN CUR_1;
			FETCH NEXT FROM CUR_1 
				INTO @V_AGEN_CD		
					, @V_AGEN_NM		
					, @V_AGEN_FUL_NM	
					, @V_BSN_ORGZ		
					, @V_CST_GRP		
					, @V_SALE_ZONE	
					, @V_PC_DECSN		
					, @V_ACCT_GRP		
					, @V_PRD_SAP_TYPE	
					, @V_BHFC_AGEN_CD	
					, @V_BIZ_NO		
					, @V_JUR_NO		
					, @V_SALE_CD		
					, @V_AGEN_PRST	
					, @V_BIZ_CON		
					, @V_BIZ_INDU		
					, @V_ZIP_CD		
					, @V_ADDR1		
					, @V_TEL_NO		
					, @V_PRST_TEL_NO	
					, @V_FAX_NO		
					, @V_AGEN_EML		
					, @V_AGEN_USE_YN	
					, @V_CLS_DE		
					, @V_CLS_TM		
					, @V_DELG_END_DT
					, @V_AGEN_TYPE1
					, @V_AGEN_TYPE2
					, @V_AGEN_TYPE3
					, @V_IFFLAG
					, @V_IFDATE
					, @V_IFTIME
					, @V_IFUSER;
			WHILE @@FETCH_STATUS = 0    
		/*4.대리점정보 MERGE*/
		BEGIN   
			MERGE T_AGEN_MST AS A 
			USING (SELECT  
						@V_AGEN_CD			AS AGEN_CD
						, @V_AGEN_NM		AS AGEN_NM
						, @V_AGEN_FUL_NM	AS AGEN_FUL_NM
						, @V_BSN_ORGZ		AS BSN_ORGZ
						, @V_CST_GRP		AS CST_GRP
						, @V_SALE_ZONE		AS SALE_ZONE
						, @V_PC_DECSN		AS PC_DECSN
						, @V_ACCT_GRP		AS ACCT_GRP
						, @V_PRD_SAP_TYPE	AS PRD_SAP_TYPE
						, @V_BHFC_AGEN_CD	AS BHFC_AGEN_CD
						, @V_BIZ_NO			AS BIZ_NO
						, @V_JUR_NO			AS JUR_NO
						, @V_SALE_CD		AS SALE_CD
						, @V_AGEN_PRST		AS AGEN_PRST
						, @V_BIZ_CON		AS BIZ_CON
						, @V_BIZ_INDU		AS BIZ_INDU
						, @V_ZIP_CD			AS ZIP_CD
						, @V_ADDR1			AS ADDR1
						, @V_TEL_NO			AS TEL_NO
						, @V_PRST_TEL_NO	AS PRST_TEL_NO
						, @V_FAX_NO			AS FAX_NO
						, @V_AGEN_EML		AS AGEN_EML
						, @V_AGEN_USE_YN	AS AGEN_USE_YN
						, @V_CLS_DE			AS CLS_DE
						, @V_CLS_TM			AS CLS_TM
						, @V_DELG_END_DT	AS DELG_END_DT
						, @V_AGEN_TYPE1		AS AGEN_TYPE1
						, @V_AGEN_TYPE2		AS AGEN_TYPE2
						, @V_AGEN_TYPE3		AS AGEN_TYPE3
						, @V_IFFLAG			AS IFFLAG
						, @V_IFDATE			AS IFDATE
						, @V_IFTIME			AS IFTIME
						, @V_IFUSER			AS IFUSER
			) AS B
			ON (A.AGEN_CD = B.AGEN_CD)
			WHEN MATCHED THEN 
                UPDATE SET 
						A.AGEN_CD	     	= B.AGEN_CD	               
						, A.AGEN_NM		 	= B.AGEN_NM		           
						, A.AGEN_FUL_NM		= B.AGEN_FUL_NM              
						, A.BSN_ORGZ		= B.BSN_ORGZ                 
						, A.CST_GRP			= B.CST_GRP                  
						, A.SALE_ZONE		= B.SALE_ZONE                
						, A.PC_DECSN		= B.PC_DECSN                 
						, A.ACCT_GRP		= B.ACCT_GRP                 
						, A.PRD_SAP_TYPE	= B.PRD_SAP_TYPE
						, A.BHFC_AGEN_CD	= B.BHFC_AGEN_CD             
						, A.BIZ_NO			= B.BIZ_NO                   
						, A.JUR_NO			= B.JUR_NO                   
						, A.SALE_CD			= B.SALE_CD                  
						, A.AGEN_PRST		= B.AGEN_PRST                
						, A.BIZ_CON			= B.BIZ_CON                  
						, A.BIZ_INDU		= B.BIZ_INDU                 
						, A.ZIP_CD			= B.ZIP_CD                   
						, A.ADDR1			= B.ADDR1                    
						, A.TEL_NO			= B.TEL_NO                   
						, A.PRST_TEL_NO		= B.PRST_TEL_NO              
						, A.FAX_NO			= B.FAX_NO                   
						, A.AGEN_EML		= B.AGEN_EML                 
						, A.AGEN_USE_YN		= B.AGEN_USE_YN              
						, A.CLS_DE			= B.CLS_DE                   
						, A.CLS_TM			= B.CLS_TM                   
						, A.DELG_END_DT		= B.DELG_END_DT   
						, A.AGEN_TYPE1		= B.AGEN_TYPE1
						, A.AGEN_TYPE2		= B.AGEN_TYPE2
						, A.AGEN_TYPE3		= B.AGEN_TYPE3
						, A.UPD_SEQ			= 0
						, A.UPD_DTM			= GETDATE()
			WHEN NOT MATCHED THEN 
				INSERT (
					AGEN_CD
					, AGEN_NM
					, AGEN_FUL_NM
					, BSN_ORGZ
					, CST_GRP
					, SALE_ZONE
					, PC_DECSN
					, ACCT_GRP
					, PRD_SAP_TYPE
					, BHFC_AGEN_CD
					, BIZ_NO
					, JUR_NO
					, SALE_CD
					, AGEN_PRST
					, BIZ_CON
					, BIZ_INDU
					, ZIP_CD
					, ADDR1
					, TEL_NO
					, PRST_TEL_NO
					, FAX_NO
					, AGEN_EML
					, AGEN_USE_YN
					, CLS_DE
					, CLS_TM
					, DELG_END_DT
					, AGEN_TYPE1
					, AGEN_TYPE2
					, AGEN_TYPE3
					, REG_DTM
					, REG_SEQ
					, UPD_DTM
					, UPD_SEQ
				) 
                VALUES (
					B.AGEN_CD
					, B.AGEN_NM
					, B.AGEN_FUL_NM
					, B.BSN_ORGZ
					, B.CST_GRP
					, B.SALE_ZONE
					, B.PC_DECSN
					, B.ACCT_GRP
					, B.PRD_SAP_TYPE
					, B.BHFC_AGEN_CD
					, B.BIZ_NO
					, B.JUR_NO
					, B.SALE_CD
					, B.AGEN_PRST
					, B.BIZ_CON
					, B.BIZ_INDU
					, B.ZIP_CD
					, B.ADDR1
					, B.TEL_NO
					, B.PRST_TEL_NO
					, B.FAX_NO
					, B.AGEN_EML
					, B.AGEN_USE_YN
					, B.CLS_DE
					, B.CLS_TM
					, B.DELG_END_DT	
					, B.AGEN_TYPE1
					, B.AGEN_TYPE2
					, B.AGEN_TYPE3
					, GETDATE()
					, 0
					, GETDATE()
					, 0
				);
                      
			/*
			4.ROLE권한 추가 
			MERGE SYUSERAUTH AS A 
			USING (SELECT  @V_KUNNR       AS USERID
                          ,'AGENT'        AS AUTHCD                        
                          ,'UP_IF_AGENT'  AS PGMID
                          ,'SYSTEM'       AS REGUSERID
            ) AS B
            ON (A.USERID = B.USERID)
             WHEN MATCHED THEN 
                  UPDATE SET A.AUTHCD         = B.AUTHCD
                            ,A.MODPGMID       = B.PGMID    
                            ,A.MODUSERID      = B.REGUSERID   
                            ,A.MODDATE        = GETDATE()
             WHEN NOT MATCHED THEN 
                  INSERT (USERID, AUTHCD
                        , REGPGMID, REGUSERID, REGDATE, MODPGMID, MODUSERID, MODDATE) 
                  VALUES (B.USERID, B.AUTHCD
                        , B.PGMID, B.REGUSERID, GETDATE(), B.PGMID, B.REGUSERID, GETDATE());
			*/                 
                     
			FETCH NEXT FROM CUR_1 
				INTO @V_AGEN_CD		
					, @V_AGEN_NM		
					, @V_AGEN_FUL_NM	
					, @V_BSN_ORGZ		
					, @V_CST_GRP		
					, @V_SALE_ZONE	
					, @V_PC_DECSN		
					, @V_ACCT_GRP		
					, @V_PRD_SAP_TYPE	
					, @V_BHFC_AGEN_CD	
					, @V_BIZ_NO		
					, @V_JUR_NO		
					, @V_SALE_CD		
					, @V_AGEN_PRST	
					, @V_BIZ_CON		
					, @V_BIZ_INDU		
					, @V_ZIP_CD		
					, @V_ADDR1		
					, @V_TEL_NO		
					, @V_PRST_TEL_NO	
					, @V_FAX_NO		
					, @V_AGEN_EML		
					, @V_AGEN_USE_YN	
					, @V_CLS_DE		
					, @V_CLS_TM		
					, @V_DELG_END_DT
					, @V_AGEN_TYPE1
					, @V_AGEN_TYPE2
					, @V_AGEN_TYPE3
					, @V_IFFLAG
					, @V_IFDATE
					, @V_IFTIME
					, @V_IFUSER;
				END;
			CLOSE CUR_1;
		DEALLOCATE CUR_1;         
      END; 
      
    /*완료 처리*/
	BEGIN
		UPDATE IF_AGENT 
			SET 
				XSTAT = 'S'
				, XERRMSG = ''
		WHERE IFGNUM = @IFGNUM
			AND XSTAT = 'P'; 
	END;
      
	SET  @V_RTN_IFDATE        = CONVERT(CHAR(8), GETDATE(), 112);
	SET  @V_RTN_IFTIME        = REPLACE(CONVERT (VARCHAR(8),GETDATE(), 108),':','');
      
	/*SAP 결과 리턴*/
	BEGIN
		MERGE IF_RSTLRTN AS A 
		USING (SELECT @IFGNUM         AS IFGNUM
                     ,@V_IFSYS        AS IFSYS
                     ,@V_RTN_IFDATE   AS IFDATE
                     ,@V_RTN_IFTIME   AS IFTIME
                     ,'ADMIN'         AS IFUSER
                     ,'S'             AS IFSTAT
                     ,'R'             AS XSTAT
		) AS B
		ON (A.IFGNUM = B.IFGNUM)
		WHEN MATCHED THEN 
			UPDATE SET 
				A.IFSYS		= B.IFSYS
				,A.IFDATE	= B.IFDATE
				,A.IFTIME	= B.IFTIME
				,A.IFUSER	= B.IFUSER
				,A.IFSTAT	= B.IFSTAT
				,A.XSTAT	= B.XSTAT
        WHEN NOT MATCHED THEN 
			INSERT (IFGNUM, IFSYS, IFDATE, IFTIME, IFUSER, IFSTAT , XSTAT) 
			VALUES (B.IFGNUM, B.IFSYS, B.IFDATE, B.IFTIME, B.IFUSER, B.IFSTAT , B.XSTAT); 
                          
		END;
      
	COMMIT TRAN;  -- 프로시저 내의 최초 TRANSACTION에 대해 COMMIT;
      
		END TRY
	BEGIN CATCH
		CLOSE CUR_1;
		DEALLOCATE CUR_1; 
    
	ROLLBACK TRAN SAVE_UP_TRAN; -- 에러시에 SAVE POINT로 이동
	COMMIT TRAN;  --최초 TRANSACTION 문에 대해 COMMIT (*** 내부프로시저에서 COMMIT은 해서 성공시킴 ***)
    
	SET @V_ERROR_LINE         = ERROR_LINE();       --오류가 발생한 줄번호
    SET @V_ERROR_MESSAGE      = ERROR_MESSAGE();    --오류의 메시지
    SET @V_ERROR_NUMBER       = ERROR_NUMBER();     --오류번호
    SET @V_ERROR_PROCEDURE    = ERROR_PROCEDURE();  --오류가 발생한 프로시저나 트리거
    SET @V_ERROR_SEVERITY     = ERROR_SEVERITY();   --오류의 심각도
    SET @V_ERROR_STATE        = ERROR_STATE();      --오류의 상태번호
    SET @V_ERRMSG = '고개코드:' + ISNULL(@V_AGEN_CD,'UNKNOWN')  
                        + ', 오류프로시저:' + @V_ERROR_PROCEDURE
                        + ', 오류줄번호:' + CAST(@V_ERROR_LINE AS NVARCHAR(100))
                        + ', 오류메세지:' + @V_ERROR_MESSAGE;
        
    SET  @V_RTN_IFDATE        = CONVERT(CHAR(8), GETDATE(), 112);
    SET  @V_RTN_IFTIME        = REPLACE(CONVERT (VARCHAR(8),GETDATE(), 108),':','');
    
    --에러저장
    BEGIN
      UPDATE IF_AGENT 
         SET XSTAT      = 'E'
            ,XERRMSG    = @V_ERRMSG
      WHERE IFGNUM      = @IFGNUM;
    END;
    
    --SAP에 결과 리턴(ERROR)
    BEGIN
      MERGE IF_RSTLRTN AS A 
        USING (SELECT @IFGNUM         AS IFGNUM
                     ,@V_IFSYS        AS IFSYS
                     ,@V_RTN_IFDATE   AS IFDATE
                     ,@V_RTN_IFTIME   AS IFTIME
                     ,'ADMIN'         AS IFUSER
                     ,'E'             AS IFSTAT
                     ,@V_ERRMSG       AS IFERRMSG
                     ,'R'             AS XSTAT
              ) AS B
           ON (A.IFGNUM = B.IFGNUM)
         WHEN MATCHED THEN 
              UPDATE SET A.IFSYS      = B.IFSYS
                        ,A.IFDATE     = B.IFDATE
                        ,A.IFTIME     = B.IFTIME
                        ,A.IFUSER     = B.IFUSER
                        ,A.IFSTAT     = B.IFSTAT
                        ,A.IFERRMSG   = B.IFERRMSG
                        ,A.XSTAT      = B.XSTAT
        WHEN NOT MATCHED THEN 
              INSERT (IFGNUM, IFSYS, IFDATE, IFTIME, IFUSER, IFSTAT, IFERRMSG, XSTAT) 
              VALUES (B.IFGNUM, B.IFSYS, B.IFDATE, B.IFTIME, B.IFUSER, B.IFSTAT, B.IFERRMSG, B.XSTAT); 
    
      /*
      INSERT INTO IF_RSTLRTN(IFGNUM, IFSYS
                           , IFDATE, IFTIME, IFUSER, IFSTAT, IFERRMSG
                           , XSTAT) 
                     VALUES (@IFGNUM, @V_IFSYS
                           , @V_RTN_IFDATE, @V_RTN_IFTIME, 'ADMIN',  'E', @V_ERRMSG
                           , 'R');
      */                           
    END;
  END CATCH;

END;