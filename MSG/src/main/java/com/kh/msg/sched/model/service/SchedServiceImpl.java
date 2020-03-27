package com.kh.msg.sched.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.sched.model.dao.ScheDAO;
import com.kh.msg.sched.model.vo.Schedule;

@Service
public class SchedServiceImpl implements SchedService {

	@Autowired
	ScheDAO scheDAO;
	
	@Override
	public List<Schedule> schedList() {
		return scheDAO.schedList();
	}
	
	@Override
	public int insert(Schedule s) {
		return scheDAO.insert(s);
	}

}
