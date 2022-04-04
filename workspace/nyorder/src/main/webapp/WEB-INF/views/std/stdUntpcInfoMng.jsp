<!-- 
	@File Name: stdPrdSearch
	@File 설명 : 제품 조회
	@UI ID : UI-PSTD-0401.html
	@작성일 : 2022.01.17
	@작성자 : 박예솔
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">
var mGrid;
var gridData = [
	{"id":"#Cust0","areaNm":"매입단가","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust1","areaNm":"지역표준단가","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust2","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust3","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust4","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust5","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust6","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust7","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust8","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust9","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust10","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust11","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust12","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust13","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust14","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust15","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust16","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust17","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust18","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust19","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust20","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust21","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust22","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""},
	{"id":"#Cust23","areaNm":"역삼동","gtS":"340","gtM":"725","gtL":"1,380","aS":999,"aM":"333","aL":"000","highCs":"000","highCm":"111","highCl":"000","baM":"","baL":"","lowL":"","stro":"","cho":"","blS":"","blL":""}  
];

$(document).ready(function(){
	// AUIGrid 생성 후 반환 ID
	createAUIGrid();
	// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.		
	
	AUIGrid.setGridData(mGrid, gridData);
	
});

var columnLayout = [
	{
		dataField : "areaNm",
		headerText : "지역명",
		style : "auiLeft"
	},{
		dataField : "gtS",
		headerText : "GT소",
		width : "5%",
		style : "auiRight"
	},{
		dataField : "gtM",
		headerText : "GT중",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "gtL",
		headerText : "GT대",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "aS",
		headerText : "아소",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "aM",
		headerText : "아중",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "aL",
		headerText : "아대",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "highCs",
		headerText : "고칼소",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "highCm",
		headerText : "고칼중",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "highCl",
		headerText : "고칼대",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "baM",
		headerText : "배중",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "baL",
		headerText : "배대",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "lowS",
		headerText : "저소",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "lowM",
		headerText : "저중",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "lowL",
		headerText : "저대",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "stro",
		headerText : "딸기",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "cho",
		headerText : "쵸코",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "blS",
		headerText : "깜소",
		width : "5%",
		style : "auiRight"			
	},{
		dataField : "blL",
		headerText : "깜대",
		width : "5%",
		style : "auiRight"			
	}
];
// 그리드 속성 설정
var gridPros = {
	headerHeight : 29,
	rowHeight : 29,
	// 편집 가능 여부 (기본값 : false)
	editable : false,
	// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
	enterKeyColumnBase : true,
	// 셀 선택모드 (기본값: singleCell)
	selectionMode : "multipleCells",
	//showFooter : true,
	// 컨텍스트 메뉴 사용 여부 (기본값 : false)
	useContextMenu : true,
	// 필터 사용 여부 (기본값 : false)
	enableFilter : true,
	// 그룹핑 패널 사용
	useGroupingPanel : false,
	// 체크박스 사용 
	showRowCheckColumn : true,
	// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
	displayTreeOpen : true,
	noDataMessage : "출력할 데이터가 없습니다.",
	groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
	// 고정 칼럼, 행에 있는 셀도 수정 가능 여부(기본값:false)
	editableOnFixedCell : true,
	fixedRowCount : 2,
	enableSorting : false,
	selectionMode : "multipleCells",
	editable : true, // 수정 모드
	// 행 고유 id 에 속하는 필드명(DB의 primary key 와 일치 시키면 유용합니다.)
	rowIdField : "id",
	// 고정 칼럼, 행에 있는 셀도 수정 가능 여부(기본값:false)
	editableOnFixedCell : true, 
	// 행 선택모드에서 옆으로 칼럼 변경할 시 selectionChange 이벤트 발생 시킬지 여부(기본값 : false)
	triggerSelectionChangeOnCell : true, 
	//softRemoveRowMode 적용을 원래 데이터에만 적용 즉, 새 행인 경우 적용 안시킴
	softRemovePolicy :"exceptNew",
	// 칼럼 끝에서 오른쪽 이동 시 다음 행, 처음 칼럼으로 이동할지 여부
	wrapSelectionMove : true,
	
	// selectionChange 이벤트 발생 시 간소화된 정보만 받을지 여부
	// 이 속성은 선택한 셀이 많을 때 false 설정하면 퍼포먼스에 영향을 미칩니다.
	// selectionChange 이벤트 바인딩 한 경우 true 설정을 권합니다.
	simplifySelectionEvent : true	   
}

//AUIGrid 를 생성합니다.
function createAUIGrid() {
	// 실제로 #grid_wrap 에 그리드 생성
	mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
}

</script>
<!-- content -->
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- tabs -->
	<div class="tabsWrap">
		<ul class="tabs">
			<li class="active" rel="tab01">지역단가 관리</li>
			<li class="" rel="tab02">애음자단가 관리</li>
		</ul>

		<!-- tabContent 전체 -->
		<div id="tab01" class="tabContent">
			 <!-- 조회 -->
			<div class="inquiryBox type02">
				<dl>
					<dt>기준일</dt>
					<dd>
						<div class="formWrap">			
							<div class="dateWrap">
								<input type="text" name="srcDate" value="10-24-1984" class="inp" id="datepicker">
								<button type="button" class="datepickerBtn" title="날짜입력"></button>
							</div>						
						</div>
					</dd>
					<dt>지역</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="areaNm" class="inp w120 mr10" value="" name="areaNm" placeholder="지역명">
							<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
						</div>
					</dd>
				</dl>
				<div class="btnGroup right">
					<button type="button" name="" class="comBtn">지역 관리</button>
					<button type="button" name="" class="inquBtn">저장</button>
				</div>
			</div>
			<!-- 조회 -->
			
			<!-- 상태정보 -->
			<div class="txtInfo">
				※ 지역표준단가는 &lt;표준제품 관리&gt; 메뉴에서 제품별로 관리할 수 있습니다.
			</div>
			<!--// 상태정보 -->


			<div class="titleArea right">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="areaCnt">24</span></em> 건 이 조회되었습니다.
				</p>
				<div class="formGroup">
					<label for="sel_puch" name="sel_puch" class="mr10">매입원가 대비</label>  
					<select name="" class="sel small w140" id="sel_puch">
						<option>초기화</option>
						<option>전일자주문량</option>
						<option>전전일자주문량</option>
						<option>예상수량</option>
					</select>
					<input type="text" id="inp_product02" class="inp w120 small" name="" placeholder="0">
					<button type="button" name="" class="comBtn small">일괄적용</button>
				</div>
			</div>
		
			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap" style="height:500px"></div>
			</div>
			<!-- grid -->
		</div>

		<div id="tab02" class="tabContent">
			 <!-- 조회 -->
			<div class="inquiryBox type02">
				<dl>
					<dt>기준일</dt>
					<dd>
						<div class="formWrap">			
							<div class="dateWrap">
								<input type="text" name="srcDate" value="10-24-1984" class="inp" id="datepicker">
								<button type="button" class="datepickerBtn" title="날짜입력"></button>
							</div>						
						</div>
					</dd>
					<dt>지역</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="inp_product01" class="inp w120 mr10" value="" name="" placeholder="지역명">
							<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
						</div>
					</dd>
				</dl>
				<div class="btnGroup right">
					<button type="button" name="" class="comBtn">지역 관리</button>
					<button type="button" name="" class="inquBtn">저장</button>
				</div>
			</div>
			<!-- 조회 -->
			
			<!-- 상태정보 -->
			<div class="txtInfo">
				※ 지역표준단가는 &lt;표준제품 관리&gt; 메뉴에서 제품별로 관리할 수 있습니다.
			</div>
			<!--// 상태정보 -->


			<div class="titleArea right">
				<p class="numState">
					<em>총 <span class="pColor01 fb">24</span></em> 건 이 조회되었습니다.
				</p>
				<div class="formGroup">
					<label for="sel_puch" name="sel_puch" class="mr10">매입원가 대비</label>  
					<select name="" class="sel small w140" id="sel_puch">
						<option>초기화</option>
						<option>전일자주문량</option>
						<option>전전일자주문량</option>
						<option>예상수량</option>
					</select>
					<input type="text" id="inp_product02" class="inp w120 small" name="" placeholder="0">
					<button type="button" name="" class="comBtn small">일괄적용</button>
				</div>
			</div>
		
			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap2" style="height:500px"></div>
			</div>
			<!-- grid -->
		</div>
	</div>
</div>
