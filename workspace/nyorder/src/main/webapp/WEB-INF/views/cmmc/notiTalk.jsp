<!-- 
	@File Name: 
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 2. 21.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">
    var myGridID;
    var gridData = [
			{"id":"#Cust0","area":"신사4동","code":53665,"order":2,"code":1234567,"name":"이남양","phoneNm":"010-8888-1515","address":"학동로 100-10, 1층","regiPath":"직영몰","tel":"010-9455-4560","regiState":"거래중","collState":"불량"},
			{"id":"#Cust1","area":"신사4동","code":53665,"order":2,"code":1234567,"name":"이남양","phoneNm":"010-8888-1515","address":"학동로 100-10, 1층","regiPath":"직영몰","tel":"010-9455-4560","regiState":"거래중","collState":"불량"}
		];
   
   	$(document).ready(function(){
        // AUIGrid 생성 후 반환 ID
        createAUIGrid(columnLayout);
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.        
        
        AUIGrid.setGridData(myGridID, gridData);
	    //AUIGrid.setFooter(myGridID, footerLayout);
    });
    
   
    // AUIGrid 를 생성합니다.
    function createAUIGrid(columnLayout) {
        // 그리드 속성 설정
        var gridPros = {
                headerHeight : 29,
                rowHeight : 29,
                // 편집 가능 여부 (기본값 : false)
                editable : true,
                
                // 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
                enterKeyColumnBase : true,
				showRowCheckColumn : true, // 체크박스 사용

				showRowNumColumn : true, 
                
                // 셀 선택모드 (기본값: singleCell)
                selectionMode : "multipleCells",
                showFooter : false,
                
                // 컨텍스트 메뉴 사용 여부 (기본값 : false)
                useContextMenu : true,
                
                // 필터 사용 여부 (기본값 : false)
                enableFilter : true,
            
                // 그룹핑 패널 사용
                useGroupingPanel : false,
                
                
                // 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
                displayTreeOpen : true,
                
                noDataMessage : "출력할 데이터가 없습니다.",
                
                groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
                
        };
    
        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        
    }

    var columnLayout = [{
			dataField : "area",
			headerText : "지역",
			width : "10%",
        },{
			dataField : "order",
			headerText : "순서",
			width : "4%"
        },{
			dataField : "code",
			headerText : "코드",
            width : "8%",
        },{
			dataField : "name",
			headerText : "성명",
			width : "8%",
        },{
			dataField : "phoneNm",
			headerText : "휴대폰번호",
			width : "10%",
        },{
			dataField : "tel",
			headerText : "전화번호",
			width : "10%",
        },{
			dataField : "address",
			headerText : "배달주소",
			style: "auiLeft"
		},{
			dataField : "regiPath",
			headerText : "가입경로",
            dataType : "numeric",
			width : "8%",
		},{  
			dataField : "regiState",
			headerText : "계약상태",
			width : "8%",
        },{
			dataField : "collState",
			headerText : "수금상태",
            width : "8%",   
		}
	];

</script>
<body>
	<div class="content">
    	<tiles:insertAttribute name="body.breadcrumb" />

        <!-- 조회 -->
        <div class="inquiryBox">
        	<dl>
				<dt>지역</dt>
                	<dd>
						<select name="" class="sel">
							<option>전체</option>
							<option>논현동</option>
							<option>역삼동</option>
						</select>
                    </dd>
				<dt>상태</dt>
                    <dd>
						<select name="" class="sel">
							<option>전체</option>
							<option>논현동</option>
							<option>역삼동</option>
						</select>
                    </dd>
				<dt>구분</dt>
               	<dd>
					<div class="formWrap">
						<select name="" class="sel mr10">
							<option>전체</option>
							<option>구분</option>
							<option>구분</option>
						</select>
		
						<input type="text" id="inp_name01" class="inp w160" value="" title="제품 입력">
		
						<button type="button" name="" class="comBtn">조회</button>
					</div>
                </dd>
			</dl>

			<div class="btnGroup right">
            	<button type="button" name="" class="inquBtn">발송</button>
            </div>
		</div>
        <!-- 조회 -->

		<div class="txtInfo pColor02">
        	※ 발송 상태/현황, 사용금액 등 통계는 <a href="<c:out value='${bizPpuridUrl}'/>" target="_blank">서비스 제공 업체의 페이지</a>” (← 클릭하여 바로가기)에서 확인할 수 있습니다.
        </div>

        <!-- grid -->
        <div class="girdBox">
            <div id="grid_wrap"></div>
        </div>
        <!-- grid -->

    </div>

</body>
</html>