<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-05-23
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">

    <script>
        const saveForm = () => {
            location.href = "/board/save";
        }

        const paging = () => {
            location.href = "/board/paging";
        }



        //    회원가입: /member-save => /member/save
        //    글쓰기 : /board-save   => /board/save
    </script>

    <style>
        .mainBox {
            margin-right: auto;
            margin-left: auto;
            text-align: center
        }
    </style>
</head>
<body>
<jsp:include page="layout/header.jsp" flush="false"></jsp:include>
<br><br><br><br>
<div class="mainBox">
    <h1>Prefer J Main</h1>

</div>
<br><br><br><br>
<div class="mainBox">
    <div style="border: 3px solid #2c3034;width: auto;height: auto">여기는 공지사항 쓰는곳 수정은 관리자만 가능합니다. DB에는 안넣을거고 킬 때 마다
        수정할거
    </div>
</div>




<br><br><br><br>


<div class="container">
    <button class="btn btn-outline-success" onclick="saveForm()">글작성</button>
    <button class="btn btn-outline-success" onclick="paging()">페이징목록</button>
    <table class="table">
        <tr>
            <th>글번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>작성시간</th>
            <th>조회수</th>
        </tr>
        <c:forEach items="${boardList}" var="board">
            <tr>
                <td>${board.id}</td>
                <td>${board.boardWriter}</td>
                <td><a href="/board/detail?id=${board.id}">${board.boardTitle}</a></td>
                <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss"
                                    value="${board.boardCreatedDate}"></fmt:formatDate></td>
                <td>${board.boardHits}</td>
            </tr>
        </c:forEach>
    </table>
    <button class="btn btn-outline-success" onclick="saveForm()">글작성</button>
    <button class="btn btn-outline-success" onclick="paging()">페이징목록</button>
</div>


</body>
</html>
