package net.daum.controller;

import java.util.List;

import net.daum.dao.GuDAOImpl;
import net.daum.vo.GuVO;

public class Gu_list {//방명록 목록 보기
	public static void main(String[] args) {
		
		GuDAOImpl gdao = new GuDAOImpl();
		List<GuVO> glist = gdao.getGuList();//목록 가져오기
		
		System.out.println("No \t title \t name \t cont \t date");
		System.out.println("----------------------------------------------->");
		
		if(glist != null && glist.size() > 0) {
			for(GuVO g : glist) {
				System.out.println(g.getGno()+"\t"+g.getGtitle()+"\t"+
				g.getGname()+"\t"+g.getGcont()+"\t"+g.getGdate());
			}//for
		}else {
			System.out.println("게시물 목록이 없습니다!");
		}//if else
	
	}//main
}//class
