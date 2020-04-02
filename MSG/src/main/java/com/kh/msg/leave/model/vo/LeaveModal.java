package com.kh.msg.leave.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LeaveModal implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int empNo;
	private int annual;
	private int reward;
	private int vctnNo;
	private int vctnCd;
	private String vctnNm;
	private int vctnAmt;
	private Date vctnUpdtDt;
	private String vctnReason;
	private String edocId;
	

	
	public static long getSerialversionuid() {
		return serialVersionUID;

	
	}	
}
