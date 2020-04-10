package com.kh.msg.chat.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.kh.msg.member.model.vo.OrgChart;

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
public class ChannelMsg extends OrgChart implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int chMsgNo;
	private int chNo;
	private int empNo;
	private String userId;
	private String msgContent;
	private Date msgDate;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
