--r기본키인 primary key와 not null 제약조건 실습을 위한 테이블 생성
create table dept60(
 deptno number(38) primary key --부서 번호
 ,dname varchar2(50) not null --부서명
 ,LOC varchar2(100) --부서지역
 );
 
 insert into dept60 values(10,'영업부','서울');
 insert into dept60 values(10,'영업부 부산사무소','부산');--deptno 컬럼에 동일 부서번호를 저장할려다가 무결성 제약조건 위배에러가 나서
 --저장할 수 없다. 이유는 기본키로 설정되어서 중복 부서번호를 저장할 수 없다.
 
 insert into dept60 values(20,null,'서울'); --dname컬럼에 not null 제약조건으로 설정되어서 null을 저장할 수 없다.
 
 /*dept60 테이블의 제약조건이름, 제약조건 유형,제약조건이 속한 테이블 명을 확인*/
 select constraint_name, constraint_type, table_name from user_constraints where table_name in('DEPT60');
 --제약조건 유형에서 C는 NOT NULL과 CHECK제약조건을 의미하고, P는 Primary key즉 기본키 제약조건을 의미한다.
 --오라클에서 기본으로 제공하는 SYS C숫자번호 형태의 제약조건이름이 지정된다.
 --in연산의 영문 테이블명은 반드시 영문대문자로 해야 검색된다. 이유는 영문자 레코드는 대소문자를 구분한다.sql문은 대소문자 구분X
 
 /* not null제약조건 실습을 위한 테이블 생성 */
 create table emp101(
  empno number(38) --null 제약조건, 사원번호
  ,ename varchar2(50) --사원명
  ,job varchar2(20) --직종
  ,deptno number(38) --부서번호
  );
  
  insert into emp101 values(null,null,'영엉부',20);
  select * from emp101;
  
  create table emp102(
   empno number(38) not null
   ,ename varchar2(50) not null
   ,job varchar2(20) 
   ,deptno number(38)
   );
   
 insert into emp102 values(null,null,'관리부',10);
 --not null 제약조건으로 설정된 컬럼에 null저장금지
 
 insert into emp102 values(501,'이순신','관리부',10);
 select * from emp102;
 
 /* 테이블 컬럼을 정의할 때 사용하는 unique 제약조건 특징)
    1.특정 컬럼에 자료가 중복되지 않게 한다.
    2.null 저장되는 것은 허용한다.
    3.중복 자료에서 null은 체크하지 않는다. 즉 null은 중복을 허용하는 특징이 있다. */
    
    --unique제약조건 실습을 위한 테이블 생성
    create table emp103(
    empno number(10) unique
    ,ename varchar2(30) not null
    ,job varchar2(30)
    ,deptno number(38)
    );
    insert into emp103 values(502,'홍길동','인사부',40);
    insert into emp103 values(502,'이순신','영업부',30); --동일 중복 부서번호 저장안된다.이유는 해당컬럼 empno가 unique제약조건으로
    --설정 되어있기 때문이다.
    select * from emp103;
    
    insert into emp103 values(null,'강감찬','관리부',50);
    insert into emp103 values(null,'신사임당','개발부',60);
    --unique 제약조건으로 설정된 컬럼에 null저장 허용하고,중복도 허용한다.
    
    --constraint 키워드로 사용자 정의 제약조건명을 지정해서 만들어 봄
    create table emp105(
     empno number(38) constraint emp105_empno_uk unique
     ,ename varchar2(50) constraint emp105_ename_nn not null
     ,job varchar2(50)
     ,deptno number(38)
     );
     /* 사용자 정의 제약조건명 지정방법)
        테이블명_컬럼명_제약조건유형
        emp105_empno_uk와 emp105_ename_nn이 바로 사용자 정의 제약조건명이다.
    */
    --emp105테이블의 제약조건명이 생성된 테이블명, 제약조건이름을 확인
    select table_name, constraint_name from user_constraints where table_name in('EMP105');
    
    --사원번호를 기본키로 가지는 EMP106테이블 생성)
    create table emp106(
     empno number(38) constraint emp106_empno_pk primary key
     ,ename varchar2(50) constraint emp106_ename_nn not null
     ,job varchar2(50)
     ,deptno number(38)
     );
     
     insert into emp106 values(201,'강감찬','관리부',10);
     insert into emp106 values(201,'이순신','영업부',20);
     --중복사원번호는 저장 안된다.
     
     /*
      참조 무결성을 위한 외래어 제약조건 실습)
      1.기본키로 설정된 부모 즉 주인테이블 dept71부터 먼저 만든다.
      2.dept71 부모 테이블부터 먼저 자료를 저장한다.
    */
    create table dept71(
     deptno number(38) constraint dept71_deptno_pk primary key --부서번호
     ,dname varchar2(100) constraint dept71_dname_nn not null --부서명
     ,LOC varchar2(50) --부서지역  
     );
     
     drop table dept71;
     insert into dept71 values(10,'관리부','서울');
     insert into dept71 values(20,'영업부','부산');
     insert into dept71 values(30,'개발부','판교');
     
     select * from dept71 order by deptno asc;
     
     /*  외래키(foreign key) 제약조건 특징)
        1.dept71 테이블의 기본키로 설정된 deptno컬럼을 참조하고 있다.
        2.dept71 테이블의 deptno컬럼에 저장된 부서번호만 외래키로 설정된 컬럼 자료값으로 저장된다. 이것이 곧 참조 무결성이다.
        이것이 가능한 것은 주종관계이기 때문이다.
    */
    
    --외래키가 포함된 종속테이블 emp71을 생성
    create table emp71(
     empno number(38) constraint emp71_empno_pk primary key --사원번호
     ,ename varchar2(50) constraint emp71_ename_nn not null --사원명
     ,job varchar2(50) --직종
     ,deptno number(38) constraint emp71_deptno_fk references dept71(deptno) --외래키 설정
     );
     
     insert into emp71 values(11,'홍길동','관리사원',10);
     insert into emp71 values(12,'강감찬','영업사원',20);
     
     select * from emp71 order by empno asc;
     
     insert into emp71 values(13,'강참찬','기획사원',50);
     /* 무결성 제약조건 위배 에러가 발생해서 레코드가 저장 안된다.이유는 부모 테이블 dept71의 기본키 컬럼인 deptno에
        부서번호가 없기 때문이다. 
    */
    
    select table_name, constraint_type, constraint_name, r_constraint_name from user_constraints
    where table_name in('DEPT71','EMP71');
    /* 1.table_name 컬럼 : 제약조건명이 지정된 테이블명
        2.constraint_type : 제약조건 유형
        3.constraint_name : 제약조건 이름
        4.r_constraint_name : 외래키가 어느 기본키를 참조하고 있는가에 대한 정보
    */
    
    /* 문제) 주종관계인 dept71과 emp71 두 테이블의 공통 컬럼인 deptno를 기준으로 미국 표준협회 ANSI Inner JOIN문을 만들어 보자*/
    select * from dept71 inner join emp71 on dept71.deptno = emp71.deptno;
    
    commit;
    
    --기본키가 있는 학과 테이블 생성
    create table depart71(
    deptcode varchar2(10) constraint depart71_deptcode_pk primary key --학과코드
    ,deptname varchar2(50) constraint depart71_deptname_nn not null --학과 이름
    );
    
    insert into depart71 values('a001','영어교육학과');
    insert into depart71 values('a002','컴퓨터공학과');
    
    select * from depart71 order by deptcode asc;
    
    --외래키가 있는 학생테이블 student71을 생성
    create table student71(
     sno number(38) constraint student71_sno_pk primary key --학번
     ,sname varchar2(50) constraint student71_sname_nn not null --학생이름
     ,gender varchar2(10) constraint student71_gender_nn not null --성별
     ,addr varchar2(300) --주소
     ,deptcode varchar2(10) constraint student71_deptcode_fk references depart71(deptcode) --외래키 설정
    );
    
    insert into student71 values(101,'홍길동','남','서울시','a001');
    insert into student71 values(102,'이순신','남','서울시','a002');
    
    select * from student71 order by sno asc;
    
    --문제)inner join말고 학과 코드 공통 컬럼을 기준으로 equi JOIN 검색문을 작성해 보자
    select sno,sname,gender,addr,d.deptcode,deptname from depart71 d, student71 s
    where d.deptcode = s.deptcode;
    
    select table_name,constraint_type,constraint_name, r_constraint_name from user_constraints
    where table_name in('DEPART71','STUDENT71');
    
    --CHECK 제약조건 실습을 위한 테이블 생성
    create table emp73(
     empno number(38) constraint emp73_empno_pk primary key --사원번호
     ,ename varchar2(50) constraint emp73_ename_nn not null --사원명
     ,sal number(38) constraint emp73_sal_ck check(sal between 500 and 5000) --급여,check제약조건을 주면서 급여가 500부터
     --5000사이만 저장되게 한다.
     ,gender varchar2(6) constraint emp73_gender_ck check(gender in('M','F')) --성별,gender컬럼에 check제약조건을 주면서
     --남자인 경우'M', 여자인 경우는 'F' 둘 중 하나만 저장되게 한다.
     );
     
      alter table emp73 drop constraint emp73_sal_ck; 
      alter table emp73 modify gender check(gender in('남자','여자'));
      alter table emp73 add constraint emp73_sal_ck check(gender in('남자','여자'));
      
      /*  제약 조건을 변경하는 명령문이다.
        추가
        ALTER TABLE 테이블이름 ADD CONSTRAINT 제약이름 제약조건;
        수정
        ALTER TABLE 테이블이름 MODIFY 컬럼명 컬럼조건;
        삭제
        ALTER TABLE 테이블이름 DROP CONTRAINT 제약이름;      
      */
     
     insert into emp73 values(1101,'홍길동',8000,'M'); --급여가 500~5000사이 범위를 벗어나서 check제약조건 위배 에러 발생
     insert into emp73 values(1101,'홍길동',5000,'M');
     insert into emp73 values(1102,'홍길동',500,'M');
     insert into emp73 values(1103,'신사임당',3000,'C');--gender컬럼에는 남자는 M 여자는 F 가들어가야 저장이되는데
     --이 범위를 벗어난 C를 저장할려다가 check 제약조건 위배 에러 발생
     
     delete from emp73;
     
     select * from emp73 order by empno;
     
     --default 제약조건 실습
     create table dept73(
      deptno number(38) primary key --부서번호
      ,dname varchar2(50) --부서명
      ,LOC varchar2(50) default '서울' --부서지역,LOC컬럼에는 굳이 레코드를 저장하지 않아도 기본값 서울이 저장
      );
      
      insert into dept73 (deptno,dname) values(10,'개발부');
      select * from dept73 order by deptno asc;--부서번호를 기준으로 해서 오름차순 정렬
      insert into dept73 values(20,'기획부','부산');
    
      --컬럼 레벨 지정방식으로 emp75 테이블 생성
    create table emp75(
     empno number(38) primary key
     ,ename varchar2(50) not null
     ,job varchar2(30) unique --null만 중복허용
     ,deptno number(38) references dept71(deptno) --외래키 설정
     );
    
    select * from emp75;
    
    select table_name, constraint_name, constraint_type, r_constraint_name from user_constraints
    where table_name = 'EMP77';
    
    --테이블 레벨 지정방식으로 emp76 테이블을 생성
    create table emp76(
    empno number(38)
    ,ename varchar2(50) not null
    ,job varchar2(50)
    ,deptno number(38)
    ,primary key(empno) --기본키
    ,unique(job)
    ,foreign key(deptno) references dept71(deptno) --외래키
    );
    
    --테이블 레벨 지정방식으로 constraint 키워드를 사용해서 사용자 정의 제약조건명을 지정하면서 테이블 생성)
    create table emp77(
     empno number(38)
     ,ename varchar2(50) constraint emp77_ename_nn not null
     ,job varchar2(50)
     ,deptno number(38)
     ,constraint emp77_empno_pk primary key(empno) --기본키
     ,constraint emp77_job_uk unique(job)
     ,constraint emp77_deptno_fk
     foreign key(deptno) references dept71(deptno) --외래키
    );
    
    --하나의 테이블에 2개의 기본키 인 복합키를 지정하는 테이블 생성
    create table member01(
    id varchar2(20)
    ,name varchar2(50)
    ,addr varchar2(200)
    ,phone varchar2(30)
    ,constraint member01_idphone_pk primary key(id,phone) --id,phone2개 컬럼을 기본키로 지정
    );
    
    select owner, constraint_name, table_name, column_name from user_cons_columns
    where table_name = 'MEMBER01';
    /* OWNER 컬럼에는 오라클 사용자가 저장되어 있다.
        column_name에는 제약조건이 지정된 컬럼명이 지정되어 있다.*/
    /*
    미리 생성된 테이블 컬럼에 제약조건 추가)
    alter table 테이블명
    add constraint 사용자정의제약조건명 제약조건타입 */
    
    --모든 컬럼 제약조건이 null인 테이블 생성
    create table emp78(
    empno number(38) --제약조건 지정하지않으면 기본적으로 null
    ,ename varchar2(50)
    ,job varchar2(50)
    ,deptno number(38)
    );
    
    --empno 컬럼에 emp78_empno_pk 사용자 정의 제약조건명을 가진 기본키 제약조건추가
    alter table emp78
    add constraint emp78_empno_pk primary key(empno);
    
    select constraint_name, constraint_type, table_name, r_constraint_name
    from user_constraints where table_name='EMP78';
    
    --EMP78 테이블의 deptno컬럼에 사용자 정의 제약조건명 emp78_deptno_fk로 지정되는 외래키 추가
    alter table emp78
    add constraint emp78_deptno_fk 
    foreign key(deptno) REFERENCES dept71(deptno);
    
    --emp78 테이블의 ename컬럼에 emp78_ename_nn 사용자정의 제약조건명을 지정하면서 not null 제약조건 추가
    alter table emp78
    modify ename constraint emp78_ename_nn not null;
    
    insert into emp78 values(11,'이순신','관리사원',10);
    insert into emp78 values(12,'홍길동','영업사원',20);
    insert into emp78 values(11,'강감찬','개발자',30); --empno컬럼은 기본키라서 중복사원번호 저장금지
    
    --기본키 제약조건 제거
    alter table emp78 drop constraint emp78_empno_pk;
    
    select * from emp78;
    
    --emp78테이블 제약조건명 확인
    select constraint_name from user_constraints where table_name='EMP78';
    
    --ename 컬럼에 null데이터 저장시도
    insert into emp78 values(13,null,'영업사원',20);
    
    --emp78테이블 ename컬럼 not null 제약조건 제거
    alter table emp78 drop constraint emp78_ename_nn;
    commit;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    