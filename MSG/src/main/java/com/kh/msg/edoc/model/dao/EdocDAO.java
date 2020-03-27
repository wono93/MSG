package com.kh.msg.edoc.model.dao;

import java.util.List;

import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;

public interface EdocDAO {

	List<Jstree> selectJstree();

	JstreeMem selectJstreeMem(String name);

}
