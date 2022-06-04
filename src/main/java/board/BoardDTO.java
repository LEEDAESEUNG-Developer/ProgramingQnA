package board;

import java.sql.Timestamp;

public class BoardDTO {
    private int boardNo;
    private int classification;
    private String writer;
    private String subject;
    private String content;
    private int count;
    private Timestamp regDate;

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public int getClassification() {
        return classification;
    }

    public void setClassification(int classification) {
        this.classification = classification;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }

    @Override
    public String toString() {
        return "BoardDTO{" +
                "boardNo=" + boardNo +
                ", classification=" + classification +
                ", writer='" + writer + '\'' +
                ", subject='" + subject + '\'' +
                ", content='" + content + '\'' +
                ", count=" + count +
                ", regDate=" + regDate +
                '}';
    }
}
