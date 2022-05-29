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
        <form style="color: #6c757d" action="/member/loginReq" method="post">
            <h1 class="h3 mb-3 fw-normal" style="text-align: center">Login</h1>

            <div class="form-floating">
                <input type="text" name="memberId" class="form-control" id="memberId" placeholder="memberId"
                       value="${memberId}">
                <label for="memberId">memberId</label>
            </div>

            <div id="memberIdCheck"></div>
            <br>
            <div class="form-floating">
                <input type="password" name="memberPassword" class="form-control" id="memberPassword"
                       placeholder="memberPassword">
                <label for="memberPassword">memberPassword</label>
            </div>


            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="remember-me"> Remember me
                </label>
            </div>
            <input type="button" class="btn btn-primary" onclick="login()" value="Login">
        </form>
    </main>
</div>


<script>
    function login() {
        const memberId = document.getElementById("memberId").value;
        const memberPassword = document.getElementById("memberPassword").value;

        $.ajax({
            type: "post", // http request method
            url: "/member/loginReq", // 요청주소(컨트롤러 주소값)
            data: {"memberId": memberId}, // 전송하는 파라미터
            dataType: "json", // 리턴받을 데이터 형식


            success: function (result) {
                if (memberPassword == result.memberPassword) {
                    alert("로그인 성공")
                    location.href = "/"
                } else {
                    alert("비밀번호 틀림")
                }

            },
            error: function () {
                console.log("아이디가 업찌롱~~")
                alert("아이디가 없찌롱~")
            },

        });
    };


</script>
</body>
</html>
