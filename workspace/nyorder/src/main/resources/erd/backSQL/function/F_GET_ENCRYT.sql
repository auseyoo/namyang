USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_ENCRYT]    Script Date: 2022-03-15 오후 12:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[F_GET_ENCRYT](@str varchar(400))
RETURNS varbinary(256)
AS
BEGIN
	DECLARE @Result varbinary(256)
	SET @Result = EncryptByKey(Key_GUID('nyOrderKey'), @str)

	RETURN @Result
END
