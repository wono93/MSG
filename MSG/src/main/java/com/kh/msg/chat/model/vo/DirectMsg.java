package com.kh.msg.chat.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.kh.msg.member.model.vo.Member;

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
public class DirectMsg extends Member implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int msgNo;
	private int empNo;
	private String toId;
	private String fromId;
	private String msgContent;
	private Date msgDate;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
