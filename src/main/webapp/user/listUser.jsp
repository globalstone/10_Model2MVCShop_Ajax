<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>회원 목록 조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

		$(document).ready(function() {

			var isLoading = false;
			var isEndOfData = false;
			var currentPage = 2;  // 현재 페이지를 2로 설정
			var pageSize = 8;

			function loadMoreUsers() {
				if (!isLoading && !isEndOfData) {
					isLoading = true;

					$.ajax({
						url: "/user/json/listUser",
						method: "GET",
						data: {
							currentPage: currentPage,
							pageSize: pageSize
						},
						dataType: "json",
						success: function(data) {
							var userList = data.userlist;
							if (userList.length === 0) {
								isEndOfData = true;
								return;
							}
							for (var i = 0; i < userList.length; i++) {
								var user = userList[i];
								var row = '<tr class="ct_list_pop">' +
										'<td align="center">' + ((currentPage - 1) * pageSize + i + 1) + '</td>' +
										'<td></td>' +
										'<td align="left" class="get" data-userid="' + user.userId + '">' + user.userId + '</td>' +
										'<td></td>' +
										'<td align="left">' + user.userName + '</td>' +
										'<td></td>' +
										'<td align="left">' + user.email + '</td>' +
										'</tr>' +
										'<tr>' +
										'<td id="' + user.userId + '" colspan="11" bgcolor="D6D7D6" height="1"></td>' +
										'</tr>';
								$('#listTable tbody').append(row);
							}
							$(".ct_list_pop td:nth-child(3)").css("color", "red");
							$("h7").css("color", "red");
							$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
							isLoading = false;
							currentPage++;
						},
						error: function() {
							isLoading = false;
						}
					});
				}
			}

			function loadUserData(userId) {
				$.ajax({
					url: "/user/json/getUser/" + userId,
					method: "GET",
					dataType: "json",
					headers: {
						"Accept": "application/json",
						"Content-Type": "application/json"
					},
					success: function (JSONData, status) {
						var displayValue = "<h3>" +
								"아이디 : " + JSONData.userId + "<br/>" +
								"이  름 : " + JSONData.userName + "<br/>" +
								"이메일 : " + JSONData.email + "<br/>" +
								"ROLE : " + JSONData.role + "<br/>" +
								"등록일 : " + JSONData.regDateString + "<br/>" +
								"</h3>";
						$("h3").remove();
						$("#" + userId + "").html(displayValue); // 해당 userId에 대한 정보만 업데이트
					}
				});
			}

			loadMoreUsers();  // 초기에 한 번 데이터 로드

			$(window).scroll(function() {
				var $window = $(this);
				var scrollTop = $window.scrollTop();
				var windowHeight = $window.height();
				var documentHeight = $(document).height();

				if (scrollTop + windowHeight >= documentHeight - 100) {
					loadMoreUsers();
				}
			});

			$("body").on("click", ".get", function () {
				var userId = $(this).data("userid");
				console.log("Clicked user ID: ", userId);
				loadUserData(userId);
			});

			$("td.ct_btn01:contains('검색')").on("click", function() {
				//Debug..
				//alert( $("td.ct_btn01:contains('검색')").html() );
				fncGetUserList(1);
			});

			$(document).on('click', 'h3', function () {
				$(this).remove();
			});

			$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );

				//////////////////////////// 추가 , 변경된 부분 ///////////////////////////////////
				//self.location ="/user/getUser?userId="+$(this).text().trim();
				////////////////////////////////////////////////////////////////////////////////////////////
				var userId = $(this).text().trim();
				$.ajax(
						{
							url : "/user/json/getUser/"+userId ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {

								//Debug...
								//alert(status);
								//Debug...
								//alert("JSONData : \n"+JSONData);

								var displayValue = "<h3>"
										+"아이디 : "+JSONData.userId+"<br/>"
										+"이  름 : "+JSONData.userName+"<br/>"
										+"이메일 : "+JSONData.email+"<br/>"
										+"ROLE : "+JSONData.role+"<br/>"
										+"등록일 : "+JSONData.regDateString+"<br/>"
										+"</h3>";
								//Debug...
								//alert(displayValue);
								$("h3").remove();
								$( "#"+userId+"" ).html(displayValue);
							}
						});
				////////////////////////////////////////////////////////////////////////////////////////////

			});

		});

	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

	<form name="detailForm">

		<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
			<tr>
				<td width="15" height="37">
					<img src="/images/ct_ttl_img01.gif" width="15" height="37" />
				</td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">회원 목록조회</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37">
					<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
				</td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td align="right">
					<select name="searchCondition" class="ct_input_g" style="width:80px">
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
					</select>
					<input type="text" name="searchKeyword"
						   value="${! empty search.searchKeyword ? search.searchKeyword : ""}"
						   class="ct_input_g" style="width:200px; height:20px" >
				</td>
				<td align="right" width="70">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								검색
							</td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<table id = "listTable" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td colspan="11" >
					전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
				</td>
			</tr>
			<tr>
				<td class="ct_list_b" width="100">No</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">
					회원ID<br>
					<h7 >(id click:상세정보)</h7>
				</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">회원명</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">이메일</td>
			</tr>
			<tr>
				<td colspan="11" bgcolor="808285" height="1"></td>
			</tr>

			<c:set var="i" value="0" />
			<c:forEach var="user" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr class="ct_list_pop">
					<td align="center">${ i }</td>
					<td></td>
					<td align="left">${user.userId}</td>
					<td></td>
					<td align="left">${user.userName}</td>
					<td></td>
					<td align="left">${user.email}
					</td>
				</tr>
				<tr>
					<!-- //////////////////////////// 추가 , 변경된 부분 /////////////////////////////
                    <td colspan="11" bgcolor="D6D7D6" height="1"></td>
                    ////////////////////////////////////////////////////////////////////////////////////////////  -->
					<td id="${user.userId}" colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>

			</c:forEach>
		</table>


		<!-- PageNavigation Start... -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
			<tr>
				<td align="center">
					<input type="hidden" id="currentPage" name="currentPage" value=""/>

<%--					<jsp:include page="../common/pageNavigator.jsp"/>--%>
'
				</td>
			</tr>
		</table>
		<!-- PageNavigation End... -->

	</form>
</div>

</body>

</html>