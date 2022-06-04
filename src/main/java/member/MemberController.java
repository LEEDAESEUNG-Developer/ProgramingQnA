package member;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "MemberController", value = "/MemberController")
public class MemberController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        urlMove(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        urlMove(request, response);
    }

    private void urlMove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String getUrl = request.getParameter("url");
        String url = "/index.jsp";
        MemberEditModel memberEditModel = new MemberEditModel(request, response);

        if (sessionCheck(request)) {
            if(getUrl.equals("memberInfoEdit")){
                url = "/login/memberInfoEdit.jsp";
                request.setAttribute("memberInfo", memberEditModel.getMember());
            } else if(getUrl.equals("memberInfoPro")){
                memberEditModel.changeMember();
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
        dispatcher.forward(request, response);
    }

    private boolean sessionCheck(HttpServletRequest request){
        return ((String) request.getSession().getAttribute("memberId") != null);
    }
}
