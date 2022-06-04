<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/12
  Time: 22:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    BoardDAO boardDAO = BoardDAO.getInstance();

    List<BoardDTO> board = boardDAO.getPopularBoard();
    pageContext.setAttribute("board", board);
%>
<%--
<table border="1">
    <th width="15%">작성자</th>
    <th width="20%">제목</th>
    <th width="13%">조회수</th>
    <th width="20%">글 작성일</th>
    <c:forEach var="forBoard" items="${board}">
        <tr>
            <td>${forBoard.writer}</td>
            <td>${forBoard.subject}</td>
            <td>${forBoard.count}</td>
            <td><fmt:formatDate value="${forBoard.regDate}" pattern="yy/MM/dd KK:mm"/></td>
        </tr>
    </c:forEach>
</table>--%>
<c:forEach var="forBoard" items="${board}">
    <div class="boardUnit">
        <span><a href="/board/communication.jsp?boardNo=${forBoard.boardNo}">${forBoard.subject}</a></span>
        <span class="comment"><ion-icon name="chatbubbles-outline"></ion-icon></span> <%--댓글--%>
        <span class="writer">${forBoard.writer}</span>
        <span class="regDate"><fmt:formatDate value="${forBoard.regDate}" pattern="yy-MM-dd kk:mm"/></span>
    </div>
</c:forEach>
