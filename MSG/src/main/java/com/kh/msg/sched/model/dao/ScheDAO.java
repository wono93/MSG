package com.kh.msg.sched.model.dao;

import java.util.List;

import com.kh.msg.sched.model.vo.Schedule;

public interface ScheDAO {

	List<Schedule> schedList();

	int insert(Schedule s);

}
