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
public class LeaveReward implements Serializable{


	private static final long serialVersionUID = 1L;
	 
	private int reward;
	private int empNo;
	private String vctnCd;

	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}