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
public class Department implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String deptCd;
	private String deptName;
	private String superDept;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
