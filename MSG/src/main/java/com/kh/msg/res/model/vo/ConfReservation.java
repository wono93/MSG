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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((croomCode == null) ? 0 : croomCode.hashCode());
		result = prime * result + empNo;
		result = prime * result + ((resCode == null) ? 0 : resCode.hashCode());
		result = prime * result + ((resEnrolldate == null) ? 0 : resEnrolldate.hashCode());
		result = prime * result + ((resReturnDate == null) ? 0 : resReturnDate.hashCode());
		result = prime * result + ((resUseDate == null) ? 0 : resUseDate.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ConfReservation other = (ConfReservation) obj;
		if (croomCode == null) {
			if (other.croomCode != null)
				return false;
		} else if (!croomCode.equals(other.croomCode))
			return false;
		if (empNo != other.empNo)
			return false;
		if (resCode == null) {
			if (other.resCode != null)
				return false;
		} else if (!resCode.equals(other.resCode))
			return false;
		if (resEnrolldate == null) {
			if (other.resEnrolldate != null)
				return false;
		} else if (!resEnrolldate.equals(other.resEnrolldate))
			return false;
		if (resReturnDate == null) {
			if (other.resReturnDate != null)
				return false;
		} else if (!resReturnDate.equals(other.resReturnDate))
			return false;
		if (resUseDate == null) {
			if (other.resUseDate != null)
				return false;
		} else if (!resUseDate.equals(other.resUseDate))
			return false;
		return true;
	}
	
	
}
