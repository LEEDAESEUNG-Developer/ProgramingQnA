<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/15
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>수다 게시판</title>
    <link rel="stylesheet" href="../style/board.css">
</head>
<body>
<%
    BoardDAO boardDAO = BoardDAO.getInstance();

    // 게시판에 있는 글 개수를 확인
    int cnt = boardDAO.getBoardCount(20);

    ////////////////////////////////////////////////////////////////
    // 페이징 처리

    // 한 페이지에 출력될 글 수
    int pageOutputSize = 10;

    // 총 몇 페이지인지 계산
    int pageMaxCount = 0;

    int pageBlock = 10; // 페이지번호를 출력
    int startPage = 0; // 첫 페이지
    int endPage = 0;   // 끝 페이지

    String pageNum = request.getParameter("pageNum"); // 페이지 번호
    if(pageNum == null) {
        pageNum = "1"; // 페이지 값이 없으면 1페이지 지정
        response.sendRedirect("chatBoard.jsp?pageNum=" + pageNum);
    }

    // 첫 행번호를 계산
    int currentPage = Integer.parseInt(pageNum); // 현재 페이지 수
    int startRowCount = (currentPage - 1) * pageOutputSize; // 페이지의 게시글 수

    List<BoardDTO> board = boardDAO.getChatBoards(startRowCount, pageBlock);
    pageContext.setAttribute("board", board);
%>
<jsp:include page="../sidebar/sidebarControll.jsp"/>
<div id="container">
    <h3>커뮤니티</h3>
    <div>
        <a href="">최신순</a>&ensp;&ensp;&ensp;&ensp;
        <a href="">조회순</a>&ensp;&ensp;&ensp;&ensp;
        <input type="text" name="" id="">
        <input type="button" value="검색">
        <a href="writerBoard.jsp">새 글쓰기</a>
    </div>
    <div class="boardSize">
        <c:forEach var="forBoard" items="${board}">
            <div class="boardUnit">
                <span class="subject"><label><a
                        href="/board/communication.jsp?boardNo=${forBoard.boardNo}">${forBoard.subject}</a></label></span>
                <span class="comment"><ion-icon name="chatbubbles-outline"></ion-icon></span> <%--댓글--%>
                <span class="writer">${forBoard.writer}</span>
                <span class="regDate"><fmt:formatDate value="${forBoard.regDate}" pattern="yy-MM-dd kk:mm"/></span>
            </div>
        </c:forEach>
    </div>
    <div id="page_control">
        <% if(cnt != 0){
            /////////////////////////
            // 페이징 처리
            // 전체 페이지수 계산
            pageMaxCount = cnt / pageOutputSize + (cnt % pageOutputSize == 0 ? 0 : 1);

            // 한 페이지에 보여줄 페이지 블럭 시작번호 계산
            startPage = ((currentPage-1)/pageBlock)*pageBlock+1;

            // 한 페이지에 보여줄 페이지 블럭 끝 번호 계산
            endPage = startPage + pageBlock - 1;
            if(endPage > pageMaxCount) endPage = pageMaxCount;
        } %>
        <% if(startPage > pageBlock) {%> <!-- 다음블럭에서 이전 버튼을 나오게함 -->
        <a href="chatBoard.jsp?pageNum=<%=startPage - pageBlock%>"> < 이전</a>
        <% } %>
        <% for(int i=startPage;i<=endPage;i++){ %> <%-- 페이지 밑에 페이지수를 출력--%>
        <a href="chatBoard.jsp?pageNum=<%=i%>"><%=i%></a>
        <%} %>

        <% if(endPage< pageMaxCount) { /* 다음 페이지 이동 */
            int movePage = currentPage + 10;
            if(movePage > pageMaxCount) movePage = pageMaxCount;
            out.print("<a href='chatBoard.jsp?pageNum=" + (startPage+pageBlock) + "'>다음 > </a>");
        } %>
    </div>
</div>
</body>
</html>
