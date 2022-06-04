<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/14
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/style/sidebar.css">
<jsp:include page="/bootstrap.jsp"/>

<c:choose>
    <c:when test="${isManager != null}">   <%-- 관리자 로그인 성공시 --%>
        <jsp:include page="managerBar.jsp"/>
    </c:when>
    <c:when test="${memberId == null}">    <%-- 로그인 세션 x --%>
        <jsp:include page="loginFail.jsp"/>
    </c:when>
    <c:when test="${memberId != null}">    <%-- 일반 사용자 로그인 성공시 --%>
        <jsp:include page="loginScs.jsp"/>
    </c:when>
</c:choose>