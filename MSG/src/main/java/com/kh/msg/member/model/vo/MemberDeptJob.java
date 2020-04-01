package com.kh.msg.member.model.vo;

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
public class MemberDeptJob extends Member implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String jobName;
	private String deptName;
	private String superDept;
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public MemberDeptJob(int empNo, String jobCd, String deptCd, String userId, String isManager, String userPwd,
			String empName, String empImage, String empContact, String empEmail, String empAddress, String authority,
			Date hireDate, String quitYn, String empMsg, String jobName, String deptName, String superDept) {
		super(empNo, jobCd, deptCd, userId, isManager, userPwd, empName, empImage, empContact, empEmail, empAddress, authority,
				hireDate, quitYn, empMsg);
		this.jobName = jobName;
		this.deptName= deptName;
		this.superDept = superDept;
	}

	
	
}
