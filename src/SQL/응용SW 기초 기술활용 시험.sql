/*1번문제)
윈도우 운영체제의 기본 명령어를 활용할 수 있어야 합니다. CMD를 실행한 다음 도스 명령어로 C드라이브에 이동하고 
night_os라는 폴더를 생성하세요. 파일목록 보기 명령어로 해당 폴더가 제대로 생성되었는지 확인합니다. 그런다음 night_os 폴더로 이동하시고, 
위에 해당하는 4가지 도스 명령어를 차례대로 기술하시오.
작업 수행 순서)  1. c 드라이브 이동 도스 명령어 기술
                            2. night_os 폴더 생성 도스 명령어 기술
                            3. 파일 목록 보기 도스 명령어 기술
                            4. 생성된 night_os 폴더로 이동하는 명령어 기술
*/
--1. cd /
--2.mkdir night_os
--3.dir
--4.cd night_os

/*2번문제)
    관계형 데이터베이스 오라클에서 테이블을 생성할 수 있어야 합니다. 다음과 같은 테이블과 시퀀스를 생성하시고 쿼리문을 각각 기술하세요.
테이블명: mem_addr
  컬럼명: mem_no(구분번호->mem_no_seq라는 시퀀스 사용,number(38),기본키), mem_name(이름,varchar2(20)), 
  mem_phone(폰번호,varchar2(24)), mem_email(전자우편주소,varchar2(50)),
  mem_addr01(특별시(광역시),도,varchar2(20)),mem_addr02(시,구,군,동,길,번지,varchar2(100)),mem_addr03(나머지주소,varchar2(50))

  1부터 시작해서 1씩증가하고, 임시 메모리를 사용하지 않는 mem_no_seq라는 시퀀스를 생성하세요.

작업 수행 순서) 1. 테이블 생성문 2. 시퀀스 생성문
*/
create table mem_addr(
 mem_no number(38) primary key
 ,mem_name varchar2(20)
 ,mem_phone varchar2(24)
 ,mem_email varchar2(50)
 ,mem_addr01 varchar2(20)
 ,mem_addr02 varchar2(100)
 ,mem_addr03 varchar2(50)
 );
 insert into mem_addr values(1,'홍길동','010-1234-5678','1@naver.com','서울','종로구','단성사');
 insert into mem_addr values(2,'홍길동','010-1234-5678','1@naver.com','서울','종로구','단성사');
 insert into mem_addr values(3,'홍길동','010-1234-5678','1@naver.com','서울','종로구','단성사');
 insert into mem_addr values(4,'홍길동','010-1234-5678','1@naver.com','서울','종로구','단성사');
 select * from mem_addr order by mem_no asc;
 
 create sequence mem_no_seq
 start with 1 --1부터 시작
 increment by 1 --1씩 증가
 nocache; --임시 메모리를 사용하지 않겠다는 의미
 
 --시퀀스 번호값 확인
 select mem_no_seq.nextval as "시퀀스 번호값" from dual;
 
/*3번문제)
     mem_addr테이블에 저장된 4번 레코드를 삭제하는 SQL문을 작성하시오.
*/
delete from mem_addr where mem_no=4;

/*4번문제)
    데이터베이스의 기본 연산을 구분하여 설명할 수 있어야 합니다. 이전 문제에서 작성되어진 
    mem_addr테이블에 mem_no 컬럼에 저장된 3번 레코드의 mem_name 컬럼 이름 레코드를 
    ‘이순신’, mem_email 컬럼 메일 주소 레코드를 ‘leeshin@gmail.com'으로 수정하는 SQL문을 작성하시오.
*/
update mem_addr set mem_name='이순신' where mem_no=3;
update mem_addr set mem_email='leeshin@gmail.com' where mem_no=3;
 select * from mem_addr order by mem_no asc;

/*5번문제)
     CMD를 실행해서 ip주소,게이트웨이 등 네트워크 정보를 알아내는 명령어와 
     네트워크 연결 유무를 판단할 때 사용하는 명령어를 각각 차례대로 기술하시오.
*/
 --ip주소,게이트웨이 등 네트워크 정보를 알아내는 명령어
ipconfig

--네트워크 연결 유무를 판단할 때 사용하는 명령어
ping

/*6번문제)
CMD를 실행한 다음 해당 컴퓨터이름을 알아낼수 있는 명령어가 무엇인지 작성하세요.

작업 수행 순서) 1. 컴퓨터 이름을 알아 내는 명령어 기술
*/
ipconfig/all
set user
hostname
whoami

commit;