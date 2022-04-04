USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_NAME_MASKING]    Script Date: 2022-03-15 오후 12:57:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gain
-- Create date: 2022-01-21
-- Description:	이름 마스킹
-- =============================================
ALTER FUNCTION [dbo].[F_GET_NAME_MASKING](@STR VARCHAR(50),@PRT INT)
RETURNS VARCHAR(50)
AS
-- (@PRT = 0)가운데 자리를 마스킹
-- (@PRT = 1) 뒤 자리를 마스킹

-- 두 자리 일 때 김*,
-- 세 자리 일 때 홍*동, 홍길* 
-- 네 자리 일 때 남궁*분, 남궁옥*,
-- 다섯 자리 이상 일 때 김**지리, 김노고**
     BEGIN
         DECLARE @RTNVALUE VARCHAR(50), @STRLEN INT;
         SET @STRLEN = LEN(@STR);
         IF @STRLEN = 2
             BEGIN
                 SET @RTNVALUE = LEFT(@STR, 1) + '*';
         	END;
         ELSE
             IF @STRLEN = 3
                 BEGIN
	                 IF @PRT = 0
	                 	BEGIN
		             		SET @RTNVALUE = LEFT(@STR, 1) + '*' + RIGHT(@STR , 1);
	                 	END;
	                 ELSE
               			IF @PRT = 1
               				BEGIN
	               				SET @RTNVALUE = LEFT(@STR, LEN(@STR)-1) + '*';
               				END;
             	 END;
             ELSE
             	IF @STRLEN = 4
             		BEGIN
	             		IF @PRT = 0
	             			BEGIN
		             			SET @RTNVALUE = LEFT(@STR, 2) + '*' + RIGHT(@STR, 1);
	             			END;
             			ELSE
             				IF @PRT = 1
             					BEGIN
	             					SET @RTNVALUE = LEFT(@STR, 3) + '*';
             					END;
 			 		END;
             	ELSE 
             		IF @STRLEN = 5
             			BEGIN
	             			IF @PRT = 0
	             				BEGIN
		             				SET @RTNVALUE = LEFT(@STR, 1) + '**' + RIGHT(@STR, 2);
	             				END
             				ELSE
             					IF @PRT = 1
             						BEGIN
	             						SET @RTNVALUE = LEFT(@STR, 3) + '**';		
             						END
             			END
     			ELSE
	                 BEGIN
	                     SET @RTNVALUE = @STR;
	            	 END;
         RETURN @RTNVALUE;
     END;
