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
public class Job implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String jobCd;
	private String jobName;
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
