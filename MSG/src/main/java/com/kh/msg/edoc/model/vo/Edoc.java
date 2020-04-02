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
public class Edoc implements Serializable{
	
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
	
	private List<EdocFlow> edocFlowList;
	
	private List<EdocAtt> edocAttList;

	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public Edoc(String edocId, String secuCd, String prsvCd, int empNo, int empModNo, String edocTitle,
			int edocVer, int edocOrgId, Date edocDt, char edocEnd, Date edocEndDt, List<EdocFlow> edocFlowList) {
		// TODO Auto-generated constructor stub
	}

	
}
