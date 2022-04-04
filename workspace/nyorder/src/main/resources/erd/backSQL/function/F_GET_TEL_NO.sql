USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_TEL_NO]    Script Date: 2022-03-15 오후 12:58:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   FUNCTION [dbo].[F_GET_TEL_NO] (
         @iTelNo VARCHAR(20) = '' 
         ) RETURNS VARCHAR(100)
AS
BEGIN
 DECLARE  @wTelNo VARCHAR(20)
           , @wReturn VARCHAR(20)
 SELECT @wTelNo = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@iTelNo, CHAR(13)+CHAR(10), ''), ' ', ''), '-', ''), '.', ''), '/', ''), ',', '')       
 IF ISNUMERIC(@wTelNo) = 0 OR LEN(@wTelNo) < 7 OR LEN(@wTelNo) > 11 BEGIN
  RETURN @iTelNo
 END 
SELECT @wReturn =  
CASE WHEN LEN(@wTelNo) = 7 
       THEN SUBSTRING(@wTelNo, 1, 3)+'-'+SUBSTRING(@wTelNo, 4, 4)
       WHEN LEN(@wTelNo) = 8 
       THEN SUBSTRING(@wTelNo, 1, 4)+'-'+SUBSTRING(@wTelNo, 5, 4)
       WHEN LEN(@wTelNo) = 9 
       THEN SUBSTRING(@wTelNo, 1, 2)+'-'+SUBSTRING(@wTelNo, 3, 3)+'-'+SUBSTRING(@wTelNo, 6, 4)
       WHEN LEN(@wTelNo) = 10 
       THEN CASE WHEN LEFT(@wTelNo, 2) = '02'
     THEN SUBSTRING(@wTelNo, 1, 2)+'-'+SUBSTRING(@wTelNo, 3, 4)+'-'+SUBSTRING(@wTelNo, 7, 4)
             ELSE SUBSTRING(@wTelNo, 1, 3)+'-'+SUBSTRING(@wTelNo, 4, 3)+'-'+SUBSTRING(@wTelNo, 7, 4) 
END
       WHEN LEN(@wTelNo) = 11 
       THEN SUBSTRING(@wTelNo, 1, 3)+'-'+SUBSTRING(@wTelNo, 4, 4)+'-'+SUBSTRING(@wTelNo, 8, 4)
       ELSE @iTelNo 
END
 RETURN @wReturn
END;