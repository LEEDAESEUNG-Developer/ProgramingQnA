package comment;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Map;

@WebServlet(name = "CommentController", value = "/CommentController")
public class CommentController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        location(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        location(request, response);
    }

    public void location(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String getUrlPara = request.getParameter("move");
        String boardNo = request.getParameter("boardNo");
        String moveUrl = "";

        if(getUrlPara.equals("remove")){
            moveUrl = "/CommentDelete";
            RequestDispatcher requestDispatcher = request.getRequestDispatcher(moveUrl);
            requestDispatcher.forward(request, response);
        } else if(getUrlPara.equals("edit")){
            moveUrl = "/CommentEdit";
            RequestDispatcher requestDispatcher = request.getRequestDispatcher(moveUrl);
            requestDispatcher.forward(request, response);
        }else if(getUrlPara.equals("board")){
            moveUrl = "/board/communication.jsp?boardNo=" + boardNo;
            response.sendRedirect(moveUrl);
        }
    }
}
