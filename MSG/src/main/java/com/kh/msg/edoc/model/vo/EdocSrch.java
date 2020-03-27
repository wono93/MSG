package com.kh.msg.edoc.model.vo;

import java.io.Serializable;
import java.sql.Date;

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
public class EdocSrch implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String edocId;
	private String secuCd;
	private String prsvCd;
	private int empNo;
	private int empModNo;
	private String edocTitle;
	private String attachTitle;
	private String attachOriTitle;
	private int edocVer;
	private int edocOrgId;
	private Date edocDt;
	private int typeCd;




	public static long getSerialversionuid() {
		return serialVersionUID;
	}


}
