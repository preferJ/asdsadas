<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-05-23
  Time: 오후 1:55
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
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<BR><BR><BR><BR><BR>

<div class="container">
    <main class="form-signin w-100 m-auto">
        <form style="color: #6c757d" action="/member/update" method="post">
            <h1 class="h3 mb-3 fw-normal" style="text-align: center">MY PAGE</h1>

            <div class="form">
                <input type="text" name="memberId" class="form-control" id="memberId" placeholder="memberId"
                       value='${memberList.memberId}' readonly>
                <label for="memberId">memberId</label>
            </div>
            <div id="memberIdCheck"></div>
            <br>
            <div class="form">
                <input type="password" name="memberPassword" class="form-control" id="memberPassword"
                       placeholder="memberPassword" onblur="pwCheck()" value='${memberList.memberPassword}'>
                <label for="memberPassword">memberPassword</label>
            </div>
            <br>

            <div class="form">
                <input type="password" name="memberPasswordCk" class="form-control" id="memberPasswordCk"
                       placeholder="memberPasswordCk" onblur="pwCheck()" value='${memberList.memberPassword}'>
                <label for="memberPasswordCk">memberPasswordCk</label>
            </div>
            <div id="pwCheck"></div>

            <br>

            <div class="form">
                <input type="text" name="memberName" class="form-control" id="memberName"
                       placeholder="memberName"
                       value='${memberList.memberName}'>
                <label for="memberName">memberName</label>
            </div>
            <br>

            <div class="form">
                <input type="text" name="memberAge" class="form-control" id="memberAge" placeholder="memberAge"
                       value='${memberList.memberAge}'>
                <label for="memberAge">memberAge</label>
            </div>
            <br>

            <div class="form">
                <input type="text" name="memberPhone" class="form-control" id="memberPhone"
                       placeholder="memberPhone"
                       value='${memberList.memberPhone}'>
                <label for="memberPhone">memberPhone</label>
            </div>
            <br>


            <button class="w-100 btn btn-lg btn-primary" id="submitBtn" type="submit">Update
            </button>
        </form>
    </main>


    내가 쓴 글 목록
    <div class="container">
        <table class="table">
            <tr>
                <th>글번호</th>
                <th>작성자</th>
                <th>제목</th>
                <th>작성시간</th>
                <th>조회수</th>
                <th>수정</th>
            </tr>
            <c:forEach items="${boardList}" var="board">
                <tr>
                    <td>${board.id}</td>
                    <td>${board.boardWriter}</td>
                    <td><a href="/board/detail?id=${board.id}">${board.boardTitle}</a></td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss"
                                        value="${board.boardCreatedDate}"></fmt:formatDate></td>
                    <td>${board.boardHits}</td>
                    <td>
                        <button class="btn btn-primary" onclick="boardUpdate()">수정</button>
                    </td>

                </tr>
            </c:forEach>
        </table>
    </div>
</div>


<script>
    function pwCheck() {
        const pw1 = document.getElementById("memberPassword").value
        const pw2 = document.getElementById("memberPasswordCk").value
        const pwCheck = document.getElementById("pwCheck")
        const submitBtn = document.getElementById("submitBtn")
        if (pw1 == "") {
            pwCheck.innerHTML = "비밀번호를 입력하지 않았습니다."
            pwCheck.style = "color: red"
            submitBtn.disabled = true;


        } else if (pw1 == pw2) {
            pwCheck.innerHTML = "비밀번호가 일치합니다."
            pwCheck.style = "color: green"
            submitBtn.disabled = false;


        } else {
            pwCheck.innerHTML = "비밀번호가 일치하지 않습니다."
            pwCheck.style = "color: red"
            submitBtn.disabled = true;

        }
    }

    const boardUpdate = () => {
        // 수정을 위한 화면(update.jsp)을 출력하고, 비밀번호를 입력받아서
        // 비밀번호 일치하면 수정처리, 일치하지 않으면 alert(회원 수정이랑 프로세스 같음.)
        location.href = "/board/update?id=${board.id}";
    }


</script>
</body>
</html>
