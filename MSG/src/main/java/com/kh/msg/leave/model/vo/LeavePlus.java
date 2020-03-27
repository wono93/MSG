package com.kh.msg.leave.model.vo;

import java.io.Serializable;

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
public class LeavePlus implements Serializable{

	private static final long serialVersionUID = 1L;
	
	 private int vctnUsed;
	 private int empNo;
	 private int dtlNo;
	 private int vctnCd;
      	 
	public static long getSerialversionuid() {
		return serialVersionUID;

	
	}	
}
