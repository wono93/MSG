package com.kh.msg.edoc.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

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
public class EdocLeaveLtt extends Edoc implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String vctnCd;
	private Date startDt;
	private Date endDt;
	private int leaveAmt;
	private String leavePurpose;
	private String leaveContact;
	private String surEmpNo;
	
	
	public EdocLeaveLtt(String edocId, String secuCd, String prsvCd, int empNo, int empModNo, String edocTitle,
			int edocVer, int edocOrgId, Date edocDt, char edocEnd, Date edocEndDt, List<EdocFlow> edocFlowList, List<EdocAtt> edocAttList,
			String vctnCd, Date startDt, Date endDt, int leaveAmt, String leavePurpose, String leaveContact) {
		super(edocId, secuCd, prsvCd, empNo, empModNo, edocTitle, edocVer, edocOrgId, edocDt, edocEnd, edocEndDt, edocFlowList, edocAttList);
		this.vctnCd = vctnCd;
		this.startDt = startDt;
		this.endDt = endDt;
		this.leaveAmt = leaveAmt;
		this.leavePurpose = leavePurpose;
		this.leaveContact = leaveContact;
		this.surEmpNo = surEmpNo;
	}

}
