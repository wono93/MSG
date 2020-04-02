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
public class HrMntList implements Serializable{
	private static final long serialVersionUID = 1L;
	private String DeptName;
	private int empNo;
	private String empName;
	private int workedDays;
	private int lateCount;
	private int leaveCount;
	private int absentCount;
	private int vctnCount;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
