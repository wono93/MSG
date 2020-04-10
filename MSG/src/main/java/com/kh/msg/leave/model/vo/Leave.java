package com.kh.msg.leave.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import com.kh.msg.edoc.model.vo.EdocFlow;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Leave implements Serializable{

	private static final long serialVersionUID = 1L;
	
	 private int vctnDtlNo;
	 private Date vctnStdt;
     private Date vctnEndt;
     private Date appDt;
     private int vctnUsed;
	 private String empName;
	 private String deptName;
	 private String vctnNm;
	 private String vctnReason;
	public static long getSerialversionuid() {
		return serialVersionUID;

	
	}	
	
}
