USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_VEND_CD]    Script Date: 2022-03-15 오후 12:59:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[F_GET_VEND_CD]( @agen_seq numeric , @vend_cd varchar(1) )
returns varchar(5)
AS
BEGIN
	DECLARE @rtCd varchar(5)
		 SET  @rtCd = (
		  SELECT 
			 CASE WHEN MAX(tav.VEND_CD) IS NULL  THEN @vend_cd + '0001'
			 ELSE @vend_cd+FORMAT((RIGHT(MAX(tav.VEND_CD),4) + 1), '0000')
			 END AS EMPL_CD
		  FROM T_AGEN_VEND tav
		   WHERE tav.AGEN_SEQ = @agen_seq
			  AND  tav.VEND_CD LIKE @vend_cd+'%'   
		 )

	RETURN Isnull(@rtCd, null) 
END