package com.kh.msg.edoc.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;

@Repository
public class EdocDAOImpl implements EdocDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Jstree> selectJstree() {
		return sqlSession.selectList("edoc.jstree");
	}

	@Override
	public JstreeMem selectJstreeMem(String name) {
		return sqlSession.selectOne("edoc.jstreeMem", name);
	}
	
	
}
