package board;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class BoardDeleteModel {

    private HttpServletRequest request;
    private HttpServletResponse response;

    private final BoardDAO boardDAO;
    private final String memberId;
    private final int boardNo;

    public BoardDeleteModel(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        boardDAO = BoardDAO.getInstance();
        boardNo =  Integer.parseInt(request.getParameter("boardNo"));
        memberId = (String) request.getSession().getAttribute("memberId");
    }

    private PrintWriter getResponsePrint(){
        PrintWriter writer = null;
        response.setContentType("text/html; charset=UTF-8;");
        response.setCharacterEncoding("utf-8");
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return writer;
    }

    /**
     * 게시판 작성자와 로그인 사용자와 검증을 한다
     * @return 둘다 맞으면 T, 아니면 F
     */
    private boolean isWriter(){
        BoardDTO board = boardDAO.getBoards(boardNo);
        return (board.getWriter().equals(memberId));
    }

    /**
     * 로그인 된 사용자가 작성자가 아닐때
     */
   /* private boolean notWriterPrint() {
        PrintWriter printWriter = getResponsePrint();
        printWriter.println("<script>");
        if (isWriter() || isManager()) {
            printWriter.print("location = '/BoardController?url=index;");
            printWriter.println("</script>");
        } else {
            printWriter.println("alert('사용하실수 없습니다');");
            printWriter.print("location = '/BoardController?url=index';");
            printWriter.println("</script>");
        }
    }*/

    /**
     * 현재 로그인된 사용자가 매니저인지 확인
     * @return 매니저 T, 일반 F
     */
    private boolean isManager(){
        return (Boolean) request.getSession().getAttribute("isManager");
    }

    /**
     * 작성자가 맞다면 삭제한다
     */
    private void deleteProcess(){
        if(isWriter() || isManager()) boardDAO.deleteBoard(boardNo);
    }

    /**
     * 삭제 메서드
     */
    public void delete() throws ServletException, IOException {
        deleteProcess();
        request.getRequestDispatcher("/BoardController?url=index").forward(request, response);
    }

}
