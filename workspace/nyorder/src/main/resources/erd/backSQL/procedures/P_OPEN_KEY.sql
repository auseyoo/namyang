USE [NY_ORDER]
GO
/****** Object:  StoredProcedure [dbo].[P_OPEN_KEY]    Script Date: 2022-03-15 오후 12:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[P_OPEN_KEY]
AS
BEGIN
	BEGIN TRY
        OPEN SYMMETRIC KEY nyOrderKey
		DECRYPTION BY CERTIFICATE nyOrderCert
    END TRY
    BEGIN CATCH
        -- Handle non-existant key here
    END CATCH
END
