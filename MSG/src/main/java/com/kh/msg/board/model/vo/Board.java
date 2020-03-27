package com.kh.msg.board.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

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
	private Date date;
	private int cnt;
	private String catag;
	private int empNo;
	
	private List<Attachment> attachList;
	
	private List<Comment> commentList;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public Board(int no, String title, String content, Date date, int cnt, String catag, int empNo) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.date = date;
		this.cnt = cnt;
		this.catag = catag;
		this.empNo = empNo;
	}
	

}
