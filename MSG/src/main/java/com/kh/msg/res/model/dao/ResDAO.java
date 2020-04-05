package com.kh.msg.res.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.msg.member.model.vo.Member;
import com.kh.msg.res.model.vo.Car;
import com.kh.msg.res.model.vo.CarReservation;
import com.kh.msg.res.model.vo.ConfReservation;
import com.kh.msg.res.model.vo.ConferenceRoom;
import com.kh.msg.res.model.vo.ResView;
import com.kh.msg.res.model.vo.Reservation;

public interface ResDAO {

	List<ConferenceRoom> selectConfList();

	int confResInsert(ConfReservation cr);

	List<Car> selectCarList();

	int carResInsert(CarReservation cr);

	List<ResView> selectAllConfResList(String empNo, String srchFrom, String srchTo);
	
	List<ResView> selectAllCarResList(String empNo, String srchFrom, String srchTo);

	List<ResView> selectAllRList(String empNo, String srchFrom, String srchTo);

	int addConferenceRoom(ConferenceRoom c);

	int addCar(Car c);

	int getNextval(String seq);

	int delCar(String carCode);

	List<Car> selectCarListEnd(String resUseDate, String resReturnDate);

	List<ResView> selectResListByDate(String srchFrom, String srchTo);

}
