package com.kh.msg.leave.model.vo;

import java.io.Serializable;
import java.sql.Date;
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
public class LeaveSet implements Serializable{

	private static final long serialVersionUID = 1L;
	
     private int empNo;
	 private int vctnNo;
	 private String deptName;
	 private String empName;
	 private int longevity;
	 private int reward;
     private int annual;
     	
     
	public static long getSerialversionuid() {
		return serialVersionUID;

	
	}	
	
	
}
