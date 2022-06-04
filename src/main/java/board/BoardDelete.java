package board;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "BoardDelete", value = "/BoardDelete")
public class BoardDelete extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BoardDeleteModel boardDelete = new BoardDeleteModel(req, resp);

        boardDelete.delete();

    }

}
