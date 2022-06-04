<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/20
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String memberId = (String) session.getAttribute("memberId");
    BoardDAO boardDAO = BoardDAO.getInstance();
    BoardDTO boardDTO = new BoardDTO();
    boardDTO.setClassification(Integer.parseInt(request.getParameter("categoryCode")));
    boardDTO.setWriter(memberId);
    boardDTO.setSubject(request.getParameter("subject"));
    boardDTO.setContent(request.getParameter("content"));

//    System.out.println(boardDTO);

    /*if(boardDAO.addBoard(boardDTO) == 1){
        response.sendRedirect("/index.jsp");
    }*/

    boardDAO.addBoard(boardDTO);
    response.sendRedirect("/index.jsp");
%>
</body>
</html>
