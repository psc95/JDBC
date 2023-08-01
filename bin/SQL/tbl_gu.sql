create table tbl_gu(
 gno int primary key --번호
 ,gname varchar(20) not null --작성자
 ,gtitle varchar(200) not null --글제목
 ,gcont varchar(4000) not null --글내용
 ,gdate date default sysdate --등록날짜, default sysdate 제약조건을 했기 때문에 해당 컬럼에 굳이 날짜를 저장하지 않아도 기본값으로
 --오라클 날짜함수에 의해서 날짜값이 저장된다.
 );
 
 select * from tbl_gu order by gno desc; --bno즉 게시판 번호를 기준으로 내림차순 정렬해서 큰숫자번호값 부터 먼저 정렬한다.
 
 --bno_seq10 번호 발생기 시퀀스 생성
 create sequence gno_seq10
 start with 1 --1부터 시작
 increment by 1 --1씩 증가
 nocache; --임시 메모리를 사용하지 않겠다는 의미
 
 --시퀀스 번호값 확인
 select gno_seq10.nextval as "시퀀스 번호값" from dual;

commit;