/* 기존 테이블에 새로운 컬럼을 추가 쿼리문)
    alter table 테이블명 add(추가할 컬럼명 자료형(크기)); */
    
create table emp21(
empno number(38) primary key -- 사원번호 
,ename varchar2(30) -- 사원명
,sal number(38) -- 급여
);

 describe emp21; --emp21 테이블 구조 확인 명령어
 desc emp21; --describe 를 줄여서 desc로 테이블 구조를 확인
 
 --emp21 테이블에 job 컬럼을 추가
 alter table emp21 add(job varchar2(50));
 
 --추가된 job컬럼 크기를 50에서 30으로 변경
 alter table emp21 modify(job varchar2(30));
 
 alter table emp21 drop column job; --job 컬럼 삭제

 /* truncate table 테이블명; 으로 테이블의 전체행 레코드를 삭제한다.*/
 insert into emp21 values(11,'홍길동',2000);
 insert into emp21 values(12,'신사임당',3000);
 select * from emp21 order by empno desc;
 
 delete from emp21 where empno=11; --원하는 레코드만 삭제가능 오토커밋이라 잘못삭제해도 복구가능
 truncate table emp21; --emp21테이블의 전체 레코드를 삭제
 
 rename emp21 to emp21_test; --emp21 테이블명을 emp21_test테이블명으로 변경
 select * from emp21_test;
 
 drop table emp21_test;--emp21_test 테이블 삭제
 
 --현재 접속중인 사용자로 사용 가능한 테이블명을 알고자 하는 경우
 select table_name from user_tables order by table_name asc;
 
 











































 