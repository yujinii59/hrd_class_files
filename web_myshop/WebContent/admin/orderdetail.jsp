<%@page import="kr.shop.product.ProductDto"%>
<%@page import="kr.shop.order.OrderDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="orderMgr" class="kr.shop.order.OrderMgr" />
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />

<%
OrderDto order = orderMgr.getOrderDetail(request.getParameter("no"));
ProductDto product = productMgr.getProduct(order.getProduct_no());
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리 : 관리자</title>

<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>

</head>
<body style="margin-top: 20px;">
<a href="../index.jsp"><img src="../images/samplelogo1.jpg" width = "170" height = "30" ></a>
<img src="../images/managerlogo.png" width = "30" height = "30" align="top"><p/>
<%@ include file="admin_top.jsp" %>
<form action="orderproc_admin.jsp" name="detailFrm" method="post">
<table style="width: 90%; margin-left: auto; margin-right: auto;">
	<tr>
		<td>고객 아이디 : <%=order.getId() %></td>
		<td>주 문 번 호 : <%=order.getNo() %></td>
		<td>상 품 번 호 : <%=order.getProduct_no() %></td>
		<td>상 품 명 : <%=product.getName() %></td>
	</tr>
	<tr>
		<td>상 품 가 격 : <%=product.getPrice() %></td>
		<td>주 문 수 량 : <%=order.getQuantity() %></td>
		<td>재 고 수 량 : <%=product.getStock() %></td>
		<td>주 문 일 자 : <%=order.getSdate() %></td>
	</tr>
	<tr>
		<td colspan="4">
		고객 결제 금액 : <%=Integer.parseInt(order.getQuantity()) * Integer.parseInt(product.getPrice()) %>
		</td>
	</tr>
	<tr>
		<td colspan = "4" style = "text-align: center;">
		주문 상태 : 
		<select name = "state">
		<option value="1">접수</option>
		<option value="2">입금확인</option>
		<option value="3">배송준비</option>
		<option value="4">배송중</option>
		<option value="5">처리 완료</option>
		</select>
		<script type="text/javascript">
		document.detailFrm.state.value = <%=order.getState() %>
		</script>
		</td>
	</tr>
	<tr>
		<td colspan = "4" style="text-align: center;">
			<input type="button" value = " 수 정 " onclick="orderUpdate(this.form)"> /
			<input type="button" value = " 삭 제 " onclick="orderDelete(this.form)">
			<input type="hidden" name="no" value="<%=order.getNo() %>">
			<input type="hidden" name="flag">
		</td>
	</tr>
</table>
</form>
<%@ include file="admin_bottom.jsp" %>
</body>
</html>