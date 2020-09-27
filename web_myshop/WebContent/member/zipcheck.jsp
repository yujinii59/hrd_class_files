<%@page import="kr.shop.member.ZipcodeDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberMgr" class="kr.shop.member.MemberMgr" scope="page" />

<%
request.setCharacterEncoding("utf-8");
String check = request.getParameter("check");
String p_narea3 = request.getParameter("zip_narea3");  //검색 길이름
String p_oarea1 = request.getParameter("zip_oarea1");	//검색 동이름

ArrayList<ZipcodeDto> list = memberMgr.zipcodeRead(p_oarea1, p_narea3);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function() {
	document.getElementById("btnZipFind").onclick = dongCheck;
	
	document.getElementById("btnZipClose").onclick = function(){
		window.close();
	};
}

function dongCheck(){
	//alert("c");
	if(zipForm.zip_oarea1.value === "" && zipForm.zip_narea3.value === ""){
		alert("검색할 주소를 입력하시오");
		zipForm.area3.focus();
		return;
	}
	
	zipForm.submit();
}

function send(zip_code, zip_narea1, zip_narea2, zip_narea3, zip_narea4, zip_narea5, zip_oarea1, zip_oarea2){
	//alert(zipcode + " " + area1);
	opener.document.regForm.zipcode.value = zip_code;
	var newaddr = zip_narea1 + " " + zip_narea2 + " " + zip_narea3 + " " + zip_narea4 + " " + zip_narea5;
	opener.document.regForm.newaddress.value = newaddr;
	
	var addr = zip_narea1 + " " + zip_narea2 + " " + zip_oarea1 + " " + zip_oarea2;
	opener.document.regForm.address.value = addr;
	window.close();
}
</script>
</head>
<body>
<b>** 우편번호 찾기 **</b><br>
<form action="zipcheck.jsp" name="zipForm" method="post">
<table>
  <tr>
  	<td>
  	도로명 입력 : <input type="text" name="zip_narea3">
  	<input type="hidden" value="n" name="check">
  	</td>
  </tr>
  <tr>
  	<td>
  	동 이름 입력 : <input type="text" name="zip_oarea1">
  	<input type="hidden" value="n" name="check">
  	</td>
  </tr>
  <tr>
  	<td>
  	<input type="button" value="검색" id="btnZipFind">
  	<input type="button" value="닫기" id="btnZipClose">
  	</td>
  </tr>
</table>
</form>

<%
if(check.equals("n")){
	if(list.isEmpty()){
%>
		<b>검색 결과가 없습니다!</b>
<% 		
	}else{
%>		
	<table>
	  <tr>
	  	<td style="text-align: center;color: red">
		  검색자료를 클릭하면 자동으로 주소가 입력됩니다 
	  	</td>
	  </tr>
	  <tr>
	 	<td>
<%
		for(int i=0; i < list.size(); i++){
			ZipcodeDto dto = list.get(i);
			String zip_code = dto.getZip_code();
			String zip_narea1 = dto.getZip_narea1();
			String zip_narea2 = dto.getZip_narea2();
			String zip_narea3 = dto.getZip_narea3();
			String zip_narea4 = dto.getZip_narea4();
			String zip_narea5 = dto.getZip_narea5();
			String zip_oarea1 = dto.getZip_oarea1();
			String zip_oarea2 = dto.getZip_oarea2();
			if(zip_narea4 == null) zip_narea4 = "";
%>
		<a href="javascript:send('<%=zip_code %>','<%=zip_narea1 %>','<%=zip_narea2 %>','<%=zip_narea3 %>','<%=zip_narea4 %>', '<%=zip_narea5 %>','<%=zip_oarea1 %>','<%=zip_oarea2 %>')">
		<%=zip_code %> <%=zip_narea1 %> <%=zip_narea2 %> <%=zip_narea3 %> <%=zip_narea4 %> <%=zip_narea5 %> <%=zip_oarea1 %> <%=zip_oarea2 %>
		</a>
		<br>
		
<%
		}
%>	 		
	 	</td>
	  </tr>
	</table>
<%
	}
}
%>
</body>
</html>






