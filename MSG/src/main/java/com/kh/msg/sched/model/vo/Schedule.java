package com.kh.msg.sched.model.vo;

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
public class Schedule implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int scheCode;
	private String scheCate;
	private int empNo;
	private String scheName;
	private Date scheStart;
	private Date scheEnd;
	private String scheColor;
	private String scheEx;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
	
}
