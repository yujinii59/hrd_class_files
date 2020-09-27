<%@page import="java.util.Hashtable"%>
<%@page import="kr.shop.product.ProductDto"%>
<%@page import="kr.shop.order.OrderBean"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="cartMgr" class="kr.shop.order.CartMgr" scope="session" />
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품주문</title>

<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>

</head>
<body style="margin-top: 20px">
** 장바구니 목록 **<p/>
<%@ include file="guest_top.jsp" %>
<table style="width: 90%; margin-left: auto; margin-right: auto;">
	<tr style="background-color: sliver;">
		<th>주문상품</th><th>상품명</th><th>가격</th><th>주문수량</th><th>소계</th><th>수정/삭제/조회</th>
	</tr>
	<%
	int totalPrice = 0;
	Hashtable hCart = cartMgr.getCartList();	//카트에 있는 전체 자료 읽기
	if(hCart.size() == 0){
	%>
	<tr><td>주문 건수가 없습니다.</td></tr>
	<%
	}else{
		Enumeration enu = hCart.keys();
		while(enu.hasMoreElements()){		//컬랙션에 자료 있으면 true, 없으면 false
			OrderBean order = (OrderBean)hCart.get(enu.nextElement());
			ProductDto product = productMgr.getProduct(order.getProduct_no());
			int price = Integer.parseInt(product.getPrice());
			int quantity = Integer.parseInt(order.getQuantity());
			int subTotal = price * quantity;		//소계
			totalPrice += subTotal;				// 총계
			//System.out.println(product.getName() + " 가격 : " + price + " 주문수량 : " + quantity + " " + subTotal);
			%>
			<tr style = "text-align: center;">
				<td><img src="../upload/<%=product.getImage()%>" width="50"></td>
				<td><%=product.getName() %></td>
				<td><%=price %></td>
				<td><%=quantity %></td>
				<td><%=subTotal %></td>
				<td>
					<a href="javascript:productDetail_guest('<%=product.getNo() %>')">상세보기</a>
					<a href="javascript:productDetail_guest('<%=product.getNo() %>')">수정</a>
					<a href="javascript:productDetail_guest('<%=product.getNo() %>')">삭제</a>
				</td>
			</tr>
	<%
		}
	%>
	<tr>
		<td colspan="4">
			<br>
			총 결제 금액 : <%=totalPrice %> &nbsp;&nbsp;
			<a href="orderproc.jsp">[ 주문하기 ]</a>
		</td>
	</tr>
	<%
	}
	%>
</table>
<%@ include file="guest_bottom.jsp" %>

<form action="productdetail_g.jsp" name="detailFrm">
<input type="hidden" name="no">
</form>
</body>
</html>