<!-- 
	@File Name: 
	@File 설명 : 
	@UI ID : 
	@작성일 : 2022. 2. 10.
	@작성자 : JungsuKim
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="code" uri="/WEB-INF/tlds/getCommCode.tld"%>

<script type="text/javascript">

	gTabGridFunc = [{"target": "tab01", "tarFunc": setTabResize }, {"target": "tab02", "tarFunc": setTabResize }, {"target": "tab03", "tarFunc": setTabResize }];
	
	var myGridID;
    var myGridID2;
	var myGridID3;
	var myGridID4;
	var myGridID5;
	var myGridIDExcel;
	var nowTabId = "tab01";

	var columnLayout = [{
			dataField : "agenAreaCd",
			headerText : "코드",
			width : "22%",
		},{
			dataField : "areaNm",
			headerText : "지역",
		},{
			dataField : "emplNm",
			headerText : "판매원",
            width : "25%",	   
		},{
			dataField : "cstCnt",
			headerText : "애음자수",
			width : "25%",
			style : "auiRight"
		},{
			dataField : "agenSeq",
			headerText : "대리점코드",
			visible : false			
		},{
			dataField : "areaSeq",
			headerText : "지역코드",
			visible : false			
		}
	];
	
    var columnLayoutExcel = [{
		dataField : "agenAreaCd",
		headerText : "코드",
		cellMerge : true,
		mergeRef : "cstSeq",
		mergePolicy : "restrict"			
    },{
		dataField : "areaNm",
		headerText : "지역",
		cellMerge : true,			
		mergeRef : "cstSeq",
		mergePolicy : "restrict"
    },{
		dataField : "dlvOrdr",
		headerText : "배달순서",
		width : "60",
		cellMerge : true,
		mergeRef : "cstSeq",
		mergePolicy : "restrict"			
	},{
		dataField : "cstSeq",
		headerText : "코드",
        width : "70",
		cellMerge : true,			
		mergeRef : "cstSeq",
		mergePolicy : "restrict"
	},{
		dataField : "cstNmMas",
		headerText : "성명",
		width : "70",
		cellMerge : true,
		mergeRef : "mobNoMas",
		mergePolicy : "restrict"
	},{
		dataField : "mobNoMas",
		headerText : "휴대폰번호",
		width : "100",
		cellMerge : true,
		mergeRef : "mobNo",
		mergePolicy : "restrict"
	},{
		dataField : "dlvAddr",
		headerText : "배달주소",
		width : "280",
		style : "auiLeft",
		cellMerge : true,			
		mergeRef : "mobNo",
		mergePolicy : "restrict"
	},{
		dataField : "badnYn",
		headerText : "수금상태",
		width : "60",
		cellMerge : true,
		mergeRef : "mobNo",
		mergePolicy : "restrict"
	},{
		dataField : "cstRegDtm",
		headerText : "등록일",
		width : "80",
		cellMerge : true,
		mergeRef : "mobNo",
		mergePolicy : "restrict"
	},{
		dataField : "prdNm",
		headerText : "제품명",
		width : "280",
		style : "auiLeft"
	},{
		dataField : "untpc",
		headerText : "단가",
		dataType : "numeric",
		width : "70",
		style : "auiRight"
	},{
		dataField : "dfltQty",
		headerText : "수량",
		width : "50",
		style : "auiRight"
	},{
		dataField : "sumDayQty",
		headerText : "패턴",
		width : "100",
	},{
		dataField : "untpcDtm",
		headerText : "가입일",
		width : "80",
	},{
		dataField : "untpcStatDtm",
		headerText : "투입일",
		width : "80",
	},{
		dataField : "chgSecNm",
		headerText : "투입상태",
		width : "70",
	},{
		dataField : "sbscrbCosCd",
		headerText : "가입경로",
		width : "70",
	},{
		dataField : "salesPerson",
		headerText : "판촉사원",
		width : "70",
	},{
		dataField : "hop",
		headerText : "홉수",
		width : "70",
	},{
		dataField : "hopUntpc",
		headerText : "홉단가",
		dataType : "numeric",			
		style : "auiRight",
		width : "70",
	},{
		dataField : "cntrPeriod",
		headerText : "계약기간",
		width : "70",
	},{
		dataField : "stpgDtm",
		headerText : "중지일",
		width : "80",
	},{
		dataField : "rmk",
		headerText : "중지사유",
		width : "70",
	},{
		dataField : "rervDtm",
		headerText : "보류일",
		width : "70",
	},{
		dataField : "remPeriod",
		headerText : "잔여기간",
		width : "70",
	},{
		dataField : "untpcEndDtm",
		headerText : "계약종료일",
		width : "70",
	}
];

    var columnLayout2 = [{
			dataField : "agenAreaCd",
			headerText : "코드",
			cellMerge : true,
			mergeRef : "mobNo",
			mergePolicy : "restrict"			
        },{
			dataField : "areaNm",
			headerText : "지역",
			cellMerge : true,			
			mergeRef : "mobNo",
			mergePolicy : "restrict"
        },{
			dataField : "dlvOrdr",
			headerText : "배달순서",
			width : "6%",
			cellMerge : true,
			mergeRef : "mobNo",
			mergePolicy : "restrict"			
		},{
			dataField : "cstSeq",
			headerText : "코드",
            width : "7%",
			cellMerge : true,			
			mergeRef : "mobNo",
			mergePolicy : "restrict"
		},{
			dataField : "cstNm",
			headerText : "성명",
			width : "7%",
			cellMerge : true,
			mergeRef : "mobNo",
			mergePolicy : "restrict"
		},{
			dataField : "mobNo",
			headerText : "휴대폰번호",
			width : "10%",
			cellMerge : true,
			mergeRef : "mobNo",
			mergePolicy : "restrict"
		},{
			dataField : "dlvAddr",
			headerText : "배달주소",
			width : "17%",
			style : "auiLeft",
			cellMerge : true,			
			mergeRef : "mobNo",
			mergePolicy : "restrict"
		},{
			dataField : "badnYn",
			headerText : "수금상태",
			width : "6%",
			cellMerge : true,
			mergeRef : "mobNo",
			mergePolicy : "restrict"
		},{
			dataField : "cstRegDtm",
			headerText : "등록일",
			width : "8%",
			cellMerge : true,
			mergeRef : "mobNo",
			mergePolicy : "restrict"
		},{
			dataField : "prdNm",
			headerText : "제품명",
			width : "20%",
			style : "auiLeft"
		},{
			dataField : "untpc",
			headerText : "단가",
			dataType : "numeric",
			width : "7%",
			style : "auiRight"
		},{
			dataField : "dfltQty",
			headerText : "수량",
			width : "5%",
			style : "auiRight"
		},{
			dataField : "sumDayQty",
			headerText : "패턴",
			width : "10%",
		},{
			dataField : "untpcDtm",
			headerText : "가입일",
			width : "8%",
		},{
			dataField : "untpcStatDtm",
			headerText : "투입일",
			width : "8%",
		},{
			dataField : "chgSecNm",
			headerText : "투입상태",
			width : "7%",
		},{
			dataField : "sbscrbCosCd",
			headerText : "가입경로",
			width : "7%",
		},{
			dataField : "salesPerson",
			headerText : "판촉사원",
			width : "7%",
		},{
			dataField : "hop",
			headerText : "홉수",
			width : "7%",
		},{
			dataField : "hopUntpc",
			headerText : "홉단가",
			dataType : "numeric",			
			style : "auiRight",
			width : "7%",
		},{
			dataField : "cntrPeriod",
			headerText : "계약기간",
			width : "7%",
		},{
			dataField : "stpgDtm",
			headerText : "중지일",
			width : "8%",
		},{
			dataField : "rmk",
			headerText : "중지사유",
			width : "7%",
		},{
			dataField : "rervDtm",
			headerText : "보류일",
			width : "7%",
		},{
			dataField : "remPeriod",
			headerText : "잔여기간",
			width : "7%",
		},{
			dataField : "untpcEndDtm",
			headerText : "계약종료일",
			width : "7%",
		}
	];

	var columnLayout3 = [{
			dataField : "prdSeq",
			headerText : "제품코드",
			width : "18%",
		},{
			dataField : "prdNm",
			headerText : "제품명",
			style : "auiLeft"
		},{
			dataField : "dfltQty",
			headerText : "수량",
			width : "20%",
			style : "auiRight"
		},{
			dataField : "untpc",
			headerText : "금액합계",
			dataType : "numeric",
			width : "20%",
			style : "auiRight"
		}
	];

	var columnLayout4 = [{
			dataField : "ordr",
			headerText : "배달순서",
			width : "9%",
		},{
			dataField : "cstAgenCd",
			headerText : "코드",			
		},{
			dataField : "cstNm",
			headerText : "성명",
			width : "8%", 
		},{
			dataField : "mobNo",
			headerText : "휴대폰번호",
			width : "15%", 
		},{
			dataField : "dlvAddr",
			headerText : "배달주소",
			width : "18%",
			style : "auiLeft"
		},{
			dataField : "untpc",
			headerText : "단가",
			dataType : "numeric",
			style : "auiRight",
			width : "12%", 
		},{
			dataField : "dfltQty",
			headerText : "수량",
			style : "auiRight",
			width : "10%", 
		},{
			dataField : "totUntpc",
			headerText : "금액합계",
			dataType : "numeric",
			style : "auiRight",
			width : "17%", 		
		}
	];

	var columnLayout5 = [{
			dataField : "agenAreaCd",
			headerText : "코드",
			width : "22%",
		},{
			dataField : "areaNm",
			headerText : "지역",
		},{
			dataField : "emplNm",
			headerText : "판매원",
	        width : "25%",	   
		},{
			dataField : "cstCnt",
			headerText : "애음자수",
			width : "25%",
			style : "auiRight"
		},{
			dataField : "agenSeq",
			headerText : "대리점코드",
			visible : false			
		},{
			dataField : "areaSeq",
			headerText : "지역코드",
			visible : false			
		}
	];
    
	// 푸터 설정
    var footerLayout3 = [{
    		labelText : "합계 : ",    		
    		//positionField : "#base"
    		positionField :	"prdNm"
    		//, colSpan : 3
        }, {
            dataField : "dfltQty",
            positionField : "dfltQty",
            operation : "SUM",
            style : "auiRight",
            formatString : "#,##0"
            
        }, {
            dataField : "untpc",
            positionField : "untpc",
            operation : "SUM",
            style : "auiRight",
            formatString : "#,##0"
        }];

	var footerLayout4 = [{
		labelText : "합계 : ",    		
		//positionField : "#base"
		positionField :	"cstNm"
			
		}, {
			dataField : "dfltQty",
			positionField : "dfltQty",
			operation : "SUM",
			style : "auiRight",
			formatString : "#,##0"
			
		}, {
			dataField : "totUntpc",
			positionField : "totUntpc",
			operation : "SUM",
			style : "auiRight",
			formatString : "#,##0"
	}];
	
	function setTabResize(tabId){
		
		console.log("setTabResize start nowTabId :: "+ nowTabId );
		
		if(tabId == "tab01"){			
			AUIGrid.resize(myGridID, $("#grid_wrap1").width());
			nowTabId = "tab01";
		}else if(tabId == "tab02"){
			
			AUIGrid.resize(myGridID3, $("#grid_wrap3").width());
			AUIGrid.resize(myGridID4, $("#grid_wrap4").width());
			getPuchList();	        
	        getPrdAreaList();			
	        nowTabId = "tab02";
	        
		}else if(tabId == "tab03"){			
			AUIGrid.resize(myGridID5, $("#grid_wrap5").width());
			nowTabId = "tab03";
		}		
	}

	$(document).ready(function(){
		
		$("#startDate").val(fnGetToDay());
		$("#endDate").val(fnGetToDay());
		
		$("#prdStartDate").val(fnGetToDay());
		$("#prdEndDate").val(fnGetToDay());
		setTab();
        // AUIGrid 생성 후 반환 ID
        createAUIGrid();
        // 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
        
        //getPeriAreaList();

	    AUIGrid.setFooter(myGridID3, footerLayout3);
		AUIGrid.setFooter(myGridID4, footerLayout4);
    });

	// AUIGrid 를 생성합니다.
	function createAUIGrid() {
		// 그리드 속성 설정
		var gridPros = {
				headerHeight : 29,
				rowHeight : 29,
				// 편집 가능 여부 (기본값 : false)

				enableCellMerge : true,  // 셀 병합 실행
				showStateColumn : false,
				showRowCheckColumn : false, // 체크박스 사용 	
				wrapSelectionMove : true,
				editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)
				editable : true,
				// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
				enterKeyColumnBase : true,
				// 셀 선택모드 (기본값: singleCell)
				selectionMode : "singleRow",
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
		
		var gridProsGroup = {
				headerHeight : 29,
				rowHeight : 29,
				// 편집 가능 여부 (기본값 : false)

				enableCellMerge : true,  // 셀 병합 실행
				showStateColumn : false,
				showRowCheckColumn : false, // 체크박스 사용 	
				wrapSelectionMove : true,
				editingOnKeyDown : true, // 키보드 입력으로 편집 모드 진입 (기본값:true임;)				
				editable : true,
				// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
				enterKeyColumnBase : true,
				// 셀 선택모드 (기본값: singleCell)
				selectionMode : "singleRow",
				showFooter : false,
				// 컨텍스트 메뉴 사용 여부 (기본값 : false)
				useContextMenu : true,
				// 필터 사용 여부 (기본값 : false)
				enableFilter : true,
				// 그룹핑 패널 사용
				useGroupingPanel : false,		
				//groupingFields : ["agenAreaCd", "areaNm", "dlvOrdr", "cstSeq", "cstNm", "mobNo", "dlvAddr", "badnYn", "cstRegDtm"],
				// 그룹핑 후 셀 병합 실행
				enableCellMerge : true,
				// enableCellMerge 할 때 실제로 rowspan 적용 시킬지 여부
				// 만약 false 설정하면 실제 병합은 하지 않고(rowspan 적용 시키지 않고) 최상단에 값만 출력 시킵니다.
				cellMergeRowSpan : true,
				cellMergePolicy : "valueWithNull",
				// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
				displayTreeOpen : true,
				noDataMessage : "출력할 데이터가 없습니다.",
				groupingMessage : "여기에 칼럼을 드래그하면 그룹핑이 됩니다."
		};

		var gridPros3 = {
			showFooter : true,
			selectionMode : "singleRow",
		}

		var gridPros4 = {
			showFooter : true,
			selectionMode : "singleRow",
		}

        // 실제로 #grid_wrap 에 그리드 생성
        myGridID = AUIGrid.create("#grid_wrap", columnLayout, gridPros);
        myGridID2 = AUIGrid.create("#grid_wrap2", columnLayout2, gridProsGroup);
        
        myGridIDExcel = AUIGrid.create("#grid_wrap_excel", columnLayoutExcel, gridPros);
        
		myGridID3 = AUIGrid.create("#grid_wrap3", columnLayout3, gridPros3);
		myGridID4 = AUIGrid.create("#grid_wrap4", columnLayout4, gridPros4);
		myGridID5 = AUIGrid.create("#grid_wrap5", columnLayout5, gridPros);
		
		AUIGrid.bind(myGridID, "cellClick", function(event) {			
			let areaSeq = AUIGrid.getCellValue(myGridID, event.rowIndex, "areaSeq");
			getPeriPrdList(areaSeq);
		});
		
		AUIGrid.bind(myGridID3, "cellClick", function(event) {			
			let prdSeq = AUIGrid.getCellValue(myGridID3, event.rowIndex, "prdSeq");
			getPrdAreaDetailList(prdSeq);
		});
		
		AUIGrid.bind(myGridID5, "cellClick", function(event) {			
			let areaSeq = AUIGrid.getCellValue(myGridID5, event.rowIndex, "areaSeq");
			getCstAreaMapDetailList(areaSeq);
		});		
	}
	
	//지역별 리스트
	function getPeriAreaList(){
		
		let param = $("#searchFrm").serialize();
		console.log("param ::", JSON.stringify(param));
		
		AUIGrid.clearGridData(myGridID2);
		
		$.ajax({
			url : "/cst/selectCstPeriAreaList.do", 
			type : 'POST', 
			data : param,
			success : function(data) {
				
				console.log("data", data);				
				$("#listCnt").text(data.length);
				AUIGrid.setGridData(myGridID, data);

			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	} 
	
	//지역별 애음자 리스트
	function getPeriPrdList(areaSeq){
		
		let formData = $("#searchFrm").serialize();
		
		let param = formData + "&areaSeq=" + areaSeq;
		
		console.log("param ::", JSON.stringify(param));
		
		$.ajax({
			url : "/cst/selectCstPeriPrdList.do", 
			type : 'POST', 
			data : param,
			success : function(data) {
				
				console.log("data", data);
								
				$("#listCnt2").text(data.length);
				AUIGrid.setGridData(myGridID2, data);
				AUIGrid.setGridData(myGridIDExcel, data);

			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	} 
	
	function openAreaPop(){
		console.log("openAreaPop ::");		
		//openPopup("modalAgencyViews03");
		
		$.ajaxDialog({
			id: "areaChoicePop",
			ajax: {
				url: "/cst/areaChoicePop.do",
			},
			dialog: {
				width:680,
				height:580,
				modal: true,
				draggable: false
			},
			success: function(data) {
				alert("여기로 리턴됨 ㅇㅇ >> "+ data.prdNm);
				
			}
		});
	}
	
	function setAreaCd(paramObj){
		
		//paramObj = {"areaSeq" : areaSeq, "agenAreaCd" : agenAreaCd, "areaNm": areaNm};
		console.log("setAreaCd ::");		
		//closePopup("modalAgencyViews03");
		
		if(nowTabId == "tab02"){
			$("#areaSeq").val(paramObj.areaSeq);
			$("#areaNm").val(paramObj.areaNm);	
			
		}else{
			$("#areaSeq3").val(paramObj.areaSeq);
			$("#areaNm3").val(paramObj.areaNm);	
			
		}
		
	}
	
	//매입처 리스트
	function getPuchList(){
				
		$.ajax({
			url : "/cst/selectPuchList.do", 
			type : 'POST', 
			data : {},
			success : function(data) {
				
				console.log("data", data);
				let selHtml = "<option value=''></option>";
				
				$.each(data, function(index, item){
					selHtml = selHtml  + "<option value='"+item.puchSeq+"'>"+item.puchNm+"</option>";
				});
				
				$("#puchSeq").html(selHtml);

			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	} 
	
	//제품별 제품 리스트
	function getPrdAreaList(){
		
		let formData = $("#prdSearchFrm").serialize();
		
		console.log("param ::", JSON.stringify(formData));
		
		AUIGrid.clearGridData(myGridID4);
		
		$.ajax({
			url : "/cst/selectPrdAreaList.do", 
			type : 'POST', 
			data : formData,
			success : function(data) {
				
				console.log("data", data);								
				$("#listCnt3").text(data.length);
				AUIGrid.setGridData(myGridID3, data);
				

			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	} 
	
	//제품별 애음자 리스트
	function getPrdAreaDetailList(prdSeq){
		
		let formData = $("#prdSearchFrm").serialize();
		
		let param = formData + "&prdSeq=" + prdSeq;
		
		console.log("param ::", JSON.stringify(param));
		
		$.ajax({
			url : "/cst/selectPrdAreaDetailList.do", 
			type : 'POST', 
			data : param,
			success : function(data) {
				
				console.log("data", data);
								
				$("#listCnt4").text(data.length);
				AUIGrid.setGridData(myGridID4, data);

			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	} 
	
	//애음자분포 지역별 리스트
	function getCstAreaMapList(){
		
		//let param = $("#searchFrm3").serialize();
		let areaSeq3 = $("#areaSeq3").val();
		let param = {"areaSeq": areaSeq3};
		console.log("param ::", JSON.stringify(param));
		
		AUIGrid.clearGridData(myGridID2);
		
		$.ajax({
			url : "/cst/selectCstAreaMapList.do", 
			type : 'POST', 
			data : param,
			success : function(data) {
				
				console.log("data", data);				
				$("#listCnt5").text(data.length);
				AUIGrid.setGridData(myGridID5, data);
				
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	}
	
	//애음자분포 지역별 애음자 리스트
	function getCstAreaMapDetailList(areaSeq){
		
		let formData = $("#searchFrm3").serialize();
		
		let param = formData + "&areaSeq=" + areaSeq;
		console.log("param ::", JSON.stringify(param));
		
		$.ajax({
			url : "/cst/selectCstAreaMapDetailList.do", 
			type : 'POST', 
			data : param,
			success : function(data) {
				console.log("data", data);
				
				if(data.length > 0 ){
					setKakaoMap(data);	
				}
			}, // success 
			error : function(xhr, status) {
				alert(xhr + " : " + status);
			}
		}); 	
	} 
	
	function setKakaoMap(data){
		
		let latu = data[0].mapLatu;
		let lotu = data[0].mapLotu;
		
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(latu, lotu),
			level: 3
		};
		var map = new kakao.maps.Map(container, options);	
		
		/**
		.mapBoxWrap .pin{position:absolute; width:38px; height:46px; background:url('../images/pin_bg_01.png') no-repeat center 0; text-align:center;}
		.mapBoxWrap .pin span{width:100%; font-size:14px; text-align:center; padding-top:7px;}
		*/
		
		var content = '<div style="position:absolute; width:38px; height:46px; background:url(\'../images/pin_bg_01.png\') no-repeat center 0; text-align:center;"><span style="width:100%; font-size:14px; text-align:center; padding-top:7px;"></span></div>';

		$.each(data, function(index, item){
			
			// 커스텀 오버레이가 표시될 위치입니다 
			var position = new kakao.maps.LatLng(item.mapLatu, item.mapLotu);  

			// 커스텀 오버레이를 생성합니다
			var customOverlay = new kakao.maps.CustomOverlay({
			    position: position,
			    content: content   
			});

			// 커스텀 오버레이를 지도에 표시합니다
			customOverlay.setMap(map);
		});
		
	}
	
	function gridExcelDown(){		
		
		//AUIGrid.setCellMerge(myGridID2, false);		
		AUIGrid.exportToXlsx(myGridIDExcel, {
			// 스타일 상태 유지 여부(기본값:true)
			exportWithStyle : false
		});
		
		/*
		setTimeout(function(){
			AUIGrid.setCellMerge(myGridID2, true);	
		}, 1000);
		*/
		
	}
	
	
</script>
</head>
<body>

<!-- content -->

	<div class="content">
	<tiles:insertAttribute name="body.breadcrumb" />

		<!-- tabs -->
		<div class="tabsWrap">
        	<ul class="tabs">
            	<li class="active" rel="tab01">지역별 조회</li>
                <li class="" rel="tab02">제품별 조회</li>
				<li class="" rel="tab03">애음자 분포</li>
            </ul>

			<!-- tabContent 기간별 조회 -->
            <div id="tab01" class="tabContent">
                <form name="searchFrm" id="searchFrm">
				<div class="inquiryBox type02 formBtnRepon">
					<div class="dlBoxWrap">
						<div class="dlBox">
						
							<dl>
								<dt>기간</dt>
								<dd>
									<div class="formWrap">
										<div class="dateWrap">
											<input type="text" name="startDate" value="10/24/1984" class="datepicker" id="startDate" readonly="">                                        
											<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="startDate"></button>                                        
										</div> 
	
										<span class="divi02">-</span>
										
										<div class="dateWrap">
											<input type="text" name="endDate" value="10/24/1984" class="datepicker" id="endDate" readonly="">
											<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="endDate"></button>                                        
										</div> 
									</div>
								</dd>
								<dt>계약구분</dt>
								<dd>
									<select name="cntrSec" class="sel">
										<option value="all">전체</option>
										<option value="reg">등록일</option>
										<option value="sbscrb">가입일</option>
										<option value="inpt">투입일</option>
										<option value="cntrEnd">계약종료일</option>
									</select>
								</dd>
								<dt>수금상태</dt>
								<dd>
									<select name="bilctStus" class="sel">
										<option value="all">전체</option>
										<option value="norm">정상</option>
										<option value="badn">불량</option>
									</select>
								</dd>
							</dl>
							<dl>
								<dt>투입상태</dt>
								<dd>
									<div class="formWrap">
										<select name="inptStus" class="sel">
											<option value="all">전체</option>
											<option value="norm">정상</option>											
											<option value="pose">일시중지</option>
											<option value="pdRerv">기간보류</option>											
										</select>										
									</div>
								</dd>
							</dl>
						
						</div>

						<div class="btnRepon">
							<button type="button" name="" class="comBtn" id="inp_name01" onclick="getPeriAreaList();">조회</button>
						</div>
					</div>

					<div class="btnGroup verAlign">
						<button type="button" name="" class="comBtn" onclick="gridExcelDown();">액셀다운</button>
					</div>
				</div>
				</form>	
				<!-- grid -->
				<div class="girdBoxGroup">
					<div class="girdBox w25per">
						<div class="titleArea">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="listCnt">0</span></em> 건 이 조회되었습니다.
							</p>
						</div>

						<div id="grid_wrap"></div>
					</div>

					<div class="girdBox w74per">
						<div class="titleArea">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="listCnt2">0</span></em> 건 이 조회되었습니다.
							</p>
						</div>

						<div id="grid_wrap2"></div>
						
						<div id="grid_wrap_excel" style="display:none;"></div>
						
						
					</div>
				</div>
				<!-- grid -->
			</div>
			<!-- //tabContent 기간별 조회 -->

			<!-- tabContent 제품별 조회 -->
            <div id="tab02" class="tabContent">
				<!-- 조회 -->
				<form name="prdSearchFrm" id="prdSearchFrm">
				<div class="inquiryBox type02">
					<dl>
						<dt>지역</dt>
						<dd>
							<div class="searchWrap">
								<input type="hidden" name="areaSeq" id="areaSeq" class="inp w160">
								<input type="text" name="areaNm" id="areaNm" class="inp w160">
								<button type="button" class="postBtn" title="지역 찾기" onclick="openAreaPop()">											
							</div>
						</dd>
						<dt>기간</dt>
						<dd>
							<div class="formWrap">
								<div class="dateWrap">
									<input type="text" name="prdStartDate" value="10/24/1984" class="datepicker" id="prdStartDate" readonly="">                                        
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="prdStartDate"></button>                                        
								</div> 

								<span class="divi02">-</span>
								
								<div class="dateWrap">
									<input type="text" name="prdEndDate" value="10/24/1984" class="datepicker" id="prdEndDate" readonly="">
									<button type="button" class="datepickerBtn" title="날짜입력" data-target-id="prdEndDate"></button>                                        
								</div> 
							</div>
						</dd>
						<dt>매입처</dt>
						<dd>
							<div class="formWrap">
								<select name="puchSeq" class="sel" id="puchSeq">
									
								</select>

								<button type="button" name="" class="comBtn" id="inp_name01" onclick="getPrdAreaList();">조회</button>
							</div>
						</dd>
					</dl>
				</div>
				</form>
				<!-- 조회 -->

				<!-- grid -->
				<div class="girdBoxGroup">
					<div class="girdBox w33per">
						<div class="titleArea">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="listCnt3">0</span></em> 건 이 조회되었습니다.
							</p>
						</div>

						<div id="grid_wrap3"></div>
					</div>

					<div class="girdBox w65per">
						<div class="titleArea">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="listCnt4">0</span></em> 건 이 조회되었습니다.
							</p>
						</div>

						<div id="grid_wrap4"></div>
					</div>
				</div>
				<!-- grid -->
			</div>
			<!-- //tabContent 제품별 조회 -->

			<!-- tabContent 애음자 분포 -->
            <div id="tab03" class="tabContent">
            	<form name="searchFrm3" id="searchFrm3">            	
            	<div class="inquiryBox type02">
					<dl>
						<dt>지역</dt>
						<dd>
							<div class="searchWrap">
								<input type="hidden" name="areaSeq3" id="areaSeq3" class="inp w160">
								<input type="text" name="areaNm3" id="areaNm3" class="inp w160">
								<button type="button" class="postBtn" title="지역 찾기" onclick="openAreaPop()">											
							</div>
						</dd>						
						<dd>
							<div class="formWrap">								
								<button type="button" name="" class="comBtn" id="inp_name01" onclick="getCstAreaMapList();">조회</button>
							</div>
						</dd>
					</dl>
				</div>
				</form>
				<!-- 조회 -->

				<!-- grid -->
				<div class="girdBoxGroup">
					<div class="girdBox w33per">
						<div class="titleArea">
							<p class="numState">
								<em>총 <span class="pColor01 fb" id="listCnt5">0</span></em> 건 이 조회되었습니다.
							</p>
						</div>

						<div id="grid_wrap5"></div>
					</div>

					<div class="girdBox w65per">
						<!-- map -->
						<div class="mapBox">
							<div class="map" id="map" style="width:100%;height:540px;" >								
							</div>
						</div>
						<!-- map -->
					</div>
				</div>
				<!-- grid -->
			</div>
			<!-- //tabContent 애음자 분포 -->
		</div>
		
	</div>
	
<!-- content -->

</body>
</html>