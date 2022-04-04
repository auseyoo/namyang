USE [NY_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[UP_IF_CMMNCD]    Script Date: 2022-03-28 오후 4:03:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[UP_IF_CMMNCD]
( 
    @IFGNUM       NVARCHAR(12)     --일련번호
)
AS
BEGIN

  ------------------------------------------------------------------------
  -- Author     : 김동주
  -- Create Date: 2022-03-29
  -- Description: IF_CMMNCD 공통코드 I/F 처리 SP
  -- 수신상태  - R:수신완료(PO세팅), P:수신 측 처리작업 중, S:수신 측 처리완료, E:수신 측 에러
  -- FIX ISSUE 
  ------------------------------------------------------------------------
  SET NOCOUNT ON;
  
  DECLARE
		@V_IFGNUM				NVARCHAR(12)   
        , @V_COMM_GRP_CD		NVARCHAR(20)		--공통코드그룹
        , @V_COMM_GRP_NM		NVARCHAR(120)		--공통코드그룹명 공통코드
        , @V_COMM_CD            NVARCHAR(20)        
        , @V_COMM_NM            NVARCHAR(240)       
        , @V_ORDR           	NUMERIC(4) 
        , @V_COMM_DESC1			NVARCHAR(120)
        , @V_COMM_DESC2			NVARCHAR(120)
        , @V_COMM_DESC3			NVARCHAR(120)
        , @V_COMM_DESC4			NVARCHAR(120)
        , @V_COMM_DESC5			NVARCHAR(120)
        , @V_USE_YN				VARCHAR(1)
        , @V_IFFLAG				NVARCHAR(1)
        , @V_IFDATE				NVARCHAR(8)
        , @V_IFTIME				NVARCHAR(6)
		, @V_IFUSER	    		NVARCHAR(12)
        , @V_IFSYS				NVARCHAR(8)     = 'OOS'
        , @V_RTN_IFDATE			NVARCHAR(8)
        , @V_RTN_IFTIME			NVARCHAR(6)
        , @V_ERRMSG				NVARCHAR(1000)
        , @V_MODPGMID			NVARCHAR(30)    = 'IF_CMMNCD'
        , @V_ERROR_LINE			INT
        , @V_ERROR_MESSAGE		NVARCHAR(2048)
        , @V_ERROR_NUMBER		INT
        , @V_ERROR_PROCEDURE	NVARCHAR(300)
        , @V_ERROR_SEVERITY		INT
        , @V_ERROR_STATE		INT;
        
	/*1.EAI에서 전송 된 DATA를 'R' -> 'P' 상태변환*/
	BEGIN
		UPDATE IF_AGENT
			SET XSTAT = 'P'
		WHERE 
			1=1
			AND IFGNUM = @IFGNUM
			AND XSTAT = 'R'; 
	END;     

	BEGIN TRAN   
	SAVE TRAN SAVE_UP_TRAN;
  
	BEGIN TRY
		/*2.커서선언*/
		BEGIN
		DECLARE CUR_COMM CURSOR FOR
		SELECT 
			ZCODEH		AS COMM_GRP_CD
			, ZCODEHT	AS COMM_GRP_NM
			, ZCODEV	AS COMM_CD
			, ZCODEVT	AS COMM_NM
			, SORTSEQ	AS ORDR
			, VALUEC1	AS COMM_DESC1
			, VALUEC2	AS COMM_DESC2
			, VALUEC3	AS COMM_DESC3
			, VALUEC4	AS COMM_DESC4
			, VALUEC5	AS COMM_DESC5
			, CASE WHEN IFCHKI = 'X' THEN 'N' ELSE 'Y' END AS USE_YN
			, IFFLAG 
			, IFDATE 
			, IFTIME
			, IFUSER
		FROM IF_CMMNCD(NOLOCK)
		WHERE 
			1=1
			AND IFGNUM = @IFGNUM
			AND XSTAT = 'P';
        
		OPEN CUR_COMM;
        FETCH NEXT FROM CUR_COMM 
			INTO @V_COMM_GRP_CD
		        , @V_COMM_GRP_NM
		        , @V_COMM_CD
		        , @V_COMM_NM
		        , @V_ORDR
		        , @V_COMM_DESC1
		        , @V_COMM_DESC2
		        , @V_COMM_DESC3
		        , @V_COMM_DESC4
		        , @V_COMM_DESC5
				, @V_USE_YN
				, @V_IFFLAG
				, @V_IFDATE
				, @V_IFTIME
				, @V_IFSYS;
			WHILE @@FETCH_STATUS = 0    
			
			BEGIN   
				/*3.공통코드 insert.*/
				MERGE T_COMM AS A 
				USING (
					SELECT 
						@V_COMM_GRP_CD 		AS COMM_GRP_CD
						, @V_COMM_GRP_NM 	AS COMM_GRP_NM
						, @V_COMM_CD 		AS COMM_CD
						, @V_COMM_NM 		AS COMM_NM
						, @V_ORDR			AS ORDR
						, @V_COMM_DESC1 	AS COMM_DESC1
						, @V_COMM_DESC2 	AS COMM_DESC2
						, @V_COMM_DESC3 	AS COMM_DESC3
						, @V_COMM_DESC4 	AS COMM_DESC4
						, @V_COMM_DESC5 	AS COMM_DESC5
						, @V_USE_YN 		AS USE_YN
						, @V_IFFLAG			AS IFFLAG
						, @V_IFDATE			AS IFDATE
						, @V_IFTIME			AS IFTIME
						, @V_IFUSER			AS IFUSER
				) AS B
				ON (
					A.COMM_GRP_CD	= B.COMM_GRP_CD
					AND A.COMM_CD	= B.COMM_CD
				)
				WHEN MATCHED THEN 
                UPDATE 
                	SET 
                		A.COMM_GRP_NM	= B.COMM_GRP_NM
                        , A.COMM_NM  	= B.COMM_NM                           
						, A.COMM_DESC1	= B.COMM_DESC1
						, A.COMM_DESC2	= B.COMM_DESC2
						, A.COMM_DESC3	= B.COMM_DESC3
						, A.COMM_DESC4	= B.COMM_DESC4
						, A.COMM_DESC5	= B.COMM_DESC5
						, A.USE_YN		= B.USE_YN
						, A.ORDR		= B.ORDR
						, A.UPD_DTM   	= GETDATE()                           
						, A.UPD_SEQ		= 0
				WHEN NOT MATCHED THEN 
				INSERT (
					COMM_GRP_CD
					, COMM_GRP_NM
					, COMM_CD
					, COMM_NM
					, COMM_DESC1
					, COMM_DESC2
					, COMM_DESC3
					, COMM_DESC4
					, COMM_DESC5
					, USE_YN
					, ORDR
					, REG_DTM
					, UPD_DTM 
					, REG_SEQ
					, UPD_SEQ
				)
                VALUES (
					B.COMM_GRP_CD
					, B.COMM_GRP_NM
					, B.COMM_CD
					, B.COMM_NM
					, B.COMM_DESC1
					, B.COMM_DESC2
					, B.COMM_DESC3
					, B.COMM_DESC4
					, B.COMM_DESC5
					, B.USE_YN
					, B.ORDR
					, GETDATE() 
					, GETDATE() 
					, 0
					, 0	
				);
          
			
			FETCH NEXT FROM CUR_COMM 
				INTO @V_COMM_GRP_CD
		        , @V_COMM_GRP_NM
		        , @V_COMM_CD
		        , @V_COMM_NM
		        , @V_ORDR
		        , @V_COMM_DESC1
		        , @V_COMM_DESC2
		        , @V_COMM_DESC3
		        , @V_COMM_DESC4
		        , @V_COMM_DESC5
				, @V_USE_YN
				, @V_IFFLAG
				, @V_IFDATE
				, @V_IFTIME
				, @V_IFUSER;
			END;
		CLOSE CUR_COMM;
		DEALLOCATE CUR_COMM;         
	END; 
       
    /*완료 처리*/
	BEGIN
		
		UPDATE IF_CMMNCD
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
			VALUES (B.IFGNUM, B.IFSYS, B.IFDATE, B.IFTIME, B.IFUSER, B.IFSTAT, B.XSTAT); 
                          
		END;
      
	COMMIT TRAN;  -- 프로시저 내의 최초 TRANSACTION에 대해 COMMIT;
      
		END TRY
	BEGIN CATCH
		CLOSE CUR_COMM;
		DEALLOCATE CUR_COMM; 
    
	ROLLBACK TRAN SAVE_UP_TRAN; -- 에러시에 SAVE POINT로 이동
	COMMIT TRAN;  --최초 TRANSACTION 문에 대해 COMMIT (*** 내부프로시저에서 COMMIT은 해서 성공시킴 ***)
    
	PRINT ERROR_MESSAGE()

    SET @V_ERROR_LINE         = ERROR_LINE();       --오류가 발생한 줄번호
    SET @V_ERROR_MESSAGE      = ERROR_MESSAGE();    --오류의 메시지
    SET @V_ERROR_NUMBER       = ERROR_NUMBER();     --오류번호
    SET @V_ERROR_PROCEDURE    = ERROR_PROCEDURE();  --오류가 발생한 프로시저나 트리거
    SET @V_ERROR_SEVERITY     = ERROR_SEVERITY();   --오류의 심각도
    SET @V_ERROR_STATE        = ERROR_STATE();      --오류의 상태번호
    SET @V_ERRMSG = '공통코드:' + @V_COMM_GRP_CD + '-' + @V_COMM_CD
                        + ', 오류프로시저:' + @V_ERROR_PROCEDURE
                        + ', 오류줄번호:' + CAST(@V_ERROR_LINE AS NVARCHAR(100))
                        + ', 오류메세지:' + @V_ERROR_MESSAGE;
        
                        
    SET  @V_RTN_IFDATE        = CONVERT(CHAR(8), GETDATE(), 112);
    SET  @V_RTN_IFTIME        = REPLACE(CONVERT (VARCHAR(8),GETDATE(), 108),':','');
    
    --에러저장
    BEGIN
      UPDATE IF_CMMNCD 
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
		END;
	END CATCH;

END;