package com.kh.msg.edoc.model.service;

import java.util.List;
import java.util.Map;

import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.edoc.model.vo.EdocAtt;
import com.kh.msg.edoc.model.vo.EdocFlow;
import com.kh.msg.edoc.model.vo.EdocLeaveLtt;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;
import com.kh.msg.member.model.vo.Member;

public interface EdocService {

	List<Jstree> selectJstree();

	JstreeMem selectJstreeMem(String id);

	List<EdocSrch> selectList(int cPage, int numPerPage, String srchWord, String srchType);

	int selectEdocTotalContents(String srchWord, String srchType);

	List<EdocSrch> selectMyList(int cPage, int numPerPage, Map<String, String> map);

	int selectMyEdocTotalContents(Map<String, String> map);

	String newEdocId();

	int edocWrite(EdocLeaveLtt edocLeaveLtt, List<EdocAtt> edocAttList, List<EdocFlow> edocFlowList);

	String insertPdf(EdocAtt edocAtt);

	EdocAtt selectPdf(String attachId);

	
}
