<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-05-24
  Time: 오전 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <script src="http://code.jquery.com/jquery-3.6.0.js"></script>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <style>
        .sample {
            border: solid red 2px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<BR><BR><BR><BR><BR>
<h2>detail.jsp</h2>
<div class="container">
    <div class="sample">
        <div class="row">
            <div class="col-sm-3">
                IMG
            </div>
            <div class="col-sm-9">
                <div class="row">
                    <div class="col-4 col-sm-12">
                        글 번호 : ${board.id}
                        <br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-sm-12">
                        제목 : ${board.boardTitle}
                        <br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-sm-12">
                        등록일 : ${board.boardCreatedDate}
                        <br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-sm-12">
                        작성자 : ${board.boardWriter}
                        <br>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
조회수: ${board.boardHits} <br>
<img src="${pageContext.request.contextPath}/upload/${board.boardFileName}"
     alt="" height="100" width="100">
<br>

<button class="btn btn-primary" onclick="boardUpdate()">수정</button>
<button class="btn btn-primary" onclick="boardDelete()">삭제</button>
<button class="btn btn-primary" onclick="findAll()">목록</button>
<button class="btn btn-primary" onclick="paging()">페이징목록</button>

<div class="container">
    <div id="comment-write" class="input-group mb-3">
        <input type="text" id="commentWriter" placeholder="작성자" class="form-control">
        <input type="text" id="commentContents" placeholder="내용" class="form-control">
        <button id="comment-write-btn" class="btn btn-primary">댓글 작성</button>
    </div>
</div>
<br><br><br>
<div id="CommentList">
    <table class="table">
        <tr>
            <th>댓글번호</th>
            <th>작성자</th>
            <th>내용</th>
            <th>작성시간</th>
        </tr>
        <C:forEach items="${commentList}" var="comment">
            <tr>
                <td>${comment.id}</td>
                <td>${comment.commentWriter}</td>
                <td>${comment.commentContents}</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss"
                                    value="${comment.commentCreatedDate}"></fmt:formatDate></td>


            </tr>
        </C:forEach>

    </table>
</div>

</body>
<script>
    $("#comment-write-btn").click(function () {
        //댓글, 작성자, 내용을 가져오기
        //ajax 문법을 활용하여 /comment/save 주소로 post 방식으로 작성자, 내용, 글번호 이렇게
        // 세개의 값을 보내는 코드를 작성!
        // ㅈㄴ어렵네;; ㄹㅇ;
        const boardId = '${board.id}';
        const commentWriter = document.getElementById("commentWriter").value;
        const commentContents = document.getElementById("commentContents").value;
        $.ajax({
            type: "post", // http request method
            url: "/comment/save", // 요청주소(컨트롤러 주소값)
            data: {"boardId": boardId, "commentWriter": commentWriter, "commentContents": commentContents}, // 전송하는 파라미터
            dataType: "json", // 리턴받을 데이터 형식


            success: function (result) {
                let output = "<table class='table'>";
                output += "<tr><th>댓글번호</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th></tr>";
                for (let i in result) {
                    //     output += "<tr>";
                    output += "<td>" + result[i].id + "</td>";
                    output += "<td>" + result[i].commentWriter + "</td>";
                    output += "<td>" + result[i].commentContents + "</td>";
                    output += "<td>" + moment(result[i].commentCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "</td>";

                    output += "</tr>";

                }
                output += "</table>";
                document.getElementById('CommentList').innerHTML = output;
                document.getElementById('commentWriter').innerHTML = '';
                document.getElementById('commentContents').value = '';


            },
            error: function () {
                console.log("틀렷지롱~")
                alert("틀렷찌롱~~~~")
            },

        });
    });

    const boardUpdate = () => {
        // 수정을 위한 화면(update.jsp)을 출력하고, 비밀번호를 입력받아서
        // 비밀번호 일치하면 수정처리, 일치하지 않으면 alert(회원 수정이랑 프로세스 같음.)
        location.href = "/board/update?id=${board.id}";
    }
    const boardDelete = () => {
        // 비밀번호 체크를 위한 화면(passwordCheck.jsp)을 출력하고, 비밀번호 입력받아서
        // 비밀번호 일치하면 삭제처리 후 목록 출력, 일치하지 않으면 alert 띄우고 상세화면으로
        location.href = "/board/passwordCheck?id=${board.id}";
    }
    const findAll = () => {
        location.href = "/board/findAll";
    }

    const paging = () => {
        location.href = "/board/paging?page=${page}";
    }


</script>
</html>
