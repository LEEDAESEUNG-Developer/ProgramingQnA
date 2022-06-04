package comment;

import utill.DbcpUtill;
import utill.JdbcUtill;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private final static CommentDAO instance = new CommentDAO();

    /* 싱글톤 패턴: 객체하나만 만들수 있음 */
    private CommentDAO(){}

    public static CommentDAO getInstance(){
        return instance;
    }

    /**
     * 게시판 번호로 댓글을 가지고 온다.
     * 순서는 먼저 만든순으로 간다 즉 숫자는 낮은순에서 큰순으로 간다
     */
    public List<CommentDTO> getComments(int boardNo){
        String sql = "select * from comment where boardNo_fk = ?";
        List<CommentDTO> commentList = new ArrayList<>();
        
        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardNo);
            rs = pstmt.executeQuery();
            
            while(rs.next()){
                commentList.add(databaseConversionDTO(rs));
            }

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return commentList;
    }
    
    public CommentDTO getComment(int commendNo){
        CommentDTO comment = null;
        String sql = "select * from comment where comment_id = ?";

        try{
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commendNo);
            rs = pstmt.executeQuery();
            if(rs.next()){
                comment = databaseConversionDTO(rs);
            }
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        return comment;
    }

    /**
     * 게시판 추가하기
     */
    public void addComment(CommentDTO comment){
        String sql = "insert into comment(writer, content, boardNo_fk) values(?, ?, ?)";

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, comment.getWriter());
            pstmt.setString(2, comment.getContent());
            pstmt.setInt(3, comment.getBoardNo());

            pstmt.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtill.close(conn, pstmt);
        }
    }

    /**
     * 댓글 수정
     */
    public void editCommetns(CommentDTO comment){
        String sql = "update comment set content = ? where comment_id = ?";
        try{
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, comment.getContent());
            pstmt.setInt(2, comment.getComment_id());
            pstmt.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt);
        }
    }

    /**
     * 댓글 삭제한다
     * @param commentNo 댓글 번호
     */
    public void commentsRemoving(int commentNo){
        String sql = "delete from comment where comment_id = ?";
        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commentNo);
            pstmt.executeUpdate();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt);
        }
    }

    /**
     * 게시판에 있는 댓글을 모두 삭제한다
     * @param boardNo 게시판 번호
     */
    public void boardAllCommentRemoving(int boardNo){
        /* 객체를 따로 만든 이유 BoardDAO에서도 이 메소드를 사용하는데 close가 되버리면 이 메소드가 강제 종료되기 때문이다*/
        Connection localConn;
        PreparedStatement localPstmt;
        String sql = "delete from comment where boardNo_fk = ?";

        try {
            localConn = DbcpUtill.getConnection();
            localPstmt = localConn.prepareStatement(sql);
            localPstmt.setInt(1, boardNo);
            localPstmt.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * select 결과값을 처리하는 메소드 (?)
     * @param rs
     * @return
     */
    private CommentDTO databaseConversionDTO(ResultSet rs) {
        CommentDTO comment = new CommentDTO();
        try {
            comment.setComment_id(rs.getInt("comment_id"));
            comment.setWriter(rs.getString("writer"));
            comment.setContent(rs.getString("content"));
            comment.setReg_date(rs.getTimestamp("reg_date"));
            comment.setEdit_date(rs.getTimestamp("edit_date"));
            comment.setBoardNo(rs.getInt("boardNo_fk"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comment;
    }
}
