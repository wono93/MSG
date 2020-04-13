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
public class Edoc implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String edocId;
	private String secuCd;
	private String prsvCd;
	private int empNo;
	private String empName;
	private int empModNo;
	private String edocTitle;
	private int edocVer;
	private int edocOrgId;
	private String edocDt;
	private String edocEnd;
	private String edocEndDt;	
	
	private List<EdocFlow> edocFlowList;
	
	private List<EdocAtt> edocAttList;

	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public Edoc(String edocId, String secuCd, String prsvCd, int empNo, String empName, int empModNo, String edocTitle,
			int edocVer, int edocOrgId, String edocDt, String edocEnd, String edocEndDt, List<EdocFlow> edocFlowList) {
		// TODO Auto-generated constructor stub
	}

	
}
