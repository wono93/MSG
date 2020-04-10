package com.kh.msg.sched.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SchedEmp implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int empNo;
	private String empRrnNo;
	private String deptName;
	private String jobName;
	private String empName;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
}
