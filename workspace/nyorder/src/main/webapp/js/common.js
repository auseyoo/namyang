var pageSize = 20;
var gridObj = [];
var gTabGridFunc = [];
	
/**
 * 
 */
$(function() {
	
	$.ajaxSetup({
		//dataType    : "json",
       	//contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		//contentType : "application/json; charset=utf-8"
	});
	
    $(document).ajaxSend(function (e, xhr, options) {	
		//console.log("ajaxSend start ==========");
		$(".loadBox").show();
		
		//var token = $("meta[name='_csrf']").attr("content");
		//var header = $("meta[name='_csrf_header']").attr("content");
		//console.log("header==" + header + ", token == " + token);
    	//xhr.setRequestHeader(header, token);
    });

	$(document).ajaxComplete(function (e, xhr, options) {
		
		$(".loadBox").hide();
		
		//var token = $("meta[name='_csrf']").attr("content");
		//var header = $("meta[name='_csrf_header']").attr("content");
		//console.log("header==" + header + ", token == " + token);
    	//xhr.setRequestHeader(header, token);
    });

	$(document).ajaxError(function(e, xhr, options) {
		$(".loadBox").hide();
  		//console.log("ajaxError start ==========" + xhr.status);		
		if(xhr.status == '399'){			
			location.href="/login.do"
		}
		

	});
    
    
	/* 팝업 닫기 버튼 이벤트 바인드*/
/*	$('.modalCloseBtn').on('click', function(){
		var target = $(this).closest(".modal_wrap").data('popup');
		closePop(target);
	});*/
});



	function gSetGridData(paramObj) {
		
		let gridId = "";		
		
		if(gridObj.length > 0){
			$.each(gridObj, function(index, item){
				
				console.log("gSetGridData  item.gridId==" + item.gridId + ",   ::" + paramObj.gridId);
				if(item.gridId == paramObj.gridId){
					paramObj.data.pageNo = 1;
					paramObj.noRequest = false;
					gridObj[index] = paramObj;	
					gridId = item.gridId; 						
				}			
			});	
			if(gridId == ""){
				paramObj.data.pageNo = 1;
				gridObj[gridObj.length] = paramObj;
				console.log("gSetGridData  .paramObj==" + JSON.stringify(paramObj));
				
			}
		}else{
			paramObj.data.pageNo = 1;
			gridObj[gridObj.length] = paramObj;
			console.log("gSetGridData  11111.paramObj==" + JSON.stringify(paramObj));
			
		}
		gGridAjax(paramObj);
	}
	
	function gVScollChangeHandelr(event) {
		var paramObj;

		//console.log("event.event==" + JSON.stringify(event));
		
		// 스크롤 위치가 마지막과 일치한다면 추가 데이터 요청함
		if(event.position == event.maxPosition) {
			
			$.each(gridObj, function(index, item){
				
				//console.log("gVScollChangeHandelr  .item==" + JSON.stringify(item));	
				
				if(item.gridId == event.pid){
					paramObj = item;				
				}			
			});
			
			//console.log("gVScollChangeHandelr  .paramObj==" + JSON.stringify(paramObj));	
			
			if(paramObj.noRequest == true){
				
				return;
			}
			
			paramObj.noRequest = true;
			paramObj.data.pageNo = paramObj.data.pageNo+1;
			
			gGridAjax(paramObj);
		}
	}
	

	function gGridAjax(paramObj){
		
		console.log("gGridAjax  paramObj==" + JSON.stringify(paramObj));
				
		$.ajax({
	        cache : false,
	        url : paramObj.url, 
	        type : 'POST', 
	        data : paramObj.data, 
	        success : function(data) {
				//console.log("gGridAjax  data==" + JSON.stringify(data));
				
	            if(paramObj.data.pageNo > 1){
	            	AUIGrid.appendData(paramObj.gridId, data);
	
	            	paramObj.noRequest = false;
	            }else{
	            	AUIGrid.setGridData(paramObj.gridId, data);
	            }
	
	            if(data.length < pageSize){
	            	paramObj.noRequest = true;
	            }
	        	
	        }, // success 
	        error : function(xhr, status) {
	        	console.log("xhr==" + JSON.stringify(xhr));
	            alert(xhr + " : " + status);
	        }
	    });		
		
	}



/*
 * 숫자 콤마 (1,000)
 */
function setComma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

/*
 * 숫자 콤마 제거 (1000)
 */
function uncomma(str) {
	str = String(str);
	return str.replace(/[^\d]+/g, '');
}

function numberRenderer(e){
	console.log(e);
}

/*
 * 기본 Null 체크 
 */
function fnIsEmpty(str){
	if(typeof str == "undefined" || str == null || str == "")
    	return true;
	else
		return false ;
}

function fnGetGridListCRUD(gridId){
	var list = new Array();
	// 추가된 행 아이템들(배열)
	$.each(AUIGrid.getAddedRowItems(gridId), function(k,v){
		v.crudMode = "C";
		list.push(v);
	});
	$.each(AUIGrid.getEditedRowItems(gridId), function(k,v){
		v.crudMode = "U";
		list.push(v);
	});
	$.each(AUIGrid.getRemovedItems(gridId), function(k,v){
		v.crudMode = "D";
		list.push(v);
	});
	return list;
}

function fnCommCode(commGrpCd){
	var frm = $('<form></form>');
	
	frm.append("commGrpCd",  "<input type='hidden' name='commGrpCd' value='"+commGrpCd+ "'>");
	
	$.ajax({
        url : "/commselectCommCodeList.do", 
        type : 'POST', 
        data : frm.serialize(),
        success : function(data) {
        	console.log(data)
        }, // success 
        error : function(xhr, status) {
            alert(xhr + " : " + status);
        }
    }); 	
}

//다음 우편번호 팝업
function fnSetPostcode(zipCd, addr1) {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            
            console.log("data  :: " + JSON.stringify(data));

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            //document.getElementById('zipCd').value = data.zonecode;
            //document.getElementById("addr1").value = roadAddr;
            //document.getElementById("addr2").value = data.jibunAddress;

			$(zipCd).val(data.zonecode);
			$(addr1).val(roadAddr);
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                //document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                //document.getElementById("sample4_extraAddress").value = '';
            }

            /**
            //var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.            
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
            */
        }
    }).open();
}

/**
 * 오늘 날짜 (YYYY-MM-DD)
 */
function fnGetToDay(){
	var today = new Date();
	var year = today.getFullYear();
	var month = (today.getMonth()+1) < 10? '0'+(today.getMonth()+1) : (today.getMonth()+1);
	var date = (today.getDate()) < 10? '0'+today.getDate() : today.getDate() ;
	today = year+"-"+month+"-"+date;
	return today;
}
/**
 * 오늘 날짜 (YYYY-MM-DD)
 */
function fnGetToDayKor(){
	var today = new Date();
	var year = today.getFullYear();
	var month = (today.getMonth()+1) < 10? '0'+(today.getMonth()+1) : (today.getMonth()+1);
	var date = (today.getDate()) < 10? '0'+today.getDate() : today.getDate() ;
	today = year+"년 "+month+"월 "+date+"일";
	return today;
}

/**
 * 입력된 Date Type 을 (YYYY-MM-DD)
 */
function fnConvertDate(v){
	if(fnIsEmpty(v)){
		return "";
	}
	var year = v.getFullYear();
	var month = (v.getMonth()+1) < 10? '0'+(v.getMonth()+1) : (v.getMonth()+1);
	var date = (v.getDate()) < 10? '0'+v.getDate() : v.getDate() ;
	var day = year+"-"+month+"-"+date;
	return day;
}

/**
 * 입력된 (YYYYMMDD)를 (YYYY-MM-DD)로
 */
function fnConvertDate2(v){
	if(fnIsEmpty(v)){
		return "";
	}
	var year = v.substring(0,4);
	var month = v.substring(4,6);
	var date = v.substring(6,8);
	var day = year+"-"+month+"-"+date;
	return day;
}

/**
 * 오늘 날짜 (YYYY-MM)
 */
function fnGetToMon(){
	var today = new Date();
	var year = today.getFullYear();
	var month = (today.getMonth()+1) < 10? '0'+(today.getMonth()+1) : (today.getMonth()+1);
	today = year+"-"+month;
	return today;
}

/**
 * 특정 날짜 요일
 */
function  fnGetWeekDay(dateStr){
  var yyyyMMdd = String(dateStr).replaceAll("-","");
  var sYear = yyyyMMdd.substring(0,4);
  var sMonth = yyyyMMdd.substring(4,6);
  var sDate = yyyyMMdd.substring(6,8);

  var date = new Date(Number(sYear), Number(sMonth)-1, Number(sDate));

  var week = ['일', '월', '화', '수', '목', '금', '토'];
  return  week[date.getDay()] + '요일';
}

function layerAlert(popupParam){
	let popupObj = popupParam.data;
	$("#alertTitle").text(popupObj.title);
	$("#alertMessage").text(popupObj.message);
	
	if(popupObj.showBtn1 != 'N'){
		$("#alertBtn1").show();
		if(fnIsEmpty(popupObj.btn1Label)){
			$("#alertBtn1").text("확인");
		}else{			
			$("#alertBtn1").text(popupObj.btn1Label);	
		}
		$("#alertBtn1").off("click");
		if(!fnIsEmpty(popupObj.btn1Func)){
			//$("#alertBtn1").removeClass("modalCloseBtn");
			$("#alertBtn1").on("click", function(){			
				popupObj.btn1Func();
			});
		}else{
			$("#alertBtn1").off("click");
			$("#alertBtn1").addClass("modalCloseBtn");
		}
	}else{
		$("#alertBtn1").hide();
	}
	
	if(popupObj.showBtn2 != 'N'){
		$("#alertBtn2").show();
		if(fnIsEmpty(popupObj.btn2Label)){
			$("#alertBtn2").text("취소");
		}else{			
			$("#alertBtn2").text(popupObj.btn2Label);	
		}
		$("#alertBtn2").off("click");
		if(!fnIsEmpty(popupObj.btn2Func)){
			//$("#alertBtn2").removeClass("modalCloseBtn");
			$("#alertBtn2").on("click", function(){			
				popupObj.btn2Func();
			});
		}else{
			$("#alertBtn2").addClass("modalCloseBtn");
		}
	}else{
		$("#alertBtn2").hide();
	}
	var modalPop = $('[data-popup="modalAlert"]');
    var modalW = $(modalPop).outerWidth();
    var modalH = $(modalPop).outerHeight();
	$('[data-popup="modalAlert"]').css({top: '50%', left: '50%', marginTop: - modalH / 2, marginLeft: - modalW / 2});
	$('[data-popup="modalAlert"]').fadeIn(150);
	$('[data-popup="modalAlert"]').parent().find(".modal_bg").fadeIn(100);
	
	$('.modalCloseBtn').on('click', function(){
		var target = $(this).closest(".alertWrap").data('popup');
		$('[data-popup="'+target+'"]').fadeOut(100);
		$(this).closest(".modal_wrap").parent().find(".modal_bg").fadeOut(100);
	});
}

function layerAlert1(msg, title){
	let data = {};	        
	data.title = title;
	data.message = msg;	   
	data.showBtn2 = 'N';
    let popupObj = {"data" : data}
    layerAlert(popupObj);
}


/* 팝업 오픈 이벤트 */
function openPopup(id){
	
	console.log("openPopup id==" + id);
	
	var modalW = $('[data-popup="'+id+'"]').outerWidth();
	var modalH = $('[data-popup="'+id+'"]').outerHeight();
	var targetBg = $('[data-popup="'+id+'"]').data("targetBg");
	$('[data-popup="'+id+'"]').css({top: '50%', left: '50%', marginTop: - modalH / 2, marginLeft: - modalW / 2});
	$('[data-popup="'+id+'"]').fadeIn(100);
	$('[data-popup="'+id+'"]').parent().find(".modal_bg").fadeIn(100);
	if(typeof resizeGrid == 'function' ){
		resizeGrid();
	}
	$('.modalCloseBtn').on('click', function(){
		closePopup(id);
	});
}

/* 팝업 닫기 이벤트 */
function closePopup(id){
	$("#comPopArea").html("");
	$('[data-popup="'+id+'"]').fadeOut(100);
	$('[data-popup="'+id+'"]').parent().find(".modal_bg").fadeOut(100);
	
}

function getCdtlInfo(targetFunc){
	
    $.ajax({
        cache : false,
        url : "/comm/getCdtlInfo.do", 
        type : 'POST', 
        data : {}, 
		async: false,
        success : function(data) {			
			targetFunc(data);		
        }, // success 
        error : function(xhr, status) {
        	console.log("getCdtlInfo error xhr==" + JSON.stringify(xhr));
            //alert(xhr + " : " + status);
        }
    });	
}

function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

function setTab(){
	
	//tabs
	$(".content .tabContent").hide();
    $(".content .tabContent:first").show();

	$(".content .tabsWrap ul.tabs li").click(function (){
        $(".content .tabsWrap ul.tabs li").removeClass("active");
        $(this).addClass("active");
        $(".content .tabsWrap .tabContent").hide();
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn(100); 

		tabGridResize(activeTab);

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
	
}

function tabGridResize(activeTab){
	
	$.each(gTabGridFunc, function(index, item){
		
		if(item.target == activeTab){
			
			console.log("tabGridResize activeTab ==" + activeTab + ",  typeof item.tarFunc :: " + typeof item.tarFunc + ", item.tarFunc:: " + item.tarFunc);
			if(typeof item.tarFunc == "function" ){		
				item.tarFunc(activeTab);	
			}
		}
	});	
}

function getComPop(bodyUrl, popupId){
	
	$('#comPopArea').children().remove();
    $('#comPopArea').load(bodyUrl, function (data, status, xhr) {
    	openPopup(popupId);
    });		
	
}

jQuery.fn.serializeObject = function() {
    var obj = null;
    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                jQuery.each(arr, function() {
                    obj[this.name] = this.value;
                });
            }//if ( arr ) {
        }
    } catch (e) {
        alert(e.message);
    } finally {
    }
 
    return obj;
};




/**
 * Dialog Ajax
 * Ajax를 통해 페이지를 불러 Dialog를 띄운다.
 * 
 * @param options
 * 	{
 * 		id: "아이디 :필수값 (유니크한 html element 아이디)",
 * 		visibility: "visible", (visible 또는 hidden) 값이 없을 경우 visible로 인식)
 * 		openComplete: function() { ... }, // dialog가 열렸을 때 실행될 함수
 * 		success: function(data) { ... }, // 성공시 실행될 함수
 * 		fail: function(data) { ... }, // 실패시 실행될 함수
 * 		complete: function(data) { ... }, // 완료 후 실행될 함수
 * 		ajax: { // $.ajax options 
 * 			url: "불러올 페이지 url : 필수"
 * 		},
 * 		dialog: { ... } // ui Dialog options
 * 	}
 * 
 * Ex)
 * 	$.ajaxDialog({
 * 		id: "dialogId",
 * 		visibility: "visible", 
 * 		openComplete: function() {
 * 			$("#testValue").focus();
 * 		},
 * 		success: function(data) {
 * 			$("#testValue").val(data.value);
 * 		},
 * 		ajax: {
 * 			url: "<c:url value="/dialog/dialog.do"/>"
 * 		},
 * 		dialog: {
 * 			title: "검색",
 * 			modal: true
 * 		}
 * 	});
 */
(function($){
	/**
	 * AjaxDialog constructor
	 */
	function AjaxDialog(options){
		this.settings = $.extend({
			id: "",
			visibility: "visible",
			openComplete: null,
			success: null,
			fail: null,
			complete: null
		}, options);

		this.openCompleteCallback = $.Callbacks().add(this.settings.openComplete);
		this.successCallback = $.Callbacks().add(this.settings.success);
		this.failCallback = $.Callbacks().add(this.settings.fail);
		this.completeCallback = $.Callbacks().add(this.settings.complete);

		this.init();
		this.ajax();
	};

	AjaxDialog.prototype = {
		/**
		 * initailize : id를 이용해 div element 생성 
		 */
		init: function(){
			this.close();
			$("<div id=\"" + this.settings.id + "\" class=\"ajaxDialog\"></div>").hide().appendTo("#bodyTile");
		},
		/**
		 * visibility 속성 지정
		 */
		visibility: function(visibility) {
			$("#" + this.settings.id).parent().css("visibility", visibility);
			this.settings = $.extend( this.settings, {visibility: visibility});
		},
		/**
		 * 페이지 내용을 생성된 div element에 포함시킨다.
		 */
		ajax: function() {
			var $obj = $("#" + this.settings.id);
			var $this = this;
			
			var ajaxOpt = $.extend({
				url: null,
				type:"get",
				async: false,
				data:{id: this.settings.id},
				success: function(data) {
					$obj.empty();
					$this.open();
					$obj.append($(data));
					$this.openComplete();
				},
				error: function() {	// 에러일경우
					$obj.html("Request Failed");
				}
			}, this.settings.ajax);
			
			var ajaxData;
			
			// ajax data type에 따라 id를 구분하여 파라미터 추가
			if($.type(this.settings.ajax.data) == "object") {
				ajaxData = $.extend({
					id: this.settings.id
				}, this.settings.ajax.data);
			} else if($.type(this.settings.ajax.data) == "string") {
				ajaxData = this.settings.ajax.data + "&id="+this.settings.id;
			} else {
				ajaxData = $.extend({
					id: this.settings.id
				}, this.settings.ajax.data);
			}

			// ajax parameter 추가
			ajaxOpt.data = ajaxData;
			$.ajax(ajaxOpt);
		},
		/**
		 * Dialog open
		 */
		open: function() {
			var $this = this;
			// options extend
			var dialogOpt = $.extend({
				width: 500,
				height: 500,
				title: "",
				resizable: false,
				draggable: false,
				modal: true,
				close: function() {
					$this.close()
				},
			}, this.settings.dialog);
			
			$("body").css({	overflow: 'hidden'	});
			$(".ui-widget-overlay").css({
				background:"rgb(0, 0, 0)",
				opacity: ".50 !important",
				filter: "Alpha(Opacity=50)",
			});

			/**
			 * Dialog를 생성할지 여부
			 */
			$("#" + this.settings.id).dialog(dialogOpt);
			this.visibility($this.settings.visibility);

			/*
			 * Bg 활성화 
			 */
			 $(".ui-widget-overlay").attr('style', 'background-color: #000; opacity: 0.6');

			
		},
		openComplete: function() {
			this.openCompleteCallback.fire();
		},
		/**
		 * 생성된 Dialog Close
		 */
		close: function() {
			
			try {
				$("#" + this.settings.id).dialog("close").dialog("destroy").remove();
			} catch (e) {
				$("#" + this.settings.id).remove();
			}
		},
		/**
		 * 성공시 실행될 함수
		 * @param data
		 */
		success: function(data) {
			this.successCallback.fire(data);
		},
		/**
		 * 실패시 실행될 함수
		 * @param data
		 */
		fail: function(data) {
			this.failCallback.fire(data);
		},
		/**
		 * 종료 후 실행될 함수
		 * @param data
		 */
		complete: function(data) {
			this.completeCallback.fire(data);
		}
	};
	
	/**
	 * $.ajaxDialog Plugin
	 * 시작
	 */
	$.ajaxDialog = function(options) {
		if(!options.id) {
			alert("'id' may not be empty.");
			return false;
		}
		if (!options.ajax.url) {
			alert("'ajax.url' may not be empty.");
			return false;
		}
		
		// Class 실행
		ajaxDialog[options.id] = new AjaxDialog(options);
		return this;
	};

	/**
	 * $.setOption Plugin
	 * visibility 속성 변경
	 */
	$.visibleDialog = function(id, data) {
		ajaxDialog[id].visibility(data);
	};
	
	/**
	 * $.ajaxDialog Plugin
	 * 완료 메서드
	 */
	$.openDialog = function(id, data) {
		ajaxDialog[id].open(data);
	};
	
	/**
	 * $.ajaxDialog Plugin
	 * 완료 메서드
	 */
	$.successDialog = function(id, data) {
		ajaxDialog[id].success(data);
	};
	
	/**
	 * $.ajaxDialog Plugin
	 * 실패 메서드
	 */
	$.failDialog = function(id, data) {
		ajaxDialog[id].fail(data);
	};
	
	/**
	 * $.ajaxDialog Plugin
	 * 종료 메서드
	 */
	$.closeDialog = function(id) {
		$("body").css({ overflow: 'inherit' })
		ajaxDialog[id].close();
	};

})(jQuery);


