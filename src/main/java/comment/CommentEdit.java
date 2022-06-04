package comment;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet(name = "CommentEdit", value = "/CommentEdit")
public class CommentEdit extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        int commentNo = Integer.parseInt(request.getParameter("commentNo"));
        String content = request.getParameter("content");
        String memberId = (String) request.getSession().getAttribute("memberId");
//        boolean manager = (boolean) request.getSession().getAttribute("isManager");
        CommentDTO comment = new CommentDTO(); // 파라미터를 담을 코멘트
        CommentDAO commentDAO = CommentDAO.getInstance();
        // 댓글 번호를 가지고 게시판을 가지고 온다
        CommentDTO getComment = commentDAO.getComment(commentNo);

        comment.setComment_id(getComment.getComment_id());
        comment.setContent(content);

        /**
         * 현재 세션과 코멘트 작성자 비교
         * 맞으면 수정을 한다
         */
        if(getComment.getWriter().equals(memberId)){
            commentDAO.editCommetns(comment);
        }
        request.getRequestDispatcher("/CommentController?move=board").forward(request, response);
    }
}
