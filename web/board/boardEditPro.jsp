<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/23
  Time: 0:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판 수정 처리</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");

    if(session.getAttribute("memberId") == null) out.print("<script> alert('로그인 해주세요.'); history.back();</script>");


    BoardDAO boardDAO = BoardDAO.getInstance();
    BoardDTO board = new BoardDTO();

    // boardEdit.jsp에서 가져오는 값을 board에 저장
    board.setBoardNo(Integer.parseInt(request.getParameter("boardNo")));
    board.setClassification(Integer.parseInt(request.getParameter("categoryCode")));
    board.setSubject(request.getParameter("subject"));
    board.setContent(request.getParameter("content"));
    board.setWriter(request.getParameter("writer"));

    if(!session.getAttribute("memberId").equals(board.getWriter())){ // 현재 로그인 한 사용자가 게시판 작성자가 아닐경우
        out.print("<script>");
        out.print("alert('사용하실수 없습니다');");
        out.print("history.back();");
        out.print("</script>");
    }

    int editCnt =  boardDAO.editBoard(board);

    out.print("<script>");
    if(editCnt == 1){
        out.print("location = '/board/communication.jsp?boardNo=" + board.getBoardNo() + "'");
    } else if(editCnt == 0){
        out.print("alert('게시판을 수정 하실 수 없습니다.');");
        out.print("location = '/index.jsp'");
    }
    out.print("</script>");


%>
</body>
</html>
