package com.kh.msg.edoc.model.vo;

import java.io.Serializable;
import java.sql.Date;

import com.kh.msg.member.model.vo.Member;

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
public class JstreeMem extends Member implements Serializable{
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
	


	public JstreeMem(int empNo, String jobCd, String deptCd, String userId, String isManager, String userPwd,
			String empName, String empRRNNo, String empImage, String empContact, String empEmail, String empAddress,
			String authority, Date hireDate, String quitYn, String empMsg, String jobName, String deptName, String superDept) {
		super(empNo, jobCd, deptCd, userId, isManager, userPwd, empName, empRRNNo, empImage, empContact, empEmail, empAddress,
				authority, hireDate, quitYn, empMsg);
		this.jobName = jobName;
		this.deptName= deptName;
		this.superDept = superDept;
	}

	
	
}
