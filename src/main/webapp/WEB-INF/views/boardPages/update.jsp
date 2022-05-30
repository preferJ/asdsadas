<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-05-24
  Time: 오후 2:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<BR><BR><BR><BR><BR>
<h2>update.jsp</h2>
<div class="container">
<form action="/board/update" method="post" name="updateForm">
    글번호
    <input type="text" name="id" value="${boardUpdate.id}" class="form-control" readonly>
    글 제목
    <input type="text" name="boardTitle" value="${boardUpdate.boardTitle}" class="form-control">
    글 패스워드
    <input type="text" name="boardPassword" id="passwordConfirm" class="form-control">
    작성자
    <input type="text" name="boardWriter" value="${boardUpdate.boardWriter}" class="form-control" readonly>
    내용
    <br>
    <textarea name="boardContents" cols="170" rows="20">${boardUpdate.boardContents}</textarea>
    <br>
    <input type="button" class="btn btn-danger" value="수정" onclick="boardUpdate()">
</form>
</div>
</body>
<script>
    const boardUpdate = () => {
        // const passwordConfirm = document.querySelector("#passwordConfirm").value;
        const passwordConfirm = document.getElementById("passwordConfirm").value;
        const passwordDB = '${boardUpdate.boardPassword}';
        if (passwordConfirm == passwordDB) {
            updateForm.submit();
        } else {
            alert("비밀번호 불일치!!!!");
        }

    }
</script>
</html>
