package com.kh.msg.res.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.res.model.vo.Car;
import com.kh.msg.res.model.vo.CarReservation;
import com.kh.msg.res.model.vo.ConfReservation;
import com.kh.msg.res.model.vo.ConferenceRoom;
import com.kh.msg.res.model.vo.ResView;
import com.kh.msg.res.model.vo.Reservation;

@Repository
public class ResDAOImpl implements ResDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<ConferenceRoom> selectConfList() {
		return sqlSession.selectList("res.selectConfList");
	}
	
	@Override
	public int confInsert(ConfReservation cr) {
		return sqlSession.insert("res.confInsert", cr);
	}

	@Override
	public List<Car> selectCarList() {
		return sqlSession.selectList("res.selectCarList");
	}

	@Override
	public int carInsert(CarReservation cr) {
		return sqlSession.insert("res.carInsert", cr);
	}
	
	@Override
	public List<ResView> selectAllMyConfResList() {
		return sqlSession.selectList("res.selectAllMyConfResList");
	}

	@Override
	public List<ResView> selectAllMyCarResList() {
		return sqlSession.selectList("res.selectAllMyCarResList");
	}

	@Override
	public List<ResView> selectAllMyRList() {
		return sqlSession.selectList("res.selectAllMyRList");
	}

	@Override
	public int addConferenceRoom(ConferenceRoom c) {
		return sqlSession.insert("res.addConferenceRoom", c);
	}

	@Override
	public int addCar(Car c) {
		return sqlSession.insert("res.addCar", c);
	}

	@Override
	public int getNextval(String seq) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("seq", seq);
		return sqlSession.selectOne("res.getNextval", map);
	}

	@Override
	public int delCar(String carCode) {
		return sqlSession.delete("res.delCar", carCode);
	}
	
	


}
