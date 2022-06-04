<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/14
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div class="panel panel-info sidebar"> <%-- 왼쪽 메뉴 바 --%>
        <ul class="list-group">
            <li class="list-group-item"><a href="/index.jsp">메인</a></li>
            <li class="list-group-item" id="memberInfo"><img src="../icon/user.png" alt="memberIcon" height="24">&nbsp;<div class="c_welcome">${memberId}</div></li>
            <li class="list-group-item"><a href="/MemberController?url=memberInfoEdit">개인정보 수정</a></li>
            <li class="list-group-item"><a href="/login/logoout.jsp">로그아웃</a></li>
            <li class="list-group-item"><a href="/board/boardQnA.jsp">Q&A</a></li>
            <li class="list-group-item"><a href="/board/chatBoard.jsp">커뮤니티</a></li>
            <li class="list-group-item"><a href="/board/board.jsp">전체 게시글</a></li>
            <li class="list-group-item"><a href="#">관리자페이지</a></li>
        </ul>
</div>
