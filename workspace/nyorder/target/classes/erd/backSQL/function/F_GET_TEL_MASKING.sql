USE [NY_ORDER]
GO
/****** Object:  UserDefinedFunction [dbo].[F_GET_TEL_MASKING]    Script Date: 2022-03-15 오후 12:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gain
-- Create date: 2022-01-21
-- Description:	전화번호 마스킹
-- =============================================
ALTER FUNCTION [dbo].[F_GET_TEL_MASKING](@STR VARCHAR(50),@PRT INT)
RETURNS VARCHAR(50)
AS
-- (@PRT = 0)가운데 자리을 마스킹
-- (@PRT = 1)뒤 4자리를 마스킹
     BEGIN
         DECLARE @RTNVALUE VARCHAR(50), @STRLEN INT, @VSTR VARCHAR(50);
         --SET @VSTR = REPLACE(REPLACE(@STR, ' ', ''), '-', '');
        	SET @VSTR = dbo.F_TRAN_NO(@STR);
         SET @STRLEN = LEN(@VSTR);
         IF @STRLEN < 7
             BEGIN
                 SET @RTNVALUE = @VSTR;
        	 END;
         ELSE
             IF @STRLEN = 7
                 BEGIN
 	                 IF @PRT = 0
	                 	BEGIN 
		                 	SET @RTNVALUE = '***-' + RIGHT(@VSTR, 4);
	                 	END;
	                 ELSE
	               		  IF @PRT = 1
	                 		BEGIN
	                			SET @RTNVALUE = LEFT(@VSTR, 3) + '-****'; 		
	                 		END;
                 END;
              ELSE
              	IF @STRLEN = 8
                     BEGIN
	                     IF @PRT = 0
	                    	 BEGIN
		                 		SET @RTNVALUE = '****-' + RIGHT(@VSTR, 4);    
	                     	 END;
                         ELSE
                         	IF @PRT = 1
                        	 BEGIN
	                     		SET @RTNVALUE = LEFT(@VSTR, 4) + '-****';    
                        	 END;
              		  END;
               ELSE
              	IF @STRLEN = 9
             		BEGIN
                         IF @PRT = 0
                         	BEGIN
                     			SET @RTNVALUE = LEFT(@VSTR, 2) + '-***-'	+ RIGHT(@VSTR, 4);    	
                         	END;
                         ELSE
                 	    	IF @PRT = 1
                     		BEGIN
	                     		SET @RTNVALUE = LEFT(@VSTR, 2)+ '-' + SUBSTRING(@VSTR, 3, 3) +'-****'; 
                    		END;
                 	END;
               ELSE
               IF @STRLEN = 10
                         BEGIN
                             IF LEFT(@VSTR, 2) = '02'
                                 BEGIN
                                 	IF @PRT = 0
                                 		BEGIN
	                                		SET @RTNVALUE = LEFT(@VSTR, 2) + '-****-' + RIGHT(@VSTR, 4); 		
                     			 		END;
                                 	ELSE 
                                 	IF @PRT = 1
                                     	BEGIN
	                                 		SET @RTNVALUE = LEFT(@VSTR, 2) + '-' + SUBSTRING(@VSTR, 3, 4) + '-****';    	
                                     	END;
                       		    END;
                             ELSE
                                 BEGIN
	                                 IF @PRT = 0
	                                 	BEGIN
		                                 	SET @RTNVALUE = LEFT(@VSTR, 3) + '-***-' + RIGHT(@VSTR, 4);
	                                 	END;
	                                 ELSE
	                                 	IF @PRT = 1
	                                 		BEGIN
		                                 		SET @RTNVALUE = LEFT(@VSTR, 3) + '-' + SUBSTRING(@VSTR, 4, 3) + '-****';
	                                  		END;
                       	     	END;
                     	END;
                 ELSE
                IF @STRLEN = 11
                         BEGIN
	                         IF @PRT = 0
	                         	BEGIN
		                         	SET @RTNVALUE = LEFT(@VSTR, 3) + '-****-' + RIGHT(@VSTR, 4);
	                         	END;
	                         ELSE
	                   	IF @PRT = 1
	                         		BEGIN
		                    			 SET @RTNVALUE = LEFT(@VSTR, 3) + '-' + SUBSTRING(@VSTR, 4, 4) + '-****';     		
	                         		END;
         			     END;
		    ELSE
                 BEGIN
                     SET @RTNVALUE = @VSTR;
            	 END;
         RETURN @RTNVALUE;
     END;
