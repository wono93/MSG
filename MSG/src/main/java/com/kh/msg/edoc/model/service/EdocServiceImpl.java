package com.kh.msg.edoc.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.edoc.model.dao.EdocDAO;
import com.kh.msg.edoc.model.vo.EdocAtt;
import com.kh.msg.edoc.model.vo.EdocFlow;
import com.kh.msg.edoc.model.vo.EdocLeaveLtt;
import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;
import com.kh.msg.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EdocServiceImpl implements EdocService {

	@Autowired
	EdocDAO edocDAO;

	@Override
	public List<Jstree> selectJstree() {
		return edocDAO.selectJstree();
	}

	@Override
	public JstreeMem selectJstreeMem(String id) {
		return edocDAO.selectJstreeMem(id);
	}

	@Override
	public List<EdocSrch> selectList(int cPage, int numPerPage, String srchWord, String srchType) {
		// TODO Auto-generated method stub
		return edocDAO.selectList(cPage, numPerPage, srchWord, srchType);
	}

	@Override
	public int selectEdocTotalContents(String srchWord, String srchType) {
		// TODO Auto-generated method stub
		return edocDAO.selectEdocTotalContents(srchWord, srchType);
	}

	@Override
	public List<EdocSrch> selectMyList(int cPage, int numPerPage, Map<String, String> map) {
		// TODO Auto-generated method stub
		return edocDAO.selectMyList(cPage, numPerPage, map);
	}

	@Override
	public int selectMyEdocTotalContents(Map<String, String> map) {
		// TODO Auto-generated method stub
		return edocDAO.selectMyEdocTotalContents(map);
	}

	@Override
	public String newEdocId() {
		// TODO Auto-generated method stub
		return edocDAO.newEdocId();
	}

	@Override
	public int edocWrite(EdocLeaveLtt edocLeaveLtt, List<EdocAtt> edocAttList, List<EdocFlow> edocFlowList) {
		int result = 0;
		result = edocDAO.edocWrite(edocLeaveLtt);
		if(result==0) log.debug("edocWrite.edocWrite@EdocServiceImp = edoc이 등록 실패.");
		else log.debug("edocWrite.edocWrite@EdocServiceImp = edoc이 등록되었습니다.");
		
		result = 0;
		for(EdocAtt edocAtt : edocAttList) {
			result = edocDAO.edocAttWrite(edocAtt);
		}
		if(result==0) log.debug("edocAtt.edocWrite@EdocServiceImp = edocAtt이 등록 실패.");
		else log.debug("edocAtt.edocWrite@EdocServiceImp = edocAtt이 등록되었습니다.");
		
		result = 0;
		for(EdocFlow edocFlow : edocFlowList) {
			result = edocDAO.edocFlowWrite(edocFlow);
		}
		if(result==0) log.debug("edocFlow.edocWrite@EdocServiceImp = edocFlow이 등록 실패.");
		else log.debug("edocFlow.edocWrite@EdocServiceImp = edocFlow이 등록되었습니다.");
		return result;
	}
}
