

EXEC master.dbo.sp_addlinkedserver  			
	@server = N'SI_MDB' 
	, @srvproduct = N'Access' 
	, @provider = N'Microsoft.ACE.OLEDB.12.0'
	, @datasrc =  N'E:\NY_ORDER_MDB\SI_1201967.MDB'
	, @provstr = N';PWD=persys21' -- 파일 암호
;


EXEC master.dbo.sp_addlinkedsrvlogin
    @rmtsrvname = N'SI_MDB'
    , @useself = FALSE
    , @locallogin = NULL
    , @rmtuser = ADMIN      
    , @rmtpassword = NULL 
;

select * from SI_MDB...parts;

--------------------------------------------

EXEC master.dbo.sp_addlinkedserver  			
	@server = N'BA_MDB' 
	, @srvproduct = N'Access' 
	, @provider = N'Microsoft.ACE.OLEDB.12.0'
	, @datasrc =  N'E:\NY_ORDER_MDB\Pams21_01.MDB'
	,@provstr = N';PWD=qkdvksqlalfqjsgh' -- 파일 암호
;


EXEC master.dbo.sp_addlinkedsrvlogin
    @rmtsrvname = N'BA_MDB'			--servername
    , @useself = FALSE    
    , @locallogin = NULL        
    , @rmtuser = Admin       
    , @rmtpassword = NULL ;
	
	select * from BA_MDB...parts;
--------------------------------------------	

EXEC master.dbo.sp_addlinkedserver  			
	@server = 'xxee' , 			
	@srvproduct = 'Access' , 			
	@provider = 'Microsoft.ACE.OLEDB.12.0',  		    
	@datasrc =  'E:\NY_ORDER_MDB/Pams21_01.MDB'

;


EXEC master.dbo.sp_addlinkedsrvlogin
    @rmtsrvname = N'xxee',			--servername
    @useself = FALSE,    
    @locallogin = NULL,        
    @rmtuser = Admin,       
    @rmtpassword = NULL ;

	----------------------------------parms

EXEC master.dbo.sp_addlinkedserver  			
	@server = N'PARMS' 
	, @srvproduct = '' 
	, @provider = N'SQLOLEDB'
	, @datasrc =  N'203.234.208.145'
	, @catalog = N'namyang'
	--, @provstr = N';PWD=persys21' -- 파일 암호
;


EXEC master.dbo.sp_addlinkedsrvlogin
    @rmtsrvname = N'PARMS'
    , @useself = FALSE
    --, @locallogin = NULL
    , @rmtuser = N'pams21'      
    , @rmtpassword = N'pmsorder'
;

select
*
from 
parms.namyang.dbo.smcode07
;

select
*
from
xe...address;

	EXEC sp_addlinkedserver
       @server = 'PARMS',    --연결서버명칭
       @srvproduct = '',
       @provider = 'SQLOLEDB',
       @datasrc = '203.234.208.145',    --연결서버IP
       @catalog = 'NAMYANG'            --DB명 EXEC sp_addlinkedserver


EXEC sp_addlinkedsrvlogin
      @rmtsrvname= 'PARMS',        --연결서버명칭
      @useself= 'false',
      @rmtuser = 'pams21',                    --계정명
      @rmtpassword = 'pmsorder'                     --패스워