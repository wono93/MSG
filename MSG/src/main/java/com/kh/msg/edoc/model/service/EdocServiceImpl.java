package com.kh.msg.edoc.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.edoc.model.dao.EdocDAO;
import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;
import com.kh.msg.member.model.vo.Member;

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
}
