<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>


<script type="text/javascript">

</script>

<script type="text/javascript">
    var myGridID;
    var gridData = [
			{"id":"#Cust0","code":"FG51000","name":"김남양","authority":"점주","state":"사용","quantity":3,"phone":"010-8000-0007","regiDate":"2014-10-07","stopDate":"2014-10-07","worker":"김동주","workDate":"2014-10-07"},
			{"id":"#Cust1","code":"FG51000","name":"남양순","authority":"판매원","state":"중지","quantity":1,"phone":"010-8000-0007","regiDate":"2014-10-07","stopDate":"2014-10-07","worker":"류태준","workDate":"2014-10-07"}
		];
   

    // AUIGrid 칼럼 설정
    // 데이터 형태는 다음과 같은 형태임,
    //[{"id":"#Cust0","date":"2014-09-03","name":"Han","country":"USA","product":"Apple","color":"Red","price":746400}, { .....} ];
    
    
    // AUIGrid 를 생성합니다.
    function createAUIGrid(columnLayout) {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 29,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)                editable : false,
                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "multipleCells",                
                // 컨텍스트 메뉴 사용 여부 (기본값 : false)
                useContextMenu : true,                
                // 필터 사용 여부 (기본값 : false)
                enableFilter : true,            
                // 그룹핑 패널 사용
                useGroupingPanel : false,                
                // 상태 칼럼 사용
                showStateColumn : true,                
                // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
                displayTreeOpen : true,                
                noDataMessage : "출력할 데이터가 없습니다.",                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
        };
    
        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);

    	// 셀 클릭 이벤트 바인딩
    	AUIGrid.bind(myGridID, "cellClick", function(event) {
    		console.log(" ( " + event.rowIndex + ", " + event.columnIndex + ") :  " + event.value + " clicked!!");

    		var rowNo = event.rowIndex;

    		setDetailInfo(rowNo);
    		
    	});
    }

    var columnLayout = [{
            dataField : "emplCd",
			headerText : "직원코드",
			width : "10%",
			style : "myLinkStyle"
			
		},{
			dataField : "emplSeq",
			headerText : "직원시퀀스",			
			//visible : false 		
			
		},{
			dataField : "emplNm",
			headerText : "성명",
			width : "10%",
			style : "myLinkStyle"
					
		},{
			dataField : "emplSecCd",
			headerText : "권한코드",			
			visible : false 		
			
		},{
			dataField : "emplSecNm",
			headerText : "권한",
			width : "10%"					
		},{
			dataField : "reteYn",
			headerText : "상태",
			width : "10%",
			visible : false 
		},{
			dataField : "reteYnNm",
			headerText : "상태",
			width : "10%"
		},{
			dataField : "mobNo",
			headerText : "휴대폰번호",			
			width : "10%"
		},{
			dataField : "regDtm",
			headerText : "가입일자",
			width : "10%"
		},{
			dataField : "reteDt",
			headerText : "중지일자",
			width : "10%"
		},{
			dataField : "updNm",
			headerText : "작업자",
			width : "10%"
		},{
			dataField : "updDtm",
			headerText : "작업일시",
		}
	];

    function setDetailInfo(rowNo){
    	$("#emplNm").val(AUIGrid.getCellValue(myGridID, rowNo, "emplNm"));    	
    	$("#emplCd").val(AUIGrid.getCellValue(myGridID, rowNo, "emplCd"));
    	$("#emplSeq").val(AUIGrid.getCellValue(myGridID, rowNo, "emplSeq"));
    	
    	$("#tdEmplCd").text(AUIGrid.getCellValue(myGridID, rowNo, "emplCd"));    	
    	
    	$("#mobNo").val(AUIGrid.getCellValue(myGridID, rowNo, "mobNo"));
    	$("#emplSecCd").val(AUIGrid.getCellValue(myGridID, rowNo, "emplSecCd"));
    	$("#reteYn").val(AUIGrid.getCellValue(myGridID, rowNo, "reteYn"));

		let emplEml = AUIGrid.getCellValue(myGridID, rowNo, "emplEml");

		console.log("setDetailInfo emplSeq ::" + AUIGrid.getCellValue(myGridID, rowNo, "emplSeq"));
    	
    	$("#email1").val(emplEml.substr(0, emplEml.indexOf("@")));
    	$("#email2").val(emplEml.substr(emplEml.indexOf("@") + 1));

    	$("#zipCd").val(AUIGrid.getCellValue(myGridID, rowNo, "zipCd"));
    	$("#addr1").val(AUIGrid.getCellValue(myGridID, rowNo, "addr1"));
    	$("#addr2").val(AUIGrid.getCellValue(myGridID, rowNo, "addr2"));
    			

    }

 	function setListform(param) {

    	console.log("setListform param ::" + JSON.stringify(param));

    	var selEmplSec = $("#selEmplSec option:selected").val();
    	var selReteYn = $("#selReteYn option:selected").val();
    	var emplNm = $("#searchEmplNm").val();

    	var paramData = {"emplSecCd": selEmplSec, "reteYn": selReteYn, "emplNm" : emplNm, "saleCd" : "test"};
    	console.log("setListform paramData ::" + JSON.stringify(paramData)); 
		
        $.ajax({
            cache : false,
            url : "/myp/selectAgentMngList.do", 
            type : 'POST', 
            data : paramData, 
            success : function(data) {

            	console.log("success data ::" + JSON.stringify(data));
               	AUIGrid.setGridData(myGridID, data.list);

               	$("#totalRow").html(data.totalRow);
            	
            }, // success 
            error : function(xhr, status) {
            	console.log("xhr==" + JSON.stringify(xhr));
                alert(xhr + " : " + status);
            }
        }); 		
		
	}

	function changeEmailSelect(event){
		console.log("event==" + JSON.stringify(event));
		var value = $("#sel_email option:selected").val();
		console.log("value==" + JSON.stringify(value));
		if(value == ""){
			$("#email2").val("");	
			$("#email2").attr("readonly", false);
		}else{
			$("#email2").attr("readonly", true);
			$("#email2").val(value);
		}
	}

	function createEmpl(){

		$("#emplFrm")[0].reset();
		$("#tdEmplCd").text("");
		$("#emplCd").val("");
    	$("#emplSeq").val("");    	

	}

	function emplSave(){

		let formData = $("#emplFrm").serialize();

		console.log("emplSave formData::" + JSON.stringify(formData));
		let telNo = $("#telNo1").val() + $("#telNo2").val()+ $("#telNo3").val();  
		let mobNo = $("#mobNo1").val() + $("#mobNo2").val()+ $("#mobNo3").val();

		formData = formData + "&emplEml=" + $("#email1").val() + "@" + $("#email2").val()+ "&telNo=" + telNo + "&mobNo=" + mobNo;
		
		$.ajax({
            cache : false,
            url : "/myp/insertAgentMng.do", 
            type : 'POST', 
            data : formData, 
            success : function(data) {

            	alert("저장되었습니다.");
            	setListform();
            	console.log("success data ::" + JSON.stringify(data));
               	//AUIGrid.setGridData(myGridID, data.list);

               	//$("#totalRow").html(data.totalRow);
            	
            }, // success 
            error : function(xhr, status) {
            	console.log("xhr==" + JSON.stringify(xhr));
                alert(xhr + " : " + status);
            }
        }); 	

	}
     

     // 윈도우 리사이징 이벤트
    window.onresize = function() {
        // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
        if (typeof myGridID !== "undefined") {
            AUIGrid.resize(myGridID);
        }
    };
    
    


    $(document).ready(function(){
    
        // AUIGrid 생성 후 반환 ID
        createAUIGrid(columnLayout);
        
        $("#btnStaffSearch").on("click", setListform);
        
        
        let popupObj = {};
        
        popupObj.title = "주문등록";
        popupObj.message = '<spring:message code="alert.test2" arguments="${\'me\'}, ${\'한글\'}" />';        
        //popupObj.showBtn1 = 'Y';
        //popupObj.btn1Label = "확인";
        //popupObj.btn1Func = setListform;        
        popupObj.showBtn2 = 'N';
        //popupObj.btn2Label = "취소";
        //popupObj.btn2Func = "";        
        
        //$("#btnStaffSearch").on("click", popupObj, layerAlert);
        
        $("#createBtn").on("click", createEmpl);
        $("#saveBtn").on("click", emplSave);
        
        $("#sel_email").on("change", changeEmailSelect); 
    });

</script>

<body>
	<div class="content">
    	<tiles:insertAttribute name="body.breadcrumb"/>

        <!-- 조회 -->
        <div class="inquiryBox">
            <dl>
                <dt>권한</dt>
                <dd>
                    <select name="" class="sel" id="selEmplSec">
                        <option value="">전체</option>
                        <c:forEach var="name" items="${emplCode}" varStatus="status">
        					<option value="<c:out value="${name.commCd}" />" ><c:out value="${name.commNm}" /></option>
    					</c:forEach>
                    </select>
                </dd>
                <dt>상태</dt>
                <dd>
                    <select name="" class="sel w160" id="selReteYn">
                        <option value="">전체</option>
                        <option value="N">사용</option>
                        <option value="Y">중지</option>
                    </select>
                </dd>
                <dt>성명</dt>
                <dd>
                    <div class="formWrap">
                        <input type="text" id="searchEmplNm" class="inp" value="" title="성명 입력">
                        <button type="button" name="" class="comBtn" id="btnStaffSearch" >조회</button>
                    </div>
                </dd>
            </dl>

            <div class="btnGroup right">
                <button type="button" name="" class="comBtn" id="createBtn">신규</button>                
                <button type="button" name="" class="inquBtn" id="saveBtn">저장</button>
            </div>
        </div>
        <!-- 조회 -->

        <div class="titleArea">
            <h3 class="tit01">직원정보</h3>
            <p class="numState">
                <em>총 <span class="pColor01 fb" id="totalRow">0</span></em> 건 이 조회되었습니다.
            </p>
        </div>

        <!-- grid -->
        <div class="girdBox">
            <div id="grid_wrap"></div>
        </div>
        <!-- grid -->

        <div class="titleArea right">
            <h3 class="tit01">직원정보 상세</h3>

            <p class="txt01"><i class="icoRequir"></i>필수 입력 항목입니다.</p>
        </div>

        <div class="tblWrap">
        	<form name="emplFrm" id="emplFrm">
            <table class="tbl">
                <caption>직원정보 상세</caption>
                <colgroup>
                    <col style="width:170px;">
                    <col>
                    <col style="width:170px;">
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">
                            <label for="emplNm" class="required" title="필수입력">성명</label>
                        </th>
                        <td>
                            <input type="text" id="emplNm" class="inp" value="" name="emplNm" maxlength="30" required >
                        </td>
                        <th scope="row">
                            <label for="inp_employee_code">직원코드</label>
                        </th>
                        <td>
                        	<label for="inp_employee_code" id="tdEmplCd"></label>                        
                        	<input type="hidden" id="emplCd" class="inp" value="" name="emplCd" >                            
                        	<input type="hidden" id="emplSeq" class="inp" value="" name="emplSeq"  >
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="mobNo" class="required" title="필수입력">휴대폰 번호</label>
                        </th>
                        <td>
                            <div class="formWrap">
                                <select name="mobNo1" class="sel" id="mobNo1">
                                    <option>010</option>
                                    <option>011</option>
                                    <option>016</option>
                                    <option>019</option>
                                </select>                                            
                                <span class="dash"></span>
                                <input type="text" id="mobNo2" class="inp" value="" name="mobNo2">
                                <span class="dash"></span>
                                <input type="text" id="mobNo3" class="inp" value="" name="mobNo3">
                            </div>   
                        </td>
                        <th scope="row">
                            <label for="sel_authority">권한</label>
                        </th>
                        <td>
                            <select name="emplSecCd" class="sel w160" id="emplSecCd">
                                <c:forEach var="name" items="${emplCode}" varStatus="status">
        							<option value="<c:out value="${name.commCd}" />" ><c:out value="${name.commNm}" /></option>
    							</c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="inp_em_contact01">비상연락처1</label>
                        </th>
                        <td>
                            <div class="formWrap">
                                <input type="text" id="telNo1" class="inp" value="" name="telNo1"> <span class="dash"></span>                                          
                                <input type="text" id="telNo2" class="inp" value="" name="telNo2"> <span class="dash"></span>
                                <input type="text" id="telNo3" class="inp" value="" name="telNo3">
                            </div>
                        </td>
                        <th scope="row">
                            <label for="reteYn">상태</label>
                        </th>
                        <td>
                            <select name="reteYn" class="sel w160" id="reteYn">                                
		                        <option value="N">사용</option>
		                        <option value="Y">중지</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="inp_email01">이메일 주소</label>
                        </th>
                        <td>
                            <div class="formWrap email">
                                <input type="text" id="email1" class="inp w160" value="" maxlength="80" name="email1"> <span class="divi"> @ </span>
                                <input type="text" id="email2" class="inp mr10" value="" name="email2" readonly>

                                
                            </div>
                        </td>
                        <th scope="row">
                             <label for="inp_pass01">임시비밀번호</label>
                         </th>
                         <td>
                             <input type="password" id="inp_pass01" class="inp w160">
                         </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="inp_post_num">우편번호</label>
                        </th>
                        <td colspan="3">
                            <div class="postWrap w200">
                                <input type="text" id="zipCd" class="inp" value="" name="zipCd" readonly>
                                <button type="button" class="postBtn" title="우편번호 찾기" onclick="fnSetPostcode('#zipCd', '#addr1');"></button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="addr1">주소</label>
                        </th>
                        <td>
                            <input type="text" id="addr1" class="inp" value="" name="addr1" readonly>
                        </td>
                        <th scope="row">
                            <label for="addr2">상세주소</label>
                        </th>
                        <td>
                            <input type="text" id="addr2" class="inp" value="" name="addr2" maxlength="500">                            
                        </td>
                    </tr>
                    <tr>
	                    <th scope="row">
	                        <label for="sel_bank01">은행/계좌번호</label>
	                    </th>
	                    <td>
	                        <div class="formWrap">
	                        	<code:makeSelect commGrpCd="BANK_CD" var="bankCdList" name="bankCd" all="false" classNm="sel w160 mr10" />	                            
		                        ${bankCdList}
	                            <input type="text" id="inp_bank01" class="inp">
	                        </div>
	                    </td>
	                    <th scope="row">
	                        <label for="inp_account_name01">예금주</label>
	                    </th>
	                    <td>
	                        <input type="text" id="inp_account_name01" class="inp">
	                    </td>
	                </tr>
	                <tr>
	                    <th scope="row">
	                        <label for="sel_bank02">은행/계좌번호</label>
	                    </th>
	                    <td>
	                        <div class="formWrap">
	                        	<code:makeSelect commGrpCd="BANK_CD" var="bankCdList2" name="bankCd2" all="false" classNm="sel w160 mr10" />
	                            ${bankCdList}
	
	                            <input type="text" id="inp_bank01" class="inp">
	                        </div>
	                    </td>
	                    <th scope="row">
	                        <label for="inp_account_name02">예금주</label>
	                    </th>
	                    <td>
	                        <input type="text" id="inp_account_name02" class="inp">
	                    </td>
	                </tr>
                </tbody>
            </table>
            </form>
        </div>
    </div>


</body>
</html>