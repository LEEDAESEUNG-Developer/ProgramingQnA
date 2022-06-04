<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/14
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그아웃</title>
</head>
<body>
    <%
        session.invalidate();
    %>
<script>
    location = "../index.jsp";
</script>
</body>
</html>
