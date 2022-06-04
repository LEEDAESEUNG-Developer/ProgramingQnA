package board;

import comment.CommentDAO;
import utill.DbcpUtill;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

    private static int startRowNum = 0;
    private static int endRowNum = 0;
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private static final BoardDAO instance = new BoardDAO();

    private BoardDAO(){}

    /**
     * BoardDAO를 싱글톤 패턴으로 가지고온다
     *
     * @return BoardDAO 객체 리턴
     */
    public static BoardDAO getInstance(){
        return instance;
    }

    public static BoardDAO getInstance(int startRowNum, int maxRowNum){
        BoardDAO.startRowNum = startRowNum;
        BoardDAO.endRowNum = maxRowNum;
        return instance;
    }
    
    /**
     * 최신순, 조회순으로 가지고 온다
     * 페이징 처리는 필드를 이용하였음
     *
     * @return startRow 번째 ~ pageSize 번째까지 게시판을 반환
     */
    public List<BoardDTO> getAllBoard(String select){
        String sql = "";
        List<BoardDTO> board = new ArrayList<>();
        
        /* 최신순 */
        if(select != null && select.equals("latestPost")){
            sql = "select * from board order by boardNo desc limit ?, ?";
        }

        /* 조회순 */
        if(select != null && select.equals("viewPost")){
            sql = "select * from board order by count desc limit ?, ?";
        }

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startRowNum);
            pstmt.setInt(2, endRowNum);
            rs = pstmt.executeQuery();

            while(rs.next()){
                BoardDTO boardDTO = new BoardDTO();
                boardDTO.setBoardNo(rs.getInt("boardNo"));
                boardDTO.setClassification(rs.getInt("classification"));
                boardDTO.setWriter(rs.getString("writer"));
                boardDTO.setSubject(rs.getString("subject"));
                boardDTO.setContent(rs.getString("content"));
                boardDTO.setCount(rs.getInt("count"));
                boardDTO.setRegDate(rs.getTimestamp("regDate"));
                board.add(boardDTO);
            }

        } catch (NamingException | SQLException e) {
            System.out.println("MemberDAO.getBoard 메소드: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return board;
    }

    /**
     * 게시판 번호를 가지고 게시판의 정보를 가지고 온다
     * @param boardNo 게시판 번호
     * @return 게시판 번호에 충족되는 게시판을 리턴
     */
    public BoardDTO getBoards(int boardNo){
        BoardDTO board = new BoardDTO();
        String sql = "select * from board where boardNo = ?";

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardNo);
            rs = pstmt.executeQuery();

            if(rs.next()){
                board.setBoardNo(rs.getInt("boardNo"));
                board.setClassification(rs.getInt("classification"));
                board.setWriter(rs.getString("writer"));
                board.setSubject(rs.getString("subject"));
                board.setContent(rs.getString("content"));
                board.setCount(rs.getInt("count"));
                board.setRegDate(rs.getTimestamp("regDate"));
            }

        } catch (NamingException | SQLException e) {
            System.out.println("BoardDAO.getBoards 메소드 : " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return board;
    }

    /**
     * 게시판의 분류코드를 가지고 분류명을 가지고 온다
     *
     * @param classification 분류코드
     * @return 분류된 이름를 리턴
     */
    public String getStringClassification(int classification){
        String sql = "select name from classification where No = ?";
        String cfn = "";

        Connection localConn = null;
        PreparedStatement localPstmt = null;
        ResultSet localRs = null;

        try {
            localConn = DbcpUtill.getConnection();
            localPstmt = localConn.prepareStatement(sql);
            localPstmt.setInt(1, classification);
            localRs = localPstmt.executeQuery();
            localRs.next();
            cfn = localRs.getString(1);

        } catch (NamingException | SQLException e) {
            System.out.println("MemberDAO.toStringClassification 메소드: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(localConn, localPstmt, localRs);
        }
        return cfn;
    }

    /**
     * 게시판 전체 수를 가져온다
     *
     * @return 게시판의 전체수 리턴
     */
    public int getBoardCount(){
        String sql = "select count(*) from board";
        int cnt = 1;

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            rs.next();

            cnt = rs.getInt(1);

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return cnt;
    }

    /**
     * 분류번호랑 일치한 게시판을 가지고온다
     *
     * @return 게시판의 전체수 리턴
     */
    public int getBoardCount(int classification){
        String sql = "select count(*) from board where classification = ?";
        int cnt = 0;

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, classification);
            rs = pstmt.executeQuery();
            
            rs.next();
            
            cnt = rs.getInt(1);

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return cnt;
    }

    /**
     * 최근 시간 기준으로 글 5개를 가지고 온다(최신글)
     *
     * @return 최신글 5개 리턴
     */
    public List<BoardDTO> getLatestBoard(){
        List<BoardDTO> board = new ArrayList<>();
        String sql = "select * from board order by regDate desc limit 5";

        try{
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()){
                BoardDTO boardDTO = new BoardDTO();
                boardDTO.setBoardNo(rs.getInt("boardNo"));
                boardDTO.setClassification(rs.getInt("classification"));
                boardDTO.setWriter(rs.getString("writer"));
                boardDTO.setSubject(rs.getString("subject"));
                boardDTO.setContent(rs.getString("content"));
                boardDTO.setCount(rs.getInt("count"));
                boardDTO.setRegDate(rs.getTimestamp("regDate"));
                board.add(boardDTO);
            }

        } catch (NamingException | SQLException e) {
            System.out.println("MemberDAO.latestBoard 메소드(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return board;
    }

    /**
     * 인기글 5개 가지고 온다
     * 조회수가 가장 많은 기준
     * < 개선이 필요함 >
     *
     * @return 인기글 5개 리턴
     */
    public List<BoardDTO> getPopularBoard(){
        List<BoardDTO> board = new ArrayList<>();
        String sql = "select * from board order by count desc limit 5";

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()){
                BoardDTO boardDTO = new BoardDTO();
                boardDTO.setBoardNo(rs.getInt("boardNo"));
                boardDTO.setClassification(rs.getInt("classification"));
                boardDTO.setWriter(rs.getString("writer"));
                boardDTO.setSubject(rs.getString("subject"));
                boardDTO.setContent(rs.getString("content"));
                boardDTO.setCount(rs.getInt("count"));
                boardDTO.setRegDate(rs.getTimestamp("regDate"));
                board.add(boardDTO);
            }

        } catch (NamingException | SQLException e) {
            System.out.println("MemberDAO.latestBoard 메소드: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return board;
    }

    /**
     * QnA 게시글을 가지고 온다
     *
     * @return QnA 게시글 리턴
     */
    public List<BoardDTO> getQnABoards(String select) {
        List<BoardDTO> board = new ArrayList<>();
        String sql = "select * from board where classification = 10 order by boardNo desc limit ?, ?";

        /* 최신순 */
        if(select != null && select.equals("latestPost")){
            sql = "select * from board where classification = 10 order by boardNo desc limit ?, ?";
        }

        /* 조회순 */
        if(select != null && select.equals("viewPost")){
            sql = "select * from board where classification = 10 order by count desc limit ?, ?";
        }

        try{
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startRowNum);
            pstmt.setInt(2, endRowNum);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardDTO boardDTO = new BoardDTO();
                boardDTO.setBoardNo(rs.getInt("boardNo"));
                boardDTO.setClassification(rs.getInt("classification"));
                boardDTO.setWriter(rs.getString("writer"));
                boardDTO.setSubject(rs.getString("subject"));
                boardDTO.setContent(rs.getString("content"));
                boardDTO.setCount(rs.getInt("count"));
                boardDTO.setRegDate(rs.getTimestamp("regDate"));
                board.add(boardDTO);
            }

        } catch (NamingException | SQLException e) {
            System.out.println("MemberDAO.getQnABoard 메소드: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return board;
    }

    /**
     * 커뮤니티 게시글를 가지고 온다
     *
     * @return 커뮤니티 게시글 리턴
     */
    public List<BoardDTO> getCommunityBoards(String select){
        List<BoardDTO> board = new ArrayList<>();
        String sql = "select * from board where classification = 20 order by boardNo desc limit ?, ?";

        /* 최신순 */
        if(select != null && select.equals("latestPost")){
            sql = "select * from board where classification = 20 order by boardNo desc limit ?, ?";
        }

        /* 조회순 */
        if(select != null && select.equals("viewPost")){
            sql = "select * from board where classification = 20 order by count desc limit ?, ?";
        }

        try{
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startRowNum);
            pstmt.setInt(2, endRowNum);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardDTO boardDTO = new BoardDTO();
                boardDTO.setBoardNo(rs.getInt("boardNo"));
                boardDTO.setClassification(rs.getInt("classification"));
                boardDTO.setWriter(rs.getString("writer"));
                boardDTO.setSubject(rs.getString("subject"));
                boardDTO.setContent(rs.getString("content"));
                boardDTO.setCount(rs.getInt("count"));
                boardDTO.setRegDate(rs.getTimestamp("regDate"));
                board.add(boardDTO);
            }

        } catch (NamingException | SQLException e) {
            System.out.println("BoardDAO.getChatBoard 메소드: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return board;

    }

    /**
     * 게시판에 조회수를 1씩 증가시킨다
     *
     * @param boardNO 게시판번호
     */
    public void boardCountOnePlus(int boardNO){
        String sql = "update board set count = ? where boardNo = ?";
        BoardDTO boards = getBoards(boardNO);
        int count = boards.getCount() + 1;

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, count);
            pstmt.setInt(2, boardNO);
            pstmt.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt);
        }
    }

    /**
     * 데이터베이스에 게시글을 등록한다
     *
     * @param board
     * @return 작성완료 1, 작성실패 0
     */
    public int addBoard(BoardDTO board){
        String sql = "insert into board(classification, writer, subject, content) values(?, ?, ?, ?)";
        int sqlCnt = 0;
        
        try{
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, board.getClassification());
            pstmt.setString(2, board.getWriter());
            pstmt.setString(3, board.getSubject());
            pstmt.setString(4, board.getContent());

            sqlCnt = pstmt.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt);
        }
        return sqlCnt;
    }

    /**
     * 게시판 수정
     * 
     * @param board 수정페이지에서 분류번호, 제목, 내용
     * @return 수정완료 1, 수정 실패 0
     */
    public int editBoard(BoardDTO board){
        String sql = "update board set classification = ?, subject = ?, content = ? where boardNo = ?";
        int sqlCnt = 0;

        System.out.println("editBoard 메소드 : " + board);

        try{
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, board.getClassification());
            pstmt.setString(2, board.getSubject());
            pstmt.setString(3, board.getContent());
            pstmt.setInt(4, board.getBoardNo());
            
            sqlCnt = pstmt.executeUpdate();
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt);
        }
        return sqlCnt;
    }

    /**
     * 게시판 번호를 가지고 게시판을 삭제하는 메소드
     *
     * @param boardNo 게시판번호
     */
    public void deleteBoard(int boardNo) {
        CommentDAO commentDAO = CommentDAO.getInstance();
        String sql = "delete from board where boardNo = ?";
        int cnt = 0;

        // 댓글 삭제
        commentDAO.boardAllCommentRemoving(boardNo);

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardNo);
            pstmt.executeUpdate();
            
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt);
        }
    }
    
}