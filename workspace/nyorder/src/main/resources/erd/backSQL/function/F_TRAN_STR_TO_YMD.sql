USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_TRAN_STR_TO_YMD]    Script Date: 2022-03-15 오후 12:59:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[F_TRAN_STR_TO_YMD]
(
	@vDate VARCHAR(8) = ''
)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @tranDate VARCHAR(10)= '';
	
	IF LEN(@vDate) != 8
	BEGIN
		SET @tranDate = ''
	END
	ELSE
	BEGIN
		SET @tranDate = CONCAT(SUBSTRING(@vDate, 1, 4), '-', SUBSTRING(@vDate, 5, 2), '-', SUBSTRING(@vDate, 7, 2))
	END
		
	RETURN @tranDate
END