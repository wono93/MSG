package com.kh.msg.leave.model.vo;

import java.io.Serializable;
import java.util.List;

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
public class LeaveSum implements Serializable{


	private static final long serialVersionUID = 1L;
	
   	 private int empNo;
	 private String deptName;
	 private String empName;
	 private int longevity;
	 private int annual;
     private int reward;
     
	public static long getSerialversionuid() {
		return serialVersionUID;

	
	}	
	
	
}
