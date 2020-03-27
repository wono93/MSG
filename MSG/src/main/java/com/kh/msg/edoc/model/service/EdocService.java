package com.kh.msg.edoc.model.service;

import java.util.List;

import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;

public interface EdocService {

	List<Jstree> selectJstree();

	JstreeMem selectJstreeMem(String name);

	
}
