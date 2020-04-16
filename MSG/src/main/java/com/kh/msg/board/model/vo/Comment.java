package com.kh.msg.board.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

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
public class Comment implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String cmtContent;
	private Date date;
	private int level;
	private int cmtNo;
	private int empNo;
	private int brdNo;
	private String jobCd;
	private String deptCd;
	private String empName;
	private String empImage;
	private List<OrgChart> memberList;
	private String jobName;
	private String deptName;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

}
