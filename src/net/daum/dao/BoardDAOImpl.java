package net.daum.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import net.daum.vo.BoardVO;

public class BoardDAOImpl {//데이터베이스 연결 클래스
	String driver = "oracle.jdbc.OracleDriver";//oracle.jdbc는 패키지명, OracleDriver는 
	//jdbc드라이버 클래스명
	String url = "jdbc:oracle:thin:@localhost:1521:xe";//오라클 접속주소,localhost는 모든 내자신 컴퓨터
	//호스트 이름, 1521은 오라클 연결 포트번호, xe는 데이터베이스명 
	String user = "night";//오라클 사용자이름
	String password = "123456";//오라클 사용자 비번
	
	Connection con = null;//데이터 베이스 연결 con
	PreparedStatement pt = null;//쿼리문 수행 pt
	ResultSet rs = null;//검색 결과 레코드를 저장할 rs
	String sql = null; //쿼리문 저장변수
	
	//게시판 목록
	public List<BoardVO> getBoardList() {
		List<BoardVO> blist = new ArrayList<>();
		
		try {
			Class.forName(driver);//오라클 jdbc드라이버 클래스 로드
			con = DriverManager.getConnection(url, user, password);
			sql = "select * from tbl_board10 order by bno desc";//번호를 기준으로 내림차순 정렬
			pt = con.prepareStatement(sql);//쿼리문을 미리 컴파일 하여 수행할 pt생성
			rs = pt.executeQuery();//select문 수행후 검색 결과 레코드를 rs에 저장
			while(rs.next()) {//복수개의 레코드 행을 검색할 때는 while반복문으로 처리,next()메서드는 다음레코드
				//행이 존재하면 참
				BoardVO b = new BoardVO();
				b.setBno(rs.getInt("bno"));//bno컬럼 레코드가 정수숫자이면 getInt()메서드로 가져온다.
				b.setBname(rs.getNString("bname"));//bname컬럼 레코드가 문자열이면 getString()메서드로
				//가져와서 setter()메서드에 저장함
				b.setBtitle(rs.getString("btitle"));
				b.setBcont(rs.getNString("bcont"));
				b.setBdate(rs.getNString("bdate"));
				
				blist.add(b);//컬렉션에 추가
			}
		}catch(Exception e) {e.printStackTrace();}
		finally {
			try {
				if(rs != null) rs.close();
				if(pt != null) pt.close();
				if(con != null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
		return blist;
	}//getBoardList()
	
	//번호값 검색
	public BoardVO getFindNo(int bno) {
		BoardVO dbNo = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);//인자값으로 db접속주소,오라클 사용자,사용자 비밀번호가
			//전달되면서 db연결 con 생성
			sql="select * from tbl_board10 where bno = ?";//번호를 기준으로 해당테이블로 부터 레코드 검색
			pt = con.prepareStatement(sql);//쿼리문을 미리 컴파일하여 수행할 pt생성
			pt.setInt(1, bno);//쿼리문의 첫번째 물음표에 정수 숫자로 번호값 저장
			rs = pt.executeQuery();//검색문 수행후 결과 레코드를 rs에 저장
			if(rs.next()) {//한개행 레코드가 검색된 경우는 if문으로 처리, next()메서드는 다음 레코드 행이 존재하면 참
				dbNo = new BoardVO();
				dbNo.setBno(rs.getInt(1));//1은 select문 뒤에 검색되는 컬럼 순번을 의미한다.결국 첫번째로 
				//검색되는 bno컬럼으로 부터 정수 숫자로 가져와서 setter()메서드에 저장
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pt != null) pt.close();
				if(con != null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
		return dbNo;
	}//getFindNo()

	public int editBoard(BoardVO eb) {
		int re=-1;//수정 실패시 반환값
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			sql="update tbl_board10 set bname=?,btitle=?,bcont=? where bno=?";
			pt = con.prepareStatement(sql);
			pt.setString(1, eb.getBname());//쿼리문의 첫번째 물음표에 문자열로 수정할 글쓴이를 저장
			pt.setString(2, eb.getBtitle());
			pt.setString(3, eb.getBcont());
			pt.setInt(4, eb.getBno());//쿼리문의 4번째 물음표에 정수 숫자로 기준이 되는 번호값 저장
			
			re = pt.executeUpdate();//수정 쿼리문 성공후 성공한 레코드 행의개수를 반환
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pt != null) pt.close();
				if(con != null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
		return re;
	}
	
	//삭제
	public int delBoard(int bno) {
		int re = -1;//삭제 실패시 반환값
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			sql = "delete from tbl_board10 where bno=?";//번호를 기준으로 레코드 삭제
			pt = con.prepareStatement(sql);
			pt.setInt(1, bno);
			
			re = pt.executeUpdate();//삭제 쿼리문 수행후 성공한 레코드 행의 개수 반환
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pt != null) pt.close();
				if(con != null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
		return re;
	}//delBoard()
}
