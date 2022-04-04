USE [NY_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[P_PRD_CLS]    Script Date: 2022-03-15 오후 12:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[P_PRD_CLS]
/*
 * 프로시저명: P_PRD_CLS
 * 작성일: 2022-01-12
 * 사용예:  
 */
(
	@iLCLS VARCHAR(20),
	@iMCLS VARCHAR(20),
	@iSCLS VARCHAR(20),
	@iDCLS VARCHAR(20)
)
AS 
BEGIN
	
	IF LEN(@iDCLS) > 0
		BEGIN
			SELECT	DCLS AS code, DCLS_NM AS name 
			FROM	T_COMM_PRD_CLS
			WHERE	LCLS = @iLCLS
			AND		MCLS = @iMCLS
			AND		SCLS = @iSCLS
			AND		DCLS = @iDCLS
		END
	ELSE
		BEGIN
			IF LEN(@iSCLS) > 0
				BEGIN
					SELECT	DCLS AS code, DCLS_NM  AS name 
					FROM	T_COMM_PRD_CLS
					WHERE	LCLS = @iLCLS
					AND		MCLS = @iMCLS
					AND		SCLS = @iSCLS
					GROUP BY DCLS, DCLS_NM
				END
			ELSE
				BEGIN
					IF LEN(@iMCLS) > 0
						BEGIN
							SELECT	SCLS AS code, SCLS_NM  AS name 
							FROM	T_COMM_PRD_CLS
							WHERE	LCLS = @iLCLS
							AND		MCLS = @iMCLS
							GROUP BY SCLS , SCLS_NM 
						END
					ELSE
						BEGIN
							
							IF LEN(@iLCLS) > 0
								BEGIN
									SELECT	MCLS AS code, MCLS_NM  AS name 
									FROM	T_COMM_PRD_CLS
									WHERE	LCLS = @iLCLS
									GROUP BY MCLS , MCLS_NM
								END
							ELSE
								BEGIN
									SELECT	LCLS AS code, LCLS_NM  AS name 
									FROM	T_COMM_PRD_CLS
									GROUP BY LCLS , LCLS_NM
								END
							 
						END
				END
			
		END
	  
END
