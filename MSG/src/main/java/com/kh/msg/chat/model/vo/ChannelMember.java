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
public class ChannelMember extends OrgChart implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int chNo;
	private int empNo;
	private Date chDate;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}

