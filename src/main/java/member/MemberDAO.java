package member;

import utill.DbcpUtill;
import utill.JdbcUtill;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {

    // dbcp에 관련된 코드
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // 싱글톤 패텬
    private MemberDAO(){}

    private final static MemberDAO instance = new MemberDAO();

    public static MemberDAO getInstance(){
        return instance;
    }


    // 로그인 기능 메소드,

    /**
     * 로그인 -> ID,PWD를 가지고 회원을 확인한다.
     *
     * @param id 아이디
     * @param pwd 비밀번호
     * @return 실패 -1, 성공 0, 매니저 성공 1
     */
    public int isMemberLogin(String id, String pwd){
        String sql = "select * from member where memberId = ? and memberPwd = ?";

        int loginCount = -1;

        try{
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            rs = pstmt.executeQuery();

            if (rs.next()) {  // 일반 사용자 로그인 성공
                loginCount = 0;

                Boolean isManager = rs.getBoolean(5); // 관리자(true), 비관리자(false)
                if(isManager) loginCount = 1;

            } else {
                loginCount = -1; // 로그인 실패
            }

        } catch (Exception e){
            System.out.println("memberDAO.memberLogin 메소드: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt);
        }
        return loginCount;
    }

    /**
     * 닉네임 사용중인지 아닌지 체크한다.
     *
     * @param writer 작성자
     * @return 사용 0, 사용불가 1
     */
    public int isConfirmWriter(String writer){
        String sql = "select * from member where writer = ?";
        int isChk = 0;

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, writer);
            rs = pstmt.executeQuery();
            
            if(rs.next()) isChk = 1;
            else isChk = 0;
            
        } catch (NamingException | SQLException e) {
            System.out.println("MemberDAO.isWriter 메소드: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }
        
        return isChk;
    }

    /**
     * 아이디 사용중인지 아닌지 체크한다.
     * @param id 아이디
     * @return 사용 0, 사용불가 1
     */
    public int isConfirmId(String id){
        String sql = "select * from member where memberId = ?";
        int isChk = 0;

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if(rs.next()) isChk = 1;
            else isChk = 0;

        } catch (NamingException | SQLException e) {
            System.out.println("MemberDAO.confirmId 메소드: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt, rs);
        }

        return isChk;
    }

    /**
     * 작성자, 아이디, 비밀번호, 이메일 회원가입한다
     * @param writer 작성자
     * @param id 아이디
     * @param pwd 비밀번호
     * @param email 이메일
     * @return 완료시 1, 실패 0
     */
    public int register(String writer, String id, String pwd, String email){
        String sql = "insert into member(writer, memberId, memberPwd, email) values(?, ?, ?, ?)";
        int queryCnt = 1;
        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, writer);
            pstmt.setString(2, id);
            pstmt.setString(3, pwd);
            pstmt.setString(4, email);
            queryCnt = pstmt.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtill.close(conn, pstmt);
        }
        return queryCnt;
    }

    public void editMember(MemberDTO member) {
        String sql = "update member set writer = ?, memberPwd = ?, email = ? where memberId = ?";

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member.getWriter());
            pstmt.setString(2, member.getMemberPwd());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getMemberId());
            pstmt.executeUpdate();

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            DbcpUtill.close(conn, pstmt);
        }
    }

    /**
     * 사용자 계정을 가지고온다
     * 
     * @param memberId 현재 로그인된 아이디
     */
    public MemberDTO getMember(String memberId){
        MemberDTO member = new MemberDTO();
        String sql = "select * from member where memberId = ?";

        try {
            conn = DbcpUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();
            member = processingMember(rs);

        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtill.close(conn, pstmt, rs);
        }
        return member;
    }

    /**
     * db 결과를 멤버객체로 담아서 반환한다
     * @param rs Result 객체
     * @return 멤버객체로 변환
     */
    private MemberDTO processingMember(ResultSet rs) {
        MemberDTO member = new MemberDTO();
        try {
            if (rs.next()) {
                member.setWriter(rs.getString("writer"));
                member.setMemberId(rs.getString("memberId"));
                member.setMemberPwd(rs.getString("memberPwd"));
                member.setEmail(rs.getString("email"));
                member.setManager(rs.getBoolean("isManager"));
                member.setRegDate(rs.getTimestamp("regDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return member;
    }
}
