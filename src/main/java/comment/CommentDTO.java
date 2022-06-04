package comment;

import java.sql.Timestamp;

public class CommentDTO {
    private int comment_id;
    private String writer;
    private String content;
    private Timestamp reg_date;
    private Timestamp edit_date;
    private int boardNo;

    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getReg_date() {
        return reg_date;
    }

    public void setReg_date(Timestamp reg_date) {
        this.reg_date = reg_date;
    }

    public Timestamp getEdit_date() {
        return edit_date;
    }

    public void setEdit_date(Timestamp edit_date) {
        this.edit_date = edit_date;
    }

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    @Override
    public String toString() {
        return "CommentDTO{" +
                "comment_id=" + comment_id +
                ", writer='" + writer + '\'' +
                ", content='" + content + '\'' +
                ", reg_date=" + reg_date +
                ", edit_date=" + edit_date +
                ", boardNo=" + boardNo +
                '}';
    }
}
