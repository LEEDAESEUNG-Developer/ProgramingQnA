package board;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "BoardController", value = "/BoardController")
public class BoardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        redirect(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        redirect(req, resp);
    }

    private void redirect(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String url = request.getParameter("url");
        String responseUrl = "";

        response.setCharacterEncoding("utf-8");

        if(url.equals("BoardDelete")){
            responseUrl = "/BoardDelete";
            RequestDispatcher dispatcher = request.getRequestDispatcher(responseUrl);
            dispatcher.forward(request, response);
        } else if (url.equals("index")) {
            responseUrl = "/index.jsp";
            response.sendRedirect(responseUrl);
        }

    }
}
