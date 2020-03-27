package com.kh.msg.res.model.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
public class ConfReservation implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String resCode;
	private int empNo;
	private String croomCode;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private Date resEnrolldate;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private Date resUseDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private Date resReturnDate;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
