<%@page import="kr.shop.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />

<%
String no = request.getParameter("no");
ProductDto dto = productMgr.getProduct(no);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세보기</title>

<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>

</head>
<body style="margin-top: 20px">
** 상품 상세보기 **<br>
<%@ include file="guest_top.jsp" %>
<form action="cartproc.jsp">
<table style="width: 90%; margin-left: auto; margin-right: auto;">
	<tr>
		<td style="width: 20%">
			<img src="../upload/<%=dto.getImage() %>" width="150">
		</td>
		<td style="width: 50%; vertical-align: top;">
			<table style="width: 100%">
				<tr><td>상품명 : </td><td><%=dto.getName() %></td></tr>
				<tr><td>가 격 : </td><td><%=dto.getPrice() %></td></tr>
				<tr><td>등록일 : </td><td><%=dto.getSdate() %></td></tr>
				<tr><td>재고량 : </td><td><%=dto.getStock() %></td></tr>
				<tr>
					<td>
						<br><br><br><br>
						주문수 : 
						<input type="number" name="quantity" value = "1"  min = "0" max = "<%=dto.getStock() %>" size = "3" style="text-align: center;">
					</td>
				</tr>
			</table>
		</td>
		<td style="width: 30%; vertical-align: top;">
			<b>* 상품설명 *</b><br>
			<%=dto.getDetail() %>
		</td>
	</tr>
	<tr>
		<td colspan="3" style="text-align: center;">
			<br>
			<input type="hidden" name="product_no" value = "<%=dto.getNo() %>">
			<input type="submit" value="장바구니에 담기">
			<input type="button" value="바로 구매하기">
			<input type="button" value="이전화면으로" onclick="history.back()">
		</td>
	</tr>
</table>
</form>
<%@ include file="guest_bottom.jsp" %>
</body>
</html>