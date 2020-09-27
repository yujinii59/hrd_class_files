<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bean" class="kr.shop.board.BoardBean" />
<jsp:setProperty property="*" name="bean" />
<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />

<%
String spage = request.getParameter("page");

int num = bean.getNum();
int gnum = bean.getGnum();			// 그룹 넘버
int onum = bean.getOnum() + 1;		//댓글이므로 1 증가
int nested = bean.getNested() + 1;	// 댓글을 들여쓰기 하나 들어가야한다.

// 같은 그룹 내에서 새로운 댓글의 onum보다 크거나 같은 값을 댓글 입력 전에 먼저 수정하기. 작으면 수정 안 함.
boardMgr.updateOnum(gnum, onum);	//onum 갱신


// 댓글 자료 저장
bean.setOnum(onum);		//변경사항 저장
bean.setNested(nested);	//변경사항 저장
bean.setBip(request.getRemoteAddr());
bean.setBdate();		// 이미 오버라이딩 되어 있으므로 데이터 입력 필요없다.
bean.setNum(boardMgr.currentGetNum() + 1);		//댓글(새 글)의 레코드 번호

boardMgr.saveReplyData(bean);
response.sendRedirect("boardlist.jsp?page=" + spage);	//댓글 저장 후 목록 보기
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>