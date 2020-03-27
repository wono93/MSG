package com.kh.msg.res.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ConferenceRoom implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String croomCode;
	private String croomName;
	private int croomSize;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
