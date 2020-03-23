package com.kh.msg.board.model.vo;

import java.io.Serializable;
import java.sql.Date;

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
public class Comment implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String content;
	private Date date;
	private int level;
	private int cmtNo;
	private int empNo;
	private int brdNo;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

}
