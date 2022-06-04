<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/20
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 쓰기</title>
    <link rel="stylesheet" href="../style/writetBoard.css">
    <jsp:include page="../bootstrap.jsp"/>
    <jsp:include page="../summernote.jsp"/>
</head>
    <body>
    <c:if test="${memberId == null}"> <%-- 로그인 된 사용자는 접속하지 못하게한다 --%>
        <script>
            alert("로그인하고 오세요");
            location = "/index.jsp";
        </script>
    </c:if>
    <jsp:include page="../sidebar/sidebarControll.jsp"/>
    <div id="container">
        <form action="writerBoardPro.jsp" method="post">
            <div>
                <select name="categoryCode" id="category">
                    <option value="10">수다</option>
                    <option value="20">QnA</option>
                </select>
            </div>
            <div class="subject"><input type="text" name="subject" id="subject" placeholder="제목"></div>
            <textarea id="summernote" name="content"></textarea>
            <input type="button" value="취소" id="reset">
            <input type="submit" value="등록">
        </form>
    </div>
        <script>
            $(document).ready(function() {
                $('#summernote').summernote({
                    height: 300,                 // 에디터 높이
                    minHeight: null,             // 최소 높이
                    maxHeight: null,             // 최대 높이
                    focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
                    lang: "ko-KR",					// 한글 설정
                });
                $('#reset').click(function () {
                    let isResetBoolean = confirm("게시글 작성를 취소하시겠습니까?");
                    if(isResetBoolean) history.back();
                    else return;
                });
            });
        </script>
    </body>
</html>
