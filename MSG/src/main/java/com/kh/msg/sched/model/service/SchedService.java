package com.kh.msg.sched.model.service;

import java.util.List;

import com.kh.msg.sched.model.vo.Schedule;

public interface SchedService {

	List<Schedule> schedList();

	int insert(Schedule s);

}
