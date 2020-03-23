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
public class Attachment implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private int brdNo;
	private String file;
	private String refile;
	private int dwnCnt;
	private String status;
	private Date date;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
