package com.kh.msg.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class IOLog extends orgChart implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Date day;
	private Date taken;
	private String inoutFg;
	public IOLog() {
		super();
		// TODO Auto-generated constructor stub
	}
	public IOLog(int empNo, String jobCd, String deptCd, String userId, String isManager, String userPwd,
			String empName, String empRRNNo, String empImage, String empContact, String empEmail, String empAddress,
			String authority, Date hireDate, String quitYn, String empMsg, String deptName, String jobName, Date day,
			Date taken, String inoutFg) {
		super(empNo, jobCd, deptCd, userId, isManager, userPwd, empName, empRRNNo, empImage, empContact, empEmail,
				empAddress, authority, hireDate, quitYn, empMsg, deptName, jobName);
		this.day = day;
		this.taken = taken;
		this.inoutFg = inoutFg;
	}
	public Date getDay() {
		return day;
	}
	public void setDay(Date day) {
		this.day = day;
	}
	public Date getTaken() {
		return taken;
	}
	public void setTaken(Date taken) {
		this.taken = taken;
	}
	public String getInoutFg() {
		return inoutFg;
	}
	public void setInoutFg(String inoutFg) {
		this.inoutFg = inoutFg;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "IOLog [day=" + day + ", taken=" + taken + ", inoutFg=" + inoutFg + "]";
	}
	
	
	
}
