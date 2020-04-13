package com.kh.msg.edoc.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;



public class EdocFlowEx extends EdocFlow implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String empName;
	private String empImage;
	private String jobName;
	private String deptName;
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public EdocFlowEx() {
		super();
		// TODO Auto-generated constructor stub
	}


	public EdocFlowEx(int flowExeNo, String edocId, String flowCd, String flowNm, String flowEmpNo, int flowOrd,
			String flowSt, String flowCmt, String flowDt) {
		super(flowExeNo, edocId, flowCd, flowNm, flowEmpNo, flowOrd, flowSt, flowCmt, flowDt);
		// TODO Auto-generated constructor stub
	}


	public EdocFlowEx(String empName, String empImage, String jobName, String deptName) {
		super();
		this.empName = empName;
		this.empImage = empImage;
		this.jobName = jobName;
		this.deptName = deptName;
	}


	public String getEmpName() {
		return empName;
	}


	public void setEmpName(String empName) {
		this.empName = empName;
	}


	public String getEmpImage() {
		return empImage;
	}


	public void setEmpImage(String empImage) {
		this.empImage = empImage;
	}


	public String getJobName() {
		return jobName;
	}


	public void setJobName(String jobName) {
		this.jobName = jobName;
	}


	public String getDeptName() {
		return deptName;
	}


	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}


	@Override
	public String toString() {
		return "EdocFlowEx [empName=" + empName + ", empImage=" + empImage + ", jobName=" + jobName + ", deptName="
				+ deptName + "]";
	}


	
}
