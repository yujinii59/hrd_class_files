<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("utf-8"); %>    
    
<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr"></jsp:useBean>

<%
//out.println(bean.getName());
String spage = request.getParameter("page");
String num = request.getParameter("num");
String pass = request.getParameter("pass");

boolean b = boardMgr.checkPass(Integer.parseInt(num), pass);

if(b){
	boardMgr.delData(num);
	response.sendRedirect("boardlist.jsp?page=" + spage);		//글 삭제 후 목록보기
}else{
%>
	<script>
	alert("비밀번호가 맞지 않습니다. 다시 한 번 확인해주세요.");
	history.back();
	</script>
<%
}
%>