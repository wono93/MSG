package com.kh.msg.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

import org.springframework.stereotype.Repository;

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
public class Member implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int empNo;
	private String jobCd;
	private String deptCd;
	private String userId;
	private String isManager;
	private String userPwd;
	private String empName;
	private String empImage;
	private String empContact;
	private String empEmail;
	private String empAddress;
	private String authority;
	private Date hireDate;
	private String quitYn;
	private String empMsg;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
