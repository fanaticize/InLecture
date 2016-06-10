package com.team3.inlecture.lecture.statistics;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

@Repository(value="statisticsMapper")
public interface StatisticsMapper {

	ArrayList<StatisticsVO> getStatisticsList(int subjectSeq);

}
