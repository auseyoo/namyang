<!--
	@File Name: recpPrtPop.jsp
	@File 설명 : 방문영수증 출력 팝업
	@UI ID : PR-F-018.html
	@작성일 : 2022.03.28
	@작성자 : 이웅일
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>남양유업 대리점 주문시스템 - 거래명세표</title>
<link rel="stylesheet" type="text/css" href="/css/AUIGrid/grid_custom.css"/>
<link rel="stylesheet" type="text/css" href="/css/layout.css"/>
</head>
<style>
   body,html{margin:0; padding:0; font-size:12pt; overflow-y:auto;}
	* {color-adjust: exact!important; -webkit-print-color-adjust: exact!important; print-color-adjust: exact!important; box-sizing:border-box; -moz-box-sizing: border-box;}
     .page {width:29.7cm; min-height:1cm; padding:0.5cm; margin:1cm auto; background:#fff; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}
	/*.subpage {padding:1cm; height:256mm;}*/
	@page {
		/*size: A4 landscape;*/    /*Portrait*/
		size: A4 Portrait; /* 가로 */
		margin:5px 0 5px;
	}
	@media print {
		html, body {margin:0; padding:0; overflow-y:inherit;}
		.page {margin:0; border:initial; border-radius:initial; width:initial; min-height:initial; box-shadow:initial; background:initial; size: A4 landscape;}
		.tbl tbody th {background:#f5f5f5 !important;}
		.aui-grid .aui-grid-table td{font-size:9pt;}
	}
    .details_wrap { display: flex;}
    .details_wrap .content {width:33.333%; margin-left: 5pt; padding-right:5pt; border-right: 1px dashed #000;}
    .details_wrap .content:last-child {border-right:0;}
    .details_wrap .tbl {}
    .details_wrap .tbl th {height:auto; padding:2px 5px; font-size:6.5pt; line-height:11pt;border:1px solid #bdbdbd;border-width: 1px 1px 1px 0;word-break:break-all; white-space:initial; text-align:left; background:#fff !important;}
    .details_wrap .tbl .center {text-align:center;}
    .details_wrap .tbl .right {text-align:right;}
    .details_wrap .tbl td {height: 14.8pt; padding:2px 5px;border:1px solid #bdbdbd;border-width: 1px 1px 1px 0;font-size:6.5pt;}
    .details_wrap .tbl .jBetween {display: flex; width: 100%; padding-right:10pt; justify-content: space-between;}
    .details_wrap .tbl td.right {padding-right:7px;}
    .details_wrap .tbl td.center {padding:2px 5px;}
    .details_wrap .tbl tbody td.vTop {line-height:1.2;}
    .details_wrap .tbl tr {border: 1px solid #bdbdbd; border-width: 0 1px;}
    .details_wrap .tbl tr.bg {background:#efefef !important;}
    .details_wrap .tbl tr.bg th {background:#efefef !important;}
    .details_wrap .tbl tr.bg td {background:#efefef !important;}
    .details_wrap .tbl tr.bg th span {letter-spacing: 5px;}
    .details_wrap .tbl .row th {width: 100%;}
    .details_wrap .tbl .row td {width: 100%;}
    /* .details_wrap .tbl .row.jBetween th {display:flex; justify-content: space-between;} */
    .details_wrap .arTxt {text-align: right;}
    .details_wrap td.arTxt {padding-right:4px;}
    .details_wrap .alTxt {text-align: left;}
    .details_wrap td.alTxt {padding-left:4px;}
    .details_wrap .acTxt {text-align: center;}

    .details_wrap .tbl .largeTxt {font-size: 12pt;}
    .data_form {line-height:normal;}
    .data_form .data01 {display:inline-block; width: 33.333%;}
    .data_form .data02 {display:inline-block;}
    .data_form .data03 {}
    .details_wrap .titleArea {display: flex;margin-bottom:4pt; justify-content: center; align-items:baseline;}
    .details_wrap .titleArea h3 {display:inline-block; font-size: 12pt;  text-align: center; letter-spacing: 10px; font-weight: normal;}
    .details_wrap .titleArea h3.stit {letter-spacing: 0;}
    .details_wrap .titleArea span {font-size: 9pt;}
    .details_wrap .titleArea_box span{border-right: 1px solid blue;color:blue;padding: 2px 10px; letter-spacing: 1px; text-align: center;}
    .details_wrap .titleArea_item {font-size:9pt;}
    .details_wrap .titleArea_box p {display: inline-flex; font-size: 6.5pt;padding:0 10px;}
    .details_wrap .vTop { vertical-align: top;}

    .details_wrap .top {display: flex; padding:2px 5px; justify-content: space-between; align-items: center; border: 1px solid gray; border-bottom:0;}
    .details_wrap .top span {font-size:6.5pt;}
    .details_wrap .top em {font-weight: 900;}
    .details_wrap .tbl tbody td p {padding-left:0;}

</style>
<script>
window.print();
</script>
<body>
    <div class="printWrap">
		<div class="page" >
            <div class="details_wrap">
                <div class="content">
                    <div class="titleArea">
                        <h3>확인증</h3>
                        <span class="">(판매사원용 보관용)</span>
                    </div>
                    <div class="top">
                        <span>논현 1동</span>
                        <span><em>김비티</em> 귀하</span>
                    </div>
                    <table class="tbl">
                        <caption>거래명세표</caption>
                        <colgroup>
                            <col style="width:18%;">
                            <col>
                            <col style="width:18%;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr class="row bg">
                                <th colspan="4" class="center">
                                    <p>공급 받는 자</p>
                                </th>
                            </tr>
                            <tr>
                                <th>애음자명</th>
                                <td>김비티</td>
                                <th scope="row" class="center">코드</th>
                                <td>1234567</td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    전화
                                </th>
                                <td colspan="3">010-****-0000</td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    주소
                                </th>
                                <td colspan="3">학동로 100-10, 1층</td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    월분
                                </th>
                                <td class="center">2021-12</td>
                                <th scope="row" class="center">
                                    청구금액
                                </th>
                                <td class="right">50,000 원</td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    전월미수
                                </th>
                                <td class="right">0 원</td>
                                <th scope="row" class="center">
                                    당월애음
                                </th>
                                <td class="right">50,000 원</td>
                            </tr>
                            <tr>
                                <td colspan="4" class="h120 vTop">
                                    <p>
                                        제품명(투입개수, 가격, 투입요일)<br/>
                                        GT대(14,900, 화목토) 깜유홈(20. 1.530, 금)
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <th>결제수단</th>
                                <td>지로</td>
                                <th>수금일</th>
                                <td></td>
                            </tr>
                            <tr>
                                <th>메모</th>
                                <td colspan="3"></td>
                            </tr>
                            <tr>
                                <th>작성일</th>
                                <td colspan="3">2021-12-21</td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    상호명
                                </th>
                                <td>비타소프트</td>
                                <th scope="row">
                                    전화번호
                                </th>
                                <td>010-1111-1111</td>
                            </tr>
                    </table>
                </div>
                <div class="content">
                    <div class="titleArea">
                        <h3>영수증</h3>
                        <span class="">(애음자 보관용)</span>
                    </div>
                    <div class="top">
                        <span>학동로 100-10, 1층</span>
                        <span><em>김비티</em> 귀하</span>
                    </div>
                    <table class="tbl">
                        <caption>영수증</caption>
                        <colgroup>
                            <col style="width:18%;">
                            <col>
                            <col style="width:18%;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr class="row bg">
                                <th colspan="4" class="center">
                                    <p>공급자</p>
                                </th>
                            </tr>
                            <tr>
                                <th colspan="2">사업자등록번호</th>
                                <td colspan="2">000-00-0000</td>
                            </tr>
                            <tr>
                                <th colspan="2">상호명/대표자명</th>
                                <td colspan="2">비티소프트/대표자</td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <th colspan="3"></th>
                            </tr>
                            <tr>
                                <th scope="row">
                                    월분
                                </th>
                                <td class="center">2021-12</td>
                                <th scope="row">
                                    청구금액
                                </th>
                                <td class="right">50,000원</td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    전월미수
                                </th>
                                <td class="right">0원</td>
                                <th scope="row">
                                    당월애음
                                </th>
                                <td class="right">50,000원</td>
                            </tr>
                            <tr>
                                <td colspan="4" class="h120 vTop">
                                    <p>
                                        제품명(투입개수, 가격, 투입요일)<br/>
                                        GT대(14,900, 화목토) 깜유홈(20. 1.530, 금)
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <p class="jBetween">
                                        <span>위 금액을 영수(청구)함.</span>
                                        <span>취급자<em class="w20per mr10 ml10"></em>인</span>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <th>영수일</th>
                                <td colspan="3">2021-12-21</td>
                            </tr>
                            <tr>
                                <th>담당자</th>
                                <td>이티티</td>
                                <th>전화번호</th>
                                <td>010-0000-0000</td>
                            </tr>
                            <tr>
                                <th>상호명</th>
                                <td>비티소프트</td>
                                <th>전화번호</th>
                                <td>010-0000-0000</td>
                            </tr>
                    </table>
                </div>
                <div class="content">
                    <div class="titleArea">
                        <h3 class="stit">2021-12 배달 내역</h3>
                    </div>
                    <table class="tbl">
                        <caption>배달 내역</caption>
                        <colgroup>
                            <col style="width:14.285%;">
                            <col>
                            <col style="width:14.285%;">
                            <col>
                            <col style="width:14.285%;">
                            <col>
                            <col style="width:14.285%;">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>성명</th>
                                <td colspan="2">김비티</td>
                                <th scope="row" colspan="2" class="center">청구금액</th>
                                <td class="right" colspan="2">50,000원</td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    주소
                                </th>
                                <td colspan="6">학동로 100-10, 1층</td>
                            </tr>
                            <tr>
                                <th scope="row" class="center">
                                    일
                                </th>
                                <th scope="row" class="center">
                                    월
                                </th>
                                <th scope="row" class="center">
                                    화
                                </th>
                                <th scope="row" class="center">
                                    수
                                </th>
                                <th scope="row" class="center">
                                    목
                                </th>
                                <th scope="row" class="center">
                                    금
                                </th>
                                <th scope="row" class="center">
                                    토
                                </th>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="right">5</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>6</td>
                                <td>7</td>
                                <td>8</td>
                                <td>9</td>
                                <td>10</td>
                                <td>11</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td class="right">2</td>
                                <td></td>
                                <td class="right">1</td>
                                <td class="right">5</td>
                                <td class="right">1</td>
                            </tr>
                            <tr>
                                <td>12</td>
                                <td>13</td>
                                <td>14</td>
                                <td>15</td>
                                <td>16</td>
                                <td>17</td>
                                <td>18</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td class="right">2</td>
                                <td></td>
                                <td class="right">1</td>
                                <td class="right">5</td>
                                <td class="right">1</td>
                            </tr>
                            <tr>
                                <td>19</td>
                                <td>20</td>
                                <td>21</td>
                                <td>22</td>
                                <td>23</td>
                                <td>24</td>
                                <td>25</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td class="right">2</td>
                                <td></td>
                                <td class="right">1</td>
                                <td class="right">5</td>
                                <td class="right">1</td>
                            </tr>
                            <tr>
                                <td>26</td>
                                <td>27</td>
                                <td>28</td>
                                <td>29</td>
                                <td>30</td>
                                <td>31</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td class="right">1</td>
                                <td></td>
                                <td class="right">1</td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td colspan="7" class="h50 vTop">
                                    <p>
                                        현금영수증: 010-0000-0000<br/>
                                        가상계좌: 농협: 000-0000-0000-00 대표자<br/>
                                        메모내용
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <th rowspan="2" colspan="2">계좌정보</th>
                                <td colspan="5">은행명: 계좌번호 예금주</td>
                            </tr>
                            <tr>
                                <td colspan="5">농협: 000-0000-0000-00 대표자</td>
                            </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

</body>
</html>