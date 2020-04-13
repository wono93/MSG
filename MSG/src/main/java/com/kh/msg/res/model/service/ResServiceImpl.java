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
	public List<ResView> selectAllConfResList(String empNo, String srchFrom, String srchTo) {
		return resDAO.selectAllConfResList(empNo, srchFrom, srchTo);
	}

	@Override
	public List<ResView> selectAllCarResList(String empNo, String srchFrom, String srchTo) {
		return resDAO.selectAllCarResList(empNo, srchFrom, srchTo);
	}

	@Override
	public List<ResView> selectAllRList(String empNo, String srchFrom, String srchTo) {
		return resDAO.selectAllRList(empNo, srchFrom, srchTo);
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

	@Override
	public int delRes(String resCate, String resCode) {
		return resDAO.delRes(resCate, resCode);
	}

	@Override
	public int confToSchedInsert(ConfReservation cr) {
		return resDAO.confToSchedInsert(cr);
	}

	@Override
	public int carToSchedInsert(CarReservation cr) {
		return resDAO.carToSchedInsert(cr);
	}

	@Override
	public int delResToSched(String resCate, String resCode) {
		return resDAO.delResToSched(resCate, resCode);
	}
	
	


}
