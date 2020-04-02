package com.kh.msg.board.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import com.kh.msg.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Board implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String title;
	private String content;
	private Date bdate;
	private int cnt;
	private String catag;
	private int empNo;
	private String keyword;
	private String catagkeyword;
	private int dateb;
	
	private List<Attachment> attachList;
	
	private List<Comment> commentList;
	
	private List<Member> memberList;
	
	private List<BoardScrap> scrapList;
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public Board(int no, String title, String content, Date bdate, int cnt, String catag, int empNo,
			String keyword, String catagkeyword, int dateb ) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.bdate = bdate;
		this.cnt = cnt;
		this.catag = catag;
		this.empNo = empNo;
		this.keyword = keyword;
		this.catagkeyword = catagkeyword;
		this.dateb = dateb;
	}
	

}
