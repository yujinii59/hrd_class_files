<%@page import="kr.shop.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />

<%
ProductDto dto = productMgr.getProduct(request.getParameter("no"));

%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자:상품수정</title>

<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">
function readURL(input){
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function (e) {
		$('#img').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}
</script>

</head>
<body style="margin-top: 20px;">
<%@include file="admin_top.jsp" %>

<form action="productproc.jsp?flag=update" enctype="multipart/form-data" method="post">
<table style="width: 90%; margin-left: auto; margin-right: auto;">
	<tr><th colspan="2">* 상품수정 *</th></tr>
	<tr>
		<td>상품명</td>
		<td>
			<input type="text" name="name" value="<%=dto.getName() %>">
		</td>
	</tr>
	<tr>
		<td>가격</td>
		<td>
			<input type="text" name="price" value="<%=dto.getPrice() %>">
		</td>
	</tr>
	<tr>
		<td>설명</td>
		<td>
			<textarea rows="5" cols="60" name="detail"><%=dto.getDetail() %></textarea>
		</td>
	</tr>
	<tr>
		<td>재고량</td>
		<td>
			<input type="text" name="stock" value="<%=dto.getStock() %>">
		</td>
	</tr>
	<tr>
		<td>이미지</td>
	  <td>
        <img src="../upload/<%=dto.getImage()%>" width="50">
        <div id = "image_container" style="width: 30px"></div>
        <input type="file" id="image"  accept="image/*" name="image" size="50" onchange="setThumbnail(event)">
         <script> 
 function setThumbnail(event) { 
    var reader = new FileReader(); 
    reader.onload = function(event) 
    {
       var img = document.createElement("img"); 
       img.setAttribute("src", event.target.result);
       document.querySelector("div#image_container").appendChild(img); 
       }; 
       reader.readAsDataURL(event.target.files[0]);
       } 
 </script>
 </td>

	</tr>
	<tr>
		<td colspan="2" style="text-align: center;">
			<input type="hidden" name="no" value="<%=dto.getNo() %>">
			<input type="submit" value="상품수정">
			<input type="button" value="수정 취소" onclick="history.back()">
		</td>
	</tr>
</table>
</form>

<%@include file="admin_bottom.jsp" %>
</body>
</html>