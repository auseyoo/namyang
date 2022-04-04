<!-- 
	@File Name: othComPrdPop
	@File 설명 : 타사제품 조회
	@UI ID : UI-PORD-0601P1.html
	@작성일 : 2022. 3. 3.
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
	var myGridID;
	
	$(document).ready(function(){
		// AUIGrid 생성 후 반환 ID
		createAUIGrid();
	
		//타사제품 조회
		selectOthComPrdList();
	
		//셀클릭 이벤트
		AUIGrid.bind(myGridID, "cellClick", function(event) {
			var cnt = 0;
			
			$.each(AUIGrid.getGridData(mGrid2), function(k,v){
				var prdDtlCd = AUIGrid.getCellValue(mGrid2, k, "prdDtlCd");
				if( prdDtlCd == event.item.prdDtlCd ) cnt++;
			});
				
			if( cnt > 0 ){
				//이미 추가된 제품입니다.\n다시 확인해 주세요.
				var popupParam = [];
				popupParam.data = {
						title : "타사제품 조회",
						message : "<spring:message code='alert.othComPrdPop2'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			} else {
				var col = AUIGrid.getSelectedIndex( mGrid2 );
				if( AUIGrid.getDataFieldByColumnIndex( mGrid2 , col[1] ) == "prdDtlCd"){
					AUIGrid.updateRow( mGrid2 , event.item , col[0] );
					//그리드 초기화
					AUIGrid.destroy( "#grid_wrap_ocp" );
					//팝업 닫기
					$.closeDialog("othComPrdPop");
				}
			}
		});
				
		//팝업 닫기 이벤트
		$(".modalCloseBtn").on("click", function(){
			AUIGrid.destroy( "#grid_wrap_ocp" );
			$.closeDialog("othComPrdPop");
		});
	
		//조회 이벤트
		$("#searchBtn").on("click", function(){
			//타사제품 조회
			selectOthComPrdList();
		});
			
	});
	
	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			editable : false,
			showFooter : false,
			selectionMode : "singleRow",
		}
	
		// 실제로 #grid_wrap 에 그리드 생성
		myGridID = AUIGrid.create("#grid_wrap_ocp", columnLayout, gridPros);
	}
	
	var columnLayout = [
			{
				dataField : "prdDtlCd",
				headerText : "제품코드",
				width : "20%",
			},{
				dataField : "stdPrdNm",
				headerText : "제품명",
				style : "auiLeft"
			}
	];
	
	function selectOthComPrdList(){
		var item = { "puchSeq" : "${ puchSeq }",
					 "prdDtlCd" : $("#frm #prdDtlCd").val(),
					 "stdPrdNm" : $("#frm #stdPrdNm").val()
					};
		$.ajax({
			url : "/agn/selectOthComPrdList.do", 
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify( item ),
			success : function(data) {
				if( data.list.length == 0 ){
					var popupParam = [];
						
					popupParam.data = {
							title : "타사제품 조회",
							message : "<spring:message code='alert.othComPrdPop1'/>",
							showBtn1 : 'Y',
							btn1Func : goStdPrdCdMng,
							showBtn2 : 'Y'
					}
						
					layerAlert(popupParam);
					return;
						
				}else{
					AUIGrid.setGridData( myGridID , data.list );
					$("#listLength").html( data.list.length );
				}
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	
	//타사제품 코드관리 페이지로 이동
	function goStdPrdCdMng(){
		location.href = '/std/stdPrdCdMng.do';
	}
</script>

<div class="modal_bg" style="display:block;"></div> <!-- modal 배경 -->
<!-- 타사제품 조회 -->
<div class="popWrap mideum modal_wrap h600" data-popup="modalAgencyViews"> <!-- small 사이즈 600px * 370px -->
	<header>
		<h3>타사제품 조회</h3>
		<button type="button" name="" class="closeBtn modalCloseBtn" id="modalCloseBtn"></button>
	</header>
	<!-- popCon -->
	<div class="popCon">
		<div class="popTitArea">
			<h3>타사제품 조회</h3>
			<div class="popBtnArea">
				<!--<button type="button" name="" class="inquBtn">저장</button>-->
				<button type="button" name="" class="comBtn modalCloseBtn" id="modalCloseBtn">닫기</button>
			</div>
		</div>
		<form id="frm">
			<div class="inquiryBox">
				<dl>
					<dt>제품</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="prdDtlCd" class="inp w120 mr10" value="" name="prdDtlCd" placeholder="제품코드">
							<input type="text" id="stdPrdNm" class="inp w160 mr7" value="" name="stdPrdNm" placeholder="제품명">
							<button type="button" name="" class="comBtn" id="searchBtn">조회</button>
						</div>
					</dd>
				</dl>
			</div>
		</form>
		
		<p class="numState">
			<em>총 <span class="pColor01 fb" id="listLength">0</span></em> 건 이 조회되었습니다.
		</p>
		<div class="girdBox ">
			<div id="grid_wrap_ocp"></div>
		</div>
		
	</div>
	<!-- popCon -->
</div>
<!--// 타사제품 조회 -->