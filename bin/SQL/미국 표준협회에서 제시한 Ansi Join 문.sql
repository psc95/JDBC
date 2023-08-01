/* Ansi cross join, inner join 실습을 위한 테이블 생성 */
--depart11 테이블 생성
create table depart11(
    dept_code varchar2(20) primary key --강의실 호수
    ,dept_name varchar2(50) not null --강의실 담당 선생님
    );
    
    insert into depart11 values(401,'홍길동');
    insert into depart11 values(402,'이순신샘');
    update depart11 set dept_name='홍길동샘' where dept_code = 401;
    select * from depart11 order by dept_code asc;  
    
    --student11 학생 테이블 생성
    create table student11(
    st_no number(38) primary key --학생 번호
    ,st_name varchar2(30) not null --학생명
    ,st_gender varchar2(10) --성별
    ,dept_code varchar2(20) --강의실 호수
    );
    insert into student11 values(11,'신사임당','여',401);
    insert into student11 values(12,'홍길순','여','402');
    insert into student11 values(13,'강감찬','남','402');
    
    select * from student11 order by st_no asc;
    
    --Ansi cross join
    select * from depart11 cross join student11;
    
    --on 조건절을 사용한 Ansi inner join
    select * from depart11 inner join student11 on depart11.dept_code = student11.dept_code;
    
    /*문제)dept_code공통컬럼을 기준으로 한 on조건절문을 사용해서 강감찬 학생의 정보를 inner join문으로
        조인 검색 해보자.조인 검색 결과로 나오는 컬럼은 학번,학생명,성별,강의실 호수,담당샘 까지 나오게 한다.*/
    select st_no, st_name, st_gender, depart11.dept_code,dept_name from depart11 inner join student11 
    on depart11.dept_code = student11.dept_code and st_name = '강감찬';
    
    --using 절문을 사용한 inner join
    select st_no, st_name, st_gender, dept_code, dept_name from depart11 inner join
    student11 using (dept_code);
    
    --natural join
    select st_no, st_name, st_gender, dept_code, dept_name from depart11 natural join student11;
    
    /* outer join 실습을 위한 테이블 생성 */
    create table dept21(
        deptno number(38) primary key -- 부서번호
        ,dname varchar2(50) --부서명
        );
    insert into dept21 values(10,'ACCOUNTING');
    insert into dept21 values(20,'RESEARCH');
    
    select * from dept21 order by deptno asc;
    COMMIT
    
    create table dept22(
     deptno number(38) primary key
     ,dname varchar2(50)
     );
     insert into dept22 values(10,'ACCOUNTING'); 
     insert into dept22 values(30,'SALES');
     
    select * from dept22 order by deptno asc;
    
    /* dept21 테이블에는 해당 자료가 있지만 dept22 테이블에는 20번 부서번호가 없다. 이런 경우 자료가 출력되지 
        않는 문제점을 해결.오른쪽에 기술된 dept22 테이블에 해당 자료가 없을때를 기준으로 ANSI left outer join 기법을 사용한다 */
    select * from dept21 left outer join dept22 on dept21.deptno = dept22.deptno;
    
    /* right outer join은 오른쪽에 기술된 dept22테이블에는 자료가 있지만 왼쪽에 기술된 dept21 테이블에는 해당자료가 없을 경우
    자료가 출력되지 않는 문제점을 해결하기 위해서 나온 조인기법이다.공통 컬럼이 있다면 on조건절 대신 using절문을 사용할 수 있다.
    이런 경우 테이블명.컬럼명 형태가 아닌 컬럼명만 명시한다.즉 테이블명이나 테이블명 별칭은 올 수가 없다.*/
    select * from dept21 right outer join dept22 using (deptno);
    
    /*full outer join = left outer join + right outer join */
    select * from dept21 full outer join dept22 using (deptno);
    commit
    
    
    
    