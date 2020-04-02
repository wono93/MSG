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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((carCate == null) ? 0 : carCate.hashCode());
		result = prime * result + ((carCode == null) ? 0 : carCode.hashCode());
		result = prime * result + ((carCompany == null) ? 0 : carCompany.hashCode());
		result = prime * result + ((carNo == null) ? 0 : carNo.hashCode());
		result = prime * result + carSize;
		result = prime * result + ((carType == null) ? 0 : carType.hashCode());
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
		Car other = (Car) obj;
		if (carCate == null) {
			if (other.carCate != null)
				return false;
		} else if (!carCate.equals(other.carCate))
			return false;
		if (carCode == null) {
			if (other.carCode != null)
				return false;
		} else if (!carCode.equals(other.carCode))
			return false;
		if (carCompany == null) {
			if (other.carCompany != null)
				return false;
		} else if (!carCompany.equals(other.carCompany))
			return false;
		if (carNo == null) {
			if (other.carNo != null)
				return false;
		} else if (!carNo.equals(other.carNo))
			return false;
		if (carSize != other.carSize)
			return false;
		if (carType == null) {
			if (other.carType != null)
				return false;
		} else if (!carType.equals(other.carType))
			return false;
		return true;
	}
	
	
	
	

}
