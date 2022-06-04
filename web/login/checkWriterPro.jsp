<%@ page import="member.MemberDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/16
  Time: 22:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");

    String writer = request.getParameter("writer");

    MemberDAO memberDAO = MemberDAO.getInstance();
    int confirmWriterCnt = memberDAO.isConfirmWriter(writer);
    if(confirmWriterCnt == 0){  // 닉네임 없음, 회원가입 가능
        out.print("<script> alert('사용하실수 있습니다.'); history.back();</script>");
    } else {                    // 닉네임 있음, 회원가입 불가능
        out.print("<script>alert('사용하실수 없습니다.'); history.back();</script>");
    }
%>