package com.kh.msg.edoc.model.vo;

import java.io.Serializable;
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
	private String startDt;
	private String endDt;
	private int leaveAmt;
	private String leavePurpose;
	private String leaveContact;
	private int surEmpNo;
	private String typeCd;
	
	
	public EdocLeaveLtt(String edocId, String secuCd, String prsvCd, int empNo, int empModNo, String edocTitle,
			int edocVer, int edocOrgId, String edocDt, String edocEnd, String edocEndDt, List<EdocFlow> edocFlowList, List<EdocAtt> edocAttList,
			String vctnCd, String startDt, String endDt, int leaveAmt, String leavePurpose, String leaveContact, int surEmpNo, String typeCd) {
		super(edocId, secuCd, prsvCd, empNo, empModNo, edocTitle, edocVer, edocOrgId, edocDt, edocEnd, edocEndDt, edocFlowList, edocAttList);
		this.vctnCd = vctnCd;
		this.startDt = startDt;
		this.endDt = endDt;
		this.leaveAmt = leaveAmt;
		this.leavePurpose = leavePurpose;
		this.leaveContact = leaveContact;
		this.surEmpNo = surEmpNo;
		this.typeCd = typeCd;
	}

}
