package net.daum.vo;

public class BoardVO {//중간에 자료 저장하는 데이터 저장빈 클래스=>되도록이면 tbl_board10테이블의 컬럼명과 빈클래스
	//변수명은 같게 한다.
	
	private int bno;//게시판 번호
	private String bname;//글쓴이
	private String btitle;//글제목
	private String bcont;//글내용
	private int bhit;//조회수
	private String bdate;//등록날짜
	
	public int getBno() {//getter()메서드
		return bno;
	}
	public void setBno(int bno) {//setter() 메서드
		this.bno = bno;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBcont() {
		return bcont;
	}
	public void setBcont(String bcont) {
		this.bcont = bcont;
	}
	public int getBhit() {
		return bhit;
	}
	public void setBhit(int bhit) {
		this.bhit = bhit;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
}
