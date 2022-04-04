<!--
	@File Name: doubleDlvMng
	@File 설명 : 애음자 관리 - 더블/휴무 작업
	@UI ID : UI-PCLI-0701
	@작성일 : 2022.03.10
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	var mGrid;
	var mGrid2;
	$(document).ready(function() {
		createAUIGrid();
		selectDoubleDlvAreaList();
		$("#datepicker1").change(function(){
			selectDoubleDlvAreaList();

		});
	});

	var gridPros = {
		headerHeight: 29,
		rowHeight: 29,
		enableCellMerge: true,
		showStateColumn: false,
		showRowCheckColumn: true,
		wrapSelectionMove: true,
		editingOnKeyDown: true,
		editable: true,
		enterKeyColumnBase: true,
		selectionMode: "singleRow",
		showFooter: false,
		useContextMenu: true,
		enableFilter: true,
		useGroupingPanel: false,
		displayTreeOpen: true,
		noDataMessage: "출력할 데이터가 없습니다.",
		groupingMessage: "여기에 칼럼을 드래그하면 그룹핑이 됩니다.",
		showRowNumColumn: false,
	};

	function createAUIGrid() {
		mGrid = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
		mGrid2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridPros);
	}

	var columnLayout = [{
		dataField: "agenAreaCd",
		headerText: "코드",
		width: "30%",
	}, {
		dataField: "areaNm",
		headerText: "지역명",
		style: "auiLeft"
	}, {
		dataField: "emplNm",
		headerText: "판매원",
		width: "30%",
	}];

	var columnLayout2 = [{
		dataField: "puchNm",
		headerText: "매입처",
		width: "25%",
	}, {
		dataField: "prdDtlCd",
		headerText: "코드",
		width: "25%",
	}, {
		dataField: "prdNm",
		headerText: "제품명",
		style: "auiLeft"
	}];
	function selectDoubleDlvAreaList() {
		AUIGrid.clearGridData(mGrid2);
		$("#listCnt2").html(0);
		$.ajax({
			url : "/cst/selectDoubleDlvAreaList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				AUIGrid.setGridData(mGrid, data);
				$("#listCnt").html(data.length);
				selectDlvAllPrdList();
			}, // success
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	function selectDlvAllPrdList(){
		AUIGrid.clearGridData(mGrid2);
		$("#listCnt2").html(0);
		$.ajax({
			url : "/cst/selectDlvAllPrdList.do",
			type : 'POST',
			data : $("#frm").serialize(),
			success : function(data) {
				console.log(data);
				AUIGrid.setGridData(mGrid2, data);
				$("#listCnt2").html(data.length);
			}, // success
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		});
	}
	function startDoubleProc(){
		var areaSeqArr =AUIGrid.getCheckedRowItems(mGrid).map(({ item }) => item ).map(({ areaSeq }) => areaSeq );
		var prdDtlSeqArr = AUIGrid.getCheckedRowItems(mGrid2).map(({ item }) => item ).map(({ prdDtlSeq }) => prdDtlSeq );

		var sendData ={
            "legacyDlvDt" : $("#datepicker1").val(),
            "chgDlvDt" : $("#datepicker2").val(),
            "doubleSecCd" : "DOUBLE",
            "areaSeqArr" : areaSeqArr ,
            "prdDtlSeqArr" : prdDtlSeqArr
      	};
		 $.ajax({
		        url: "/cst/startDoubleProc.do",
		        contentType: 'application/json',
		        type: 'POST',
		        data:JSON.stringify(sendData),
		        success: function(data) {
		        	alert(data);
		        }, // success
		        error: function(xhr, status,errorThrown) {
		        	if ( Common.IsJsonString(xhr.responseText) )
		    		{
		    			var message = JSON.parse(xhr.responseText).message;
		    			alert(message);
		    		}
		    		else
		    		{
		    			alert("처리중 오류가 발생 하였습니다.");
		    		}
		        }
		    });
	}
	function returnDoubleProc(){
		var areaSeqArr =AUIGrid.getCheckedRowItems(mGrid).map(({ item }) => item ).map(({ areaSeq }) => areaSeq );
		var prdDtlSeqArr = AUIGrid.getCheckedRowItems(mGrid2).map(({ item }) => item ).map(({ prdDtlSeq }) => prdDtlSeq );

		var sendData ={
            "legacyDlvDt" : $("#datepicker1").val(),
            "chgDlvDt" : $("#datepicker2").val(),
            "doubleSecCd" : "",
            "areaSeqArr" : areaSeqArr ,
            "prdDtlSeqArr" : prdDtlSeqArr
      	};
		 $.ajax({
		        url: "/cst/returnDoubleProc.do",
		        contentType: 'application/json',
		        type: 'POST',
		        data:JSON.stringify(sendData),
		        success: function(data) {
					alert(data);
		        }, // success
		        error: function(xhr, status,errorThrown) {
		        	if ( Common.IsJsonString(xhr.responseText) )
		    		{
		    			var message = JSON.parse(xhr.responseText).message;
		    			alert(message);
		    		}
		    		else
		    		{
		    			alert("처리중 오류가 발생 하였습니다.");
		    		}
		        }
		    });
	}
	function openHisPop(){
		$.ajaxDialog({
			id: "doubleHisPop",
			ajax: {
				url: "/cst/doubleHisPop.do",
			},
			dialog: {
				width:860,
				height:560
			},
			success: function(data) {
			}
		});
	}
</script>

<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />
	<!-- 조회 -->
	<form id="frm" onsubmit="return false;">
		<div class="inquiryBox type02">
			<dl>
				<dd>
					<div class="formWrap">
						<div class="dateWrap">
							<input type="text" name="srcDate" value="10/24/1984" class="datepicker" id="datepicker1" readonly="" >
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker1"></button>
						</div>
						<span class="divi02">배달을</span>
						<div class="dateWrap">
							<input type="text" name="sendDate" value="10/24/1984" class="datepicker" id="datepicker2" readonly="">
							<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="datepicker2"></button>
						</div>
						<span class="divi02">으로</span>
						<div class="btnGroup">
							<button type="button" name="" class="comBtn" id="inp_name01" onclick ="startDoubleProc();">더블시작</button>
							<button type="button" name="" class="comBtn" id="inp_name01" onclick = "returnDoubleProc();">더블분리</button>
						</div>
					</div>
				</dd>
			</dl>

			<div class="btnGroup right">
				<button type="button" name="" class="comBtn" onclick ="openHisPop();">이력조회</button>
			</div>
		</div>
	</form>
	<!-- 조회 -->

	<!-- grid -->
	<div class="girdBoxGroup">
		<div class="girdBox w49per">
			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id ="listCnt">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>
			<div id="grid_wrap"></div>
		</div>
		<div class="girdBox w49per">
			<div class="titleArea">
				<p class="numState">
					<em>총 <span class="pColor01 fb" id="listCnt2">0</span></em> 건 이 조회되었습니다.
				</p>
			</div>
			<div id="grid_wrap2"></div>
		</div>
	</div>

</div>
