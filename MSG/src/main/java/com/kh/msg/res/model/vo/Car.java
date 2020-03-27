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
public class Car implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String carCode;
	private String carCate;
	private String carCompany;
	private String carType;
	private String carNo;
	private int carSize;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

}
