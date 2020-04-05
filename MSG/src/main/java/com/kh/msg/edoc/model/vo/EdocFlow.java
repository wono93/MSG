package com.kh.msg.edoc.model.vo;

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
public class EdocFlow implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String edocId;
	private String flowCd;
	private String flowNm;
	private int flowEmpNo;
	private int flowOrd;
	private String flowSt;
	private String flowCmt;
	private Date flowDt;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
