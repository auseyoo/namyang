USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_BIZ_NO]    Script Date: 2022-03-15 오후 12:55:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SoL
-- Create date: 2022-01-19
-- Description:	사업자번호 조회
-- =============================================
ALTER FUNCTION [dbo].[F_GET_BIZ_NO]
(
	@iBizNo VARCHAR(20) = ''
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @tBizNo VARCHAR(20)=@iBizNo;
	
	SELECT @tBizNo = dbo.F_TRAN_NO256(@tBizNo);

	IF LEN(@tBizNO) = 10 
		BEGIN
			select @tBizNO =SUBSTRING(@tBizNo,1,3)+'-'+SUBSTRING(@tBizNo,4,2)+'-'+SUBSTRING(@tBizNo,6,LEN(@tBizNO)-1)		
		END
	ELSE
		BEGIN
			select @tBizNO = ''
		END
	
		
	RETURN @tBizNO
END
