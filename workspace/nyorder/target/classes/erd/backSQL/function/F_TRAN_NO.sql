USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_TRAN_NO]    Script Date: 2022-03-15 오후 12:59:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[F_TRAN_NO] (@strAlphaNumeric VARCHAR(256)) 
returns VARCHAR(11) 
AS 
  BEGIN 
      DECLARE @intAlpha INT 

      SET @intAlpha = Patindex('%[^0-9]%', @strAlphaNumeric) 

      BEGIN 
          WHILE @intAlpha > 0 
            BEGIN 
                SET @strAlphaNumeric = Stuff(@strAlphaNumeric, @intAlpha, 1, '') 
                SET @intAlpha = Patindex('%[^0-9]%', @strAlphaNumeric) 
            END 
      END 

      RETURN Isnull(@strAlphaNumeric, null) 
  END 

