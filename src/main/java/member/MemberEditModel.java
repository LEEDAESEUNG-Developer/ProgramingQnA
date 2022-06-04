package member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberEditModel {

    /**
     * 세션 아이디로 회원 정보를 가지고 오기
     */
    private final HttpServletRequest request;
    private final HttpServletResponse response;
    private final String memberId;
    private final MemberDAO memberDAO;

    public MemberEditModel(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        memberId = (String) this.request.getSession().getAttribute("memberId");
        memberDAO = MemberDAO.getInstance();
    }

    public MemberDTO getMember(){
        return memberDAO.getMember(memberId);
    }

    /**
     * 파라미터 값들을 db에 맞게 데이터 가공
     * @return 멤버를 반환
     */
    public MemberDTO memberProcessing(){
        MemberDTO memberDTO = new MemberDTO();

        memberDTO.setWriter(request.getParameter("writer"));
        memberDTO.setMemberId((String) request.getSession().getAttribute("memberId"));
        memberDTO.setMemberPwd(request.getParameter("pwd"));
        memberDTO.setEmail(request.getParameter("email"));

        return memberDTO;
    }

    public void changeMember(){
        MemberDTO memberDTO = memberProcessing();
        memberDAO.editMember(memberDTO);
    }


}
