package com.kh.msg.res.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.res.model.dao.ResDAO;
import com.kh.msg.res.model.vo.Car;
import com.kh.msg.res.model.vo.CarReservation;
import com.kh.msg.res.model.vo.ConfReservation;
import com.kh.msg.res.model.vo.ConferenceRoom;
import com.kh.msg.res.model.vo.ResView;
import com.kh.msg.res.model.vo.Reservation;

@Service
public class ResServiceImpl implements ResService {

	@Autowired
	ResDAO resDAO;
	
	@Override
	public List<ConferenceRoom> selectConfList() {
		return resDAO.selectConfList();
	}
	
	@Override
	public int confInsert(ConfReservation cr) {
		return resDAO.confInsert(cr);
	}

	@Override
	public List<Car> selectCarList() {
		return resDAO.selectCarList();
	}

	@Override
	public int carInsert(CarReservation cr) {
		return resDAO.carInsert(cr);
	}

	@Override
	public List<ResView> selectAllMyConfResList() {
		return resDAO.selectAllMyConfResList();
	}

	@Override
	public List<ResView> selectAllMyCarResList() {
		return resDAO.selectAllMyCarResList();
	}


}
