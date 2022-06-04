use programingQnA;

-- member 테이블에 값을 추가하기
insert into member(writer, memberId, memberPwd, email)
values ('탄소',
        'tan10',
        '1234',
        'tan10@naver.com');
insert into member(writer, memberId, memberPwd, email, isManager)
values ('관리자',
        'admin',
        '1234',
        'admin@naver.com',
        true);

-- board 테이블에 값을 넣음
insert into board(classification, writer, subject, content, count)
values (10, 'admin', '자바 예외처리1', '자바 예외처리 할 때 에러가 발생', 10);
insert into board(classification, writer, subject, content)
values (10, 'admin', '자바 예외처리2', '자바 예외처리 할 때 에러가 발생');

insert into board(classification, writer, subject, content)
values (20, 'admin', '푸하하하', '빨래 널기 싫다');

insert into board(classification, writer, subject, content)
values (20, 'admin', 'JDBC에러', 'JDBC에러가 발생했습니다 도와주세요.');

insert into board(classification, writer, subject, content, count)
values (20, 'admin', '푸하하하', '빨래 널기 싫다', 4);

insert into board(classification, writer, subject, content, count)
values (20, 'tan10', '푸하하하', '빨래 널기 싫다', 4);

insert into board(classification, writer, subject, content, count)
values (20, 'tan10', 'lorem', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aut consequatur dolorem dolorum, eveniet illum incidunt labore libero molestiae mollitia nemo quas quos reprehenderit repudiandae suscipit totam voluptas.', 4);

insert into comment(writer, content, boardNo_fk) values
(
'admin',
'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aut consequatur dolorem dolorum, eveniet illum incidunt labore libero molestiae mollitia nemo quas quos reprehenderit repudiandae suscipit totam voluptas.',
359
);

-- board 분류 추가
insert into classification
values (20, '수다');

-- 테이블 확인
select * from member;

select * from board;

select * from classification;

select * from comment;

select * from board order by count desc limit 5;

/* 사이즈 구하기 */
select content, length(content) from board where boardNo = 75;
select content, length(content) from board where boardNo = 73;

delete from comment where boardNo_fk = 363;
delete from board where boardNo = 363;



