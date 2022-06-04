<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.CommentDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: lee-macbook
  Date: 2022/05/30
  Time: 0:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script defer>
    $(document).ready(function () {
        let index = 0; // 버튼을 눌렀을때 그 위치
        $(".edit-btn-hidden").css("display", "none");
        $('#summernote').click(function () {
            $('#summernote').summernote({
                height: 80,                 // 에디터 높이
                minHeight: null,             // 최소 높이
                maxHeight: null,             // 최대 높이
                focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
                lang: "ko-KR",				  // 한글 설정
            });
        });

        /* 수정 버튼을 눌렀을때 수정하는 창과 서버에 보낼수있는 버튼을 생성한다*/
        $(".editBtn").click(function () {
            index = $(this).index(".editBtn");
            console.log(index);
            if($(".editBtn").eq(index) != null){
                $(".removeBtn").eq(index).css("display", "none");
                $(".editBtn").eq(index).css("display", "none");
                $(".content").eq(index).css("display", "none");
                $(".edit-btn-hidden").eq(index).css("display", "inline");
                $('.summernote').eq(index).summernote({
                    height: 80,                 // 에디터 높이
                    minHeight: null,             // 최소 높이
                    maxHeight: null,             // 최대 높이
                    focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
                    lang: "ko-KR",				  // 한글 설정
                });
            }
        });
        $(".edit-btn-hidden").click(function () {
            let content = $('.summernote').eq(index).val();
            $('.hidden-content').eq(index).val(content).val();
        });
    });
</script>

<%-- 댓글 --%>
<ul class="comment">
    <h4 class="title margin20px">답변</h4>
    <%
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        CommentDAO commentDAO = CommentDAO.getInstance();
        List<CommentDTO> comments = commentDAO.getComments(boardNo);
        pageContext.setAttribute("boardNo", boardNo);
        pageContext.setAttribute("comments", comments);
        pageContext.setAttribute("memberId", (String) session.getAttribute("memberId"));
    %>
    <c:forEach items="${comments}" var="comment">
        <li class="comments margin20px">
            <%-- 댓글 작성자 --%>
            <div class="writer margin20px">
                <div class="writer_img"><img src="../icon/user.png" alt="icon"></div>
                <div class="comment_writer_date">
                        <div class="comment_writer">
                            ${comment.writer}
                            <c:if test="${comment.writer.equals(memberId) || isManager == true}">
                                <%-- 댓글 수정--%>
                                <form action="/CommentController?move=edit" method="post">
                                    <input type="hidden" name="commentNo" value="${comment.comment_id}">
                                    <input type="hidden" name="boardNo" value="${comment.boardNo}">
<%--                                    <input type="hidden" name="boardWriter" value="${comment.writer}">--%>
                                    <input type="hidden" name="content" class="hidden-content" value="">
                                    <input type="button" value="수정" class="editBtn">
                                    <input type="submit" value="수정" class="edit-btn-hidden">
                                </form>
                                <%-- 댓글 삭제 --%>
                                <form action="/CommentController?move=remove" method="post">
                                    <input type="hidden" name="commentNo" value="${comment.comment_id}">
                                    <input type="hidden" name="boardNo" value="${comment.boardNo}">
                                    <input type="submit" value="삭제" class="removeBtn">
                                </form>
                            </c:if>
                        </div>
                        <div class="comment_date"><fmt:formatDate value="${comment.reg_date}" pattern="yy-MM-dd kk:mm"/></div>
                </div>
            </div> <br>
            <%-- 댓글 내용 --%>
            <div class="contentBox margin20px">
                <textarea cols="30" rows="10" class="textarea-hidden summernote">${comment.content}</textarea>
                <div class="content">${comment.content}</div>
            </div>
            <hr>
        </li>
    </c:forEach>
    <%-- 댓글 추가 --%>
    <c:choose>
        <c:when test="${memberId == null}">
            <span class="login"><a href="/login/login.jsp">로그인</a> 후에 작성하실수 있습니다</span>
        </c:when>
        <c:otherwise>
            <li class="commentAdd">
                <div class="memberInfo">
                    <form action="/comment/commentAddPro.jsp" method="post">
                        <input type="hidden" name="boardNo" value="${boardNo}">
                        <div class="addWriter">
                            <img src="../icon/user.png" alt="icon">&nbsp;&nbsp;<p class="comment-add-writer">${memberId}</p>
                        </div>
                        <textarea name="addComment" id="summernote" class="margin20px" cols="20" rows="1" placeholder="글 쓰기"></textarea>
                        <div class="btns">
                            <input type="submit" value="등록">
                        </div>
                    </form>
                </div>
            </li>
        </c:otherwise>
    </c:choose>
</ul>