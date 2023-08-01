package net.daum.controller;

import java.util.Scanner;

import net.daum.dao.GuDAOImpl;
import net.daum.vo.GuVO;

public class Gu_insert {
	private static String gname;
	private static String gtitle;
	private static String gcont;

	public static void main(String[] args) {
		/* 문제 겸 과제물)
		 * 	1. tbl_gu 테이블을 생성한다.
		 * 		컬럼명 	자료형	크기	    제약조건
		 * 		gno		int			  primary key
		 * 		gname   varchar  20   not null
		 * 		gtitle  varchar  200  not null
		 * 		gcont	varchar  4000 not null
		 * 		gdate   date     default  sysdate
		 * 
		 * 2.net.daum.vo 패키지의 GuVO.java 데이터 저장 빈 클래스를 생성하고 tbl_gu테이블의 컬럼명과 같은
		 * 변수명을 정의한다. 그리고 setter(), getter()메서드를 정의한다.
		 * 
		 * 3.gno_seq10 시퀸스를 생성한다. 1부터 시작하고,1씩증가하고, 캐쉬를 사용하지 않게 한다. 이 시퀸스는
		 * gno 컬럼 레코드값 저장 용도로 활용한다.
		 * 
		 * 4. net.daum.dao패키지에 GuDAOImpl.java 오라클 db연동클래스를 만들어서 jdbc프로그래밍을 한다.
		 * 	  가. Gu_Insert.java에서 스캐너로 입력한 글쓴이, 글제목,글내용과 함께 글번호를 저장하는
		 * 	 public int insertGu(GuVO g){}메서드를 GuDAOImpl.java에서 작성한다.
		 * 
		 * 5. net.daum.controller패키지에 방명록 목록을 가져오는 Gu_List.java를 작성해서 목록을 가져오는
		 * public List<GuVO> getGuList(){} 를 GuDAOImpl.java에 작성한다.
		 */
		Scanner scan = new Scanner(System.in);
		GuDAOImpl gdao = new GuDAOImpl();
		GuVO g = new GuVO();
		
		System.out.println("tbl_gu 테이블에 레코드 저장하기 ");
		System.out.print("글쓴이 입력>> ");
		String gname = scan.nextLine();//문자열로 입력받음.
		System.out.print("글제목 입력>> ");
		String gtitle = scan.nextLine();
		System.out.print("글내용 입력>> ");
		String gcont = scan.nextLine();
		
		g.setGname(gname); g.setGtitle(gtitle); g.setGcont(gcont);
		
		int re = gdao.insertGu(g);//방명록 저장
		
		if(re == 1)
			System.out.println("방명록 저장 성공");
		//문제)방명록 저장되게 만들어 보고 에러가 발생하면 디버깅을 해 본다.
	}//main
}//class
