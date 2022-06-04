<%@ page import="member.MemberDAO" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/13
  Time: 13:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>로그인 처리</title>
</head>
<body>
<%
    MemberDAO memberDAO = MemberDAO.getInstance();
    pageContext.setAttribute("memberDAO", memberDAO);   // jstl에 객체를 사용할수 있게 넘겨줌
%>
<script>
<c:choose>
    <c:when test="${memberDAO.isMemberLogin(param.id, param.pwd) == -1}"> <%-- 로그인 실패시 --%>
            alert("로그인을 실패하였습니다");
            history.back();
    </c:when>
    <c:when test="${memberDAO.isMemberLogin(param.id, param.pwd) == 0}"> <%-- 일반 사용자 로그인 성공 --%>
        <%
            session.setMaxInactiveInterval(60*30);
            session.setAttribute("memberId", request.getParameter("id"));
            response.sendRedirect("../index.jsp");
        %>
    </c:when>

    <c:when test="${memberDAO.isMemberLogin(param.id, param.pwd) == 1}"> /* 매니저 로그인 성공 */
        <%
            session.setMaxInactiveInterval(60*30);
            session.setAttribute("memberId", request.getParameter("id"));
            session.setAttribute("isManager", true);
            response.sendRedirect("../index.jsp");
        %>
    </c:when>
</c:choose>
</script>
</body>
</html>
