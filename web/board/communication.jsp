<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.CommentDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/19
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>Programing QnA</title>
    <link rel="stylesheet" href="../style/communication.css">
    <jsp:include page="../bootstrap.jsp"/>
    <jsp:include page="../summernote.jsp"/>
</head>
<body>
<%
    int boardNo = Integer.parseInt(request.getParameter("boardNo"));
    String memberId = (String) session.getAttribute("memberId");
    BoardDAO boardDAO = BoardDAO.getInstance();
    BoardDTO boards = boardDAO.getBoards(boardNo);
    String classification = boardDAO.getStringClassification(boards.getClassification());

    boardDAO.boardCountOnePlus(boardNo); // 게시판을 볼 때 마다 게시판 조회수 1씩 올라감

    pageContext.setAttribute("boards", boards);
    pageContext.setAttribute("classification", classification);
%>
    <jsp:include page="/sidebar/sidebarControll.jsp"/>
    <div id="container">
        <h4>전체 게시판</h4>
        <%-- 게시글 --%>
        <div class="boardInfoBox">
            <%-- 게시판 작성자, 게시판 생성일--%>
            <div class="border_writer">${boards.writer}</div>
            <div class="regDate"><fmt:formatDate value="${boards.regDate}" pattern="yy-MM-dd kk:mm"/></div>
            <hr>
            <div class="boardNoBox">
                <%-- 게시판 번호, 게시판 분류, 제목, 내용--%>
                <div class="boardNo_subject_btn">
                    No.${boards.boardNo}
                    <div class="boardClassification">${classification}</div>
                    <div class="tab"></div>
                    <% if(memberId != null && memberId.equals(boards.getWriter()) || ((Boolean)session.getAttribute("isManager") != null)) { %>
                    <!-- 게시판 수정 -->
                        <div class="boardNo_btn_Box">
                            <form action="boardEdit.jsp" method="post">
                                <input type="hidden" name="boardNo" value="${boards.boardNo}">
                                <input type="submit" value="수정">
                            </form>
                            <!-- 게시판 삭제 -->
                            <form action="/BoardController" method="post">
                                <input type="hidden" name="boardNo" value="${boards.boardNo}">
                                <input type="hidden" name="url" value="BoardDelete"/>
                                <input type="submit" value="삭제">
                            </form>
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="board_subject margin20px">${boards.subject}</div>
            <hr>
            <div class="board_content margin20px">${boards.content}</div>
        </div>
        <!-- 댓글 -->
        <jsp:include page="../comment/comment.jsp"/>
    </div> <%-- container Close --%>
</body>
</html>
