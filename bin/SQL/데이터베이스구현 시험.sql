/*1번 문제 ) 테이블명: guestbook
  컬럼명: g_no, g_name, g_title, g_cont, g_date
  자료형과 크기: number(38), varchar2(50), varchar2(200),varchar2(4000),date
  제약조건: primary key, not null, not null, not null, null */
create table guestbook(
    g_no number(38) primary key
    ,g_name varchar2(50) not null
    ,g_title varchar2(200) not null
    ,g_cont varchar2(4000) not null
    ,g_date date null
    );
    
/*2번 문제) 작업절차) 1. night13 테이블 스페이스명 생성 기술
                  2. 오라클 11g 이전 방식으로 되돌려 주는 명령문 기술
                  3. night13 오라클 사용자와 비밀번호 night13 생성 기술
                4. grant 권한 부여
                5. connect 명령어로 오라클 DB서버 접속
                6. show 명령어로 접속한 사용자 확인 */    
/* 풀이 1)sqlplus / as sysdba
create tablespace night13
datafile ‘C:\app\user\product\21c\oradata\XE\night13.dbf’ size 200M;

 2)alter session set "_ORACLE_SCRIPT"=true;

3)create user night13
2 identified by night13
3 default tablespace night13
4 quota UNLIMITED ON night13;

4)GRANT connect, resource TO night13;

5)conn night13/night13;

6)show user; */

/* 3번문제) 다음과 같은 emp테이블을 생성합니다.
컬럼명 데이터타입 길이 제약조건 컬럼설명
empno number 10 primary key 사원번호
ename varchar2 50 not null 사원명
sal number 38 not null 월급
deptno number 10 null 부서번호
emp 사원 테이블을 생성하는 쿼리문을 기술하시고 생성한 테이블에 적절한 레코드가 저장되었다는 가정하에 사원번호를 기준으로 내림차순 정렬하는 쿼리문을 기술하시오.
기술절차)  1. emp 사원 테이블 생성 쿼리문 기술
                  2. 사원번호를 기준으로 내림차순 정렬 쿼리문 기술 */

create table emp1(
 empno number(10) primary key --사원번호
 ,ename varchar2(50) not null --사원명
 ,sal number(38) not null --월급
 ,deptno number(10) null --부서번호
 );

insert into emp1 values(10,'홍길동',2500,10);
insert into emp1 values(11,'이순신',2000,10);

select * from emp1 where deptno is null;
 select * from emp where comm is null;














