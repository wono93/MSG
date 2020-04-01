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
public class EdocSrch implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String edocId;
	private String secuCd;
	private String prsvCd;
	private int empNo;
	private int empModNo;
	private String edocTitle;
	private int edocVer;
	private int edocOrgId;
	private Date edocDt;
	private char edocEnd;
	private Date edocEndDt;	
	private int typeCd;
	private String formNm;
	private int prsvAmt;
	private String secuNm;
	private String empName;
	
	private List<EdocSrchFlow> SrchFlowList;
	
	

	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public EdocSrch(String edocId, String secuCd, String prsvCd, int empNo, int empModNo, String edocTitle, int edocVer,
			int edocOrgId, Date edocDt, char edocEnd, Date edocEndDt, int typeCd, String formNm, int prsvAmt,
			String secuNm, String empName) {
		super();
		this.edocId = edocId;
		this.secuCd = secuCd;
		this.prsvCd = prsvCd;
		this.empNo = empNo;
		this.empModNo = empModNo;
		this.edocTitle = edocTitle;
		this.edocVer = edocVer;
		this.edocOrgId = edocOrgId;
		this.edocDt = edocDt;
		this.edocEnd = edocEnd;
		this.edocEndDt = edocEndDt;
		this.typeCd = typeCd;
		this.formNm = formNm;
		this.prsvAmt = prsvAmt;
		this.secuNm = secuNm;
		this.empName = empName;
	}
	

}
