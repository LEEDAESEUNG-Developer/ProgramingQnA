package comment;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CommentDelete", value = "/CommentDelete")
public class CommentDelete extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int commentNo = Integer.parseInt(request.getParameter("commentNo"));
        CommentDAO commentDAO = CommentDAO.getInstance();
        commentDAO.commentsRemoving(commentNo);
        request.getRequestDispatcher("/CommentController?move=board").forward(request, response);
    }
}
