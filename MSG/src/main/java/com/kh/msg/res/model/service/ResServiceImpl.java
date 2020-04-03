package com.kh.msg.res.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.msg.member.model.vo.Member;
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
	public int confResInsert(ConfReservation cr) {
		return resDAO.confResInsert(cr);
	}

	@Override
	public List<Car> selectCarList() {
		return resDAO.selectCarList();
	}

	@Override
	public int carResInsert(CarReservation cr) {
		return resDAO.carResInsert(cr);
	}

	@Override
	public List<ResView> selectAllConfResList(Member m) {
		return resDAO.selectAllConfResList(m);
	}

	@Override
	public List<ResView> selectAllCarResList(Member m) {
		return resDAO.selectAllCarResList(m);
	}

	@Override
	public List<ResView> selectAllRList(Member m) {
		return resDAO.selectAllRList(m);
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
	public List<Car> selectCarListEnd(String resUseDate, String resReturnDate) {
		return resDAO.selectCarListEnd(resUseDate, resReturnDate);
	}
	
	


}
