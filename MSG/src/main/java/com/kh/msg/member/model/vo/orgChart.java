package com.kh.msg.member.model.vo;

import java.io.Serializable;
import java.sql.Date;


public class orgChart extends Member implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String deptName;
	private String jobName;
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public orgChart(int empNo, String jobCd, String deptCd, String userId, String isManager, String userPwd,
			String empName, String empRRNNo, String empImage, String empContact, String empEmail, String empAddress, String authority,
			Date hireDate, String quitYn, String empMsg, String deptName, String jobName) {
		super(empNo, jobCd, deptCd, userId, isManager, userPwd, empName, empRRNNo, empImage, empContact, empEmail, empAddress, authority,
				hireDate, quitYn, empMsg);
		this.deptName = deptName;
		this.jobName = jobName;
	}


	public orgChart(String deptName, String jobName) {
		super();
		this.deptName = deptName;
		this.jobName = jobName;
	}


	public orgChart() {
		super();
		// TODO Auto-generated constructor stub
	}


	public orgChart(int empNo, String jobCd, String deptCd, String userId, String isManager, String userPwd,
			String empName, String empRRNNo, String empImage, String empContact, String empEmail, String empAddress, String authority,
			Date hireDate, String quitYn, String empMsg) {
		super(empNo, jobCd, deptCd, userId, isManager, userPwd, empName, empRRNNo, empImage, empContact, empEmail, empAddress, authority,
				hireDate, quitYn, empMsg);
		// TODO Auto-generated constructor stub
	}


	public String getDeptName() {
		return deptName;
	}


	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}


	public String getJobName() {
		return jobName;
	}


	public void setJobName(String jobName) {
		this.jobName = jobName;
	}


	@Override
	public String toString() {
		return "orgChart [deptName=" + deptName + ", jobName=" + jobName + "]";
	}


	
	
	
	
}
