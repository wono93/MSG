package com.kh.msg.res.model.service;

import java.util.List;
import java.util.Map;

import com.kh.msg.res.model.vo.Car;
import com.kh.msg.res.model.vo.CarReservation;
import com.kh.msg.res.model.vo.ConfReservation;
import com.kh.msg.res.model.vo.ConferenceRoom;
import com.kh.msg.res.model.vo.ResView;
import com.kh.msg.res.model.vo.Reservation;

public interface ResService {
	
	List<ConferenceRoom> selectConfList();

	int confInsert(ConfReservation cr);

	List<Car> selectCarList();

	int carInsert(CarReservation cr);

	List<ResView> selectAllMyConfResList();

	List<ResView> selectAllMyCarResList();

	List<ResView> selectAllMyRList();

	int addConferenceRoom(ConferenceRoom c);

	int addCar(Car c);

	int getNextval(String seq);

	int delCar(String carCode);

	List<Car> selectCarListEnd(String resUseDate, String resReturnDate);


}
