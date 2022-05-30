<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-05-30
  Time: 오후 3:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sign-in/">
    <script src="http://code.jquery.com/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>


<body>
<h1>admin</h1>
<div class="memberL">
    회원
    <table class="table">
        <tr>
            <th>id</th>
            <th>memberId</th>
            <th>memberPassword</th>
            <th>memberName</th>
            <th>memberAge</th>
            <th>memberPhone</th>
            <th>삭제</th>
        </tr>
        <c:forEach items="${memberDTOList}" var="memberDTOList">
            <tr onclick="asd()">
                <td>${memberDTOList.id}</td>
                <td>${memberDTOList.memberId}</td>
                <td>${memberDTOList.memberPassword}</td>
                <td>${memberDTOList.memberName}</td>
                <td>${memberDTOList.memberAge}</td>
                <td>${memberDTOList.memberPhone}</td>
                <td>삭제</td>

            </tr>
        </c:forEach>
    </table>
</div>
<div class="boardL">
    게시글
    <table class="table">
        <tr>
            <th>id</th>
            <th>boardWriter</th>
            <th>boardPassword</th>
            <th>boardTitle</th>
            <th>boardContents</th>
            <th>boardCreatedDate</th>
            <th>boardHits</th>
            <th>삭제</th>
        </tr>
        <c:forEach items="${boardDTOList}" var="boardDTOList">
            <tr onclick="asd()">
                <td>${boardDTOList.id}</td>
                <td>${boardDTOList.boardWriter}</td>
                <td>${boardDTOList.boardPassword}</td>
                <td>${boardDTOList.boardTitle}</td>
                <td>${boardDTOList.boardContents}</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss"
                                    value="${boardDTOList.boardCreatedDate}"></fmt:formatDate></td>
                <td>${boardDTOList.boardHits}</td>
                <td>삭제</td>
            </tr>
        </c:forEach>
    </table>
</div>
<div class="commentL">
    댓글
    <table class="table">
        <tr>
            <th>id</th>
            <th>commentWriter</th>
            <th>commentContents</th>
            <th>boardId</th>
            <th>commentCreatedDate</th>
            <th>삭제</th>
        </tr>
        <c:forEach items="${commentDTOList}" var="commentDTOList">
            <tr class="asd${commentDTOList.id}" onclick="asd()" >
                <td>${commentDTOList.id}</td>
                <td>${commentDTOList.commentWriter}</td>
                <td>${commentDTOList.commentContents}</td>
                <td>${commentDTOList.boardId}</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss"
                                    value="${commentDTOList.commentCreatedDate}"></fmt:formatDate></td>
                <td>삭제</td>

            </tr>
        </c:forEach>
    </table>
</div>


<script>
    function asd() {
        alert("클릭쿠");
        const asd = document.getElementById("asd${commentDTOList.id}");
        asd.style ="color: red";
    }
</script>
</body>
</html>
