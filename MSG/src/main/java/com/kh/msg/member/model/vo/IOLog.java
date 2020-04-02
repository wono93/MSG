package com.kh.msg.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class IOLog extends HrMntList implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Date taken;
	private String inoutFg;
	public IOLog() {
		super();
		// TODO Auto-generated constructor stub
	}
	public IOLog(String DeptName, int empNo, String empName, int workedDays, int lateCount, int leaveCount,
			int absentCount, int vctnCount, Date taken, String inoutFg) {
		super(DeptName, empNo, empName, workedDays, lateCount, leaveCount, absentCount, vctnCount);
		this.taken = taken;
		this.inoutFg = inoutFg;
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
		return "IOLog [ taken=" + taken + ", inoutFg=" + inoutFg + "]";
	}
	
	
	
}
