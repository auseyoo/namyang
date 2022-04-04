<!--
	@File Name: bcncMngDtl
	@File 설명 : 거래처 등록(상세)
	@UI ID : UI-PSAL-0102T1.html
	@작성일 : 2022.01.14
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<code:makeSelect commGrpCd="VEND_STUS_SEC" var="vendStusSecList" name="vendStusSec" all="true" allNm="선택" />
<code:makeSelect commGrpCd="VEND_DLV_CYCLE" var="vendDlvCycleList" name="vendDlvCycle" all="true" allNm="선택" />
<code:makeSelect commGrpCd="SPRT_EQPMN_CD" var="sprtEqpmnList" name="sprtEqpmnCd" all="true" allNm="선택" />
<code:makeSelect commGrpCd="PYM_MTH" var="pymMthList" name="pymMth" all="true" allNm="선택" />
<code:makeSelect commGrpCd="STR_SEC_CD" var="strSecCdList" name="strSecCd" all="true" allNm="선택" />
<code:makeSelect commGrpCd="STM_DT_CD" var="stmDtCdList" name="stmDtCd" all="true" allNm="선택" />
<code:makeRadio commGrpCd="VEND_SPRT_SEC" var="sprtSecList" name="vendSprtSec" classNm="type01" />

<script type="text/javascript">
var nowTab = 1;
var mGrid;
var sprtEditSeq = '<c:out value="${param.sprtEditSeq}" />';
var targetNotGrid = true;
var prdBndChg = false;
var untpcPage = false;
$(document).ready(function() {

    //tabs
    $(".content .tabContent").hide();
    $(".content .tabContent:first").show();

    $(".content .tabsWrap ul.tabs li").click(function() {
        $(".content .tabsWrap ul.tabs li").removeClass("active");
        $(this).addClass("active");
        $(".content .tabsWrap .tabContent").hide();
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn(100);
        if (typeof resizeGrid == 'function') {
            resizeGrid();
        }
    });

    $(".lnbTabsWrap > .tabContent").hide();
    $(".lnbTabsWrap > .tabContent:first").show();

    $(".lnbTabsWrap > ul.tabs li").click(function() {
        $(".lnbTabsWrap > ul.tabs li").removeClass("active");
        $(this).addClass("active");
        $(".lnbTabsWrap > .tabContent").hide();
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn(100);
    });

    createAUIGrid();
    $("[name =vendSprtSec]:first").prop("checked", true);
    $('input[name="vendSprtSec"]').change(function() {
        clearSprtInput();
        var rTab = $('input[name="vendSprtSec"]:checked').val();
        $("tbody[id$='_tbody']").hide();
        $('#' + rTab + '_tbody').show();
    });
    $('input[name="subsidSec"]').change(function() {
        var rTab = $('input[name="subsidSec"]:checked').val();
        $('#subsidRate').val("");
        $('#subsidCt').val("");
        $('#subsidRate').attr("readonly", true);
        $('#subsidCt').attr("readonly", true);
        $('#' + rTab).attr("readonly", false);
    });
    getSprtList();
    if (sprtEditSeq != null && sprtEditSeq != "") {
        $("#sprtBtn").trigger("click");
        getBncSprtDtl(sprtEditSeq);
    }
    $("[name= statDt]").val('${bcncMngDtl.statDt}');
    $("[name= clsDt]").val('${bcncMngDtl.clsDt}');
});
var auiGridProps = {
    headerHeight: 29,
    rowHeight: 29,
    rowIdField: "id",
    editable: true,
    headerHeight: 26,
    editable: false,
    enterKeyColumnBase: true,
    selectionMode: "multipleCells",
    useContextMenu: true,
    enableFilter: true,
    useGroupingPanel: false,
    displayTreeOpen: true,
    noDataMessage: "출력할 데이터가 없습니다.",
    groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
};

function createAUIGrid() {
    mGrid = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps);
}

var columnLayout = [{
        dataField: "vendSprtSeq",
        headerText: "vendSprtSeq",
        visible: false
    },
    {
        dataField: "updbtn",
        headerText: "수정",
        width: "5%",
        renderer: {
            type: "ButtonRenderer",
            onClick: function(event) {
                getBncSprtDtl(AUIGrid.getCellValue(mGrid,
                    event.rowIndex, "vendSprtSeq"));
            },
        }
    }, {
        dataField: "useYn",
        headerText: "적용여부",
        width: "4%"
    }, {
        dataField: "grant",
        headerText: "지원금",
        children: [{
            dataField: "hoffAlotm",
            headerText: "회사부담금",
            width: "7%",
            dataType: "numeric",
            formatString: "#,##0",
            style: "auiRight"
        }, {
            dataField: "agenAlotm",
            headerText: "대리점부담금",
            width: "7%",
            dataType: "numeric",
            formatString: "#,##0",
            style: "auiRight"
        }, {
            dataField: "ctStatDt",
            headerText: "지급일",
            width: "6%",
        }, {
            dataField: "ctMemo",
            headerText: "메모",
            width: "12%",
            style: "auiLeft"
        }]
    }, {
        dataField: "subsid",
        headerText: "장려금",
        children: [{
            dataField: "subsidRate",
            headerText: "지급율",
            width: "6%",
            style: "auiRight"
        }, {
            dataField: "subsidCt",
            headerText: "금액",
            width: "6%",
            dataType: "numeric",
            formatString: "#,##0",
            style: "auiRight"
        }, {
            dataField: "subsidStatDt",
            headerText: "기간 시작일",
            width: "6%",
        }, {
            dataField: "subsidClsDt",
            headerText: "기간 종료일",
            width: "6%",

        }]
    }, {
        dataField: "prd",
        headerText: "물량지원",
        children: [{
            dataField: "sprtPrdCd",
            headerText: "제품코드",
            width: "6%",
        }, {
            dataField: "sprtPrdNm",
            headerText: "제품명",
            width: "12%",
            style: "auiLeft"
        }, {
            dataField: "prdQty",
            headerText: "수량",
            width: "5%",
            style: "auiRight"
        }, {
            dataField: "prdCt",
            headerText: "금액",
            width: "6%",
            dataType: "numeric",
            formatString: "#,##0",
            style: "auiRight"

        }, {
            dataField: "prdStatDt",
            headerText: "지급일",
            width: "6%",
            dataType: "numeric",
            formatString: "#,##0",
            style: "auiRight"

        }]
    }, {
        dataField: "eqpmn",
        headerText: "장비지원",
        children: [{
            dataField: "sprtEqpmnNm",
            headerText: "장비명",
            width: "6%",
            style: "auiLeft"
        }, {
            dataField: "eqpmnQty",
            headerText: "수량",
            width: "5%",
            dataType: "numeric",
            formatString: "#,##0",
            style: "auiRight"
        }, {
            dataField: "eqpmnCt",
            headerText: "금액",
            width: "5%",
            dataType: "numeric",
            formatString: "#,##0",
            style: "auiRight"
        }, {
            dataField: "eqpmnStatDt",
            headerText: "장비지급일",
            width: "6%"
        }, {
            dataField: "eqpmnClsDt",
            headerText: "장비회수일",
            width: "6%"
        }]
    }, {
        dataField: "etcSprt",
        headerText: "기타",
        children: [{
            dataField: "etcCt",
            headerText: "금액",
            width: "6%",
            dataType: "numeric",
            formatString: "#,##0",
            style: "auiRight"
        }, {
            dataField: "etcStatDt",
            headerText: "지급일",
            width: "6%"
        }, {
            dataField: "etcMemo",
            headerText: "메모",
            width: "12%",
            style: "auiLeft"
        }]
    }, {
        dataField: "regNm",
        headerText: "등록자",
        width: "6%"
    }, {
        dataField: "regDtm",
        headerText: "등록일시",
        width: "6%"
    }, {
        dataField: "updNm",
        headerText: "수정자",
        width: "6%"
    }, {
        dataField: "updDtm",
        headerText: "수정일시",
        width: "6%"
    }
];

function selectedFn(targetId, value) {

    if (value != null && value != "") {
        $("#" + targetId).val(value).attr("selected", "selected");
    }

}

function saveBcnc() {
    if (nowTab == 1) {
        if ($("#vendNm").val() == null || $("#vendNm").val() == "") {
            alert("거래처명을 입력해주세요.");
            return;
        }
        if ($("#targetEmplSeq").val() == null ||
            $("#targetEmplSeq").val() == "") {
            alert("담당직원을 선택해주세요.");
            return;
        }
        /*Validation 은 추후 작업예정..*/
        $("#bizNo").val($("#bizNo01").val() + $("#bizNo02").val() + $("#bizNo03").val());
        $("#telNo").val($("#telNo01").val() + $("#telNo02").val() + $("#telNo03").val());
        $("#mobNo").val($("#mobNo01").val() + $("#mobNo02").val() + $("#mobNo03").val());
        $("#faxNo").val($("#faxNo01").val() + $("#faxNo02").val() + $("#faxNo03").val());
        $("#prstMobNo").val($("#prstMobNo01").val() + $("#prstMobNo02").val() + $("#prstMobNo03").val());
        $.ajax({
            url: "/sale/saveBcnc.do",
            type: 'POST',
            data: $("#frm").serialize(),
            success: function(data) {
                alert("저장되었습니다.");
            }, // success
            error: function(xhr, status) {
                console.log(xhr);
                alert(xhr + " : " + status);
            }
        });
    } else {

        $.ajax({
            url: "/sale/saveBcncSprt.do",
            type: 'POST',
            data: $("#frm").serialize(),
            success: function(data) {
                alert("저장되었습니다.");
                $("#sprtStusSec").html("신규");
                $("#vendSprtSeq").val("");
                getSprtList();
                clearSprtInput();
            }, // success
            error: function(xhr, status) {
                console.log(xhr);
                alert(xhr + " : " + status);
            }
        });
    }

}

function resizeGrid() {
    AUIGrid.resize(mGrid, $("#content").width());
}

function getSprtList() {
    $.ajax({
        url: "/sale/selectBcncSprtList.do",
        type: 'POST',
        data: $("#frm").serialize(),
        success: function(data) {
            console.log(data);
            AUIGrid.setGridData(mGrid, data.bcncSprtList);
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}

function getBncSprtDtl(vendSprtSeq) {
    $("#vendSprtSeq").val(vendSprtSeq);
    $.ajax({
        url: "/sale/bncSprtDtl.do",
        type: 'POST',
        data: $("#frm").serialize(),
        success: function(data) {
            console.log(data);
            clearSprtInput();
            $("#sprtStusSec").html("수정");
            for (var keyNm in data) {
				if (data[keyNm] != null && data[keyNm] != "") {
					if (keyNm == 'vendSprtSec' || keyNm == 'useYn' || keyNm == 'subsidSec') {
						$("input[name='" + keyNm + "']:radio[value='" +data[keyNm] + "']").prop( "checked", true);
						$("input[name='" + keyNm + "']").trigger("change");
					} else {
						$("[name='" + keyNm + "']").val(data[keyNm]);
					}
				}
			}
        }, // success
        error: function(xhr, status) {
            alert(xhr + " : " + status);
        }
    });
}

function clearSprtInput() {
    $('#tab02 :input').each(function() {
        if ($(this).attr("type") == "text") {
            $(this).val("");
        }
    });
}

function openSearchPrdPop() {
    $.ajaxDialog({
        id: "searchBcncPrdPop",
        ajax: {
            url: "/sale/searchBcncPrdPop.do",
        },
        dialog: {
            width: 860,
            height: 560
        },
        success: function(data) {}
    });
}
var datePickerNo=9;
var prdSprtNo =1;
function addPrdSprt(){
	datePickerNo += 1;
	prdSprtNo +=1;
	var htmlTag ;
	htmlTag += '<tr id="prdSprt'+prdSprtNo+'_1">';
	htmlTag += '<th scope="row"><label for="inp_pCode">제품</label></th>';
	htmlTag += '<td>';
	htmlTag += '<div class="formWrap type02">';
	htmlTag += '<input type="hidden" name="sprtPrdDtlSeq" id="sprtPrdDtlSeq" value="" /> <input type="text" name="sprtPrdCd" id="sprtPrdCd" class="inp w140 mr10" readonly />';
	htmlTag += '<div class="searchWrap w223 mr10">';
	htmlTag += '<input type="text" name="sprtPrdNm" id="sprtPrdNm" class="inp" disabled />';
	htmlTag += '<button type="button" class="postBtn" name="" title="검색하기" onclick="openSearchPrdPop();"></button>';
	htmlTag += '</div>';
	htmlTag += '<button type="button" name="" class="inquBtn medium addTr" onclick ="delPrdSprt('+prdSprtNo+');">삭제</button>';
	htmlTag += '</div>';
	htmlTag += '</td>';
	htmlTag += '<th scope="row"><label for="datepicker6">지급일</label></th>';
	htmlTag += '<td>';
	htmlTag += '<div class="dateWrap">';
	htmlTag += '<input type="text" name="prdStatDt" value="" class="datepicker" id="datepicker'+datePickerNo+'" readonly />';
	htmlTag += '<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker'+datePickerNo+'" id="datepickerBtn'+datePickerNo+'"></button>';
	htmlTag += '</div>';
	htmlTag += '</td>';
	htmlTag += '</tr>';
	htmlTag += '<tr id="prdSprt'+prdSprtNo+'_2">';
	htmlTag += '<th scope="row"><label for="inp_qty">수량</label></th>';
	htmlTag += '<td>';
	htmlTag += '<div class="formWrap w250">';
	htmlTag += '<input type="text" id="prdQty" class="inp ar" value="" name="prdQty"> <span class="unit">개</span>';
	htmlTag += '</div>';
	htmlTag += '</td>';
	htmlTag += '<th scope="row"><label for="prdCt">금액</label></th>';
	htmlTag += '<td>';
	htmlTag += '<div class="formWrap w250">';
	htmlTag += '<input type="text" id="prdCt" class="inp ar" value="" name="prdCt"> <span class="unit">원</span>';
	htmlTag += '</div>';
	htmlTag += '</td>';
	htmlTag += '</tr>';

	$("#VOL_tbody").append(htmlTag);
	setAddDatePickerSet(datePickerNo);
}
function setAddDatePickerSet(targetNo){
	$("#datepicker"+targetNo).daterangepicker(
		daterangepickerOption,
    	function (start, end, label) {
      		console.log("New date range selected: " + start.format("YYYY-MM-DD") + " to " + end.format("YYYY-MM-DD") +" (predefined range: " +label +")" );
    	}
  	);
  	$("#datepickerBtn"+targetNo).click(function (event) {
	    event.preventDefault();
	    if ($(this).data("targetId")) {

	    	$("#" + $(this).data("targetId")).click();
	    } else {
	      	$("#datepicker").click();
	    }
  	});
}
function delPrdSprt(targetNo){
	$("#prdSprt"+targetNo+"_1").remove();
	$("#prdSprt"+targetNo+"_2").remove();
}
</script>

<div class="content">
	<div class="titTopArea">
		<h2 class="tit01">
			거래처 관리 <a href="#" class="favor" title="즐겨찾기"></a>
		</h2>
		<div class="location">
			<ul>
				<li><i class="home"></i></li>
				<li>판매관리</li>
				<li>거래처 관리</li>
				<li>거래처 등록/수정</li>
			</ul>
		</div>
	</div>
	<form id="frm" name="frm">
		<input type="hidden" name="vendSprtSeq" id="vendSprtSeq" value=""> <input type="hidden" name="vendSeq" id="vendSeq" value="${bcncMngDtl.vendSeq}">
		<!-- tabs -->
		<div class="tabsWrap">
			<div class="titTabWrap">
				<ul class="tabs">
					<li class="active" rel="tab01" onclick="nowTab =1;">기본 정보</li>
					<li class="" rel="tab02" onclick="nowTab =2;" id="sprtBtn">지원 내역</li>
				</ul>

				<div class="btnGroup">
					<button type="button" name="" class="inquBtn" onclick="saveBcnc();">저장</button>
				</div>
			</div>

			<!-- tabContent 기본 정보 -->
			<div id="tab01" class="tabContent">
				<div class="titleArea arTxt">
					<p class="txt01">
						<i class="icoRequir"></i>필수 입력 항목입니다.
					</p>
				</div>

				<div class="tblWrap">
					<table class="tbl">
						<caption>거래처 기본정보</caption>
						<colgroup>
							<col style="width: 170px;">
							<col>
							<col style="width: 170px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">거래처 코드</th>
								<td>
									<p>${bcncMngDtl.vendCd}</p>
								</td>
								<th scope="row"><label for="vendNm" class="required" title="필수입력">거래처명</label></th>
								<td><input type="text" id="vendNm" class="inp" value="${bcncMngDtl.vendNm}" name="vendNm"></td>
							</tr>
							<tr>
								<th scope="row"><label for="bizNo01" class="required" title="필수입력">사업자번호</label></th>
								<td>
									<div class="formWrap">
										<c:set var="bizNo" value="${fn:split(bcncMngDtl.bizNo,'-')}" />

										<input type="text" id="bizNo01" class="inp" value="${bizNo[0]}" name="bizNo01"> <span class="dash"></span> <input type="text" id="bizNo02" class="inp" value="${bizNo[1]}" name="bizNo02"> <span class="dash"></span> <input type="text" id="bizNo03" class="inp" value="${bizNo[2]}" name="bizNo03"> <input type="hidden" id="bizNo" name="bizNo" />
									</div>
								</td>
								<th scope="row"><label for="vendPrst" class="required" title="필수입력">대표자명</label></th>
								<td><input type="text" id="vendPrst" class="inp" value="${bcncMngDtl.vendPrst}" name="vendPrst"></td>
							</tr>
							<tr>
								<th scope="row"><label for="bizCon">업태</label></th>
								<td><input type="text" id="bizCon" class="inp" value="${bcncMngDtl.bizCon}" name="bizCon"></td>
								<th scope="row"><label for="bizIndu">업종</label></th>
								<td><input type="text" id="bizIndu" class="inp" value="${bcncMngDtl.bizIndu}" name="bizIndu"></td>
							</tr>
							<tr>
								<th scope="row"><label for="telNo01" class="required" title="필수입력">전화번호</label></th>
								<td>
									<div class="formWrap">
										<c:set var="telNo" value="${fn:split(bcncMngDtl.telNo,'-')}" />
										<input type="text" id="telNo01" class="inp" value="${telNo[0]}" name="telNo01"> <span class="dash"></span> <input type="text" id="telNo02" class="inp" value="${telNo[1]}" name="telNo02"> <span class="dash"></span> <input type="text" id="telNo03" class="inp" value="${telNo[2]}" name="telNo03"> <input type="hidden" id="telNo" name="telNo" />
									</div>
								</td>
								<th scope="row"><label for="prstMobNo01" class="required" title="필수입력">휴대폰번호</label></th>
								<td>
									<div class="formWrap">
										<c:set var="prstMobNo" value="${fn:split(bcncMngDtl.prstMobNo,'-')}" />

										<select name="prstMobNo01" class="sel" id="prstMobNo01">
											<option>010</option>
											<option>011</option>
										</select> <span class="dash"></span> <input type="text" id="prstMobNo02" class="inp" value="${prstMobNo[1]}" name="prstMobNo02"> <span class="dash"></span> <input type="text" id="prstMobNo03" class="inp" value="${prstMobNo[2]}" name="prstMobNo03">
										<script>
											selectedFn("prstMobNo01",
													"${prstMobNo[0]}");
										</script>

										<input type="hidden" id="prstMobNo" name="prstMobNo" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="faxNo01">팩스</label></th>
								<td>
									<div class="formWrap">
										<c:set var="faxNo" value="${fn:split(bcncMngDtl.faxNo,'-')}" />
										<input type="text" id="faxNo01" class="inp" value="${faxNo[0]}" name="faxNo01"> <span class="dash"></span> <input type="text" id="faxNo02" class="inp" value="${faxNo[1]}" name="faxNo02"> <span class="dash"></span> <input type="text" id="faxNo03" class="inp" value="${faxNo[2]}" name="faxNo03"> <input type="hidden" id="faxNo" name="faxNo" />
									</div>
								</td>
								<th scope="row"><label for="vendEml01">이메일 주소</label></th>
								<td>
									<div class="formWrap email">
										<c:set var="vendEml" value="${fn:split(bcncMngDtl.vendEml,'@')}" />
										<input type="text" id="vendEml01" class="inp w160" value="${vendEml[0]}" name="vendEml01"> <span class="divi"> @ </span> <input type="text" id="vendEml02" class="inp mr10" value="${vendEml[1]}" name="vendEml02"> <select name="" class="sel" id="sel_email" onChange="$('#vendEml02').val(this.value);">
											<option value="">직접입력</option>
											<option>naver.com</option>
											<option>google.com</option>
										</select> <input type="hidden" id="vendEml" name="vendEml" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="zipCd">우편번호</label></th>
								<td colspan="3">
									<div class="postWrap w160">
										<input type="text" id="zipCd" name="zipCd" class="inp" value="${bcncMngDtl.zipCd}">
										<button type="button" class="postBtn" title="우편번호 찾기" onclick="fnSetPostcode('#zipCd', '#addr1');"></button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="addr1" class="required" title="필수입력">주소</label></th>
								<td><input type="text" id="addr1" name="addr1" class="inp" value="${bcncMngDtl.addr1}"></td>
								<th scope="row"><label for="addr2" class="required" title="필수입력">상세주소</label></th>
								<td><input type="text" id="addr2" name="addr2" class="inp" value="${bcncMngDtl.addr2}"></td>
							</tr>
							<tr>
								<th scope="row"><label for="vendChag">거래처 담당자</label></th>
								<td><input type="text" id="vendChag" name="vendChag" class="inp" value="${bcncMngDtl.vendChag}"></td>
								<th scope="row"><label for="sel_vendChagTel11">담당자 휴대폰 번호</label></th>
								<td>
									<div class="formWrap">
										<c:set var="mobNo" value="${fn:split(bcncMngDtl.mobNo,'-')}" />
										<select name="mobNo01" class="sel" id="mobNo01">
											<option>010</option>
											<option>011</option>
										</select> <span class="dash"></span> <input type="text" id="mobNo02" class="inp" value="${mobNo[1]}" name="mobNo02"> <span class="dash"></span> <input type="text" id="mobNo03" class="inp" value="${mobNo[2]}" name="mobNo03">
										<script>
											selectedFn("mobNo01", "${mobNo[0]}");
										</script>

										<input type="hidden" id="mobNo" name="mobNo" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">거래처유형</th>
								<td>
									<P>일반</P>
								</td>
								<th scope="row" class="txtLong"><label for="vendStusSec" class="">상태(구분/부실사유)</label></th>
								<td><span style="width: 160px"> ${vendStusSecList} </span> <script>
									selectedFn("vendStusSec",
											"${bcncMngDtl.vendStusSec}");
								</script></td>
							</tr>
							<tr>
								<th scope="row"><label for="targetEmplSeq" class="required" title="필수입력">담당 직원</label></th>
								<td><select name="targetEmplSeq" class="sel w160" id="targetEmplSeq">
										<option value="">선택</option>
										<c:forEach var="empl" items="${emplList}" varStatus="status">
											<option value="<c:out value="${empl.emplSeq}" />"><c:out value="${empl.emplNm}" /></option>
										</c:forEach>

								</select> <script>
									selectedFn("targetEmplSeq",
											"${bcncMngDtl.emplSeq}");
								</script></td>
								<th scope="row">지원유무</th>
								<td>
									<p>Y</p>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="sel_storeType" class="">매장유형</label></th>
								<td><span style="width: 160px"> ${strSecCdList}</span></td>
								<script>
									selectedFn("strSecCd",
											"${bcncMngDtl.strSecCd}");
								</script>
								<th scope="row"><label for="sel_delCycle" class="">납품주기</label></th>
								<td><span style="width: 160px"> ${vendDlvCycleList}</span></td>
								<script>
									selectedFn("vendDlvCycle",
											"${bcncMngDtl.vendDlvCycle}");
								</script>
							</tr>
							<tr>
								<th scope="row"><label for="datepicker" class="required" title="필수입력">거래시작일자</label></th>
								<td>
									<div class="formWrap">
										<div class="dateWrap w160">
											<input type="text" name="statDt" value="1984-10-24" class="datepicker" id="datepicker1" readonly>
											<button type="button" class="datepickerBtn" data-target-id="datepicker1" title="날짜입력"></button>
										</div>
									</div>
								</td>
								<th scope="row"><label for="datepicker2" class="required" title="필수입력">거래종료일자</label></th>
								<td>
									<div class="formWrap">
										<div class="dateWrap w160">
											<input type="text" name="clsDt" value="10/24/1984" class="datepicker" id="datepicker2" readonly>
											<button type="button" class="datepickerBtn" data-target-id="datepicker2" title="날짜입력"></button>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="inp_lastCollDate" class="">최종수금일</label></th>
								<td>
									<p>2022-01-01</p>
								</td>
								<th scope="row"><label for="inp_lastSellDate" class="">최종판매일</label></th>
								<td>
									<p>2022-01-01</p>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="sel_collForm" class="">수금형태</label></th>
								<td><span style="width: 160px"> ${pymMthList} </span></td>
								<script>
									selectedFn("pymMth","${bcncMngDtl.pymMth}");
								</script>
								<th scope="row"><label for="sel_stmDe" class="">결제일</label></th>
								<td><span style="width: 160px"> ${stmDtCdList}</span></td>
								<script>
									selectedFn("stmDtCd","${bcncMngDtl.stmDtCd}");
								</script>
							</tr>
							<tr>
								<th scope="row"><label for="sel_bank01">은행/계좌번호</label></th>
								<td>
									<div class="formWrap">
										<select name="bankCd" class="sel w160" id="bankCd">
											<option value="">선택</option>
											<c:forEach var="code" items="${bankList}" varStatus="status">
												<option value="${code.commCd}">${code.commNm}</option>
											</c:forEach>

										</select>
										<script>
											selectedFn("bankCd",
													"${bcncMngDtl.bankCd}");
										</script>
										<input type="text" id="stmAcctNo" name="stmAcctNo" class="inp" value="${bcncMngDtl.stmAcctNo}">
									</div>
								</td>
								<th scope="row"><label for="acctDpsr" class="">예금주</label></th>
								<td><input type="text" name ="acctDpsr" id="acctDpsr" class="inp" value="${bcncMngDtl.acctDpsr}"></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="tblWrap">
					<table class="tbl">
						<caption>기본 정보</caption>
						<colgroup>
							<col style="width: 170px;">
							<col>
							<col style="width: 170px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">작업자</th>
								<td>${bcncMngDtl.updNm}</td>
								<th scope="row">작업일시</th>
								<td>${bcncMngDtl.updDtm}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- tabContent 기본 정보 -->

			<!-- tabContent 지원 내역 -->
			<div id="tab02" class="tabContent">
				<div class="titleArea">
					<h3 class="tit01">지원 내역</h3>
				</div>

				<div class="raTblCon">
					<dl class="raTbl">
						<dt>지원 구분</dt>
						<dd>
							<div class="checkGroup">${sprtSecList }</div>
						</dd>
					</dl>

					<!-- 지원금 -->
					<div class="rTabBox" id="grantCon">
						<div class="tblWrap">
							<table class="tbl">
								<caption>지원금</caption>
								<colgroup>
									<col style="width: 170px;">
									<col>
									<col style="width: 170px;">
									<col>
								</colgroup>
								<tbody>
								<tbody id="basicTbody">
									<tr>
										<th scope="row">상태 구분</th>
										<td>
											<p id="sprtStusSec">신규</p>
										</td>
										<th scope="row"><label for="inp_apply01">적용 여부</label></th>
										<td>
											<div class="checkGroup yn">
												<input type="radio" name="useYn" class="type01" checked="checked" value="Y"><label for="inp_apply01"><span>Y</span></label> <input type="radio" name="useYn" class="type01" value="N"><label for="inp_apply02"><span>N</span></label>
											</div>
										</td>
									</tr>
								</tbody>
								<tbody id="SPR_CT_tbody">
									<tr>
										<th scope="row"><label for="hoffAlotm">지원금_회사부담액</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="hoffAlotm" class="inp ar" value="" name="hoffAlotm"> <span class="unit">원</span>
											</div>
										</td>
										<th scope="row"><label for="datepicker3">지급일</label></th>
										<td>
											<div class="dateWrap">
												<input type="text" name="ctStatDt" value="10/24/1984" class="datepicker" id="datepicker3" readonly>
												<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker3"></button>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row" class="txtLong"><label for="agenAlotm">지원금_대리점부담액</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="agenAlotm" class="inp ar" value="" name="agenAlotm"> <span class="unit">원</span>
											</div>
										</td>
										<th scope="row"><label for="ctMeno">메모</label></th>
										<td><input type="text" id="ctMeno" class="inp" value="" name="ctMeno"></td>
									</tr>
								</tbody>
								<!-- 지원금 -->

								<!-- 장려금 -->
								<tbody id="SUBSID_tbody" style="display: none">
									<tr>
										<th scope="row"><label for="">장려금</label></th>
										<td>
											<div class="checkGroup">
												<input type="radio" name="subsidSec" id="subsidSec1" class="type01" checked="checked" value="subsidRate"><label for="subsidSec1"><span>지급율</span></label> <input type="radio" name="subsidSec" id="subsidSec2" class="type01" value="subsidCt"><label for="subsidSec2"><span>지급금액</span></label>
											</div>
										</td>
										<th scope="row"><label for="datepicker4">기간</label></th>
										<td>
											<div class="formWrap w340">
												<div class="dateWrap">
													<input type="text" name="subsidStatDt" value="10/24/1984" class="datepicker" id="datepicker4" readonly>
													<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker4"></button>
												</div>

												<span class="divi">-</span>

												<div class="dateWrap">
													<input type="text" name="subsidClsDt" value="10/24/1984" class="datepicker" id="datepicker5" readonly>
													<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker5"></button>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="subsidRate">지급율</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="subsidRate" class="inp ar" value="" name="subsidRate"> <span class="unit">%</span>
											</div>
										</td>
										<th scope="row"><label for="SUBSID_sprCt">금액</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="subsidCt" class="inp ar" value="" name="subsidCt" readonly> <span class="unit">원</span>
											</div>
										</td>
									</tr>
								</tbody>
								<!-- 장려금 -->
								<!-- 물량지원 -->
								<tbody id="VOL_tbody" style="display: none">
									<tr>
										<th scope="row"><label for="inp_pCode">제품</label></th>
										<td>
											<div class="formWrap type02">
												<input type="hidden" name="sprtPrdDtlSeq" id="sprtPrdDtlSeq" value="" /> <input type="text" name="sprtPrdCd" id="sprtPrdCd" class="inp w140 mr10" readonly />

												<div class="searchWrap w223 mr10">
													<input type="text" name="sprtPrdNm" id="sprtPrdNm" class="inp" disabled />
													<button type="button" class="postBtn" name="" title="검색하기" onclick="openSearchPrdPop();"></button>
												</div>

												<button type="button" name="" class="inquBtn medium addTr" onclick ="addPrdSprt();">추가</button>
											</div>
										</td>
										<th scope="row"><label for="datepicker6">지급일</label></th>
										<td>
											<div class="dateWrap">
												<input type="text" name="prdStatDt" value="" class="datepicker" id="datepicker6" readonly />
												<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker6"></button>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="inp_qty">수량</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="prdQty" class="inp ar" value="" name="prdQty"> <span class="unit">개</span>
											</div>
										</td>
										<th scope="row"><label for="prdCt">금액</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="prdCt" class="inp ar" value="" name="prdCt"> <span class="unit">원</span>
											</div>
										</td>
									</tr>
								</tbody>
								<!-- 물량지원 -->
								<!-- 장비지원 -->
								<tbody id="EQPMN_tbody" style="display: none">
									<tr>
										<th scope="row"><label for="sel_equiName">장비명</label></th>
										<td><span style="width: 160px"> ${sprtEqpmnList} </span></td>
										<th scope="row"><label for="eqpmnQty">수량</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="eqpmnQty" class="inp ar" value="" name="eqpmnQty"> <span class="unit">개</span>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="eqpmnCt">금액</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="eqpmnCt" class="inp ar" value="" name="eqpmnCt"> <span class="unit">원</span>
											</div>
										</td>
										<th scope="row"><label for="datepicker8">지급일</label></th>
										<td>
											<div class="dateWrap">
												<input type="text" name="eqpmnStatDt" value="10/24/1984" class="datepicker" id="datepicker8" readonly>
												<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker8"></button>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="datepicker9">회수일</label></th>
										<td colspan="3">
											<div class="dateWrap">
												<input type="text" name="eqpmnClsDt" value="10/24/1984" class="datepicker" id="datepicker9" readonly>
												<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker9"></button>
											</div>
										</td>
									</tr>
								</tbody>
								<!-- 장비지원 -->
								<!-- 기타 -->
								<tbody id="ETC_tbody" style="display: none">
									<tr>
										<th scope="row"><label for="etcCt">금액</label></th>
										<td>
											<div class="formWrap w250">
												<input type="text" id="etcCt" class="inp ar" value="" name="etcCt"> <span class="unit">원</span>
											</div>
										</td>
										<th scope="row"><label for="datepicker10">지급일</label></th>
										<td>
											<div class="dateWrap">
												<input type="text" name="etcStatDt" value="10/24/1984" class="datepicker" id="datepicker10" readonly>
												<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker10"></button>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="etcMemo">메모</label></th>
										<td colspan="3"><input type="text" id="etcMemo" class="inp" value="" name="etcMemo"></td>
									</tr>
								</tbody>
								<!-- 기타 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="titleArea">
					<h3 class="tit01">지원 내역 관리</h3>
				</div>

				<div class="txtInfo pColor02">※ 최근 30건만 조회됩니다. 더 많은 내역은 거래처 지원내역 관리에서 확인 가능합니다.</div>

				<!-- grid -->
				<div class="girdBox">
					<div id="grid_wrap"></div>
				</div>
				<!-- grid -->

			</div>
			<!-- tabContent 지원 내역 -->
		</div>
		<!-- tabs -->
	</form>
</div>
