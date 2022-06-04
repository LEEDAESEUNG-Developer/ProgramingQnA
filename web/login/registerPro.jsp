<%@ page import="member.MemberDAO" %>
<%@ page import="javax.naming.Context" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/16
  Time: 23:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");

    String writer = request.getParameter("writer");
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    String email = request.getParameter("email");
    int chk = 0;

    MemberDAO memberDAO = MemberDAO.getInstance();

    chk = memberDAO.register(writer, id, pwd, email);

    pageContext.setAttribute("chk", chk);
%>
<script>
    <c:choose>
    <c:when test="${chk == 0}"> <%-- 회원가입 실패 --%>
        alert("회원가입이 실패 하였습니다. 닉네임, 아이디 중복체크 해주세요.");
    </c:when>
    <c:when test="${chk == 1}"> <%-- 회원가입 성공 --%>
        alert("회원가입이 완료 되었습니다.");
        location = "/index.jsp";
    </c:when>
    </c:choose>
</script>