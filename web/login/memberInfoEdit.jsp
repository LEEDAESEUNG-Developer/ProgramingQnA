<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/28
  Time: 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>개인정보 수정</title>
    <link rel="stylesheet" href="../style/allUse.css">
    <link rel="stylesheet" href="../style/register.css">
    <link rel="stylesheet" href="../style/sidebar.css">
    <jsp:include page="../bootstrap.jsp"/>
    <script src="../script/register.js"></script>
</head>
<body>
<% if(session.getAttribute("memberId") == null) out.print("<script> location = '/index.jsp';</script>"); %>
<jsp:include page="../sidebar/sidebarControll.jsp"/>
<div id="container">
    <form action="/MemberController?url=memberInfoPro" method="post" name="register">
        <input type="hidden" name="checkWriter" value="${chk_writer}">
        <div class="id">
            <label>닉네임: </label> <input type="text" name="writer" id="writer" value="${memberInfo.writer}">
            <input type="button" value="중복체크" name="confirmWriter" id="confirmWriter">
        </div>
        <div class="id"><label>비밀번호: </label> <input type="password" name="pwd" id="pwd" value="${memberInfo.memberPwd}"></div>
        <div class="id"><label>비밀번호 확인: </label> <input type="password" name="pwd" id="pwd_chk"></div>
        <div class="id"><label>이메일: </label> <input type="text" name="email" id="email" value="${memberInfo.email}"></div>
        <div class="btn">
            <input type="reset" value="다시 입력">
            <input type="submit" value="정보수정">
        </div>
    </form>
</div>
</body>
</html>
