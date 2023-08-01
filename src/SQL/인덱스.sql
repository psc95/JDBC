/* 
 오라클에서 인덱스를 사용하는 목적: 보다 더 빠른 검색을 위해서 이다.
 테이블 생성시 기본키 또는 유일키 제약조건을 설정하면 오라클에서 해당 컬럼에 기본으로 인덱스를 생성해 준다.
*/
create table emp201(
 empno number(38) primary key
 ,ename varchar2(100)
 ,sal number(38)
 );
 insert into emp201 values(11,'홍길동',100);
 insert into emp201 values(12,'이순신',200);
 insert into emp201 values(13,'강감찬',300);
 
 select * from emp201;
 
 --서브쿼리로 복제본 테이블 emp202을 생성
 create table emp202
 as
 select * from emp201; --복제본 테이블 emp202에는 인덱스는 복제되지 않는다.

 select table_name,index_name,column_name from user_ind_columns
 where table_name in('EMP201','EMP202'); 
 /* INDEX_NAME컬럼에는 인덱스명이 저장되어 있고, emp201원본테이블의 기본키로 설정된 empno컬럼에만 오라클에서 제공한 기본
    인덱스가 설정되어 있다. 결국 복제본 테이블에는 원본의 인덱스까지는 복제되지 않는다는 것을 알수 있다.
*/
select * from emp202; --emp202 복제테이블에는 원본테이블의 기본키 제약조건도 복제되지 않는다.

--서브쿼리로 중복사원번호 저장
insert into emp202
select * from emp202;

--emp202 복제테이블의 ename컬럼에 인덱스 설정
create index idx_emp202_ename
on emp202(ename);

--emp202 복제테이블의 empno컬럼에 인덱스 설정
create index idx_emp202_empno
on emp202(empno);

--emp202테이블에 생성된 idx_emp202_empno 인덱스를 삭제
drop index idx_emp202_empno;
drop index idx_emp202_ename;

commit;

--where 조건절을 거짓으로 해서 테이블 구조만 복제하고 레코드는 복제하지 않는다. 복제되는 테이블에는 제약조건과 인덱스는 복제되지 않는다.
create table emp203
as
select * from emp202 where 10=0;

select * from emp203;

insert into emp203 values(11,'신사임당님',1000);
insert into emp203 values(12,'홍길동',2000);
insert into emp203 values(13,'강감찬',3000);

commit;

--중복번호가 없는 empno컬럼에 고유 인덱스를 설정
create unique index idx_emp203_empno on emp203(empno);

update emp203 set ename='신사임당님' where empno=13;

--중복 사원이름이 있는 ename컬럼에 고유 인덱스를 설정
create unique index idx_emp203_ename on emp203(ename); --에러 발생

--중복 레코드가 있는 ename 컬럼에 비고유 인덱스를 설정
create index idx_emp203_ename on emp203(ename);

select * from emp;

--night계정으로 user01사용자에게 할당된 권한등을 조회
select grantee, table_name, grantor, privilege from user_tab_privs_made;
/* grantee 컬럼 : 권한이 할당된 사용자명
    table_name : 권한이 할당된 테이블명
    grantor : 권한을 준 사용자명
    privilege : 주어진 권한 
*/
revoke select on emp from user01; --user01사용자에게 night소유의 emp테이블의 검색권한을 철회한다.

/*
    1.권한 할당 명령어 : grant
    2.권한 취소 명령어 : revoke
*/
select dname from dept;



















