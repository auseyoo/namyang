/**
 * Project		:: 남양유업 대리점주문 시스템
 * Description	:: 공통 유틸
 * Modify		:: 
 *	[2022.03.25] [김경진] :: Birthday
 *	
 */
// ========================================================= CommonAjax =========================================================>
/**
 * START : Ajax 처리 관련 메소드
 */
var CommAjax = new Object();

	/**
	 * ajax 호출 공통 모듈 
	 * @obj	
	 * 		param		: 서버로 보낼 데이터
	 * 		url			: 호출되는 주소
	 * 		type		: get, post 중 전송방식을 선택한다. (default: 'GET')
	 * 		async		: 기본적으로 비동기 요청을 하도록 한다. 동기 요청이 필요하면 값을 false로 설정하면 된다.
	 *      dataType	: dataType (default: Intelligent Guess (xml, json, script, or html))
	 *					  서버에서 받을 데이터 형식을 지적한다.
	 *		              지정하지 않으면 MIME 타입을 참고하여 자동 파싱된다.
	 *      contentType	: contentType (default: 'application/x-www-form-urlencoded; charset=UTF-8')
	 *					  Type: Boolean or String
	 *					  해더의 Content-Type을 설정한다.
	 *					  json 요청시 "application/json; charset=UTF-8"
	 *      isAuiGrid	: Aui grid 로딩바 표시 여부 (Type: Boolean)
	 *      myGridID	: Aui grid ID (Object)
	 *      layerId		: 로딩바 표시할 엘리먼트 영역 ID (Aui grid 로딩바 사용시 미사용)
	 * 		
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 * 
	 */
	CommAjax.ajaxRequest = function(obj) {
		
		if( CommUtil.isEmpty(obj.type) ) {
			obj.type = "POST";
		}
		
		if( CommUtil.isEmpty(obj.param) ) {
			obj.param = [];
		}
		
		if( CommUtil.isEmpty(obj.async) ) {
			obj.async = true;
		}
		
		if( CommUtil.isEmpty(obj.dataType) ) {
			obj.dataType = "json";
		}
		
		if ( CommUtil.isEmpty(obj.contentType) ) {
			obj.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
		}
		
		if( CommUtil.isEmpty(obj.isAuiGrid) ) {
			obj.isAuiGrid = false;
		}
		
		if( CommUtil.isEmpty(obj.layerId) || obj.isAuiGrid == true ) {
			obj.layerId = "";
		}
		
	    $.ajax({
	        url         : obj.uri,
	        type        : obj.type,
	        data        : obj.param,
	        async       : obj.async,
	        dataType    : obj.dataType,		
			contentType : obj.contentType,
	        beforeSend : function(xhr) {     //UTF-8 로 변경하여 전송
	        	//xhr.setRequestHeader("Content-type","application/json; charset=utf-8");
				if (obj.isAuiGrid)
				{
					if (CommUtil.isNotEmpty(obj.myGridID))
					{
						AUIGrid.showAjaxLoader(obj.myGridID);
					}
				}
				else
				{
					if(obj.layerId != "")
					{
						CommAjax.addLodingBar(obj.layerId);
					}
				}
			},
	        error : function(xhr, status, errorThrown) {
				CommAjax.errProc(xhr, status, errorThrown);
	        },
	        complete : function(xhr, status) {
				if (obj.isAuiGrid)
				{
					if (CommUtil.isNotEmpty(obj.myGridID))
					{
						AUIGrid.removeAjaxLoader(obj.myGridID);
					}
				}
				else
				{
					if(obj.layerId != "")
					{
						CommAjax.removeLoadingBar(obj.layerId);
					}
				}
				
				//CommAjax.errProc2(xhr, status);
	        },
	        //success   : obj.callback
	        success : function(data) {
	        	obj.callback(CommAjax.unescape(data));
	        }
	    });
	};
	
	/**
	* ajax 호출 공통 모듈 (멀티파트 업로드)
	* @obj	
	* 		param : 파라미터 정보
	* 		url : 호출되는 주소
	* 		data : 파라미터값
	* 		type : get / post
	* 		async : true, false
	* 		
	* @auther : 김경진
	* 작성일자 : 2022.03.25
	*/
	CommAjax.ajaxUploadRequest = function(obj) {
		
		if( CommUtil.isEmpty(obj.data) ) {
			obj.data = [];
		}
		
		if( CommUtil.isEmpty(obj.async) ) { 
			obj.async = true;
		}		
		
		if( CommUtil.isEmpty(obj.dataType) ) {
			obj.dataType = "json";
		}
		
		if( CommUtil.isEmpty(obj.layerId) ) {
			obj.layerId	= "";
		}
		
	    $.ajax({
	        url         : obj.uri,
	        type        : "POST",
	        data        : obj.param,
	        enctype		: "multipart/form-data",
	        async       : obj.async,
			dataType    : obj.dataType,	
	        processData	: false,
			contentType	: false,
			cache		: false,
	        beforeSend : function(xhr) {     //UTF-8 로 변경하여 전송
	        	//xhr.setRequestHeader("Content-type","application/json");
				if(obj.layerId != "") {
					CommAjax.addLodingBar(obj.layerId);
				}
			},
	        error     : function(xhr, status, errorThrown){
				CommAjax.errProc(xhr, status, errorThrown);
	        },
	        complete  : function(data){
	        	if(obj.layerId != "") {
					CommAjax.removeLoadingBar(obj.layerId);
				}
	        },
	        success   : obj.callback
	    });
	};
	
	/**
	 * 로딩효과 추가 펑션
	 * @param layerId
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 */
	CommAjax.addLodingBar = function(layerId) {
		var str = "";
		var top = 0;
		var left = 0;
		var layerTop = $("#" + layerId).scrollTop();
		var layerWidth = $("#" + layerId).width();
		var layerHeight = $("#" + layerId).height();
		var pad_top = $("#" + layerId).css("padding-top").replace("px", "").replace("auto", "0");
		var pad_bottom = $("#" + layerId).css("padding-bottom").replace("px", "").replace("auto", "0");
		var pad_left = $("#" + layerId).css("padding-left").replace("px", "").replace("auto", "0");
		var pad_right = $("#" + layerId).css("padding-right").replace("px", "").replace("auto", "0");
		var mar_top = $("#" + layerId).css("margin-top").replace("px", "").replace("auto", "0");
		var mar_bottom = $("#" + layerId).css("margin-bottom").replace("px", "").replace("auto", "0");
		var mar_left = $("#" + layerId).css("margin-left").replace("px", "").replace("auto", "0");
		var mar_right = $("#" + layerId).css("margin-right").replace("px", "").replace("auto", "0");
		
		// Margin, Padding값 더하기
		layerWidth += parseInt(pad_left) + parseInt(pad_right) + parseInt(mar_left) + parseInt(mar_right);
		layerHeight += parseInt(pad_top) + parseInt(pad_bottom) + parseInt(mar_top) + parseInt(mar_bottom);
		
		str  = "<div id=\"" + layerId + "_loading\" style=\"width:60px;height:60px;\">";
		str += "	<img src=\"/images/loading_02.png\" />";
		str += "</div>";
		
		// 로딩시 바탕 효과
		$("#" + layerId).append(str);											// 로딩 이미지
		$("#" + layerId).append("<div id=\"" + layerId + "_loadingBg\"></div>");// 로딩 바탕 흐림 효과
		
		// 로딩 이미지 위치값
		top = (layerHeight / 2) - ($("#" + layerId + "_loading").height() / 2) + layerTop;
		left = (layerWidth / 2) - ($("#" + layerId + "_loading").width() / 2);

		// 로딩 CSS 설정
		if($("#" + layerId).css("position") != "absolute") {
			$("#" + layerId).css({"position":"relative"});
		}
		
		$("#" + layerId + "_loading").css({
			"top": "50%",
			"left": "50%",
			"margin-top": "-50px",
			"margin-left": "-50px",
			"position":"fixed",
			"z-index":"9999"
		});
		
		var loadingBgHgt = "100%";
		
		if($("#" + layerId).height() != null && $("#" + layerId).height() != "undefined") {
			loadingBgHgt = $("#" + layerId).height() + "px";
		}
		
		$("#" + layerId + "_loadingBg").css({
			"top": layerTop,
			"left": 0,
			"width": "100%",
			"height": loadingBgHgt,
			"background": "black",
			"opacity": 0.15,
			"position": "absolute",
			"z-index":"9998"
		});
	};
	
	/**
	 * 로딩효과 제거 펑션
	 * @param layerId
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 */
	CommAjax.removeLoadingBar = function(layerId) {
		$("#" + layerId + "_loading").remove();		// 로딩바 숨기기				
		$("#" + layerId + "_loadingBg").remove();	// 로딩 바탕 효과 제거
	};
	
	/**
	 * JSON 체크
	 * @param str	
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 */
	CommAjax.IsJsonString = function(str) {
		try {
			var json = JSON.parse(str);
			return (typeof json === 'object');
		} catch (e) {
			return false;
		}
	};
	
	/**
	 * 에러 처리 페이지 이동
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 */
	CommAjax.errProc = function(jqXHR, status, errorThrown) {
		
		if (jqXHR.status == 403) {
			alert("세션이 만료 되었습니다.");
			$(location).attr('href',"/");
		} else if (jqXHR.status == 404) {
			alert("요청페이지를 찾을 수 없습니다.");
		} else {
			if ( CommAjax.IsJsonString(jqXHR.responseText) ) {
				var message = JSON.parse(jqXHR.responseText).message;
				alert(message);
			} else {
				alert("처리중 오류가 발생 하였습니다.");
			}
		}
	};
	
	/**
	 * 에러 처리 페이지 이동
	 * 		Response Status code 200 성공이지만 에러일때 메세지 처리
	 * 
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 */
	CommAjax.errProc2 = function(jqXHR, status) {
		
		if (jqXHR.status == 200)
		{
			if ( CommAjax.IsJsonString(jqXHR.responseText) )
			{
				var jsonStr = JSON.parse(jqXHR.responseText);
				if ( jsonStr.errorStat == true )
				{
					var message = jsonStr.message;
					alert(message);
				}
			}
		}
	};
	
	/**
	 * ajax 통신 후 json 결과값 escape 역치환
	 * 
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 */
	CommAjax.unescape = function(data) {
		if ( CommUtil.isNotEmpty(data) )
		{
			//data = JSON.stringify(data).unescapeHtml();
			//return JSON.parse(data);
			
			return CommAjax.objCon(data);
		}
		else
		{
			return data;
		}
	};
	
	/**
	 * ajax 통신 후 foreach 로 json 결과값 escape 역치환
	 * 
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 */
	CommAjax.objCon = function(obj) {
		
		if ( typeof obj === "object" )
		{
			for(key in obj)
			{
				//console.log('key:' + key + ' / ' + 'value:' + obj[key]);
				//console.log(typeof obj[key]);
				if ( typeof obj[key] === "string" )
				{
					obj[key] = obj[key].unescapeHtml();
				}
				else if ( typeof obj[key] === "object" )
				{
					CommAjax.objCon(obj[key]);	// 다시 object 이면 재귀호출
				}
			}
		}
		else if ( typeof obj === "string" )
		{
			obj = obj.unescapeHtml();
		}
		
		return obj;
	};
	
	
// ========================================================= CommAjax =========================================================/

// ========================================================= CommPagination =========================================================>
/**
 * START : Paging 관련 메소드
 */
var CommPagination = new Object();
	
	/**
	* paging 호출 공통 모듈
	* @totalCnt	: 전체 수
	* @dataSize	: 페이지당 보여줄 데이타수
	* @pageSize	: 페이지 그룹 범위 1 2 3 5 6 7 8 9 10
	* @pageNo	: 현재페이지
	* @token	: 요청 함수명
	* 
	* @auther : 김경진
	* 작성일자 : 2022.03.25
	*/
	CommPagination.getPagination = function(totalCnt, dataSize, pageSize, pageNo, token) {
		
		totalCnt = parseInt(totalCnt); 
		dataSize = parseInt(dataSize);
		pageSize = parseInt(pageSize);
		pageNo = parseInt(pageNo);
		
		var html = new Array();
		
		if(totalCnt == 0)
		{
			return "";
		}
		
		// 페이지 카운트
		var pageCnt = totalCnt % dataSize;
		
		if(pageCnt == 0)
		{
			pageCnt = parseInt(totalCnt / dataSize);
		}
		else
		{
			pageCnt = parseInt(totalCnt / dataSize) + 1;
		}
		
		var pRCnt = parseInt(pageNo / pageSize);
		
		if(pageNo % pageSize == 0)
		{
			pRCnt = parseInt(pageNo / pageSize) - 1;
		}
		
		//html.push("<ul>");
		//이전 화살표
		if(pageNo > pageSize)
		{
			var s2;
			if(pageNo % pageSize == 0)
			{
				s2 = pageNo - pageSize;
			}
			else
			{
				s2 = pageNo - pageNo % pageSize;
			}
			
			html.push("<li class=\"prv-bt\"><a href=\"#\" onclick=\"javascript:" + token + "('" + s2 + "'); return false;\">이전페이지</a></li>");
		}
		else
		{
			html.push("<li class=\"prv-bt\"><a href=\"javascript:alert('첫번째 페이지 입니다.');\">이전페이지</a></li>");
		}
		
		//paging Bar
		for(var index=pRCnt * pageSize + 1;index<(pRCnt + 1)*pageSize + 1;index++)
		{
			if(index == pageNo)
			{
				html.push("<li><a href=\"#\" class=\"active\">" + index + "</a></li>");
			}
			else
			{
				html.push("<li><a href=\"#\" onclick=\"javascript:" + token + "('" + index + "'); return false;\">" + index + "</a></li>");
			}
			
			if(index == pageCnt)
			{
				break;
			}
		}
		
		//다음 화살표 
		if(pageCnt > (pRCnt + 1) * pageSize)
		{
			var nextVal = (pRCnt + 1) * pageSize + 1;
			html.push("<li class=\"nxt-bt\"><a href=\"#\" onclick=\"javascript:" + token + "('" + nextVal + "'); return false;\">다음페이지</a></li>");
		}
		else
		{
			html.push("<li class=\"nxt-bt\"><a href=\"javascript:alert('마지막 페이지 입니다.');\">다음페이지</a></li>");
		}
		//html.push("</ul>");
		
		return html.join("");
	};
	
// ========================================================= CommPagination =========================================================/

	
// ========================================================= CommContext =========================================================>
/**
 * START : Context 관련 메소드
 */
var CommContext = new Object();

	/**
	* context 경로 알아오는 함수
	* 
	* @auther : 김경진
	* 작성일자 : 2022.03.25
	*/
	CommContext.getContextPath = function() {
		
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
	
// ========================================================= CommContext =========================================================/
	
// ========================================================= CommFile =========================================================>
/**
 * START : 파일 관련
 */
var CommFile = new Object();

	/**
	* 파일 다운로드
	* 
	* @auther : 김경진
	* 작성일자 : 2022.03.25
	*/
	CommFile.fileDown = function(tchprductIngrSn, filSn, gubun, subPath, realFilNm) {
		
		var frm;
		if($("[name=downFrm]").length < 1)
			$(document.body).append("<form name='downFrm'></form>");
		frm = document.downFrm;
		
		frm.encoding = "application/x-www-form-urlencoded";
		if($(frm).find("[name=subPath]").length < 1)
			$(frm).append("<input type='hidden' name='subPath' />");
		if($(frm).find("[name=tchprductIngrSn]").length < 1)
			$(frm).append("<input type='hidden' name='tchprductIngrSn' />");
		if($(frm).find("[name=filSn]").length < 1)
			$(frm).append("<input type='hidden' name='filSn' />");
		if($(frm).find("[name=gubun]").length < 1)
			$(frm).append("<input type='hidden' name='gubun' />");
		if($(frm).find("[name=realFilNm]").length < 1)
			$(frm).append("<input type='hidden' name='realFilNm' />");
		
		if(typeof(tchprductIngrSn) == "undefined" || tchprductIngrSn == "")
		{
			tchprductIngrSn = 0;
		}
		
		if(typeof(filSn) == "undefined" || filSn == "")
		{
			filSn = "0";
		}
		
		if(typeof(gubun) == "undefined" || gubun == "")
		{
			gubun = "";
		}
		
		if(typeof(subPath) == "undefined" || subPath == "")
		{
			frm.subPath.value = "tchpr";
		}
		else
		{
			frm.subPath.value = subPath;
		}
		
		if(typeof(realFilNm) != "undefined" && realFilNm != "")
		{
			frm.realFilNm.value = realFilNm;
		}
		
		frm.tchprductIngrSn.value = tchprductIngrSn;
		frm.filSn.value = filSn;
		frm.gubun.value = gubun;
		frm.action = "/cmmn/downloadFile.do";
		frm.submit();
	};
	
// ========================================================= CommFile. =========================================================/	

// ========================================================= CommCookie =========================================================>
	/**
	 * Cookie제어 Util
	 */
	var CommCookie = {
		
	    get: function (name){
	        var cookieName = encodeURIComponent(name) + "=",
	            cookieStart = document.cookie.indexOf(cookieName),
	            cookieValue = null,
	            cookieEnd;
	            
	        if (cookieStart > -1){
	            cookieEnd = document.cookie.indexOf(";", cookieStart);
	            if (cookieEnd == -1){
	                cookieEnd = document.cookie.length;
	            }
	            cookieValue = decodeURIComponent(document.cookie.substring(cookieStart + cookieName.length, cookieEnd));
	        } 
	        return cookieValue;
	    },
	    set: function (name, value, path, domain, secure, expires) {
	        var cookieText = encodeURIComponent(name) + "=" + encodeURIComponent(value);
	    
	        if (expires instanceof Date) {
	            cookieText += "; expires=" + expires.toGMTString();
	        }
	        if (path) {
	            cookieText += "; path=" + path;
	        }
	        if (domain) {
	            cookieText += "; domain=" + domain;
	        }
	        if (secure) {
	            cookieText += "; secure";
	        }
	        document.cookie = cookieText;
	    },
	    unset: function (name, path, domain, secure){
	        this.set(name, "", new Date(0), path, domain, secure);
	    }
	};
	
// ========================================================= CommDynamicForm =========================================================>
var CommDynamicForm	= {
	submit:	function(url, params){
		
		var nForm	= $("<form></form>");
		nForm.attr("method", "post");
		nForm.attr("action", url); 
		
		$.each(params, function(key, val) { 
			nForm.append($('<input/>', {type: "hidden", name: key, value: val}));	
		});
		
		nForm.appendTo("body");
		nForm.submit();
	}
};

var CommDynamicPopupForm	= {
		submit:	function(url, params){
			
			var nForm	= $("<form></form>");
			nForm.attr("method", "post");
			nForm.attr("action", url); 
			nForm.attr("target", "popup");
			
			$.each(params, function(key, val) { 
				nForm.append($('<input/>', {type: "hidden", name: key, value: val}));	
			});
			
			nForm.appendTo("body");
			nForm.submit();
		}
	};
	
	
// ========================================== CommUtil ==========================================>
var CommUtil = new Object();

	/**
	 * <pre>
	 * @Desc        :  숫자 0 및 배열, 객체의 빈값도 전부 null 체크
	 * </pre>
	 * 
	 * @author      : kjkim
	 * @Method Name : CommUtil.isEmpty
	 * @return
	 */
	CommUtil.isEmpty = function(obj) {
		if( obj === "" || obj === null || obj == undefined || obj == "null"
				|| (obj !== null && typeof obj === "object" && !Object.keys(obj).length) 
				)
		{
			return true;
		}
		else
		{
			return false ;
		}
	};
	
	/**
	 * <pre>
	 * @Desc        :  Not null 체크
	 * </pre>
	 * 
	 * @author      : kjkim
	 * @Method Name : CommUtil.isNotEmpty
	 * @return
	 */
	CommUtil.isNotEmpty = function(obj) {
		return !CommUtil.isEmpty(obj);
	};
	
	/**
	 * JSON 체크
	 * @param str	
	 * @auther : 김경진
	 * 작성일자 : 2022.03.25
	 */
	CommUtil.IsJsonString = function(str) {
		try {
			var json = JSON.parse(str);
			return (typeof json === 'object');
		} catch (e) {
			return false;
		}
	};
	
	/**
	 * 함수 설명 : 숫자만 입력
	 * 작성자 : 김경진
	 * 작성일자 : 2022.03.25
	 * @param obj = input obj
	 */
	CommUtil.cmmVldNumChk = function(obj) {
		obj.value = obj.value.replace(/[^0-9]/g,'');
	};
	
	/**
	 * 작성자 : 김경진
	 * 설명 : Input textbox 입력한 글자수가 maxLength 와 같으면 다음 Input textbox 로 포커스 이동 
	 * @param obj
	 * @param next_id
	 * @return
	 */
	CommUtil.cmmVldFocusMove = function(obj, next_id) {
		if(obj.value.length>=obj.maxLength)
			document.getElementById(next_id).focus();
	};
// ========================================== CommUtil ==========================================//

// ========================================== Comm date ==========================================>
var CommDate	= new Object();

	/** 
	 * 특정 날짜에 대해 지정한 값만큼 가감(+-)한 날짜를 반환
	 * 
	 * 입력 파라미터 -----
	 * pInterval : "y" 는 연도 가감, "m" 은 월 가감, "d" 는 일 가감
	 * pAddVal  : 가감 하고자 하는 값 (정수형)
	 * pYyyymmdd : 가감의 기준이 되는 날짜
	 * pDelimiter : pYyyymmdd 값에 사용된 구분자를 설정 (없으면 "" 입력)
	 * 
	 * 반환값 ----
	 * yyyymmdd 또는 함수 입력시 지정된 구분자를 가지는 yyyy?mm?dd 값
	 *
	 * 사용예 ---
	 * 2008-01-01 에 3 일 더하기 ==> addDate("d", 3, "2008-08-01", "-");
	 * 20080301 에 8 개월 더하기 ==> addDate("m", 8, "20080301", "");
	 */
	CommDate.addDate = function(pInterval, pAddVal, pYyyymmdd, pDelimiter) {
		var yyyy;
		var mm;
		var dd;
		var cDate;
		var oDate;
		var cYear, cMonth, cDay;
		
		if (pDelimiter != "") {
			pYyyymmdd = pYyyymmdd.replace(eval("/\\" + pDelimiter + "/g"), "");
		}
		
		yyyy = pYyyymmdd.substr(0, 4);
		mm  = pYyyymmdd.substr(4, 2);
		dd  = pYyyymmdd.substr(6, 2);
		
		if (pInterval == "y") {
			yyyy = (yyyy * 1) + (pAddVal * 1); 
		} else if (pInterval == "m") {
			mm  = (mm * 1) + (pAddVal * 1);
		} else if (pInterval == "d") {
			dd  = (dd * 1) + (pAddVal * 1);
		}
		
		cDate = new Date(yyyy, mm - 1, dd) // 12월, 31일을 초과하는 입력값에 대해 자동으로 계산된 날짜가 만들어짐.
		cYear = cDate.getFullYear();
		cMonth = cDate.getMonth() + 1;
		cDay = cDate.getDate();
		
		cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
		cDay = cDay < 10 ? "0" + cDay : cDay;
		
		if (pDelimiter != "") {
			return cYear + pDelimiter + cMonth + pDelimiter + cDay;
		} else {
			return cYear + cMonth + cDay;
		}
	};
	
	/**
	 * @description : 차이의 개월 수 계산
	 * @param dateFrom		Date
	 * @param dateTo		Date
	 * @returns	차이수
	 */
	CommDate.monthDiff = function(dateFrom, dateTo) {
		return dateTo.getMonth() - dateFrom.getMonth() +
		(12 * (dateTo.getFullYear() - dateFrom.getFullYear()))
	};
	
	
// ========================================== Common date ==========================================//
	
	