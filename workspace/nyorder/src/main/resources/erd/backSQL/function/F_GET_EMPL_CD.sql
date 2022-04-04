USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_EMPL_CD]    Script Date: 2022-03-15 오후 12:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[F_GET_EMPL_CD] ( @agen_seq numeric , @empl_cd varchar(1) )
returns varchar(5)
AS
BEGIN
	DECLARE @rtCd varchar(5)
		 SET  @rtCd = (
		  SELECT 
			 CASE WHEN MAX(tae.EMPL_CD) IS NULL  THEN @empl_cd + '0001'
			 ELSE @empl_cd+FORMAT((RIGHT(MAX(tae.EMPL_CD),4) + 1), '0000')
			 END AS EMPL_CD
		  FROM t_agen_mst tam
			 INNER JOIN t_agen_empl tae
				ON tam.AGEN_SEQ = tae.AGEN_SEQ
		   WHERE tam.AGEN_SEQ = @agen_seq
			  AND  tae.EMPL_CD LIKE @empl_cd+'%'   
		 )

	RETURN Isnull(@rtCd, null) 
END