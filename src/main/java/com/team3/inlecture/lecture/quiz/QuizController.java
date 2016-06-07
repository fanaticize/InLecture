package com.team3.inlecture.lecture.quiz;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "lecture/quiz")
public class QuizController {
	@Autowired
    private QuizService quizService;
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizManagePage", method = RequestMethod.GET)
	public String quizManagePage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			Model model){
		ArrayList<QuizVO> quizList = quizService.selectQuizList(subjectSeq);
		model.addAttribute("quizList", quizList);
		return "lecture/quiz/quizManage";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/getQuiz", method = RequestMethod.GET)
	public @ResponseBody QuizVO quizProblems(@PathVariable int subjectSeq,
			@RequestBody QuizVO quizVO){
		return quizService.selectQuizProblem(quizVO.getQuizSeq());
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizInsert", method = RequestMethod.POST)
	public String quizInsert(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute("quiz") QuizVO quiz,
			Model model){
		quizService.insertQuiz(quiz);
		return "redirect:quizManage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizDelete", method = RequestMethod.GET)
	public String quizDelete(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@RequestParam int quizSeq,
			Model model){
		quizService.deleteQuiz(quizSeq);
		return "redirect:quizManage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizModify", method = RequestMethod.POST)
	public String quizDModify(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute("quiz") QuizVO quiz,
			Model model){
		quizService.modifyQuiz(quiz);
		return "redirect:quizManage.do";
	}

}
