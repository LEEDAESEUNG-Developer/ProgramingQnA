<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="member.MemberDAO" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/22
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 수정 페이지</title>
    <link rel="stylesheet" href="../style/boardEdit.css">
    <jsp:include page="../bootstrap.jsp"/>
    <jsp:include page="../summernote.jsp"/>
</head>
<body>
<%
    if(session.getAttribute("memberId") == null) out.print("<script> alert('로그인 해주세요.'); history.back();</script>");

    BoardDAO boardDAO = BoardDAO.getInstance();
    int boardNo = Integer.parseInt(request.getParameter("boardNo"));// 게시판 번호
    String memberId = (String) session.getAttribute("memberId");    // 현재 로그인 된 사용자
    BoardDTO board = boardDAO.getBoards(boardNo);                   // 게시판 번호를 가지고 게시판을 가지고온다

    if((!(board.getWriter().equals(memberId)))){ // 현재 로그인 한 사용자가 게시판 작성자가 아닐경우
        out.print("<script>");
        out.print("alert('사용하실수 없습니다');");
        out.print("history.back();");
        out.print("</script>");
    }

    pageContext.setAttribute("board", board);
%>
<%--<c:if test="${memberId == null}"> &lt;%&ndash; 로그인 된 사용자는 접속하지 못하게한다 &ndash;%&gt;
    <script>
        alert("로그인하고 오세요");
        location = "/index.jsp";
    </script>
</c:if>--%>
<jsp:include page="../sidebar/sidebarControll.jsp"/>
<div id="container">
    <form action="boardEditPro.jsp" method="post">
        <input type="hidden" name="boardNo" value="${board.boardNo}">
        <input type="hidden" name="writer" value="${board.writer}">
        <div>   <%-- 자바 스크립트 사용 --%>
            <select name="categoryCode" id="category">
                <option value="10">수다</option>
                <option value="20">QnA</option>
            </select>
        </div>
        <div class="subject"><input type="text" name="subject" id="subject" placeholder="제목" value="${board.subject}"></div>
        <textarea id="summernote" name="content">${board.content}</textarea>
        <input type="button" value="되돌리기" id="reset">
        <input type="submit" value="변경">
    </form>
</div>
<script>
    $(document).ready(function() {
        $("#reset").click(function() {
            $("#subject").val('${board.subject}');
            $(".note-editable").html('${board.content}');
        });
        $('#summernote').summernote({
            height: 300,                  // 에디터 높이
            minHeight: null,              // 최소 높이
            maxHeight: null,              // 최대 높이
            focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
            lang: "ko-KR",				  // 한글 설정
        });
    });
</script>
</body>
</html>
