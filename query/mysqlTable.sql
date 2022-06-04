use programingQnA;

-- 테이블 생성
create table member
(
    writer    varchar(10) primary key comment '작성자',
    memberId  varchar(40) unique comment '아이디',
    memberPwd varchar(18) not null comment '비밀번호',
    email     varchar(40) not null comment '이메일',
    isManager boolean  default false comment '매니저 인지 아닌지',
    regDate   DATETIME default now() comment '회원가입 일자'
);


create table board
(
    boardNo        int primary key auto_increment comment '게시판 번호',
    classification int comment '게시판 분류',
    writer         varchar(10) comment '글 작성자',
    subject        varchar(45) not null comment '제목',
    content        longtext    not null comment '내용',
    count          int comment '게시판 조회수',
    regDate        datetime default now() comment '게시판 생성 일',
    foreign key (classification) references classification (No)
);

create table classification
(
    No   int primary key comment '분류 번호',
    name varchar(20) not null comment '분류 이름'
);

create table comment
(
    comment_id int auto_increment primary key,
    writer     varchar(10) not null,
    content    longtext    not null,
    reg_date   datetime default now(),
    edit_date  datetime,
    boardNo_fk int,
    foreign key comment (boardNo_fk) references board (boardNo)
);

show tables;
