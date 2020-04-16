package com.kh.msg.edoc.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.edoc.model.dao.EdocDAO;
import com.kh.msg.edoc.model.vo.EdocAtt;
import com.kh.msg.edoc.model.vo.EdocFlow;
import com.kh.msg.edoc.model.vo.EdocFlowEx;
import com.kh.msg.edoc.model.vo.EdocLeaveLtt;
import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.OrgChart;

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

	@Override
	public String insertPdf(EdocAtt edocAtt) {
		
		int result = edocDAO.insertPdf(edocAtt);
		String attachId = edocAtt.getAttachId();
		return attachId;
	}

	@Override
	public EdocAtt selectPdf(String attachId) {
		EdocAtt edocAtt = edocDAO.selectPdf(attachId);  
		
		return edocAtt;
	}

	@Override
	public EdocLeaveLtt selectEdocLeaveLtt(String edocId) {
		EdocLeaveLtt edocLeaveLtt = edocDAO.selectEdocLeaveLtt(edocId);
		return edocLeaveLtt;
	}

	@Override
	public List<EdocFlow> selectEdocFlowList(String edocId) {
		List<EdocFlow> edocFlowList = edocDAO.selectEdocFlowList(edocId);
		return edocFlowList;
	}

	@Override
	public List<EdocAtt> selectEdocAttList(String edocId) {
		List<EdocAtt> edocAttList = edocDAO.selectEdocAttList(edocId);
		return edocAttList;
	}

	@Override
	public int deleteEdocPdfSt() {
		int result = edocDAO.deleteEdocPdfSt();
		return result;
	}

	@Override
	public List<EdocFlowEx> selectEdocFlowExList(String edocId) {
		List<EdocFlowEx> edocFlowExList = edocDAO.selectEdocFlowExList(edocId);
		return edocFlowExList;
	}

	@Override
	public int updateFlowExe(EdocFlow edocFlow) {
		int result = edocDAO.updateFlowExe(edocFlow);
		return result;
	}

	@Override
	public int countSt(EdocFlow edocFlow) {
		int count = edocDAO.countSt(edocFlow);
		return count;
	}

	@Override
	public int updateEdocSt(EdocFlow edocFlow) {
		int complete = edocDAO.updateEdocSt(edocFlow);
		return complete;
	}

	@Override
	public List<OrgChart> selectNameSrch() {
		List<OrgChart> orgChartList = edocDAO.selectNameSrch();
		return orgChartList;
	}

	@Override
	public List<EdocSrch> selectEdocWelcome() {
		List<EdocSrch> edocSrchList = edocDAO.selectEdocWelcome();
		return edocSrchList;
	}
}
