package com.kh.msg.common.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Utils {

	public static String getRefile(String file) {
		//기존파일의 확장자
		String ext = "";
		int dotIndex = file.lastIndexOf(".");
		if(dotIndex > -1)
			ext = file.substring(dotIndex);// .txt
		
		//새파일명:yyyyMMdd_HHmmssSSS_rnd.txt
		String refile 
			= new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(new Date())
			+ "_" + (int)(Math.random()*1000)
			+ ext;
		
		return refile;
	}

}
