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
public class LeaveInfoPlus   implements Serializable{


	private static final long serialVersionUID = 1L;
	
	private int empNo;
	private String deptName;
	private String jobName;
	private String empName;
	private String userId;
	private int annual;
	private int reward;
	private String vctnCd;
	private String vctnNm;
	private int vctnUsed;
	private int annualUsed;
    private int rewardUsed;
    private int floatingUsed; 
    private int familyeventUsed;
    private int sickleaveUsed;
    private int unpaidUsed;
    private int otherUsed;
    private int annualNotUsed;
    private int rewardNotused;
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;

	
	}	
	
	
}
