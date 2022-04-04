USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_INPUT_DAY]    Script Date: 2022-03-15 오후 12:57:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[F_GET_INPUT_DAY] (@pttnSeq Numeric(13)) 
returns nvarchar(14) 
AS 
	BEGIN 
		DECLARE @rtDay nvarchar(14) = ''
				, @day1	numeric(5)
				, @day2	numeric(5)
				, @day3	numeric(5)
				, @day4	numeric(5)
				, @day5	numeric(5)
				, @day6	numeric(5)
				, @day7	numeric(5);

		SELECT 
      		@day1 = MON_QTY
			, @day2 = TUE_QTY
			, @day3 = WED_QTY
			, @day4 = THU_QTY
			, @day5 = FRI_QTY
			, @day6 = SAT_QTY
			, @day7 = SUN_QTY
      	FROM T_CST_PTTN a
      	WHERE 
      		1=1
      		AND a.PTTN_SEQ = @pttnSeq
      		
      	IF @day1 > 0
      	BEGIN 
			SET	@rtDay	= '월'
		END 
		
      	IF @day2 > 0
      	BEGIN 
			SET	@rtDay	= CONCAT(@rtDay, '화')
		END 	
		
      	IF @day3 > 0
      	BEGIN 
			SET	@rtDay	= CONCAT(@rtDay, '수')
		END 		
      
      	IF @day4 > 0
      	BEGIN 
			SET	@rtDay	= CONCAT(@rtDay, '목')
		END 	
	
      	IF @day5 > 0
      	BEGIN 
			SET	@rtDay	= CONCAT(@rtDay, '금')
		END
		
      	IF @day6 > 0
      	BEGIN 
			SET	@rtDay	= CONCAT(@rtDay, '토')
		END
		
      	IF @day7 > 0
      	BEGIN 
			SET	@rtDay	= CONCAT(@rtDay, '일')
		END		

      RETURN Isnull(@rtDay, '') 
  END