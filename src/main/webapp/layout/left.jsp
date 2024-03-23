<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>Model2 MVC Shop</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<meta name = "viewport" content="width=device-width, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

	<link href="/css/left.css" rel="stylesheet" type="text/css">

	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script type="text/javascript">

		function history(){
			popWin = window.open("/history.jsp",
					"popWin",
					"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}

		//==> jQuery ���� �߰��� �κ�
		$(function() {

			//==> ����������ȸ Event ����ó���κ�
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( ".Depth03:contains('����������ȸ')" ).on("click" , function() {
				//Debug..
				//alert(  $( ".Depth03:contains('����������ȸ')" ).html() );
				$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId=${user.userId}");
			});


			//==> ȸ��������ȸ Event ����ó���κ�
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( ".Depth03:contains('ȸ��������ȸ')" ).on("click" , function() {
				//Debug..
				//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
				$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
			});
			$(".Depth03:contains('�ǸŻ�ǰ���')").on("click" , function () {
				$(window.parent.frames["rightFrame"].document.location).attr("href","../product/addProductView.jsp");
			});

			$(".Depth03:contains('�ǸŻ�ǰ����')").on("click" , function (){
				$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct/manage");
			});

			$(".Depth03:contains('�� ǰ �� ��')").on("click" , function (){
				$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct/search");
			});

			$(".Depth03:contains('�����̷���ȸ')").on("click", function (){
				$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listPurchase");
			});

			$(".Depth03:contains('�ֱ� �� ��ǰ')").on("click", function (){
				window.open("/history.jsp", "_blank");
			});

			$( function() {
				$( document ).tooltip({
					position: {
						my: "center bottom-20",
						at: "center top",
						using: function( position, feedback ) {
							$( this ).css( position );
							$( "<div>" )
									.addClass( "arrow" )
									.addClass( feedback.vertical )
									.addClass( feedback.horizontal )
									.appendTo( this );
						}
					}
				});
			});
		});

	</script>
	<style>
		.ui-tooltip, .arrow:after {
			background: black;
			border: 2px solid white;
		}
		.ui-tooltip {
			padding: 10px 20px;
			color: red;
			border-radius: 20px;
			font: bold 14px "Helvetica Neue", Sans-Serif;
			text-transform: uppercase;
			box-shadow: 0 0 7px black;
		}
		.arrow {
			width: 70px;
			height: 16px;
			overflow: hidden;
			position: absolute;
			left: 50%;
			margin-left: -35px;
			bottom: -16px;
		}
		.arrow.top {
			top: -16px;
			bottom: auto;
		}
		.arrow.left {
			left: 20%;
		}
		.arrow:after {
			content: "";
			position: absolute;
			left: 20px;
			top: -20px;
			width: 25px;
			height: 25px;
			box-shadow: 6px 5px 9px -9px black;
			-webkit-transform: rotate(45deg);
			-ms-transform: rotate(45deg);
			transform: rotate(45deg);
		}
		.arrow.top:after {
			bottom: -20px;
			top: auto;
		}
	</style>
</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="159" border="0" cellspacing="0" cellpadding="0">

	<!--menu 01 line-->
	<tr>
		<td valign="top">
			<table  border="0" cellspacing="0" cellpadding="0" width="159" >
				<tr>
					<c:if test="${ !empty user }">
				<tr>
					<td class="Depth03">
						<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
							<a href="/user/getUser?userId=${user.userId}" target="rightFrame">����������ȸ</a>
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
						<span title = "�������� ��ȸ">����������ȸ</span>
					</td>
				</tr>
				</c:if>

				<c:if test="${user.role == 'admin'}">
					<tr>
						<td class="Depth03" >
							<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
							<a href="/user/listUser" target="rightFrame">ȸ��������ȸ</a>
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
							<span title = "ȸ��������ȸ">ȸ��������ȸ</span>
						</td>
					</tr>
				</c:if>

				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>

	<!--menu 02 line-->
	<c:if test="${user.role == 'admin'}">
		<tr>
			<td valign="top">
				<table  border="0" cellspacing="0" cellpadding="0" width="159">
					<tr>
						<td class="Depth03">
							<!--	<a href="../product/addProductView.jsp;" target="rightFrame">�ǸŻ�ǰ���</a>-->
							<span title = "�ǸŻ�ǰ���">�ǸŻ�ǰ���</span>
						</td>
					</tr>
					<tr>
						<td class="Depth03">
							<!--<a href="/listProduct.do?menu=manage"  target="rightFrame">�ǸŻ�ǰ����</a>-->
							<span title = "�ǸŻ�ǰ����">�ǸŻ�ǰ����</span>
						</td>
					</tr>
					<tr>
						<td class="DepthEnd">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</c:if>

	<!--menu 03 line-->
	<tr>
		<td valign="top">
			<table  border="0" cellspacing="0" cellpadding="0" width="159">
				<tr>
					<td class="Depth03">
						<!--<a href="/listProduct.do?menu=search" target="rightFrame">�� ǰ �� ��</a>-->
						<span title = "��ǰ�˻�">�� ǰ �� ��</span>
					</td>
				</tr>

				<c:if test="${ !empty user && user.role == 'user'}">
					<tr>
						<td class="Depth03">
							<!--<a href="/listPurchase.do"  target="rightFrame">�����̷���ȸ</a>-->
							<span title = "�����̷���ȸ">�����̷���ȸ</span>
						</td>
					</tr>
				</c:if>

				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
				<tr>
					<td class="Depth03"><!--<a href="javascript:history()">�ֱ� �� ��ǰ</a>-->
						<span title = "�ֱ� �� ��ǰ">�ֱ� �� ��ǰ</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>

</table>

</body>

</html>