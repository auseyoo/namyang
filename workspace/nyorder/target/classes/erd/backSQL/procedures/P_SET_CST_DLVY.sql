USE [NY_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[P_SET_CST_DLVY]    Script Date: 2022-03-15 오후 12:51:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[P_SET_CST_DLVY]
(
	@I_AGEN_SEQ numeric(13)
	, @O_OUT_MSG NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON;

	BEGIN TRY
		
			-- 1. 각 데이터들의 두달치가 있는지 확인해야함.
			DECLARE @V_AGEN_SEQ numeric(13) = @I_AGEN_SEQ
				,	@V_MONTH0 VARCHAR(8) = ''
				,	@V_MONTH1 VARCHAR(8) = ''
				,	@V_MONTH2 VARCHAR(8) = ''
				,	@V_MONTH3 VARCHAR(8) = ''
				,	@V_MONTH4 VARCHAR(8) = ''
				,	@V_DLV_CNT1	int = 0
				,	@V_DLV_CNT2	int = 0
				,	@V_DLV_CNT3	int = 0
				,	@V_PRD_CNT1	int = 0
				,	@V_PRD_CNT2	int = 0
				,	@V_PRD_CNT3	int = 0
				, 	@START_DATE VARCHAR(8) = ''
				,	@END_DATE VARCHAR(8) = ''
				, 	@MONTH_NO int = 0
			SET @V_MONTH1	= CONCAT(CONVERT(VARCHAR(6), DATEADD(MONTH, 0, GETDATE()), 112), '01')
			SET @V_MONTH2	= CONCAT(CONVERT(VARCHAR(6), DATEADD(MONTH, +1, GETDATE()), 112), '01')
			SET @V_MONTH3	= CONCAT(CONVERT(VARCHAR(6), DATEADD(MONTH, +2, GETDATE()), 112), '01')
			SELECT 
				@V_DLV_CNT1 = count(*) 
			FROM
			(
			SELECT 
				tcp.CST_PRD_SEQ 
				, CASE 
					WHEN tcpd.CST_PRD_DLVY_SEQ is null THEN 'N'
					ELSE 'Y' END AS DLVY_FLG
				, tcpd.DLVY_DT 
				, tcp.AGEN_SEQ 
			FROM 
				T_CST_PRD tcp
				LEFT OUTER JOIN 
					T_CST_PRD_DLVY tcpd 
					ON tcp.AGEN_SEQ = tcpd.AGEN_SEQ 
					AND tcp.CST_PRD_SEQ = tcpd.CST_PRD_SEQ 
					AND tcpd.USE_YN = 'Y'
					AND tcpd.DLVY_DT BETWEEN @V_MONTH1 AND CONVERT(VARCHAR(8), EOMONTH(@V_MONTH1), 112)
				INNER JOIN 	
					T_AGEN_MST tam 
					ON tcp.AGEN_SEQ = tam.AGEN_SEQ 
					AND tam.SALE_CD = 'BA'
			WHERE 
				1=1
				AND tcp.AGEN_SEQ = @V_AGEN_SEQ
				AND tcp.LAST_YN ='Y'
				AND tcp.STPG_YN = 'N'
				ANd tcp.STPG_DT IS NOT NULL
			) mst
			WHERE
			1=1
			AND mst.DLVY_FLG = 'Y'
			SELECT 
				@V_DLV_CNT2 = count(*) 
			FROM
			(
			SELECT 
				tcp.CST_PRD_SEQ 
				, CASE 
					WHEN tcpd.CST_PRD_DLVY_SEQ is null THEN 'N'
					ELSE 'Y' END AS DLVY_FLG
				, tcpd.DLVY_DT 
				, tcp.AGEN_SEQ 
			FROM 
				T_CST_PRD tcp
				LEFT OUTER JOIN 
					T_CST_PRD_DLVY tcpd 
					ON tcp.AGEN_SEQ = tcpd.AGEN_SEQ 
					AND tcp.CST_PRD_SEQ = tcpd.CST_PRD_SEQ 
					AND tcpd.USE_YN = 'Y'
					AND tcpd.DLVY_DT BETWEEN @V_MONTH2 AND CONVERT(VARCHAR(8), EOMONTH(@V_MONTH2), 112)
				INNER JOIN 	
					T_AGEN_MST tam 
					ON tcp.AGEN_SEQ = tam.AGEN_SEQ 
					AND tam.SALE_CD = 'BA'
			WHERE 
				1=1
				AND tcp.AGEN_SEQ = @V_AGEN_SEQ
				AND tcp.LAST_YN ='Y'
				AND tcp.STPG_YN = 'N'
				ANd tcp.STPG_DT IS NOT NULL
			) mst
			WHERE
			1=1
			AND mst.DLVY_FLG = 'Y'
			SELECT 
				@V_DLV_CNT3 = count(*) 
			FROM
			(
			SELECT 
				tcp.CST_PRD_SEQ 
				, CASE 
					WHEN tcpd.CST_PRD_DLVY_SEQ is null THEN 'N'
					ELSE 'Y' END AS DLVY_FLG
				, tcpd.DLVY_DT 
				, tcp.AGEN_SEQ 
			FROM 
				T_CST_PRD tcp
				LEFT OUTER JOIN 
					T_CST_PRD_DLVY tcpd 
					ON tcp.AGEN_SEQ = tcpd.AGEN_SEQ 
					AND tcp.CST_PRD_SEQ = tcpd.CST_PRD_SEQ 
					AND tcpd.USE_YN = 'Y'
					AND tcpd.DLVY_DT BETWEEN @V_MONTH3 AND CONVERT(VARCHAR(8), EOMONTH(@V_MONTH3), 112)
				INNER JOIN 	
					T_AGEN_MST tam 
					ON tcp.AGEN_SEQ = tam.AGEN_SEQ 
					AND tam.SALE_CD = 'BA'
			WHERE 
				1=1
				AND tcp.AGEN_SEQ = @V_AGEN_SEQ
				AND tcp.LAST_YN ='Y'
				AND tcp.STPG_YN = 'N'
				ANd tcp.STPG_DT IS NOT NULL
			) mst
			WHERE
			1=1
			AND mst.DLVY_FLG = 'Y'
			BEGIN 
				IF @V_DLV_CNT1 = 0
				BEGIN 
					--실질적인 데이터를 넣는데 보류/일시중지를 빼고 넣어야됨.
					SET @START_DATE = @V_MONTH1 
					SET @END_DATE = CONVERT(VARCHAR(8), EOMONTH(@V_MONTH1), 112)
					SET @MONTH_NO = 1
					WHILE @MONTH_NO <= 6
					BEGIN
						INSERT INTO T_CST_PRD_DLVY(
							CST_PRD_DLVY_SEQ
							, AGEN_SEQ
							, AREA_SEQ
							, CST_SEQ
							, CST_PRD_SEQ
							, PTTN_SEQ
							, PUCH_SEQ
							, PRD_DTL_SEQ
							, DLVY_QTY
							, DLVY_DT
							, DLVY_UNTPC
							, USE_YN
							, REG_DTM
							, REG_SEQ
							, UPD_DTM
							, UPD_SEQ
						)
						SELECT 
							NEXT VALUE FOR SQ_CST_PRD_DLVY
							, b.AGEN_SEQ
							, b.AREA_SEQ
							, b.CST_SEQ
							, b.CST_PRD_SEQ
							, b.PTTN_SEQ
							, b.PUCH_SEQ
							, b.PRD_DTL_SEQ
							, b.QTY
							, a.DT
							, b.UNTPC
							, 'Y'
							, GETDATE() AS REG_DTM
							, 0 AS REG_SEQ
							, GETDATE() AS UPD_DTM
							, 0 AS UPD_SEQ		
						FROM 
						(
						SELECT
							CONVERT(VARCHAR(10), DATEADD(D, NUMBER, @START_DATE), 112) AS DT
							, CASE DATEPART(DW, CONVERT(DATETIME, @START_DATE)+ NUMBER)  /*DATE에 해당하는 요일넘버, 1(일요일)~7(토요일)*/
								WHEN 1 THEN 'SUN'
								WHEN 2 THEN 'MON'
								WHEN 3 THEN 'TUE' 
								WHEN 4 THEN 'WED' 
								WHEN 5 THEN 'THU' 
								WHEN 6 THEN 'FRI' 
								WHEN 7 THEN 'SAT' END AS DAYS
							, DATEDIFF(WK, @START_DATE, DATEADD(D, NUMBER, @START_DATE))+1 WEEKS -- 주
						FROM 
							MASTER..SPT_VALUES
						WHERE 
							1=1
							AND TYPE = 'P'
							AND NUMBER <= DATEDIFF(D, @START_DATE, @END_DATE)
							AND (DATEDIFF(WK, @START_DATE, DATEADD(D, NUMBER, @START_DATE))+1) = @MONTH_NO
						) a
						INNER JOIN
						(
							SELECT
								AGEN_SEQ
								, AREA_SEQ
								, CST_SEQ
								, CST_PRD_SEQ
								, PTTN_SEQ
								, PUCH_SEQ
								, PRD_DTL_SEQ
								, WEEKS
								, UNTPC
								, QTY
								, DAYS
							FROM 
							(
							SELECT 
								AGEN_SEQ
								, AREA_SEQ
								, CST_SEQ
								, CST_PRD_SEQ
								, PTTN_SEQ
								, PUCH_SEQ
								, PRD_DTL_SEQ
								, WEEKS
								, UNTPC
								, QTY
								, DAYS
							FROM 
							(
							SELECT 
								tct.AGEN_SEQ
								, tct.AREA_SEQ
								, tct.CST_SEQ
								, tct.CST_PRD_SEQ
								, tct.PTTN_SEQ
								, tct.PUCH_SEQ
								, tct.PRD_DTL_SEQ
								, tct.WEEKS
								, tct.SUN_QTY AS SUN
								, tct.MON_QTY AS MON 
								, tct.TUE_QTY AS TUE
								, tct.WED_QTY AS WED
								, tct.THU_QTY AS THU 
								, tct.FRI_QTY AS FRI 
								, tct.SAT_QTY AS SAT 
								, tcp.PRMT_EMPL_SEQ
								, tcp.PRTM_RMK
								, dbo.F_GET_UNTPC(tct.AGEN_SEQ, tct.AREA_SEQ, tct.CST_SEQ, tcp.PRD_SEQ, tct.PRD_DTL_SEQ, tct.CST_PRD_SEQ, tct.PTTN_SEQ) AS UNTPC
							FROM 
								T_CST_PRD tcp 
								LEFT OUTER JOIN 
									T_CST_PTTN tct 
									ON tcp.AGEN_SEQ = tct.AGEN_SEQ 
									AND tcp.CST_PRD_SEQ = tct.CST_PRD_SEQ
									AND tct.USE_YN = 'Y'
									AND tct.LAST_YN = 'Y'
									AND tct.WEEKS = @MONTH_NO
							WHERE 
								1=1
								AND tcp.LAST_YN ='Y'
								AND tct.USE_YN = 'Y'
								AND tcp.STPG_YN = 'N'
								AND (tcp.STPG_DT IS NULL OR tcp.STPG_DT != '')
								AND tct.WEEKS IS NOT NULL
								AND tcp.AGEN_SEQ = @V_AGEN_SEQ
							) a
							UNPIVOT (QTY FOR DAYS IN ([MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN])) AS RES_DT
							) a
							WHERE 
							1=1
							AND a.QTY <> 0
						) b
						ON a.DAYS = b.DAYS
						AND a.WEEKS = b.WEEKS
						PRINT @MONTH_NO
						SET @MONTH_NO = @MONTH_NO +1
					END
				END
			END
			BEGIN 
				IF @V_DLV_CNT2 = 0
				BEGIN 
					--실질적인 데이터를 넣는데 보류/일시중지를 빼고 넣어야됨.
					SET @START_DATE = @V_MONTH2 
					SET @END_DATE = CONVERT(VARCHAR(8), EOMONTH(@V_MONTH2), 112)
					SET @MONTH_NO = 1
					WHILE @MONTH_NO <= 6
					BEGIN
						INSERT INTO T_CST_PRD_DLVY(
							CST_PRD_DLVY_SEQ
							, AGEN_SEQ
							, AREA_SEQ
							, CST_SEQ
							, CST_PRD_SEQ
							, PTTN_SEQ
							, PUCH_SEQ
							, PRD_DTL_SEQ
							, DLVY_QTY
							, DLVY_DT
							, DLVY_UNTPC
							, USE_YN
							, REG_DTM
							, REG_SEQ
							, UPD_DTM
							, UPD_SEQ
						)
						SELECT 
							NEXT VALUE FOR SQ_CST_PRD_DLVY
							, b.AGEN_SEQ
							, b.AREA_SEQ
							, b.CST_SEQ
							, b.CST_PRD_SEQ
							, b.PTTN_SEQ
							, b.PUCH_SEQ
							, b.PRD_DTL_SEQ
							, b.QTY
							, a.DT
							, b.UNTPC
							, 'Y'
							, GETDATE() AS REG_DTM
							, 0 AS REG_SEQ
							, GETDATE() AS UPD_DTM
							, 0 AS UPD_SEQ		
						FROM 
						(
						SELECT
							CONVERT(VARCHAR(10), DATEADD(D, NUMBER, @START_DATE), 112) AS DT
							, CASE DATEPART(DW, CONVERT(DATETIME, @START_DATE)+ NUMBER)  /*DATE에 해당하는 요일넘버, 1(일요일)~7(토요일)*/
								WHEN 1 THEN 'SUN'
								WHEN 2 THEN 'MON'
								WHEN 3 THEN 'TUE' 
								WHEN 4 THEN 'WED' 
								WHEN 5 THEN 'THU' 
								WHEN 6 THEN 'FRI' 
								WHEN 7 THEN 'SAT' END AS DAYS
							, DATEDIFF(WK, @START_DATE, DATEADD(D, NUMBER, @START_DATE))+1 WEEKS -- 주
						FROM 
							MASTER..SPT_VALUES
						WHERE 
							1=1
							AND TYPE = 'P'
							AND NUMBER <= DATEDIFF(D, @START_DATE, @END_DATE)
							AND (DATEDIFF(WK, @START_DATE, DATEADD(D, NUMBER, @START_DATE))+1) = @MONTH_NO
						) a
						INNER JOIN
						(
							SELECT
								AGEN_SEQ
								, AREA_SEQ
								, CST_SEQ
								, CST_PRD_SEQ
								, PTTN_SEQ
								, PUCH_SEQ
								, PRD_DTL_SEQ
								, WEEKS
								, UNTPC
								, QTY
								, DAYS
							FROM 
							(
							SELECT 
								AGEN_SEQ
								, AREA_SEQ
								, CST_SEQ
								, CST_PRD_SEQ
								, PTTN_SEQ
								, PUCH_SEQ
								, PRD_DTL_SEQ
								, WEEKS
								, UNTPC
								, QTY
								, DAYS
							FROM 
							(
							SELECT 
								tct.AGEN_SEQ
								, tct.AREA_SEQ
								, tct.CST_SEQ
								, tct.CST_PRD_SEQ
								, tct.PTTN_SEQ
								, tct.PUCH_SEQ
								, tct.PRD_DTL_SEQ
								, tct.WEEKS
								, tct.SUN_QTY AS SUN
								, tct.MON_QTY AS MON 
								, tct.TUE_QTY AS TUE
								, tct.WED_QTY AS WED
								, tct.THU_QTY AS THU 
								, tct.FRI_QTY AS FRI 
								, tct.SAT_QTY AS SAT 
								, tcp.PRMT_EMPL_SEQ
								, tcp.PRTM_RMK
								, dbo.F_GET_UNTPC(tct.AGEN_SEQ, tct.AREA_SEQ, tct.CST_SEQ, tcp.PRD_SEQ, tct.PRD_DTL_SEQ, tct.CST_PRD_SEQ, tct.PTTN_SEQ) AS UNTPC
							FROM 
								T_CST_PRD tcp 
								LEFT OUTER JOIN 
									T_CST_PTTN tct 
									ON tcp.AGEN_SEQ = tct.AGEN_SEQ 
									AND tcp.CST_PRD_SEQ = tct.CST_PRD_SEQ
									AND tct.USE_YN = 'Y'
									AND tct.LAST_YN = 'Y'
									AND tct.WEEKS = @MONTH_NO
							WHERE 
								1=1
								AND tcp.LAST_YN ='Y'
								AND tct.USE_YN = 'Y'
								AND tcp.STPG_YN = 'N'
								AND (tcp.STPG_DT IS NULL OR tcp.STPG_DT != '')
								AND tcp.AGEN_SEQ = @V_AGEN_SEQ
								AND tct.WEEKS IS NOT NULL
							) a
							UNPIVOT (QTY FOR DAYS IN ([MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN])) AS RES_DT
							) a
							WHERE 
							1=1
							AND a.QTY <> 0
						) b
						ON a.DAYS = b.DAYS
						AND a.WEEKS = b.WEEKS
						PRINT @MONTH_NO
						SET @MONTH_NO = @MONTH_NO +1
					END
				END
			END	
			BEGIN 
				IF @V_DLV_CNT3 = 0
				BEGIN 
					--실질적인 데이터를 넣는데 보류/일시중지를 빼고 넣어야됨.
					SET @START_DATE = @V_MONTH3 
					SET @END_DATE = CONVERT(VARCHAR(8), EOMONTH(@V_MONTH3), 112)
					SET @MONTH_NO = 1
					WHILE @MONTH_NO <= 6
					BEGIN
						INSERT INTO T_CST_PRD_DLVY(
							CST_PRD_DLVY_SEQ
							, AGEN_SEQ
							, AREA_SEQ
							, CST_SEQ
							, CST_PRD_SEQ
							, PTTN_SEQ
							, PUCH_SEQ
							, PRD_DTL_SEQ
							, DLVY_QTY
							, DLVY_DT
							, DLVY_UNTPC
							, USE_YN
							, REG_DTM
							, REG_SEQ
							, UPD_DTM
							, UPD_SEQ
						)
						SELECT 
							NEXT VALUE FOR SQ_CST_PRD_DLVY
							, b.AGEN_SEQ
							, b.AREA_SEQ
							, b.CST_SEQ
							, b.CST_PRD_SEQ
							, b.PTTN_SEQ
							, b.PUCH_SEQ
							, b.PRD_DTL_SEQ
							, b.QTY
							, a.DT
							, b.UNTPC
							, 'Y'
							, GETDATE() AS REG_DTM
							, 0 AS REG_SEQ
							, GETDATE() AS UPD_DTM
							, 0 AS UPD_SEQ		
						FROM 
						(
						SELECT
							CONVERT(VARCHAR(10), DATEADD(D, NUMBER, @START_DATE), 112) AS DT
							, CASE DATEPART(DW, CONVERT(DATETIME, @START_DATE)+ NUMBER)  /*DATE에 해당하는 요일넘버, 1(일요일)~7(토요일)*/
								WHEN 1 THEN 'SUN'
								WHEN 2 THEN 'MON'
								WHEN 3 THEN 'TUE' 
								WHEN 4 THEN 'WED' 
								WHEN 5 THEN 'THU' 
								WHEN 6 THEN 'FRI' 
								WHEN 7 THEN 'SAT' END AS DAYS
							, DATEDIFF(WK, @START_DATE, DATEADD(D, NUMBER, @START_DATE))+1 WEEKS -- 주
						FROM 
							MASTER..SPT_VALUES
						WHERE 
							1=1
							AND TYPE = 'P'
							AND NUMBER <= DATEDIFF(D, @START_DATE, @END_DATE)
							AND (DATEDIFF(WK, @START_DATE, DATEADD(D, NUMBER, @START_DATE))+1) = @MONTH_NO
						) a
						INNER JOIN
						(
							SELECT
								AGEN_SEQ
								, AREA_SEQ
								, CST_SEQ
								, CST_PRD_SEQ
								, PTTN_SEQ
								, PUCH_SEQ
								, PRD_DTL_SEQ
								, WEEKS
								, UNTPC
								, QTY
								, DAYS
							FROM 
							(
							SELECT 
								AGEN_SEQ
								, AREA_SEQ
								, CST_SEQ
								, CST_PRD_SEQ
								, PTTN_SEQ
								, PUCH_SEQ
								, PRD_DTL_SEQ
								, WEEKS
								, UNTPC
								, QTY
								, DAYS
							FROM 
							(
							SELECT 
								tct.AGEN_SEQ
								, tct.AREA_SEQ
								, tct.CST_SEQ
								, tct.CST_PRD_SEQ
								, tct.PTTN_SEQ
								, tct.PUCH_SEQ
								, tct.PRD_DTL_SEQ
								, tct.WEEKS
								, tct.SUN_QTY AS SUN
								, tct.MON_QTY AS MON 
								, tct.TUE_QTY AS TUE
								, tct.WED_QTY AS WED
								, tct.THU_QTY AS THU 
								, tct.FRI_QTY AS FRI 
								, tct.SAT_QTY AS SAT 
								, tcp.PRMT_EMPL_SEQ
								, tcp.PRTM_RMK
								, dbo.F_GET_UNTPC(tct.AGEN_SEQ, tct.AREA_SEQ, tct.CST_SEQ, tcp.PRD_SEQ, tct.PRD_DTL_SEQ, tct.CST_PRD_SEQ, tct.PTTN_SEQ) AS UNTPC
							FROM 
								T_CST_PRD tcp 
								LEFT OUTER JOIN 
									T_CST_PTTN tct 
									ON tcp.AGEN_SEQ = tct.AGEN_SEQ 
									AND tcp.CST_PRD_SEQ = tct.CST_PRD_SEQ
									AND tct.USE_YN = 'Y'
									AND tct.LAST_YN = 'Y'
									AND tct.WEEKS = @MONTH_NO
							WHERE 
								1=1
								AND tcp.LAST_YN ='Y'
								AND tct.USE_YN = 'Y'
								AND tcp.STPG_YN = 'N'
								AND (tcp.STPG_DT IS NULL OR tcp.STPG_DT != '')
								AND tcp.AGEN_SEQ = @V_AGEN_SEQ
								AND tct.WEEKS IS NOT NULL
							) a
							UNPIVOT (QTY FOR DAYS IN ([MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN])) AS RES_DT
							) a
							WHERE 
							1=1
							AND a.QTY <> 0
						) b
						ON a.DAYS = b.DAYS
						AND a.WEEKS = b.WEEKS
						PRINT @MONTH_NO
						SET @MONTH_NO = @MONTH_NO +1
					END
				END
			END		
		
		
		SET @O_OUT_MSG = CONCAT(@V_AGEN_SEQ, '::SET DLVY Sucess')
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN 		-- 실패
		SET @O_OUT_MSG = CONCAT(@V_AGEN_SEQ, 'Error, ::@E_NUMBER::', ERROR_NUMBER(), ',::@E_SERVERITY::', ERROR_SEVERITY(),',::@E_STATE::',ERROR_STATE(),',::@E_LINE::', ERROR_LINE(),',::@E_MSG::',ERROR_MESSAGE())
		
        RETURN @O_OUT_MSG        
	END CATCH  
	
	SET NOCOUNT OFF
END
