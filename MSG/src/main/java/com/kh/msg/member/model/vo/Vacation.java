package com.kh.msg.member.model.vo;

import java.io.Serializable;

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
public class Vacation implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int empNo;
	private int vctnDtlNo;
	private String vctnStdt;
	private String vctnEndt;
	
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
