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
public class EdocAtt implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String attachId;
	private String edocId;
	private String edocPdfSt;
	private String originFilename;
	private String renamedFilename;
	private String uploadDate;
	private String attachStatus;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
