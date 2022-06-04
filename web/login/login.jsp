<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/12
  Time: 23:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>로그인 페이지</title>
    <link rel="stylesheet" href="../style/login.css">
    <link rel="stylesheet" href="../style/allUse.css">
</head>
<body>
    <c:if test="${memberId != null}"> <%-- 로그인 된 사용자는 접속하지 못하게한다 --%>
        <script>
            location = "/index.jsp";
        </script>
    </c:if>
<jsp:include page="../sidebar/sidebarControll.jsp"/>
<div id="container">
    <h3>로그인</h3>
    <form action="loginPro.jsp" method="post">
        <ul class="loginBox">
            <li><input type="text" name="id" id="id" placeholder="아이디"></li>
            <li><input type="password" name="pwd" id="pwd" placeholder="비밀번호"></li>
            <li><input type="submit" value="로그인" id="login_btn"></li>
        </ul>
    </form>
</div>
</body>
</html>
