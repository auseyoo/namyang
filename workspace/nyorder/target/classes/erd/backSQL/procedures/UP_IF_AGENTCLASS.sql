USE [NY_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[UP_IF_AGENTCLASS]    Script Date: 2022-03-28 오후 2:31:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[UP_IF_AGENTCLASS]
( 
    @IFGNUM       NVARCHAR(12)     --일련번호
)
AS
BEGIN

  ----------------------------------------------------------------------------------
  --Author     : 김동주
  --Create Date: 2022-03-28
  --Description: 대리점 분류 데이터 MERGE
  -- 수신상태  - R:수신완료(PO세팅), P:수신 측 처리작업 중, S:수신 측 처리완료, E:수신 측 에러
  ----------------------------------------------------------------------------------


	SET NOCOUNT ON;
  
	DECLARE
		@V_AGEN_TYPE1		NVARCHAR(20)  
		,@V_AGEN_TYPE2		NVARCHAR(20)  
		,@V_AGEN_TYPE3		NVARCHAR(20)  
		,@V_AGEN_TYPE_STR1	NVARCHAR(60)        
		,@V_AGEN_TYPE_STR2	NVARCHAR(60)
		,@V_AGEN_TYPE_STR3	NVARCHAR(60)
		,@V_IFSYS			NVARCHAR(8)     = 'OOS'
		,@V_RTN_IFDATE		NVARCHAR(8)
		,@V_RTN_IFTIME		NVARCHAR(6)
		,@V_ERRMSG			NVARCHAR(1000)
		,@V_MODPGMID		NVARCHAR(30) = 'UP_IF_AGENTCLASS'
		,@V_ERROR_LINE		INT
		,@V_ERROR_MESSAGE	NVARCHAR(2048)
		,@V_ERROR_NUMBER	INT
		,@V_ERROR_PROCEDURE	NVARCHAR(300)
		,@V_ERROR_SEVERITY	INT
		,@V_ERROR_STATE		INT;
   
 	/*1.EAI에서 전송 된 DATA를 'R' -> 'P' 상태변환*/
	BEGIN
		UPDATE IF_AGENTCLASS   
		SET XSTAT = 'P'
		WHERE IFGNUM = @IFGNUM
		AND XSTAT = 'R'; 
	END;

   
	BEGIN TRAN   
	SAVE TRAN SAVE_UP_TRAN;
  
	BEGIN TRY
    
		/*2.커서선언*/
		BEGIN
			DECLARE CUR_1 CURSOR FOR
	        SELECT 
	        	KVGR1		AS AGEN_TYPE1
	        	, KVGR2		AS AGEN_TYPE2
	        	, KVGR3		AS AGEN_TYPE3
	        	, KVGR1TXT	AS AGEN_TYPE_STR1
	        	, KVGR2TXT	AS AGEN_TYPE_STR2
	        	, KVGR3TXT	AS AGEN_TYPE_STR3
			FROM IF_AGENTCLASS(NOLOCK)
			WHERE 
				1=1
				AND IFGNUM = @IFGNUM
				AND XSTAT = 'P';
          
        
			OPEN CUR_1;
        	FETCH NEXT FROM CUR_1 
        		INTO @V_AGEN_TYPE1
        		, @V_AGEN_TYPE2
        		, @V_AGEN_TYPE3
        		, @V_AGEN_TYPE_STR1
        		, @V_AGEN_TYPE_STR2
        		, @V_AGEN_TYPE_STR3
			WHILE @@FETCH_STATUS = 0    
        
		/*3. 대리점 구분 정보 MERGE*/
		BEGIN
			MERGE T_AGEN_TYPE AS A 
			USING (
				SELECT 
					@V_AGEN_TYPE1			AS AGEN_TYPE1
	        		, @V_AGEN_TYPE2			AS AGEN_TYPE2
	        		, @V_AGEN_TYPE3			AS AGEN_TYPE3
	        		, @V_AGEN_TYPE_STR1		AS AGEN_TYPE_STR1
	        		, @V_AGEN_TYPE_STR2		AS AGEN_TYPE_STR2
	        		, @V_AGEN_TYPE_STR3		AS AGEN_TYPE_STR3
			) AS B
             ON (
             	A.AGEN_TYPE1 = B.AGEN_TYPE1
             	AND A.AGEN_TYPE2 = B.AGEN_TYPE2
             	AND A.AGEN_TYPE3 = B.AGEN_TYPE3
             )
           WHEN MATCHED THEN 
                UPDATE SET 
                	A.AGEN_TYPE_STR1	= B.AGEN_TYPE_STR1
                    , A.AGEN_TYPE_STR2  = B.AGEN_TYPE_STR2
					, A.AGEN_TYPE_STR3  = B.AGEN_TYPE_STR3
					, A.UPD_DTM			= GETDATE()                           
					, A.UPD_SEQ			= 0
           WHEN NOT MATCHED THEN 
                INSERT (
                	AGEN_TYPE1
                	, AGEN_TYPE2
                	, AGEN_TYPE3
                	, AGEN_TYPE_STR1
                	, AGEN_TYPE_STR2
                	, AGEN_TYPE_STR3
                	, REG_DTM
                	, REG_SEQ
                	, UPD_DTM
                	, UPD_SEQ
                )
                VALUES (
                	B.AGEN_TYPE1
                	, B.AGEN_TYPE2
                	, B.AGEN_TYPE3
                	, B.AGEN_TYPE_STR1
                	, B.AGEN_TYPE_STR2
                	, B.AGEN_TYPE_STR3
                	, GETDATE()
                	, 0
                	, GETDATE()
                	, 0
				);
           
				FETCH NEXT FROM CUR_1 
          		INTO  @V_AGEN_TYPE1
        		, @V_AGEN_TYPE2
        		, @V_AGEN_TYPE3
        		, @V_AGEN_TYPE_STR1
        		, @V_AGEN_TYPE_STR2
        		, @V_AGEN_TYPE_STR3     
			END;
			CLOSE CUR_1;
			DEALLOCATE CUR_1;         
      END;               
      
      /*4. 완료처리*/
      BEGIN
        UPDATE IF_AGENTCLASS 
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
    
    SET @V_ERRMSG = '고객계층구조:' + @V_AGEN_TYPE1 + '-' + @V_AGEN_TYPE2 + '-' + @V_AGEN_TYPE3
                        + ', 오류프로시저:' + @V_ERROR_PROCEDURE
                        + ', 오류줄번호:' + CAST(@V_ERROR_LINE AS NVARCHAR(100))
                        + ', 오류메세지:' + @V_ERROR_MESSAGE;
    SET  @V_RTN_IFDATE        = CONVERT(CHAR(8), GETDATE(), 112);
    SET  @V_RTN_IFTIME        = REPLACE(CONVERT (VARCHAR(8),GETDATE(), 108),':','');
        
    --9.IF_AGENTCLASS 상태값을 에러로 처리하고 에러내용표기
    BEGIN
      UPDATE IF_AGENTCLASS 
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