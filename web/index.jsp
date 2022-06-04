<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/11
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="UTF-8">
    <title>Programing QnA Site</title>
    <link rel="stylesheet" href="style/allUse.css">
    <link rel="stylesheet" href="style/main.css">
  </head>
  <body>
  <div class="main">
    <jsp:include page="sidebar/sidebarControll.jsp"/>
    <div class="contentBox"> <%-- 내용 --%>
      <h1>Programing QnA Site</h1>
      <div class="banner"> <%-- 배너 --%>
        <img src="image/Apple_WWDC21.jpg" alt="AppleWWDC21" width="100%" height="400px">
      </div>

      <div class="board"> <%-- 게시판 --%>
        <div class="latestArticleBox"> <%-- 최신 글 --%>
          <h3>최신글</h3>
          <jsp:include page="board/latestBoard.jsp"/>
        </div>
        <div class="popularArticleBox"> <%-- 인기 글 --%>
          <h3>인기글</h3>
          <jsp:include page="board/popularBoard.jsp"/>
        </div>
      </div>
    </div>
  </div>
  </body>
</html>
