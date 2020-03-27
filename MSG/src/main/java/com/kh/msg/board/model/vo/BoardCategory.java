package com.kh.msg.board.model.vo;

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
public class BoardCategory implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String catag;
	private String catagN;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
}
