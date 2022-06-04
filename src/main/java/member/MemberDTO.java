package member;

import java.sql.Timestamp;

public class MemberDTO {
    private String writer;
    private String memberId;
    private String memberPwd;
    private String email;
    private Boolean isManager;
    private Timestamp regDate;

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getMemberPwd() {
        return memberPwd;
    }

    public void setMemberPwd(String memberPwd) {
        this.memberPwd = memberPwd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isManager() {
        return isManager;
    }

    public void setManager(boolean manager) {
        isManager = manager;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }

    @Override
    public String toString() {
        return "memberDTO{" +
                "writer='" + writer + '\'' +
                ", memberId='" + memberId + '\'' +
                ", memberPwd='" + memberPwd + '\'' +
                ", email='" + email + '\'' +
                ", isManager=" + isManager +
                ", regDate=" + regDate +
                '}';
    }
}
