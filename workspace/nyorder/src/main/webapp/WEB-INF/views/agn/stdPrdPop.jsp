<!-- 
	@File Name: stdPrdPop
	@File 설명 : 표준제품 조회
	@UI ID : UI-PSTD-0202P3.html
	@작성일 : 2022. 3. 4.
	@작성자 : 윤이준
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<code:makeSelect commGrpCd="TAXT_CD" var="taxtCdList" name="taxtCd"	all="false" />

<script type="text/javascript">
	var myGridStdPrd;//제품조회 그리드
	
	$(document).ready(function(){
		//그리드 생성
		createAUIGrid();
		
		//제품조회 셀 클릭이벤트
		AUIGrid.bind(myGridStdPrd, "cellClick", function(event) {
			var cnt = 0;
			$.each(AUIGrid.getGridData(myGridID), function(k,v){
				var prdSapCd = AUIGrid.getCellValue(myGridID, k, "prdSapCd");
				if( prdSapCd == event.item.prdSapCd ) cnt++;
			});
			
			if( cnt > 0 ){
				//이미 추가된 제품입니다.\n다시 확인해 주세요.
				var popupParam = [];
				popupParam.data = {
						title : "주문등록",
						message : "<spring:message code='alert.ordReg3'/>",
						showBtn2 : 'N'
				}
				layerAlert(popupParam);
				return;
			} else {
				var col = AUIGrid.getSelectedIndex( myGridID );
				if( AUIGrid.getDataFieldByColumnIndex( myGridID , col[1] ) == "prdSapCd"){
					AUIGrid.updateRow( myGridID , event.item , col[0] );
					//그리드 초기화
					AUIGrid.destroy( "#grid_wrap_stdPrd" );
					//팝업 닫기
					$.closeDialog("stdPrdPop");
				}
			}
		});
		
		/* 검색 멀티 콤보 이벤트 바인드 */
		$(".prdCls").change(function(){
			var target = $(this).data("clsTarget");
			setMultiCombo(target);
		});
		
		//제품조회 팝업 조회 클릭이벤트
		$("#srchBtn").on("click",mstSearchList);

		//팝업 닫기 이벤트
		$(".modalCloseBtn").on("click", function(){
			AUIGrid.destroy( "#grid_wrap_stdPrd" );
			$.closeDialog("stdPrdPop");
		});
		
	});
	
	/* 검색 멀티콤보 설정 */
	function setMultiCombo(type){
		$("#"+type+"cls option").remove();
		switch(parseInt($("#"+type+"cls").data("clsLvl"))){
			case 2 : {
				$("#mcls option").remove();
				$("#mcls").append("<option value=''>중분류</option>");
			}
			case 3 : {
				$("#scls option").remove();
				$("#scls").append("<option value=''>소분류</option>");
			}
			case 4 : {
				$("#dcls option").remove();
				$("#dcls").append("<option value=''>세분류</option>");
			}
		}
		if(fnIsEmpty($("#lcls").val())){ return;}
		$.ajax({
			url : "/comm/selectPrdCls.do", 
			type : 'POST', 
			data : $("#popFrm").serialize(),
			success : function(data) {
				$("#"+type+"cls").append($("#codeTmpl").tmpl({"codeList": data}));
			},
			error : function(xhr, status) {
			}
		}); 	
		
	}
	
	/* 남양제품 조회 팝업 - 리스트 조회 */
	function mstSearchList(){
		var popupParam = [];
		
		if( fnIsEmpty($("#lcls").val())){
			popupParam.data = {
				title : "남양제품 조회",
				message : "<spring:message code='alert.noSelect' arguments="${'대분류'}"/>",
				showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}
		if( fnIsEmpty($("#mcls").val())){
			popupParam.data = {
				title : "남양제품 조회",
				message : "<spring:message code='alert.noSelect' arguments="${'중분류'}"/>",
				showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}
		if( fnIsEmpty($("#scls").val())){
			popupParam.data = {
				title : "남양제품 조회",
				message : "<spring:message code='alert.noSelect' arguments="${'소분류'}"/>",
				showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}
		if( fnIsEmpty($("#dcls").val())){
			popupParam.data = {
				title : "남양제품 조회",
				message : "<spring:message code='alert.noSelect' arguments="${'세분류'}"/>",
				showBtn2 : 'N'
			}
			layerAlert(popupParam);
			return;
		}
	
		$.ajax({
			url : "/agn/selectPrdMstSapList.do", 
			type : 'POST', 
			data : $("#popFrm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(myGridStdPrd, data);
				$("#mstCnt").html(data.length);
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}

	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		//표준제품 조회 그리드 속성
		var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : false,
			autoGridHeight : true,
			showRowCheckColumn : false // 체크박스 사용
		};
		
		var columnLayout = [
			{
				dataField : "prdSapCd",
				headerText : "제품코드",
				width : "10%" ,
				style : "auiLink"
			},{
				dataField : "prdNm",
				headerText : "제품명",
				style : "auiLeft"
			},{
				dataField : "lclsNm",
				headerText : "제품 대분류",
			},{
				dataField : "mclsNm",
				headerText : "제품 중분류",
			},{
				dataField : "sclsNm",
				headerText : "제품 소분류",
			},{
				dataField : "dclsNm",
				headerText : "제품 세분류",
			},{
				dataField : "ordUseYnTx",
				headerText : "주문여부",
			}
		];
		
		// 실제로 #grid_wrap_stdPrd 에 그리드 생성
		myGridStdPrd = AUIGrid.create("#grid_wrap_stdPrd", columnLayout, gridPros);
	};
</script>
<!-- 표준제품 등록 -->


<div class="popArea">
	<div class="popWrap large modal_wrap">
		<header>
			<h3>남양제품 조회</h3>
		</header>  
	
		<!-- popCon -->
		<div class="popCon">
			<div class="popTitArea">
				<h3>남양제품 조회</h3>
				<div class="popBtnArea">
					<button type="button" class="comBtn modalCloseBtn ui-dialog-titlebar-close" id="closeBtn">닫기</button>
				</div>
			</div>
	
			<!-- 조회 -->
			<form id="popFrm" method="post">
				<div class="inquiryBox">
					<dl>
						<dt>자재 그룹</dt>
						<dd>
							<div class="formWrap">
								<select name="prdType" class="sel w120" id="prdType">
									<option value="">전체</option>
									<option value="FER1">제품</option>
									<option value="ERS1">크레이트</option>
									<option value="HAW2">판촉물</option>
								</select>
							</div>
						</dd>
						<dt>분류</dt>
						<dd>
							<div class="formWrap">
								<input type="hidden" id="prdType" name="prdType"/>
								<select name="lcls" class="sel w120 mr10 prdCls" id="lcls" data-cls-target="m" data-cls-lvl="1">
									<option value="">대분류</option>
									<c:forEach items="${lclsList}" var="i" >
										<option value="${i.code}">${i.name}</option>
									</c:forEach>
								</select>
								<select name="mcls" class="sel w120 mr10 prdCls" id="mcls" data-cls-target="s" data-cls-lvl="2">
									<option value="">중분류</option>
								</select>
								<select name="scls" class="sel w120 mr10 prdCls" id="scls" data-cls-target="d" data-cls-lvl="3">
									<option value="">소분류</option>
								</select>
								<select name="dcls" class="sel w120" id="dcls" data-cls-lvl="4">
									<option value="">세분류</option>
								</select>
							</div>
						</dd>
						<dt>제품</dt>
						<dd>
							<div class="formWrap">
								<input type="text" id="srcPrdCd" 	class="inp w120 mr10"	value="" 	name="srcPrdCd"		placeholder="제품코드" maxlength="8">
								<input type="text" id="srcPrdNm" 	class="inp w160 mr7"	value="" 	name="srcPrdNm"		placeholder="제품명">
		
								<button type="button" name="srchBtn" class="comBtn" id="srchBtn">조회</button>
							</div>
						</dd>
					</dl>
				</div>
			</form>
			<!-- 조회 -->
	
			<p class="numState">
				<em>총 <span class="pColor01 fb" id="mstCnt">0</span></em> 건 이 조회되었습니다.
			</p>
			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap_stdPrd"></div>
			</div>
			<!-- grid -->
		</div>
		<!-- popCon -->
	</div>
</div>
<script id="codeTmpl" type="text/x-jquery-tmpl">
{{each(i, e) codeList }}
	<option value='\${e.code}'>\${e.name}</option>
{{/each}}
</script>