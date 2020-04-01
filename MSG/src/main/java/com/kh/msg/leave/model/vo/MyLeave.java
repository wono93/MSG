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
public class MyLeave implements Serializable{


	private static final long serialVersionUID = 1L;
	
	private int empNo;
	private int vctnDtlNo;
	private Date vctnStdt; 
	private Date vctnEndt;
	private String userId;
	private String vctnReason;
	private String vctnNm;
	private int vctnCd;		
    private int vctnUsed;   
     
	public static long getSerialversionuid() {
		return serialVersionUID;

	
	}	
	
	
}
