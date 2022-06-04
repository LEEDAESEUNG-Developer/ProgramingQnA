/*
< 게시판 테이블 설계 >
1. 게시판 프로젝트의 테이블
- member, board, classification, comment
- 5개 테이블 활용

(1) member 테이블
- 회원 정보 테이블
- 필드 구성 -> 작성자, 아이디, 비밀번호, 이메일, 매니저유무, 생성일
- 기능: 회원가입, 회원 확인, 회원 수정, 회원 삭제(게시판글 삭제)
- 로그인, 로그아웃

-- writer:      작성자, varchar(10), primary key
-- memberId:    아이디, varcahr(40), unique
-- memberPwd:   비밀번호, varchar(18), not null
-- email:       에미일, varchar(40), not null
-- isManager    매니저유무, boolean, default false
-- regDate      회원가입일자, default not()

(2) board 테이블
- 게시글 테이블
- 필드 구성 -> 게시판 번호, 분류, 작성자, 제목, 내용, 조회수, 생성일
- 기능: 조회, 생성, 삭제
-- boardNo          : 번호, int, pk, auto_increment
-- classification   : 분류 코드, int, references classification (No)
-- writer           : 작성자, varchar(45), not null
-- subject          : 제목, varchar(45), not null
-- content          : 내용, longtext, not null
-- count            : 조회수, int
-- regDate          : 생성일, default now()

(3) classification
- 게시판 분류 코드
- 필드 구성 -> 게시판 번호, 분류 이름
-- No   : 게시판번호, int, primary key
-- name : 이름, varchar20), not null

(4) comment
-- content      : 댓글, varchar(45)
-- reg_date     : 댓글 생성일, default now()
-- boardNo_fk   : 게시판번호, int, references board (boardNo)

웹 사이트 기능 설계
공통 기능: 로그인, 회원찾기, 회원가입, QnA(게시판), 수다(게시판), 게시글 파일첨부(생각만), 댓글

*/
