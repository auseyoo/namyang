USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_SPLIT]    Script Date: 2022-03-15 오후 12:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[F_GET_SPLIT] ( 
	@StrValue VARCHAR(500),-- 대상 문자열 
	@SplitChar CHAR(1), -- 구분기호 
	@idx INT -- 배열 인덱스 
) 
RETURNS NVARCHAR(100) 
AS 
BEGIN 
	DECLARE 
		@word CHAR(20), -- 반환할 문자 
		@sTextData VARCHAR(600), 
		@num SMALLINT; 
		
	SET @num = 1; 
	SET @sTextData = LTRIM(RTRIM(@StrValue)) + @SplitChar; 
	
	WHILE @idx >= @num 
	BEGIN 
		IF CHARINDEX(@SplitChar, @sTextData) > 0 
		BEGIN -- 문자열의 인덱스 위치의 요소를 반환 
			SET @word = SUBSTRING(@sTextData, 1, CHARINDEX(@SplitChar, @sTextData) - 1); 
			SET @word = LTRIM(RTRIM(@word)); -- 반환된 문자는 버린후 좌우공백 제거 
			SET @sTextData = LTRIM(RTRIM(RIGHT(@sTextData, LEN(@sTextData) - (LEN(@word) + 1)))) 
		END 
		ELSE BEGIN 
			SET @word = NULL; 
			 END 
		SET @num = @num + 1 
		END 
		RETURN(@word); 
END
