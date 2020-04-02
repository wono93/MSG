package com.kh.msg.res.model.service;

import java.util.List;
import java.util.Map;

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

	@Override
	public List<ResView> selectAllMyRList() {
		return resDAO.selectAllMyRList();
	}

	@Override
	public int addConferenceRoom(ConferenceRoom c) {
		return resDAO.addConferenceRoom(c);
	}

	@Override
	public int addCar(Car c) { 
		return resDAO.addCar(c);
		
	}

	@Override
	public int getNextval(String seq) {
		return resDAO.getNextval(seq);
	}

	@Override
	public int delCar(String carCode) {
		return resDAO.delCar(carCode);
	}

	@Override
	public List<Car> selectCarListStart(String resUseDate) {
		return resDAO.selectCarListStart(resUseDate);
	}
	
	


}
