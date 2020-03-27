package com.kh.msg.edoc.model.vo;

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
public class Jstree implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String parent;
	private String text;
	private String icon;
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
