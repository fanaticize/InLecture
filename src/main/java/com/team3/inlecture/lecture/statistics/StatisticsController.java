package com.team3.inlecture.lecture.statistics;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping(value = "lecture/statistics")
public class StatisticsController {
	@Autowired
    private StatisticsService statisticsService;
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/statisticsPage", method = RequestMethod.GET)
	public String statisticsPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			Model model){
		ArrayList<StatisticsVO> statisticsList = statisticsService.getStatisticsList(subjectSeq);
		model.addAttribute("statisticsList", statisticsList);
		return "lecture/statistics";
	}
	
}
