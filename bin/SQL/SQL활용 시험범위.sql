/*1번) boardT10 게시판 테이블 b_no 컬럼에는 오라클 시퀀스로부터 생성된 정수형 번호값을 저장하고 있습니다. 이 컬럼에 게시판 번호값 
2,3중 한 개라도 있어면 조회되는 검색쿼리문을 2가지만 작성해 보세요.*/
select * from boardT10 where b_no=2 or b_no=3;
select * from boardT10 where b_no in (2,3);

/*2번) 오라클에서 한 개의 테이블에 대해 데이터를 삽입,수정,삭제하는 DML 데이터 조작어를 작성할 수 있어야 합니다. board_name, board_title, board_cont,board_date 
컬럼에 '홍길동','게시판제목','게시판내용‘,sysdate 오라클 날짜 함수로 등록날짜 레코드를 저장할 수 있는 boardT10테이블을 생성하고 레코드 하나를 insert합니다.

이순신 개발자가 실수로 boardT10 게시판 테이블의 글쓴이(컬럼명 board_name) 전체를 ‘강감찬’으로 수정할려고 합니다. 
이에 대한 잘못된 수정쿼리문을 작성하시고,테이블 생성문,저장문도 함께 작성하세요.
작성 수행순서)
            1. boardT10테이블 생성문 작성 기술
            2. 레코드 저장문 작성 기술
            3. 수정문 작성 기술
*/
    --1.boardT10 테이블 생성문
    create table boardT10(
    board_name varchar2(50) --홍길동
    ,board_title varchar2(50) --게시판제목
    ,board_cont varchar2(50) --게시판내용
    ,board_date date --등록날짜
    );
    --2.레코드 저장문
    insert into boardT10 (board_name,board_title,board_cont,board_date) values('홍길동','게시판제목','게시판내용',sysdate);
    insert into boardT10 values('홍길동','게시판제목','게시판내용',sysdate);
--    delete from boardT10 where board_name='강감찬';
--    select * from boardT10;
    
    --3.수정문
    update boardT10 set board_name='강감찬';

/*3번) depart10 강의실 테이블과 student10 학생테이블은 room_num 컬럼을 공통 컬럼으로 같은 강의실 호수 레코드값을 공유하고 있습니다. 
  두 테이블을 참고하여 on 조건절을 사용하여 미국 표준협회에서 제정한 inner join 기술하세요.
*/
--  create table depart10(
--  room_num number(38)
--  );
--  create table student10 as select * from depart10;
  
  select * from depart10 inner join student10 on depart10.room_num = student10.room_num;
  

--4번) 오라클에서 게시판 등록날짜 저장용도 등으로 활용되는 날짜함수를 출력되게 하는 기본 쿼리문을 작성하시오.
select sysdate from dual;
select sysdate as "날짜 함수" from dual;

/*5번) 오라클에서 사용자를 생성하면 DB서버에 접속할 수 있는 권한 부여와 자원을 사용할 수 있어야 합니다. 
이러한 여러개의 권한을 하나의 그룹으로 묶어서 처리하면 쉽게 권한을 한꺼번에 할당할 수 있습니다. 
이것을 롤이라고 합니다. 그러면 생성된 오라클 사용자를 day10라고 했을 때 오라클 연결과 자원 사용 
시스템 롤(오라클 설치할 때 미리 생성되는 권한 롤) 권한할당 DCL 명령어 작성하세요.
*/
GRANT CONNECT, resource to day10;
commit;