<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.CommentDTO" %>
<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/30
  Time: 0:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    if (session.getAttribute("memberId") == null) out.print("<script>location='/index.jsp'</script>");

    String addComment = request.getParameter("addComment");
    int boardNo = Integer.parseInt(request.getParameter("boardNo"));
    CommentDTO comment = new CommentDTO();
    CommentDAO commentDAO = CommentDAO.getInstance();

    comment.setWriter((String)session.getAttribute("memberId"));
    comment.setContent(addComment);
    comment.setBoardNo(boardNo);


    if (comment.getContent().equals("")){
        out.print("<script>");
        out.print("alert('내용을 작성해주세요.');");
        out.print("location='/board/communication.jsp?boardNo="+ boardNo + "'");
        out.print("</script>");
    }
    else {
        commentDAO.addComment(comment);
    }

    out.print("<script>location='/board/communication.jsp?boardNo="+ boardNo + "'</script>");
%>