package com.kh.msg.member.model.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.SimpleTimeZone;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.Member;
import com.kh.msg.member.model.vo.Vacation;

import lombok.extern.slf4j.Slf4j;


@Repository
@Slf4j
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public Member selectOne(String userId) {
		
		return sqlSession.selectOne("member.selectOne",userId);
	}

	@Override
	public List<HrMntList> selectList(Map<String, String> map) {
		Date curDate = Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST")).getTime();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date today = null;
		Date vctnEndt = null;
		Date vctnStdt = null;
		
		List<HrMntList> hrmntlist = sqlSession.selectList("member.selectHrMngList",map);
		log.debug("HrMntList = {} ",hrmntlist);
		List<Vacation> vac = sqlSession.selectList("member.selectVacationCount",map);
		for(HrMntList hr : hrmntlist) {
			for(Vacation v : vac) {
				if(hr.getEmpNo() == v.getEmpNo()){
					try {
						today = fmt.parse(fmt.format(curDate));
						vctnEndt = fmt.parse(v.getVctnEndt());
						vctnStdt = fmt.parse(v.getVctnStdt());
						int compare = today.compareTo(vctnEndt);
						//현재 기준 휴가가 진행중인경우
						if(compare < 0) {
							//오늘-휴가시작일
							// 두날짜의 차이 구하기 
									
							// 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
							long diff = today.getTime() - vctnStdt.getTime();
							long diffDays = diff / (24 * 60 * 60 * 1000);

							hr.setVctnCount(hr.getVctnCount()+(int)diffDays+1);

						}
						else {
							//휴가종료일-휴가시작일
							long diff = vctnEndt.getTime() - vctnStdt.getTime();
							long diffDays = diff / (24 * 60 * 60 * 1000);

							hr.setVctnCount(hr.getVctnCount()+(int)diffDays+1);
						}
						
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		return hrmntlist;
	}
}
