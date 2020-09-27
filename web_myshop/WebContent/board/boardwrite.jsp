<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	  $('#summernote').summernote();
});
</script>

<script>
function check(){
	if(frm.name.value==""){
		alert("이름을 입력하세요");
		frm.name.focus();
	}else if(frm.pass.value ==""){
		alert("비밀번호를 입력하세요");
		frm.pass.focus();
	}else if(frm.mail.value ==""){
		alert("이메일을 입력하세요");
		frm.mail.focus();
	}else if(frm.title.value ==""){
		alert("제목을 입력하세요");
		frm.title.focus();
	}else if(frm.cont.value ==""){
		alert("내용을 입력하세요");
		frm.cont.focus();
	}else
		frm.submit();
}
</script>
</head>
<body>
<form name="frm" method="post" action="boardsave.jsp">
	<table border="1">
		<tr>
			<td colspan="2"><h2>*** 글쓰기 ***</h2></td>
		</tr>
		<tr>
			<td align="center" width="100">이 름</td>
			<td width="430"><input name="name" size="15"></td>
		</tr>
		<tr>
			<td align="center">암 호</td>
			<td><input type="password" name="pass" size="15"></td>
		</tr>
		<tr>
			<td align="center">메 일</td>
			<td><input name="mail" size="25"></td>
		</tr>
		<tr>
			<td align="center">제 목</td>
			<td><input name="title" size="50"></td>
		</tr>
		<tr>
			<td align="center">내 용</td>
			<td><textarea name="cont" id="summernote" cols="50" rows="10" ></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center" height="30">
			    <input type="button"
				 value="메  인" onClick="location.href='../index.jsp'">&nbsp;
				<input type="button" value="작  성" onClick="check()">&nbsp;
				<input type="button" value="목  록"
				  onClick="location.href='boardlist.jsp'"></td>
		</tr>
	</table>
</form>
</body>
</html>