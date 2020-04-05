package com.kh.msg.res.model.vo;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
public class ResView implements Serializable, Comparable<ResView>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 구분(대여물품코드) 대여명 수용인원 대여시간 대여시작 대여종료
	private String thingCode;
	private String thingName;
	private int thingSize;
	private int howLong;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private Date resUseDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private Date resReturnDate;
	private int empNo;
	private String thingCate;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int compareTo(ResView r) {
		return r.getResUseDate().compareTo(getResUseDate());
	}
	
	

}
