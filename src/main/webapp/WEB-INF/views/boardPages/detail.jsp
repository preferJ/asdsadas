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
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script src="http://code.jquery.com/jquery-3.6.0.js"></script>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <style>
        .sample {
            border: solid black 2px;
        }

        .prefer-btn {
            /*padding-right: 300px;*/
            float: right;
            position: relative;
            right: 15%;

        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<BR><BR><BR><BR><BR>
<h1 style=" text-align : center">${board.boardTitle}</h1>
<br><br><br>
<div class="prefer-btn">
    <c:choose>
        <c:when test="${sessionScope.memberId == null}">
            <button class="btn btn-primary" onclick="login()">수정</button>
        </c:when>

        <c:otherwise>
            <c:choose>

            <c:when test="${sessionScope.memberId == board.boardWriter}">
            <button class="btn btn-primary" onclick="boardUpdate()">수정</button>
            </c:when>
            <c:otherwise>
                <button class="btn btn-primary" onclick="boardUpdate()" disabled="disabled">수정</button>
            </c:otherwise>
            </c:choose>


        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${sessionScope.memberId == null}">
            <button class="btn btn-primary" onclick="login()">삭제</button>

        </c:when>

        <c:otherwise>
            <c:choose>

            <c:when test="${sessionScope.memberId == board.boardWriter}">
                <button class="btn btn-primary" onclick="boardDelete()">삭제</button>

            </c:when>
            <c:otherwise>
                <button class="btn btn-primary" onclick="boardDelete()" disabled="disabled">삭제</button>

            </c:otherwise>
            </c:choose>


        </c:otherwise>
    </c:choose>


</div>
<br><br>
<div class="container">
    <div class="sample">
        <div class="row">
            <div class="col-sm-3">
                <img src="${pageContext.request.contextPath}/upload/${board.boardFileName}"
                     alt="">
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
                <div class="row">
                    <div class="col-4 col-sm-12">
                        조회수: ${board.boardHits} <br>
                        <br>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br><br>
<div class="container" style="border: solid black 1px">
    <h4 style="text-align: center"> 본문 </h4>
    <div>${board.boardContents}</div>

</div>


<div class="container">
    <button class="btn btn-prima" onclick="paging()">목록</button>
</div>

<div class="container">
    <div id="comment-write" class="input-group mb-3">
        <input type="text" id="commentWriter"  class="form-control" value="${sessionScope.memberId}"
               readonly>
        <c:choose>
            <c:when test="${sessionScope.memberId == null}">
                <input type="text" id="commentContents" placeholder="내용"  onclick="login()" class="form-control">

            </c:when>

            <c:otherwise>
                <input type="text" id="commentContents" placeholder="내용" class="form-control">


            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${sessionScope.memberId == null}">
                <input type="button" class="btn btn-primary" onclick="login()" value="댓글 작성"></input>
            </c:when>

            <c:otherwise>
                <input type="submit" id="comment-write-btn" class="btn btn-primary" value="댓글 작성"></input>

            </c:otherwise>
        </c:choose>
    </div>
</div>
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
  if(commentContents != ""){
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
                output += "<th>작성시간</th>";
                output += "<th>삭제</th>" +
                    "</tr>";
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

        });}else{
      alert("내용이 비었습니다.")
  }
    });

    const login = () => {
        alert("로그인이 필요한 기능입니다.")
        location.href = "/member/login";
    }

    const boardUpdate = () => {
        location.href = "/board/update?id=${board.id}";
    }
    const boardDelete = () => {
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
