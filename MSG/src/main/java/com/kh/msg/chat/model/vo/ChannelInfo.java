package com.kh.msg.chat.model.vo;

import java.io.Serializable;
import java.util.Date;

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
public class ChannelInfo extends ChannelMsg implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int chNo;
	private String chName;
	private String chEx;
	private Date chGenDate;
	private String regId;
	private String chStatus;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
