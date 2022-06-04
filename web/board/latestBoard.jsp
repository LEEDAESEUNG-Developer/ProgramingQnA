<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/12
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="member.MemberDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="board.BoardDAO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<%
  BoardDAO boardDAO = BoardDAO.getInstance();

  List<BoardDTO> board = boardDAO.getLatestBoard();
  pageContext.setAttribute("board", board);
%>
<c:forEach var="forBoard" items="${board}">
  <div class="boardUnit">
    <span><a href="/board/communication.jsp?boardNo=${forBoard.boardNo}">${forBoard.subject}</a></span>
    <span class="comment"><ion-icon name="chatbubbles-outline"></ion-icon></span> <%--댓글--%>
    <span class="writer">${forBoard.writer}</span>
    <span class="regDate"><fmt:formatDate value="${forBoard.regDate}" pattern="yy-MM-dd kk:mm"/></span>
  </div>
</c:forEach>