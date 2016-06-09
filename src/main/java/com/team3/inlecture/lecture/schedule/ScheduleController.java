package com.team3.inlecture.lecture.schedule;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "lecture/schedule")
public class ScheduleController {
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/scheduleManagePage", method = RequestMethod.GET)
	public String quizManagePage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			Model model){
		//ArrayList<QuizVO> quizList = quizService.selectQuizList(subjectSeq);
		//model.addAttribute("quizList", quizList);
		return "lecture/lectureSchedule";
	}
}
