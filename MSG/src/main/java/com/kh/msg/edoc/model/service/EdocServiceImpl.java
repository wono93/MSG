package com.kh.msg.edoc.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.edoc.model.dao.EdocDAO;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;

@Service
public class EdocServiceImpl implements EdocService {

	@Autowired
	EdocDAO edocDAO;

	@Override
	public List<Jstree> selectJstree() {
		return edocDAO.selectJstree();
	}

	@Override
	public JstreeMem selectJstreeMem(String name) {
		return edocDAO.selectJstreeMem(name);
	}
}
