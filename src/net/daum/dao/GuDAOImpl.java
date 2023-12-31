package net.daum.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import net.daum.vo.GuVO;

public class GuDAOImpl {//오라클 연결 클래스=> JDBC 연결 프로그램

	String driver = "oracle.jdbc.driver.OracleDriver";//oracle.jdbc.driver는 패키지명, OracleDriver는 
	//jdbc드라이버 클래스명
	String url = "jdbc:oracle:thin:@localhost:1521:xe";//오라클 접속주소,localhost는 모든 내자신 컴퓨터
	//호스트 이름, 1521은 오라클 연결 포트번호, xe는 데이터베이스명 
	String user = "night";//오라클 사용자이름
	String password = "123456";//오라클 사용자 비번
	
	Connection con = null;//데이터 베이스 연결 con
	PreparedStatement pt = null;//쿼리문 수행 pt
	ResultSet rs = null;//검색 결과 레코드를 저장할 rs
	String sql = null; //쿼리문 저장변수
	
	//방명록 저장
	public int insertGu(GuVO g) {
		int re = -1;//저장 실패시 반환값
				
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			sql = "insert into tbl_gu(gno,gname,gtitle,gcont) values(gno_seq10.nextval,?,?,?)";
			pt = con.prepareStatement(sql);//쿼리문을 미리 컴파일 하여 수행할 pt생성
			pt.setString(1,g.getGname());//쿼리문의 첫번째 물음표에 문자열로 작성자를 저장
			pt.setString(2,g.getGtitle());
			pt.setString(3,g.getGcont());
			
			re = pt.executeUpdate();//저장 쿼리문 수행후 성공한 레코드 행의 개수를 반환
			
		}catch(Exception e) {e.printStackTrace();}
			
		finally {
			try {
				if(pt != null) pt.close();
				if(con != null) con.close();
				//select문이 있을때는 rs도 닫아줘야함
			}catch(Exception e) {e.printStackTrace();}
		}
		return re;
	}//insertGu()
	
	//방명록 목록
	public List<GuVO> getGuList(){
		List<GuVO> glist = new ArrayList<>();
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			sql = "select * from tbl_gu order by gno desc";//번호를 기준으로 내림차순 정렬
			pt = con.prepareStatement(sql);
			rs = pt.executeQuery();//select문 수행후 검색 결과 레코드를 rs에 저장
			while(rs.next()) {//next()메서드는 다음 레코드행이 존재하면 참
				GuVO g = new GuVO();
				g.setGno(rs.getInt("gno"));//gno컬럼 레코드 값을 정수 숫자로 가져와서setter()메서드에 저장
				g.setGname(rs.getString("gname"));//gname컬럼 레코드값을 문자열로 가져와서 setter()메서드에 저장
				g.setGtitle(rs.getString("gtitle"));
				g.setGcont(rs.getString("gcont"));
				g.setGdate(rs.getString("gdate"));
				
				glist.add(g);//컬렉션에 추가
			}//while
		}catch(Exception e) {e.printStackTrace();}
		finally {
			try {
				if(rs != null) rs.close();
				if(pt != null) pt.close();
				if(con != null) con.close();
			}catch(Exception e) {e.printStackTrace();}
		}
		return glist;
	}//getGuList()
}