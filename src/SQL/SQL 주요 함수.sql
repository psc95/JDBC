--곱셉 연산
select 1000*1000 as "곱셈결과값" from dual;

--오늘 날짜값 확인
select sysdate as "오늘날짜" from dual; --sysdate는 오라클 날짜 함수

--ABS()함수는 절대치를 구한다.
select ABS(-100) as "-100의 양의 절대값" from dual;

--FLOOR()함수를 사용해서 소수점이하를 버린다.물론 반올림 안한다.
select floor(34.5678) as "소수점이하를 버리는 FLOOR()함수" from dual;

--특정 자리에서 반올림 하는 ROUND()함수
select round(34.5678,2) as "ROUND()함수" from dual; --round(34.5678,2)에서 두번째 인자값이 2이면 소수점 이하 3번째 자리에서 반올림
--하여 소수점 이하 두번째 자리까지 표시한다.

--특정 자리에서 버림하는 trunc() 함수
select trunc(34.5678,2) as "trunc()함수" from dual;--trunc(34.56,2)에서 2번째 인자값이 2이면 소수점 이하 3번째 자리에서 버림해서 소수점
--이하 2번째 자리까지 표시한다.물론 소수점 이하 3번째에서 반올림 하지 않는다

--나머지를 구하는 mod()함수
select mod(26,3) as "26을3으로 나눈나머지 값" from dual;

--영문 대문자로 변경하는 upper()함수, 영문 소문자로 변경하는 Lower()함수
select upper('oracle') as "영문대문자로 변경", lower('ORCLE') as "영문소문자로 변경" from dual;

--왼쪽 공백을 제거하는 Ltrim()함수, 오른쪽 공백을 제거하는 Rtrim()함수, 양쪽 공백을 제거하는 trim()함수
select Ltrim('  Oracle') as "왼쪽공백제거", rtrim('Oracle ') as "오른쪽공백제거",
trim('  Oracle  ') as "양쪽공백제거" from dual;

--sysdate 날짜 함수
select sysdate as "오늘 날짜와 시간" from dual;

--문제) sysdate()날짜 함수를 활용해서 어제날짜,내일날짜를 각각 출력해보자. 임시 별칭명도 출력되게 한다.
select sysdate -1 as "어제 날짜",sysdate as "오늘 날짜", sysdate +1 as "내일 날짜" from dual;

/* 형변환 함수 종류)
    to_char() : 날짜형 또는 숫자형을 문자형으로 변환
    to_date() : 문자형을 날짜형으로 변환
    to_number() : 문자형을 숫자형으로 변환
*/
select sysdate, to_char(sysdate, 'YYYY-MM-DD') as "년월일 표시" from dual;
select to_date() as "" from dual;

/* NVL() 함수 특징)
comm 컬럼 보너스 레코드가 null이면 제대로 된 연봉 계산을 못한다. 그러므로 null을 NVL()함수에 의해서 0으로 변환한 다음 연봉을 계산
하면 제대로 된 연봉을 계산가능하다.
*/
select ename,sal,comm from emp order by ename;
select ename,sal,comm,sal*12+comm as "연봉" from emp;
select ename,sal,comm,sal*12+NVL(comm,0) as "연봉" from emp;

--decode함수 실습을 위한 emp01 테이블 생성
create table emp01(
deptno number(38) primary key --부서번호
,ename varchar2(20) --사원명
);
insert into emp01 values(10,'miller');
insert into emp01 values(20,'smith');
insert into emp01 values(20,'jones');
insert into emp01 values(30,'allen');

select * from emp01;

-- 문제)기존 테이블과 레코드를 유지한채 deptno부서번호 컬럼의 제약조건 기본키를 제거해서 중복 부서번호가 저장되게 만들어 보자
-- 테이블 수정문을 사용해야 한다.
alter table emp01 drop primary key;

--decode 함수 실습
select ename,deptno ,decode(deptno, 10, '개발부',
                                                20, '기획부',
                                                30, '디자인부')
                                                as 부서명
from emp01;
alter table emp01 rename column depno to deptno; --컬럼병 변경하는법

--case 함수 실습
select ename,deptno,
        case when deptno = 10 then '디자인부'
               when deptno = 20 then '개발부'
               when deptno = 30 then '경리부'
        end as 부서명
from emp01;
/* 그룹 함수 종류)
    count() : 레코드 개수 , sum() : 합계, avg() : 평균, max() : 최대값, min() : 최소값, STDDVE() : 표준편차, VARIANCE() : 분산
*/
--그룹함수 실습을 위한 테이블 생성
create table emp02(
deptno number(38) --부서번호
,ename varchar2(20) --부서명
,sal number(38) --월급
,comm int -- 보너스
,job varchar2(50) -- 업무부서
);

insert into emp02 values(10,'scott',1000,100,'영업사원');
insert into emp02 values(10,'tiger',1500,150,'영업사원');
insert into emp02 (deptno,ename,sal,job) values(20,'james',2000,'관리자');
insert into emp02 (deptno,ename,sal,job) values(20,'king',2500,'관리자');

select * from emp02 order by ename asc;

--전체사원의 월급의 총합
select sum(sal) as "총급여" from emp02;

--보너스의 총합
select sum(comm) as "보너스 총합" from emp02;--comm컬럼의 null을 제외하고 보너스 총합을 구한다.즉 그룹함수는
--다른 연산하고는 다르게 null을 제외한 보너스 총합을 구한다.

--급여평균
select avg(sal) as "급여 평균" from emp02;

--급여중에서 최대값과 최소값을 구함
select max(sal) as "급여최대값", min(sal) as "급여최소값" from emp02;

/*문제) 보너스를 수령하는 사원수와 총 사원수를 구해보자*/
select count(comm) as "보너스 수령 사원수", count(*) as "총사원수" from emp02;
--count(comm)함수는 null을 제외한 보너스를 받는 사원수를 반환
commit


select count(job) as "업무 수" from emp02;

select job from emp02 order by job asc;

/* 중복 레코드를 제거하고 업무수를 카운터 할려면 distinct 키워드를 사용한다.*/
select count(distinct job) as "중복을 제거한 업무수" from emp02;

select * from emp02;

--부서별 그룹화 시켜서 부서별 급여 평균
select deptno, avg(sal) from emp02 group by deptno;

--부서별 급여 총합과 급여 평균
select deptno, sum(sal), avg(sal) from emp02 group by deptno;

/* 문제) 부서별 최대 급여와 최소급여를 임시 별칭명으로 검색되게 해보자.*/
select deptno as "부서번호", max(sal) as "부서별 최대급여", min(sal) as "부서별 최소급여" from emp02 group by deptno;

--부서별 사원수와 보너스를 받는 사원수
select deptno as "부서번호", count(*) as "부서별 사원수", count(comm) as "보너스 받는 사원수" from emp02 group by deptno;

--부서별 급여 평균이 2000이상인 경우만 부서번호, 부서별 급여 평균을 구함
select deptno as "부서번호", avg(sal) as "급여 평균2000이상" from emp02
group by deptno
having avg(sal) >= 2000;

/*문제) 부서별 최대급여가 1500 이상인 경우 부서번호, 부서별 최대급여, 최소급여가 임시 별칭으로 나오게 검색해 보자*/
select deptno as "부서번호", max(sal) as "부서별 최대급여", min(sal) as "부서별 최소급여" from emp02
group by deptno
having max(sal) >= 1500;

