<!-- 
	@File Name: cstDiretMng.jsp
	@File 설명 : 이사/직영몰 고객 관리
	@UI ID : UI-PCLI-0401
	@작성일 : 2022. 3. 16.
	@작성자 : JIHUN
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<script type="text/javascript">
	var myGridID;
	var myGridID2;
	var gridData2 = [
		{"id":"#Cust0","regiDate":"2021-01-22","code":505405,"name":"김남양","movebf01":"001","movebf02":"강북지점","movebf03":"0000001","hopeDt":"2022-01-11","vend":"003","moveaf02":"호남지점","moveaf03":"0000002","moveaf04":"송정가정대리점","mvDt":"2022-01-26","cntrYn":"요청완료","dcsnDt":"2022-01-04","worker":"이*은"},
		{"id":"#Cust1","regiDate":"2021-01-22","code":505405,"name":"남양순","movebf01":"001","movebf02":"강남지점","movebf03":"0000001","hopeDt":"2022-01-11","vend":"003","moveaf02":"호남지점","moveaf03":"0000002","moveaf04":"송정가정대리점","mvDt":"2022-01-26","cntrYn":"거절","dcsnDt":"2022-01-04","worker":"이*은"},
		{"id":"#Cust0","regiDate":"2021-01-22","code":505405,"name":"김남양","movebf01":"001","movebf02":"강북지점","movebf03":"0000001","hopeDt":"2022-01-11","vend":"003","moveaf02":"호남지점","moveaf03":"0000002","moveaf04":"송정가정대리점","mvDt":"2022-01-26","cntrYn":"계약완료","dcsnDt":"2022-01-04","worker":"이*은"},
		{"id":"#Cust0","regiDate":"2021-01-22","code":505405,"name":"김남양","movebf01":"001","movebf02":"강북지점","movebf03":"0000001","hopeDt":"2022-01-11","vend":"003","moveaf02":"호남지점","moveaf03":"0000002","moveaf04":"송정가정대리점","mvDt":"2022-01-26","cntrYn":"대기","dcsnDt":"2022-01-04","worker":"이*은"},
		{"id":"#Cust0","regiDate":"2021-01-22","code":505405,"name":"김남양","movebf01":"001","movebf02":"강북지점","movebf03":"0000001","hopeDt":"2022-01-11","vend":"003","moveaf02":"호남지점","moveaf03":"0000002","moveaf04":"송정가정대리점","mvDt":"2022-01-26","cntrYn":"요청완료","dcsnDt":"2022-01-04","worker":"이*은"},
	];

	$(document).ready(function() {
		setTab();

		createAUIGrid();

		// AUIGrid.setGridData(myGridID, gridData);
		searchCstDiretHis();

		AUIGrid.setGridData(myGridID2, gridData2);

		AUIGrid.bind(myGridID, "selectionChange", function(event) {
			var cell = event.primeCell;
			var item = cell.item;

			searchCstDiretDtl({ cstDiretSeq : item.cstDiretSeq });
		});

		$("#cstDiretDtlArea").html($("#cstDiretDtl").tmpl({ cntrList : []}));

		$('#areaNm').on('click', openAgenAreaSearchPop);
	})

	function createAUIGrid() {
        // 그리드 속성 설정
        var gridPros = {
			headerHeight : 29,
			rowHeight : 29,
			// 편집 가능 여부 (기본값 : false)
			editable : false,
			
			// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
			enterKeyColumnBase : true,
			
			// 셀 선택모드 (기본값: singleCell)
			selectionMode : "“singleRow”",
			
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
		myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros);
    }

	var columnLayout = [
		{
			dataField : "cstDiretSeq",
			visible : false,
		},{
			dataField : "regDtm",
			headerText : "등록일",
			width : "10%",
		},{
            dataField : "cstNm",
			headerText : "성명",
			width : "5%",
		},{
            headerText : "이사 전",
            colSpan : 4,
            width : "20%",
            dataField : "movebf", // 그룹 헤더의 dataField 는 무의미 하지만, 접근자로  사용하기 위해 임의 지정함.(중복되지 않게 임의 지정하세요.)
            children : [{
                    dataField : "befAreaSeq",
                    headerText : "지점",
                    colSpan : 2,
                    width : "5.5%",
                    style: "auiRight"
                }, {
                    dataField : "befAreaNm",
                    headerText : "지점2",
                    width : "8%",
                }, {
                    dataField : "befAgenSeq",
                    headerText : "대리점",
                    //width:120,
                    colSpan : 2,
                    width : "6%",
                    style: "auiRight"
                },{
                    dataField : "befAgenNm",
                    headerText : "대리점2",
                    //width:120,
                    width : "8%",
                }]
        },{
            headerText : "이사 후",
            colSpan : 4,
            width : "20%",
            dataField : "moveaf", // 그룹 헤더의 dataField 는 무의미 하지만, 접근자로  사용하기 위해 임의 지정함.(중복되지 않게 임의 지정하세요.)
            children : [{
                    dataField : "aftAreaSeq",
                    headerText : "지점",
                    colSpan : 2,
                    width : "5.5%",
                    style: "auiRight"
                }, {
                    dataField : "aftAreaNm",
                    headerText : "지점2",
                    width : "5.5%",
                    style: "auiRight"
                }, {
                    dataField : "aftAgenSeq",
                    headerText : "대리점",
                    //width:120,
                    colSpan : 2,
                    width : "6%",
                    style: "auiRight"
                },{
                    dataField : "aftAgenNm",
                    headerText : "대리점2",
                    //width:120,
                    width : "8%",
                    style: "auiRight"
                }]
        },{
            dataField : "diretDtm",
			headerText : "이사일자",
			width : "10%",
		},{
            dataField : "cntrStus",
			headerText : "계약여부",
			width : "8%",
		},{
            dataField : "dcsnDtm",
			headerText : "확정일",
			width : "8%",
		},{
            dataField : "emplNm",
			headerText : "작업자",
			// width : "10%",
		}
	];

	var columnLayout2 = [{
        dataField : "regiDate",
			headerText : "가입일",
			width : "10%",
		},{
            dataField : "code",
			headerText : "직영몰코드",
			width : "8%",
		},{
            dataField : "name",
			headerText : "성명",
			width : "8%",
		},{
			dataField : "movebf01",
            headerText : "지점",
			headerStyle : "지점",
            colSpan : 2,
            width : "8%",
		},{
			dataField : "movebf02",
            width : "8%",
		},{
			dataField : "vend",
            headerText : "대리점",
            colSpan : 2,
            width : "8%",
        },{
            dataField : "mvDt",
			headerText : "이사일자",
			width : "10%",
		},{
            dataField : "hopeDt",
			headerText : "투입희망일자",
			width : "9%",
		},{
            dataField : "cntrYn",
			headerText : "계약여부",
			width : "9%",
		},{
            dataField : "dcsnDt",
			headerText : "확정일",
			width : "9%",
		},{
            dataField : "worker",
			headerText : "작업자",
		}
	];

	// events
	function resizeGrid() {
		AUIGrid.resize(myGridID);
		AUIGrid.resize(myGridID2);
	}

	function openAgenAreaSearchPop() {
		$.ajaxDialog({
			id: "searchAreaPop",
			ajax: {
				url: "/comm/pop/areaSearchPop.pop",
			},
			dialog: {
				width: 800,
				height: 500
			},
			success: function(item) {
				$('#areaSeq').val(item.areaSeq);
				$('#areaNm').val(item.areaNm);
			}
		})
	}
	
	// methods

	function getPttnStr(qtys) {
		var week = ['월', '화', '수', '목', '금', '토', '일'];
		var result = '';
		for(var i=0; i<qtys.length; i++) {
			if(qtys[i] !== '0') {
				result += week[i];
			}
		}
		return result + '/' + qtys.replace(/0/g, '');
	}

	function dateDiff(start, end) {
		return Math.round((start-end)/(1000*60*60*24));
	}

	function parseDate(str) {
		return new Date(str.substr(0,4), str.substr(4,2)-1, str.substr(6,2));
	}

	// api
	function searchCstDiretHis() {
		var data = {};
		data.startDt = $('#datepicker').val().replace(/-/g, '');
		data.endDt = $('#datepicker02').val().replace(/-/g, '');
		var diff = dateDiff(parseDate(data.startDt), parseDate(data.endDt));
		if(diff > 31 || diff < -31) {
			alert('기간 최대 31일까지 설정 가능합니다.\n기간을 확인해주세요.');
			return;
		}

		data.name = $('#inp_name01').val();
		data.dateFlag = $("input[name='date']:checked").val();
		$.ajax({
			url : "/cst/diretHisList.do",
			type : "POST",
			data : data,
			success : function(data) {
				AUIGrid.setGridData(myGridID, data);
				$('#listCnt').html(data.length);
			}
		})
	}

	function searchCstDiretDtl(param) {
		$.ajax({
			url : '/cst/diretDtl.do',
			type : "POST",
			data : param,
			success : function(data) {
				$("#cstDiretDtlArea").html($("#cstDiretDtl").tmpl(data));
				if(data.curAgenSeq === data.aftAgenSeq) {
					$('#cntrStus').attr('disabled', false);
					$('#rjctRson').attr('disabled', false);
					$('#areaSeq').attr('disabled', false);
					$('#aftRmk').attr('disabled', false);
					$('#areaSearchBtn').attr('disabled', false);
				} else {
					$('#diretCt').attr('disabled', false);
					$('#befRmk').attr('disabled', false);
				}
			}
		})
	}

	function saveCstDiret() {
		var data = {};
		var rowItem = AUIGrid.getItemByRowIndex(myGridID, AUIGrid.getSelectedIndex(myGridID)[0])
		data.cstDiretSeq = rowItem.cstDiretSeq;
		data.befAgenSeq = rowItem.befAgenSeq;
		data.aftAgenSeq = rowItem.aftAgenSeq;

		data.befRmk = $('#befRmk').val();
		data.aftRmk = $('#aftRmk').val();
		data.diretCt = $('#diretCt').val();
		data.cntrStus = $('#cntrStus').val();
		data.rjctRson = $('#rjctRson').val();
		data.aftAreaSeq = $('#areaSeq').val();

		$.ajax({
			url: "/cst/updateCstDiret.do",
			type: 'POST',
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			success: function(data) {
				
			},
			error: function(xhr, status, errorThrown) {
				if ( Common.IsJsonString(xhr.responseText) )
				{
					var message = JSON.parse(xhr.responseText).message;
					alert(message);
				}
				else
				{
					alert('처리중 오류가 발생 하였습니다.')
				}
			}
		})
	}

</script>
<div class="content">
<tiles:insertAttribute name="body.breadcrumb"/>

	<!-- tabs -->
	<div class="tabsWrap">
		<ul class="tabs">
			<li class="active" rel="tab01">이사 고객 관리</li>
			<li class="" rel="tab02">직영몰 고객 관리</li>
		</ul>

		<!-- tabContent 이사 고객 관리 -->
		<div id="tab01" class="tabContent">
			<!-- 조회 -->
			<div class="inquiryBox type02">
				<dl>
					<dt>기간</dt>
					<dd>
						<div class="formWrap">
							<div class="dateWrap">
								<input type="text" name="date" value="" class="inp datepicker" id="datepicker" readonly="">                                        
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker"></button>                                        
							</div> 

							<span class="divi02">-</span>
							
							<div class="dateWrap">
								<input type="text" name="date" value="" class="inp datepicker" id="datepicker02" readonly="">
								<button type="button" class="datepickerBtn02" title="날짜입력" data-target-id="datepicker02"></button>                                        
							</div>

							<div class="checkGroup">
								<input type="radio" name="date" id="date1" class="type01" checked="" value="reg"><label for="date1"><span>등록일</span></label>
								<input type="radio" name="date" id="date2" class="type01" value="dcsn"><label for="date2"><span>확정일</span></label>
							</div>
						</div>
					</dd>
					<dt>성명</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="inp_name01" class="inp w160" value="" title="성명 입력">
							<button type="button" name="" class="comBtn" id="inp_name01" onclick = 'searchCstDiretHis()'>조회</button>
						</div>
					</dd>
				</dl>
			</div>
			<!-- 조회 -->

			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="girdBox type07" id="diretGrid">
				<div id="grid_wrap"></div>
			</div>
			<!-- grid -->
			
			<div id="cstDiretDtlArea">
			</div>
			
		</div>
		<!-- //tabContent 이사 고객 관리 -->

		<!-- tabContent 직영몰 고객 관리 -->
		<div id="tab02" class="tabContent">
			<!-- 조회 -->
			<div class="inquiryBox type02">
				<dl>
					<dt>기간</dt>
					<dd>
						<div class="formWrap">
							<div class="dateWrap">
								<input type="text" name="date" value="" class="inp datepicker" id="datepicker03" readonly="">                                        
								<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker03"></button>                                        
							</div> 

							<span class="divi02">-</span>
							
							<div class="dateWrap">
								<input type="text" name="date" value="" class="inp datepicker" id="datepicker04" readonly="">
								<button type="button" class="datepickerBtn02" title="날짜입력" data-target-id="datepicker04"></button>                                        
							</div>

							<div class="checkGroup">
								<input type="radio" name="date2" id="date3" class="type01" checked="" value="reg"><label for="date3"><span>등록일</span></label>
								<input type="radio" name="date2" id="date4" class="type01" value="dcsn"><label for="date4"><span>확정일</span></label>
							</div>
						</div>
					</dd>
					<dt>계약여부</dt>
					<dd>
						<select name="" class="sel w140" id="">
							<option>전체</option>
						</select>
					</dd>
					<dt>성명</dt>
					<dd>
						<div class="formWrap">
							<input type="text" id="inp_name01" class="inp w160" value="" title="성명 입력">
							<button type="button" name="" class="comBtn" id="inp_name01">조회</button>
						</div>
					</dd>
				</dl>
			</div>
			<!-- 조회 -->

			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>

			<!-- grid -->
			<div class="girdBox type07">
				<div id="grid_wrap2"></div>
			</div>
			<!-- grid -->

			<!-- 기본 정보 -->
			
		</div>
		<!-- //tabContent 직영몰 고객 관리 -->
	</div>
	<!-- //tabs -->

</div>
<script id="cstDiretDtl" type="text/x-jquery-tmpl">
	<!-- 기본 정보 -->
	<div class="tblWrap">
		<div class="titleArea right">
			<h3 class="tit01">기본정보</h3>
			
			<button type="button" name="" class="inquBtn full small" onclick = 'saveCstDiret()'>저장</button>								
		</div>

		<p class="txt01 ar"><i class="icoRequir"></i>필수 입력 항목입니다.</p>

		<table class="tbl">
			<caption>직원정보 상세</caption>
			<colgroup>
				<col style="width:164px;">
				<col>
				<col style="width:164px;">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">
						성명
					</th>
					<td>
						<p>\${cstNm}</p>
					</td>
					<th scope="row">
						이사일자
					</th>
					<td>
						<p>\${diretDtm}</p>
					</td>
				</tr>
				<tr>
					<th scope="row">
						휴대폰 번호
					</th>
					<td>
						<p>\${mobNo}</p>
					</td>
					<th scope="row">
						전화번호
					</th>
					<td>
						<p>\${telNo}</p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!--// 기본 정보 -->

	<!-- 계약현황 -->
	<div class="tblWrap">
		<div class="titleArea right">
			<h3 class="tit01">계약현황</h3>
		</div>
		<table class="tbl">
			<caption>계약현황 상세</caption>
			<colgroup>
				<col style="width:164px;">
				<col>
				<col style="width:164px;">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">
						등록일
					</th>
					<td>
						<p>\${regDtm}</p>
					</td>
					<th scope="row">
						확정일
					</th>
					<td>
						<p>\${dcsnDtm}</p>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="sel_conOrNot02" class="required" title="필수입력">계약여부</label>
					</th>
					<td>
						<select name="" class="sel w160" id="cntrStus" disabled="true">
							<option value="RJCT" <c:if test="${cntrStus == 'RJCT'}">selected</c:if> >거절</option>
							<option value="CNTR_COMPT" <c:if test="${cntrStus == 'CNTR_COMPT'}">selected</c:if> >계약완료</option>
						</select>
					</td>
					<th scope="row">
						<label for="inp_refuse02">거절사유</label>
					</th>
					<td>
						<input type="text" id="rjctRson" class="inp" value="\${rjctRson}" title="거절사유 입력" disabled="true">
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!--// 계약현황 -->

	<!-- 이사 전 정보 -->
	<div class="tblWrap">
		<div class="titleArea right">
			<h3 class="tit01">이사 전 정보</h3>
		</div>
		<table class="tbl">
			<caption>이사 전 정보 상세</caption>
			<colgroup>
				<col style="width:164px;">
				<col>
				<col style="width:164px;">
				<col>
			</colgroup>
			<tr>
				<tr>
					<th scope="row">
						지점
					</th>
					<td colspan="3">
						<div class="formWrap type02">
							<p class="w200">\${befAreaSeq}</p>
							<p>\${befAreaNm}</p>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">
						대리점
					</th>
					<td>
						<div class="formWrap type02">
							<p class="w200">\${befAgenSeq}</p>
							<p>\${befAgenNm}</p>
						</div>
					</td>
					<th scope="row">
						연락처
					</th>
					<td>
						<p>\${befTelNo}</p>
					</td>
				</tr>
				<tr rowspan="2">
					<th scope="row" rowspan="2">
						배달주소
					</th>
					<td colspan="3">
						<p class="lh01">\${befDlvZipCd}</p>
					</td>
				</tr>
				<tr>
					<td>
						<p>\${befDlvAddr1}</p>
					</td>
					<th scope="row">
						상세주소
					</th>
					<td>
						<p>\${befDlvAddr2}</p>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="inp_move" class="required" title="필수입력">이사비용</label>
					</th>
					<td colspan="3">
						<input type="text" id="diretCt" class="inp ar w400" value="\${diretCt}" title="이사비용 입력" disabled="true">
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="inp_memo">메모</label>
					</th>
					<td colspan="3">
						<input type="text" id="befRmk" class="inp w100per" value="\${befRmk}" name="" disabled="true">
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!--// 이사 전 정보 -->

	<!-- 이사 후 정보 -->
	<div class="tblWrap">
		<div class="titleArea right">
			<h3 class="tit01">이사 후 정보</h3>
		</div>

		<table class="tbl mb10">
			<caption>이사 후 정보 상세</caption>
			<colgroup>
				<col style="width:164px;">
				<col>
				<col style="width:164px;">
				<col>
			</colgroup>
			<tr>
				<tr>
					<th scope="row">
						지점
					</th>
					<td colspan="3">
						<div class="formWrap type02">
							<p class="w200">\${bhfcSeq}</p>
							<p>\${bhfcNm}</p>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">
						담당사원
					</th>
					<td>
						<p>\${emplNm}</p>
					</td>
					<th scope="row">
						연락처
					</th>
					<td>
						<p>\${aftEmplTelNo}</p>
					</td>
				</tr>
				<tr>
					<th scope="row">
						대리점
					</th>
					<td>
						<div class="formWrap type02">
							<p class="w200">\${aftAgenSeq}</p>
							<p>\${aftAgenNm}</p>
						</div>
					</td>
					<th scope="row">
						연락처
					</th>
					<td>
						<p>\${aftAgenTelNo}</p>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="inp_move" class="required" title="필수입력">지역</label>
					</th>
					<td colspan="3">
						<div class="formWrap type02">
							<input type="text" id="areaSeq" class="inp w220 mr10" value="\${areaSeq}" disabled="true">

							<div class="searchWrap w220">
								<input type="text" id="areaNm" class="inp" value="\${areaNm}" disabled="true">
								<button type="button" class="postBtn" title="등록_지원내역 찾기" id="areaSearchBtn" disabled="true" onclick='openAgenAreaSearchPop()'></button>
							</div>
						</div>
					</td>
				</tr>
				<tr rowspan="2">
					<th scope="row" rowspan="2">
						배달주소
					</th>
					<td colspan="3">
						<p class="lh01">\${aftDlvZipCd}</p>
					</td>
				</tr>
				<tr>
					<td>
						<p>\${aftDlvAddr1}</p>
					</td>
					<th scope="row">
						상세주소
					</th>
					<td>
						<p>\${aftDlvAddr2}</p>
					</td>
				</tr>
			</tbody>
		</table>

		<table class="tbl mb10">
			<caption>이사 후 정보 상세</caption>
			<colgroup>
				<col style="width:164px;">
				<col>
				<col style="width:164px;">
				<col>
			</colgroup>
			<tbody>
				{{each(i, e) cntrList }}
					<tr>
						<th scope="row">
							계약 시작일
						</th>
						<td>
							<p>\${e.statDt}</p>
						</td>
						<th scope="row">
							계약기간
						</th>
						<td>
							<p>\${e.cntrMonth}</p>
						</td>
					</tr>
					<tr>
						<th scope="row">
							제품
						</th>
						<td>
							<div class="formWrap type02">
								<p class="w200">\${e.prdDtlCd}</p>
								<p>\${e.prdNm}</p>
							</div>
						</td>
						<th scope="row">
							잔여기간
						</th>
						<td>
							<p>\${e.remrDt}</p>
						</td>
					</tr>
					<tr>
						<th scope="row">
							수량/홉수
						</th>
						<td>
							<p>\${e.stdrQty}개 / \${e.hop} 홉</p>
						</td>
						<th scope="row">
							투입패턴
						</th>
						<td>
							<p>\${ getPttnStr(e.qtys) }</p>
						</td>
					</tr>
					<tr>
						<th scope="row">
							판촉물
						</th>
						<td colspan="3">
							<p>\${e.prmt}</p>
						</td>
					</tr>
				{{/each}}
			</tbody>
		</table>

		<table class="tbl">
			<caption>이사 후 정보 상세</caption>
			<colgroup>
				<col style="width:164px;">
				<col>
				<col style="width:164px;">
				<col>
			</colgroup>
			<tr>
				<tr>
					<th scope="row">
						정산 방법
					</th>
					<td>
						<p>CMS (자동이체)</p>
					</td>
					<th scope="row">
						이사비용
					</th>
					<td>
						<p>\${diretCt*-1}</p>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="aftRmk">메모</label>
					</th>
					<td colspan="3">
						<input type="text" id="aftRmk" class="inp w100per" value="\${aftRmk}" name="" disabled="true">
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</script>

<script id="nylDtl" type="text/x-jquery-tmpl">
<div class="tblWrap">
	<div class="titleArea right">
		<h3 class="tit01">기본정보</h3>
		
		<button type="button" name="" class="inquBtn full small">저장</button>								
	</div>

	<p class="txt01 ar"><i class="icoRequir"></i>필수 입력 항목입니다.</p>

	<table class="tbl">
		<caption>직원정보 상세</caption>
		<colgroup>
			<col style="width:164px;">
			<col>
			<col style="width:164px;">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">
					성명
				</th>
				<td>
					<p>김영희</p>
				</td>
				<th scope="row">
					투입희망일자
				</th>
				<td>
					<p>2021-12-10</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					주소
				</th>
				<td>
					<p>서울시 논현동 학동로 100-10, 1층</p>
				</td>
				<th scope="row">
					전화번호
				</th>
				<td>
					<p>031-0000-0000</p>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!--// 기본 정보 -->

<!-- 계약현황 -->
<div class="tblWrap">
	<div class="titleArea right">
		<h3 class="tit01">계약현황</h3>
	</div>
	<table class="tbl">
		<caption>계약현황 상세</caption>
		<colgroup>
			<col style="width:164px;">
			<col>
			<col style="width:164px;">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">
					등록일
				</th>
				<td>
					<p>2021-11-20</p>
				</td>
				<th scope="row">
					확정일
				</th>
				<td>
					<p>2021-12-10</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="sel_conOrNot" class="required" title="필수입력">계약여부</label>
				</th>
				<td>
					<select name="" class="sel w160" id="sel_conOrNot">
						<option>거절</option>
						<option>계약완료</option>
					</select>
				</td>
				<th scope="row">
					<label for="inp_refuse">거절사유</label>
				</th>
				<td>
					<input type="text" id="inp_refuse" class="inp" value="" title="거절사유 입력">
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!--// 계약현황 -->

<!-- 담당 지점/대리점 정보 -->
<div class="tblWrap">
	<div class="titleArea right">
		<h3 class="tit01">담당 지점/대리점 정보</h3>
	</div>
	<table class="tbl">
		<caption>담당 지점/대리점 정보 상세</caption>
		<colgroup>
			<col style="width:164px;">
			<col>
			<col style="width:164px;">
			<col>
		</colgroup>
		<tr>
			<tr>
				<th scope="row">
					지점
				</th>
				<td colspan="3">
					<div class="formWrap type02">\
						<p class="w200">500505050</p>
						<p>강북지점</p>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
					담당사원
				</th>
				<td>
					<p>홍길동</p>
				</td>
				<th scope="row">
					연락처
				</th>
				<td>
					<p>010-0000-0000</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					대리점
				</th>
				<td>
					<div class="formWrap type02">
						<p class="w200">500505050</p>
						<p>강북지점</p>
					</div>
				</td>
				<th scope="row">
					연락처
				</th>
				<td>
					<p>010-0000-0000</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="inp_area" class="required" title="필수입력">지역</label>
				</th>
				<td colspan="3">
					<div class="formWrap type02">
						<input type="text" id="inp_area" class="inp w220 mr10" placeholder="지역코드">

						<div class="searchWrap w220">
							<input type="text" id="inp_post_num" class="inp">
							<button type="button" class="postBtn" placeholder="지역명"></button>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!--// 담당 지점/대리점 정보 -->

<!-- 직영몰 고객 상세 정보 -->
<div class="tblWrap">
	<div class="titleArea right">
		<h3 class="tit01">직영몰 고객 상세 정보</h3>
	</div>

	<table class="tbl mb10">
		<caption>이사 후 정보 상세</caption>
		<colgroup>
			<col style="width:164px;">
			<col>
			<col style="width:164px;">
			<col>
		</colgroup>
		<tbody>
			<tr rowspan="2">
				<th scope="row" rowspan="2">
					배달주소
				</th>
				<td colspan="3">
						<p class="lh01">00000</p>
				</td>
			</tr>
			<tr>
				<td>
						<p>서울특별시 강남구 도산대로 240</p>
				</td>
				<th scope="row">
					상세주소
				</th>
				<td>
					<p>1964빌딩 8층</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					제품
				</th>
				<td>
					<div class="formWrap type02">
						<p class="w200">500505050</p>
						<p>광진동대문가정</p>
					</div>
				</td>
				<th scope="row">
					계약기간
				</th>
				<td>
					<p>12</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					투입패턴
				</th>
				<td colspan="3">
					<p>월수금/111</p>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="inp_memo03">메모</label>
				</th>
				<td colspan="3">
					<input type="text" id="inp_memo03" class="inp w100per" value="" name="">
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!--// 직영몰 고객 상세 정보 -->
</script>