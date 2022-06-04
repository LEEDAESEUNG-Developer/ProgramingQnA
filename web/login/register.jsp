<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/16
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="../style/allUse.css">
    <link rel="stylesheet" href="../style/register.css">
    <link rel="stylesheet" href="../style/sidebar.css">
    <jsp:include page="../bootstrap.jsp"/>
    <script src="../script/register.js"></script>
</head>
<body>
  <jsp:include page="../sidebar/sidebarControll.jsp"/>
  <div id="container">
      <form action="registerPro.jsp" method="post" name="register">
          <input type="hidden" name="checkWriter" value="${chk_writer}">
          <div class="id">
              <label>닉네임: </label> <input type="text" name="writer" id="writer">
              <input type="button" value="중복체크" name="confirmWriter" id="confirmWriter">
          </div>
          <div class="id">
              <label>아이디: </label> <input type="text" name="id" id="id">
              <input type="button" value="사용가능여부" name="confirmId" id="confirmId">
          </div>
          <div class="id"><label>비밀번호: </label> <input type="password" name="pwd" id="pwd"></div>
          <div class="id"><label>이메일: </label> <input type="text" name="email" id="email"></div>
          <div class="btn">
              <input type="reset" value="다시 입력">
              <input type="submit" value="회원가입">
          </div>
      </form>
  </div>
</body>
</html>
