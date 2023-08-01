/* 사용 용도에 따른 SQL문 종류)
    1.데이터 정의(DDL문) : 데이터베이스 관리자가 데이터베이스의 논리적 구조를 정의할 때 사용하는 언어이다.
        create,alter(테이블 수정문), drop(테이블 삭제,데이터베이스 삭제), rename(테이블명 변경), truncate(레코드 삭제)
        
    2. 데이터 조작어(DML문) : 테이블 컬럼에 저장된 한행의 자료 집합인 레코드를 다룰 때 사용하는 언어이다. INSERT(레코드 추가문),
    UPDATE(레코드 수정문), delete(레코드 삭제문)
    
    3. 데이터 제어어(DCL문) : 접근 권한 부여 또는 취소할 때 사용하는 언어이다.
        GRANT(접근 권한 부여), REVOKE(권한 취소)
        
    4. 트랜잭션 처리어 : commit(정상적인 쿼리문 성공 반영), rollback(쿼리문 실행 취소)
    
    5. 데이터 질의어(검색문) : select문
*/

--ddl문을 사용한 dept01 부서테이블 생성
create table dept01(
 deptno number(38) primary key --부서번호
 ,dname varchar2(50) --부서명
 ,LOC varchar2(20) --부서지역
 );
 
  --테이블 구조 확인 명령어,describe의 약어이다.
  desc dept01;
  describe dept01;
 
  --dname 컬럼크기를 50에서 30으로 변경
  alter table dept01 modify(dname varchar2(30));
  
 --레코드 하나 저장
 insert into dept01 values(50,'총무부','서울');
 
 --레코드 검색
 select * from dept02;
 
 --50번 부서의 지역을 서울에서 부산으로 변경
 update dept01 set dname='총무부',LOC='부산' where deptno=50;
 
 --50번 레코드 삭제
 delete from dept01 where deptno=50;
 
 --dept01 테이블명을 dept02로 변경
 rename dept01 to dept02;
 
 --10부서 저장
 insert into dept02 values(10,'개발부','판교');
 
 --잘 사용은 안되지만 truncate문으로 전체레코드를 삭제
 truncate table dept02;
 
 --dept02 테이블 삭제
 drop table dept02;
 
 --night사용자로 사용가능한 테이블 정보를 확인
 select * from tab; --tab는 table의 약어이다. 오라클 설치하면 기본으로 있는 테이블
 
 /*산술연산자 종류
    +(덧셈), -(뺄셈), *(곱셈), /(나눗셈)
    
    sysdate : 오라클 날짜 함수
 */
 --오늘날짜 확인
 select sysdate as "오늘날짜" from dual; -- dual은 오라클 설치시 생성되는 임시 테이블 
 
 --산술 연산 확인
 select 10 + 10 as "덧셈값 결과", 10 * 10 as "곱셈결과값", 10 / 3 as "나눗셈결과" from dual;
 
 --emp라는 사원테이블 생성
 create table emp(
 empno int primary key --사원번호, 원래 오라클에서는 int라는 자료형이 없지만 int타입으로 하면 number(38)타입으로 만들어 진다
 ,ename varchar2(20) --사원명
 ,sal number(38) --급여
 ,comm number(38) --보너스
 ,deptno number(38) --부서번호
 );
 
 insert into emp values(11,'홍길동',1000,100,10);
 insert into emp (empno,ename,sal,deptno) values(12,'이순신',1500,20);
 
 --사원번호를 기준으로 내림차순 정렬
 select * from emp order by empno desc;
 
 --연봉을 계산
 select ename,sal,comm,sal*12+comm as "연봉" from emp; --이순신 사원은 보너스가 null이라서 sal*12+comm = null로 나오는
 --심각한 연봉 오류가 발생한다.
 
 --보너스가 null이라서 제대로 된 연봉을 계산 못하면 nvl()함수를 사용해서 보너스 null을 0으로 변경한 다음 연봉을 계산하면 된다.
 select ename,sal,nvl(comm,0), sal*12+NVL(COMM,0) as "연봉" from emp;
 
 /*
   distinct 예악어는 중복 레코드를 한번만 나오게 한다.
 */
 insert into emp values(13,'신사임당님',2000,200,10);
 select deptno from emp;
 select distinct deptno from emp; --distinct 예악어로 중복부서번호를 한번만 나오게 한다.
 
 /* 오라클 SQL Developer는 insert,update,delete문 수행후 쿼리문이 오라클에 자동 반영되는 오터 커밋이 아니다.그러므로 반드시
     이 3가지 쿼리문 수행후에는 트랜잭션 commit명령어로 성공 반영해서 쿼리문을 정상 수행되게 해야 한다.
     */
 commit;
 
 select * from emp order by empno asc; --사원번호를 기준으로 오름차순 정렬.
 
 --문제)급여가 1500이상인 사원만 검색
 select * from emp  where sal >= 1500;
 
 /* 오라클 비교연산자 종류)
    =(같다), >(~보다 크다), <(~보다 작다), >=(~보다 크거나 같다), <=(~보다 작거나 같다.)
    다르다(<>, !=, ^=)
 */
 
 --10번 부서번호 레코드 검색
 select * from emp where deptno = 10;
 
 /*
  SQL문은 영문 대소문자를 구분하지 않는다.하지만 영문자 레코드 자료는 대소문자를 구분한다.
 */
 insert into emp values(14,'ford',3000,300,30);
 
 select empno,ename,sal from emp where ename = 'FORD'; --영문 레코드 이름 ford는 대소문자를 구분해서 자료가 검색 안된다
 select empno,ename,sal from emp where ename = 'ford';
 
 /*논리 연산자 종류
    1.AND : 두 가지 조건을 모두 만족해야 해당 자료가 검색된다.
    2.OR : 두 가지 조건 중에서 하나라도 만족하면 해당 자료가 검색된다.
    3.NOT : 조건에 만족하지 못하는 것만 검색한다.
 */
 select * from emp order by empno; --사원번호를 기준으로 오름차순 정렬(asc문 생략가능함)
 
 --문제) 10부서번호이고 홍길동인 사원을 검색해 보자.
 select * from emp where deptno = 10 and ename = '홍길동'; 
 
 --10번 부서번호 이거나 이순신 사원 레코드를 검색
 select * from emp where ename = '이순신' or deptno = 10;
 
 --문제) 10번 부서번호가 아닌(비교연산,논리연산) 사원을 검색
 --비교연산 3개, 논리연산 1개
 select * from emp where not deptno = 10; --논리 not 연산
 select * from emp where deptno != 10;
 select * from emp where deptno <> 10;
 select * from emp where deptno ^= 10;
 
 --문제) 논리연산자를 사용해서 급여가 1500에서 3000사이 사원을 검색
 select * from emp where sal >= 1500 and sal <= 3000;
 
 --문제) 급여가 1500 이하이거나 3000이상인 사원을 검색(논리연산)
 select * from emp where sal <= 1500 or sal >= 3000;
 
 --문제) 보너스(comm)가 100이거나 200이거나 null인 사원을 검색한다.
 select * from emp where comm = 100 or comm = 200 or comm is null;
 
 /* 컬럼명 between A and B 연산 특징)
    특정 범위의 값을 조회하기 위해서 between and 연산자를 사용한다.A에는 범위의 최소값을 B에는 범위내의 최대값을 기술한다.
 */
 
 --급여가 1000에서 2000사이의 사원을 검색
 select ename,sal from emp where sal between 1000 and 2000;
 
 --문제) 급여가 1500에서 2000사이가 아닌 사원을 검색(between A and B연산을 사용한다.)
 select * from emp where sal not between 1500 and 2000;
 
 /* int 연산의 특징)
    예를 들면 보너스가 300혹은 500혹은 1000인 사원을 물어 볼때는 특정 컬럼의 값이 여러 개의 값 중에서 하나 인지를 물어봐야 하는데
    이때 사용하는 연산자가 in 연산자이다.
    
    사용형식) 컬럼명 in(A,B,C)
    특정 컬럼의 값이 A,B,C 중에 어느 하나만 만족하더라도 출력되도록 하는 표현을 할 때 사용되는 연산자가 in이다.
    in연산자는 or 연산자로 대체가 가능하다.
 */
 select * from emp;
 
 --급여가 1000이거나 1500이거나 2000인 경우 in 연산자를 사용해서 사원을 검색
 select * from emp where sal in(1000,1500,2000);
 
 --위의 in 연산자를 or 연산자로 변경
 select * from emp where sal = 1000 or sal = 1500 or sal = 2000;
 
 --문제) 보너스가 100,200,null이 아닌 사원을 논리연산자와 비교연산자를 사용해서 구해보자
 select * from emp where comm != 100 and comm ^= 200 and comm is not null;
 
 --문제) in 연산자를 사용해서 급여가 1000,2000,3000이 아닌 사원을 검색한다.
 select * from emp where sal not in(1000,2000,3000);
 
 --문제) or 연산자를 사용해서 급여가 1000,2000,3000이 아닌 사원을 검색한다.
 select * from emp where not (sal = 1000 or sal = 2000 or sal = 3000);

/* like 검색 연산자 특징)
    1. 검색하려는 값을 정확히 모를 경우에 와일드 카드 문자인 % _와 함께 사용한다.
    2. 와일드 카드 문자 종류
        % : 하나 이상의 임의의 모르는 문자와 매핑 대응
        _  : 임의의 모르는 한문자와 매핑 대응
*/ 
 select * from emp;
 
 -- f로 시작하는 사원명 검색
 select empno,ename from emp where ename like 'f%';
 
 --r을 포함하는 사원을 검색
 select empno,ename,sal from emp where ename like '%r%'; --가장 많이 사용하는 검색 형태
 
 --문제) _와일드 카드 문자와 like 검색 키워드를 사용하여 순신으로 끝나는 사원인 이순신을 검색한다.
 select * from emp where ename like '_순신';

--문제) like를 사용해서 길이 포함안된 사원을 검색해 본다
 select * from emp where ename not like '%길%';
 
 --보너스가 null인 경우 사원검색
 select * from emp where comm is null; --null 컬럼은 is null로 판단
 
 --보너스가 null이 아닌 경우 사원 검색
 select * from emp where comm is not null; --null이 아닌 경우는 is not null로 판단한다.
 
 /* order by 기준 컬럼 asc/desc 정렬문 특징)
    1.asc문은 오름차순 정렬이다. 생략 가능하다.
    2.오름차순 정렬 규칙
        가.한글은 가나다 순으로 정렬
        나.숫자는 작은 숫자부터 정렬
        다.영어는 알파벳 순으로 정렬
  
    3.desc는 내림차순 정렬이다. 생략 불가능하다.
    4.내림차순 정렬 규칙
        가.한글은 가나다 역순으로 정렬
        나.숫자는 큰 숫자부터 정렬
        다.영어는 알파벳 역순으로 정렬
*/
 
 --사원번호를 기준으로 내림차순 정렬
 select * from emp order by empno desc;
 
 --급여를 기준으로 오름차순 정렬
 select ename,sal from emp order by sal asc; --asc문은 생략가능하다.
 select ename,sal from emp order by sal; --asc문 생략됨.
 
 --사원명을 기준으로 오름차순 정렬
 select * from emp order by ename; --asc문 생략됨. 영문이름이 한글이름보다 먼저 검색
 
 --사원명을 기준으로 내림차순 정렬
 select * from emp order by ename desc;