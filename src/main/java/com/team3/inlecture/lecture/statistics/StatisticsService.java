package com.team3.inlecture.lecture.statistics;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("statisticsService")
public class StatisticsService {
	@Autowired
	StatisticsMapper statisticsMapper;

	public ArrayList<StatisticsVO> getStatisticsList(int subjectSeq) {
		return statisticsMapper.getStatisticsList(subjectSeq);
	}
	

}
