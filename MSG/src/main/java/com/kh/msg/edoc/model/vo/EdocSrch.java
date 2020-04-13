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
public class EdocSrch extends Edoc implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String typeCd;
	private String formNm;
	private int prsvAmt;
	private String secuNm;
	private String empName;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public EdocSrch(String edocId, String secuCd, String prsvCd, int empNo, int empModNo, String edocTitle, int edocVer,
			int edocOrgId, String edocDt, String edocEnd, String edocEndDt, String typeCd, String formNm, int prsvAmt,
			String secuNm, String empName, List<EdocFlow> edocFlowList) {
		super(edocId, secuCd, prsvCd, empNo, empName, empModNo, edocTitle, edocVer, edocOrgId, edocDt, edocEnd, edocEndDt, edocFlowList);
		this.typeCd = typeCd;
		this.formNm = formNm;
		this.prsvAmt = prsvAmt;
		this.secuNm = secuNm;
		this.empName = empName;
	}


}
