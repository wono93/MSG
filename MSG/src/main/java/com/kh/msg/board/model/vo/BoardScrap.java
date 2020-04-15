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
public class BoardScrap implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int no;
	private int empNo;
	private String memo;
	private Date date;
	private Date bdate;
	private int cnt;
	private String catag;
	private String title;
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
