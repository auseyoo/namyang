<!--
	@File Name: cstRecpNdBilct
	@File 설명 : 애음자 관리 - 방문영수증 및 수금자료
	@UI ID : UI-PCLI-1101T1
	@작성일 : 2022.03.25
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
var myGridID;
var myGridID2;
var myGridID3;

$(document).ready(function() {
    createAUIGrid();
    AUIGrid.setFooter(myGridID2, footerLayout2);
    tabScript();
    selectRecpTargetList();
});

var gridPros = {
    headerHeight: 29,
    rowHeight: 29,
    rowIdField: "id",
    showStateColumn: true,
    wrapSelectionMove: true,
    editingOnKeyDown: true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
    showStateColumn: false, // 앞에 보이는 아이콘 사용여부
    showRowCheckColumn: true, // 체크박스 사용
    editable: true,
    enterKeyColumnBase: true,
    selectionMode: "singleRow",
    useContextMenu: true,
    enableFilter: true,
    useGroupingPanel: false,
    displayTreeOpen: true,
    noDataMessage: "출력할 데이터가 없습니다.",
    groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};

var gridPros2 = {
    headerHeight: 29,
    rowHeight: 29,
    showStateColumn: false,
    selectionMode: "singleRow",
    enableFilter: true,
    showFooter: true,
    groupingFields: ["areaNm"],
    showBranchOnGrouping: false,
    groupingSummary: {
        dataFields: ["bAmount", "cAmount", "cMonth", "due"],
        labelTexts: ["소계"]
    },

    enableCellMerge: true,

    // 그리드 ROW 스타일 함수 정의
    rowStyleFunction: function(rowIndex, item) {
        if (item._$isGroupSumField) { // 그룹핑으로 만들어진 합계 필드인지 여부
            switch (item._$depth) { // 계층형의 depth 비교 연산
                case 2:
                    return "aui-grid-row-depth1-style";
                case 3:
                    return "aui-grid-row-depth2-style";
                case 4:
                    return "aui-grid-row-depth3-style";
                default:
                    return "aui-grid-row-depth-default-style";
            }
        }

        return null;
    } // end of rowStyleFunction
}

var gridPros3 = {
    headerHeight: 29,
    rowHeight: 29,
    showStateColumn: false,
    showRowCheckColumn: false,
    selectionMode: "singleRow"
}

function createAUIGrid() {
    myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
    myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros2);
    myGridID3 = AUIGrid.create("#grid_wrap3", columnLayout3, gridPros3);
}

var columnLayout = [{
    dataField: "rpmyMonth",
    headerText: "청구년월",
    width: "10%",
}, {
    dataField: "cstAgenCd",
    headerText: "애음자코드",
    width: "10%",
}, {
    dataField: "cstNm",
    headerText: "성명",
    width: "8%",
}, {
    dataField: "fullAddr",
    headerText: "주소",
    style: "auiLeft"
}, {
    dataField: "mobNo",
    headerText: "핸드폰번호",
    width: "13%",
}, {
    dataField: "rqestCt",
    headerText: "청구금액",
    dataType: "numeric",
    width: "12%",
    style: "auiRight"
}, {
    dataField: "bilctMthNm",
    headerText: "수금방법",
    width: "14%",
}];

var columnLayout2 = [{
    dataField: "areaNm",
    headerText: "지역명",
    width: "7%"
}, {
    dataField: "code",
    headerText: "애음자코드",
    width: "5%"
}, {
    dataField: "name",
    headerText: "성명",
    width: "5%"
}, {
    dataField: "address",
    headerText: "주소",
    style: "auiLeft",
}, {
    dataField: "phone",
    headerText: "핸드폰번호",
    width: "9%"
}, {
    dataField: "cMethod",
    headerText: "수금방법",
    width: "8%",
}, {
    dataField: "prNm",
    headerText: "제품명",
    width: "8%",
}, {
    dataField: "pattern",
    headerText: "주문패턴",
    width: "6%"
}, {
    dataField: "total",
    headerText: "총수량",
    style: "auiRight",
    width: "5%"
}, {
    dataField: "bAmount",
    headerText: "전월미수",
    dataType: "numeric",
    style: "auiRight",
    width: "7%"
}, {
    dataField: "cAmount",
    headerText: "당월애음",
    dataType: "numeric",
    style: "auiRight",
    width: "7%"
}, {
    dataField: "cMonth",
    headerText: "당월수금",
    dataType: "numeric",
    style: "auiRight",
    width: "7%"
}, {
    dataField: "due",
    headerText: "미수잔액",
    dataType: "numeric",
    style: "auiRight",
    width: "7%",
    disableGrouping: true // 그룹핑의 직접적인 대상이 될 수 없음
}];

var columnLayout3 = [{
    dataField: "areaNm",
    headerText: "지역명",
    width: "7%",
}, {
    dataField: "order",
    headerText: "배달순서",
    width: "4%",
}, {
    dataField: "code",
    headerText: "애음자코드",
    width: "7%",
}, {
    dataField: "sellerNm",
    headerText: "성명",
    width: "5%",
}, {
    dataField: "address",
    headerText: "주소",
    width: "12%",
    style: "auiLeft",
}, {
    dataField: "telNm",
    headerText: "휴대폰번호",
    width: "8%",
}, {
    dataField: "cMethod",
    headerText: "수금방법",
    width: "8%",
}, {
    dataField: "prNm",
    headerText: "제품명",
    width: "10%",
    style: "auiLeft"
}, {
    dataField: "pattern",
    headerText: "주문패턴",
    children: [{
        dataField: "pattern01",
        headerText: "월",
        width: "4%",
        style: "auiRight"
    }, {
        dataField: "pattern02",
        headerText: "화",
        width: "4%",
        style: "auiRight"
    }, {
        dataField: "pattern03",
        headerText: "수",
        width: "4%",
        style: "auiRight"
    }, {
        dataField: "pattern04",
        headerText: "목",
        width: "4%",
        style: "auiRight"
    }, {
        dataField: "pattern05",
        headerText: "금",
        width: "4%",
        style: "auiRight"
    }, {
        dataField: "pattern06",
        headerText: "토",
        headerStyle: "hColor01",
        width: "4%",
        style: "auiRight"
    }, {
        dataField: "pattern07",
        headerText: "일",
        headerStyle: "hColor02",
        width: "4%",
        style: "auiRight"
    }]
}, {
    dataField: "total",
    headerText: "총수량",
    width: "6%",
    style: "auiRight"
}, {
    dataField: "cStatus",
    headerText: "수금현황",
    children: [{
        dataField: "cStatus01",
        headerText: "전월미수",
        dataType: "numeric",
        width: "6%",
        style: "auiRight"
    }, {
        dataField: "cStatus02",
        headerText: "당월애음",
        dataType: "numeric",
        width: "6%",
        style: "auiRight"
    }, {
        dataField: "cStatus03",
        headerText: "당월수금",
        dataType: "numeric",
        width: "6%",
        style: "auiRight"
    }, {
        dataField: "cStatus04",
        headerText: "미수잔액",
        dataType: "numeric",
        width: "6%",
        style: "auiRight"
    }]
}, {
    dataField: "month",
    headerText: "월분",
    width: "6%",
}, {
    dataField: "cInfo",
    headerText: "수금정보",
    children: [{
        dataField: "cInfo01",
        headerText: "수금여부",
        width: "6%",
    }, {
        dataField: "cInfo02",
        headerText: "수금방법",
        width: "7%",
    }, {
        dataField: "cInfo03",
        headerText: "수금일",
        width: "6%",
    }]
}, {
    dataField: "memo",
    headerText: "메모",
    width: "10%",
    style: "auiLeft"
}];


// 푸터 설정
var footerLayout2 = [{
    labelText: "∑",
    positionField: "#base"
}, {
    dataField: "code",
    positionField: "code",
    operation: "SUM",
    colSpan: 8, // 자신을 포함하여 8개의 푸터를 가로 병합함.
    labelFunction: function(value, columnValues, footerValues) {
        //return "합계 : " + AUIGrid.formatNumber(value, "#,##0");
        return "합계 : "
    }
}, {
    dataField: "bAmount",
    positionField: "bAmount",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "cAmount",
    positionField: "cAmount",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "fee",
    positionField: "fee",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}, {
    dataField: "total",
    positionField: "total",
    operation: "SUM",
    style: "auiRight",
    colSpan: 1,
    labelFunction: function(value, columnValues, footerValues) {
        return " " + AUIGrid.formatNumber(value, "#,##0");
    }
}];


// 전체 체크 설정/ 해제
function checkAll(checked) {
    var rowCount = AUIGrid.getRowCount(myGridID);
    if (checked) {
        // 전체 데이터를 대상으로 isActive 필드를 "Active" 값으로 변경
        AUIGrid.updateRowBlockToValue(myGridID, 0, rowCount - 1, "isActive", "Active");
    } else {
        // 전체 데이터를 대상으로 isActive 필드를 "Inactive" 값으로 변경
        AUIGrid.updateRowBlockToValue(myGridID, 0, rowCount - 1, "isActive", "Inactive");
    }
};

function tabScript(){

	$(".content .tabContent").hide();
    $(".content .tabContent:first").show();
	$(".content .tabsWrap ul.tabs li").click(function (){
        $(".content .tabsWrap ul.tabs li").removeClass("active");
        $(this).addClass("active");
        $(".content .tabsWrap .tabContent").hide();
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn(100);
		if( typeof resizeGrid == 'function' ){
			resizeGrid();
		}
    });
	$(".lnbTabsWrap > .tabContent").hide();
    $(".lnbTabsWrap > .tabContent:first").show();
	$(".lnbTabsWrap > ul.tabs li").click(function (){
        $(".lnbTabsWrap > ul.tabs li").removeClass("active");
        $(this).addClass("active");
        $(".lnbTabsWrap > .tabContent").hide();
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn(100);
    });
	$(".favor").click(function(){
		$(this).toggleClass("on");
	});
}

function selectRecpTargetList(){
	AUIGrid.clearGridData(myGridID);
	$("#listCnt").html(0);
	$.ajax({
		url : "/cst/selectRecpTargetList.do",
		type : 'POST',
		data : $("#frm").serialize(),
		success : function(data) {
			console.log(data);
			AUIGrid.setGridData(myGridID, data);
			$("#listCnt").html(data.length);
		}, // success
		error : function(xhr, status) {
			alert(xhr + " : " + status);
		}
	});

}
function recpPrtPop(){
	var params = '';

// 	params = '?reqYm=' + $("#monthPicker").val().replace('-','');
// 	params += '&ordStusCd=' + $("#ordStusCd").val();
// 	params += '&prdDtlCd=' + $("#prdDtlCd").val();
// 	params += '&prdNm=' + $("#prdNm").val();
// 	params += '&inPath=' + $("#inPath").val();

	var url = '${request.contextPath}/cst/recpPrtPop.do' + params;
	console.log(url);
	var popup = window.open(url, '', 'width=830px,height=880px,scrollbars=yes');
}
</script>
<div class="content">
	<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- tabs -->
	<div class="tabsWrap">
		<ul class="tabs">
			<li class="active" rel="tab01">애음자 영수증</li>
			<li class="" rel="tab02">판매사원 수금자료</li>
			<li class="" rel="tab03">배달장부</li>
		</ul>


		<!-- tabContent 애음자 영수증 -->
		<form id="frm" onsubmit="return false;">
		<div id="tab01" class="tabContent">
			<!-- 조회 -->
			<div class="inquiryBox type02 row">
				<div class="dlRowBoxWrap">
					<div class="dlBox">
						<dl>
							<dt>청구년월</dt>
							<dd>
								<div class="dateWrap">
									<input type="text" name="rpmyMonth" value="" class="inp monthPicker" id="monthPicker" readonly>
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="monthPicker"></button>
								</div>
							</dd>
							<dt>지역</dt>
							<dd>
								<div class="searchWrap w140">
									<input type="text" id="inp_post_num" class="inp">
									<button type="button" class="postBtn" title="지역 찾기"></button>
								</div>
							</dd>
							<dt>투입상태</dt>
							<dd>
								<select name="" class="sel w140">
									<option>전체</option>
									<option>일시중지</option>
									<option>중지제외</option>
								</select>
							</dd>
							<dt>수금방법</dt>
							<dd>
								<select name="bilctMth" class="sel w140">
									<option value="">전체</option>
									<option>지로</option>
									<option>가상계좌</option>
									<option>CMS(자동이체)</option>
									<option>CMS(카드)</option>
									<option>방문수금</option>
									<option>직접수금</option>
									<option>통장수금</option>
									<option>카드수금</option>
								</select>
							</dd>
						</dl>
						<dl>
							<dt>청구금액기준</dt>
							<dd>
								<select name="" class="sel w140">
									<option>청구금액</option>
									<option>당월애음</option>
									<option>미수잔액</option>
									<option>당월수금</option>
								</select>
							</dd>
							<dt>조건</dt>
							<dd>
								<div class="formWrap">
									<select name="" class="sel w140 mr10">
										<option>전체</option>
										<option>코드</option>
										<option>이름</option>
										<option>주소</option>
										<option>핸드폰번호</option>
									</select> <input type="text" id="" class="inp w140 mr20" value="" title="제품 입력"> <input type="checkbox" id="pr11" class="type01" checked=""><label for="pr11" class="po07"><span>미수자만</span></label>
								</div>
							</dd>
						</dl>
					</div>

					<div class="btnVer">
						<button type="button" name="" class="comBtn" id="inp_name01" onclick ="selectRecpTargetList();">조회</button>
					</div>
				</div>

				<div class="btnGroup right">
					<button type="button" name="" class="comBtn" onclick ="recpPrtPop();">인쇄</button>
				</div>
			</div>
			<!-- 조회 -->

			<!-- grid -->
			<div class="girdBoxGroup">
				<div class="girdBox w60per">
					<div class="titleArea right">
						<p class="numState">
							<em>총 <span class="pColor01 fb" id ="listCnt">0</span></em> 건 이 조회되었습니다.
						</p>
					</div>

					<div id="grid_wrap"></div>
				</div>

				<div class="conBox w39per">
					<div class="titleArea right">
						<h3 class="tit01">인쇄 옵션</h3>
					</div>

					<!-- 인쇄옵션 -->
					<div class="tblWrap">
						<table class="tbl">
							<caption>인쇄옵션</caption>
							<colgroup>
								<col style="width: 160px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="prtType">인쇄양식</label></th>
									<td><select name="prtType" class="sel w160" id="prtType">
											<option value="">선택</option>
											<option value="vistRecp">방문영수증</option>
											<option value="bl">청구서</option>
									</select></td>
								</tr>
								<tr>
									<th scope="row"><label for="untpcZeroPrtYn">제품</label></th>
									<td>
										<input type="checkbox" id="untpcZeroPrtYn" name="untpcZeroPrtYn" class="type01" checked="" value ="Y">
										<label for="untpcZeroPrtYn"><span>단가 0인 제품 포함</span></label>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="untpcPrtYn">단가</label></th>
									<td>
										<ul class="fList">
											<li>
												<input type="checkbox" id="untpcPrtYn" name="untpcPrtYn" class="type01" checked=""  value ="Y">
												<label for="untpcPrtYn"><span>단가 표시</span></label>
											</li>
											<li>
												<input type="checkbox" id="dsctPrtYn" name="dsctPrtYn" class="type01"  value ="Y">
												<label for="dsctPrtYn"><span>할인(무상)금액 표시 안함</span></label>
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="sclpsPrtYn">현금영수증</label></th>
									<td><input type="checkbox" id="sclpsPrtYn" name="sclpsPrtYn"  class="type01" checked=""  value ="Y">
									<label for="sclpsPrtYn"><span>신분확인 정보 표시</span></label></td>
								</tr>
								<tr>
									<th scope="row"><label for="account01">인쇄 계좌</label></th>
									<td>
										<div class="checkGroup">
											<input type="radio" name="acctPrtType" id="account01" class="type01" checked="" value="AGEN">
											<label for="account01"><span>대리점</span></label>
											<input type="radio" name="acctPrtType" id="account02" class="type01" value="EMPL">
											<label for="account02"><span>판매원</span></label>
											<input type="radio" name="acctPrtType" id="account03" class="type01" value="VIR">
											<label for="account03"><span>가상계좌</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="saPhone01">판매원 전화번호</label></th>
									<td>
										<div class="checkGroup">
											<input type="radio" name="emplPhonePrtType" id="saPhone01" class="type01" checked="" value="NOTPRT">
											<label for="saPhone01"><span>인쇄안함</span></label>
											<input type="radio" name="emplPhonePrtType" id="saPhone02" class="type01" value="TELNO">
											<label for="saPhone02"><span>전화번호</span></label>
											<input type="radio" name="emplPhonePrtType" id="saPhone03" class="type01" value="MOBNO">
											<label for="saPhone03"><span>핸드폰번호</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="drPhone01">애음자 전화번호</label></th>
									<td>
										<div class="checkGroup">
											<input type="radio" name="cstPhonePrtType" id="drPhone01" class="type01" checked="" value="NOTPRT">
											<label for="drPhone01"><span>인쇄안함</span></label>
											<input type="radio" name="cstPhonePrtType" id="drPhone02" class="type01" value="TELNO">
											<label for="drPhone02"><span>전화번호</span></label>
											<input type="radio" name="cstPhonePrtType" id="drPhone03" class="type01" value="MOBNO">
											<label for="drPhone03"><span>핸드폰번호</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="account01">대리점정보</label></th>
									<td>
										<div class="checkGroup">
											<input type="checkbox" id="agenNmPrtYn" name="agenNmPrtYn" class="type01" checked=""  value ="Y">
											<label for="agenNmPrtYn"><span>상호</span></label>
											<input type="checkbox" id="agenPhonePrtYn" name="agenPhonePrtYn" class="type01"  value ="Y">
											<label for="agenPhonePrtYn"><span>전화번호</span></label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="tex_meno">메모</label></th>
									<td><textarea id="" name="" rows="15" class="h110">

														</textarea></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 인쇄옵션 -->
				</div>
			</div>
			<!-- grid -->
		</div>
		</form>
		<!-- //tabContent 애음자 영수증 -->

		<!-- tabContent 판매사원 수금자료 -->
		<div id="tab02" class="tabContent">
			<!-- 조회 -->
			<div class="inquiryBox type02 row">
				<div class="dlRowBoxWrap">
					<div class="dlBox">
						<dl>
							<dt>청구년월</dt>
							<dd>
								<div class="dateWrap">
									<input type="text" name="date" value="" class="inp monthPicker" id="monthPicker" readonly>
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="monthPicker"></button>
								</div>
							</dd>
							<dt>지역</dt>
							<dd>
								<div class="searchWrap w140">
									<input type="text" id="inp_post_num" class="inp">
									<button type="button" class="postBtn" title="지역 찾기"></button>
								</div>
							</dd>
							<dt>투입상태</dt>
							<dd>
								<select name="" class="sel w140">
									<option>전체</option>
									<option>일시중지</option>
									<option>중지제외</option>
								</select>
							</dd>
							<dt>수금방법</dt>
							<dd>
								<select name="" class="sel w140">
									<option>지로</option>
									<option>가상계좌</option>
									<option>CMS(자동이체)</option>
									<option>CMS(카드)</option>
									<option>방문수금</option>
									<option>직접수금</option>
									<option>통장수금</option>
									<option>카드수금</option>
								</select>
							</dd>
						</dl>
						<dl>
							<dt>조건</dt>
							<dd>
								<div class="formWrap">
									<select name="" class="sel w140 mr10">
										<option>전체</option>
										<option>코드</option>
										<option>이름</option>
										<option>주소</option>
										<option>핸드폰번호</option>
									</select> <input type="text" id="" class="inp w140" value="" title="제품 입력">

									<div class="checkGroup">
										<input type="checkbox" id="plus1" class="type01" checked=""><label for="plus1"><span>미수자만</span></label> <input type="checkbox" id="plus2" class="type01"><label for="plus2"><span>지역소계</span></label> <input type="checkbox" id="plus3" class="type01"><label for="plus3"><span>제품보기</span></label>
										<div></div>
							</dd>
						</dl>
					</div>

					<div class="btnVer">
						<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
					</div>
				</div>

				<div class="btnGroup right">
					<button type="button" name="" class="comBtn">인쇄</button>
				</div>
			</div>
			<!-- 조회 -->

			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb">287</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap2"></div>
			</div>
			<!-- grid -->
		</div>
		<!-- //tabContent 판매사원 수금자료 -->

		<!-- tabContent 배달장부 -->
		<div id="tab03" class="tabContent">
			<!-- 조회 -->
			<div class="inquiryBox type02 row">
				<div class="dlRowBoxWrap">
					<div class="dlBox">
						<dl>
							<dt>청구년월</dt>
							<dd>
								<div class="dateWrap">
									<input type="text" name="date" value="" class="inp monthPicker" id="monthPicker" readonly>
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="monthPicker"></button>
								</div>
							</dd>
							<dt>지역</dt>
							<dd>
								<div class="searchWrap w140">
									<input type="text" id="inp_post_num" class="inp">
									<button type="button" class="postBtn" title="지역 찾기"></button>
								</div>
							</dd>
							<dt>투입상태</dt>
							<dd>
								<select name="" class="sel w140">
									<option>전체</option>
									<option>일시중지</option>
									<option>중지제외</option>
								</select>
							</dd>
							<dt>수금방법</dt>
							<dd>
								<select name="" class="sel w140">
									<option>지로</option>
									<option>가상계좌</option>
									<option>CMS(자동이체)</option>
									<option>CMS(카드)</option>
									<option>방문수금</option>
									<option>직접수금</option>
									<option>통장수금</option>
									<option>카드수금</option>
								</select>
							</dd>
						</dl>
						<dl>
							<dt>조건</dt>
							<dd>
								<div class="formWrap">
									<select name="" class="sel w140 mr10">
										<option>전체</option>
										<option>코드</option>
										<option>이름</option>
										<option>주소</option>
										<option>핸드폰번호</option>
									</select> <input type="text" id="" class="inp w140" value="" title="제품 입력">
								</div>
							</dd>
						</dl>
					</div>

					<div class="btnVer">
						<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
					</div>
				</div>

				<div class="btnGroup right">
					<button type="button" name="" class="comBtn">인쇄</button>
				</div>
			</div>
			<!-- 조회 -->

			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb">287</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="girdBox">
				<div id="grid_wrap3"></div>
			</div>
			<!-- grid -->
		</div>
		<!-- //tabContent 배달장부 -->
	</div>
</div>
