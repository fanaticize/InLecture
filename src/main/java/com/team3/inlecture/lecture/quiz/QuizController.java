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
		return "lecture/lectureQuiz";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/getQuiz", method = RequestMethod.GET)
	public @ResponseBody QuizVO quizProblems(@PathVariable int subjectSeq,
			@RequestBody QuizVO quizVO){
		return quizService.selectQuizProblem(quizVO.getQuizSeq());
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizInsertPage", method = RequestMethod.GET)
	public String quizInsert(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq){
		
		return "lecture/lectureQuizInsert";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizInsert", method = RequestMethod.POST)
	public String quizInsert(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute QuizVO quiz,
			Model model){
		quizService.insertQuiz(quiz, subjectSeq);
		return "redirect:quizManagePage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizDelete", method = RequestMethod.GET)
	public String quizDelete(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@RequestParam int quizSeq,
			Model model){
		quizService.deleteQuiz(quizSeq);
		return "redirect:quizManagePage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizModifyPage", method = RequestMethod.GET)
	public String quizModify(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@RequestParam int quizSeq,
			Model model){
		QuizVO quiz = quizService.selectQuizProblem(quizSeq);
		model.addAttribute("quiz", quiz);
		return "lecture/lectureQuizModify";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizModify", method = RequestMethod.POST)
	public String quizModify(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute QuizVO quiz,
			Model model){
		quizService.modifyQuiz(quiz);
		return "redirect:quizManagePage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizStart", method = RequestMethod.GET)
	public String quizModify(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@RequestParam int quizSeq){
		quizService.startQuiz(quizSeq);
		return "redirect:quizManagePage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizEnd", method = RequestMethod.GET)
	public String quizEnd(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@RequestParam int quizSeq){
		quizService.endQuiz(quizSeq);
		return "redirect:quizManagePage.do";
	}
	
	@Secured("ROLE_STUDENT")
	@RequestMapping(value = "{subjectSeq}/quizSelectPage.do", method = RequestMethod.GET)
	public String quizSelectPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			Model model){
		ArrayList<QuizStudentVO> quizList = quizService.selectStartedQuizList(subjectSeq);
		model.addAttribute("quizList", quizList);
		return "lecture/lectureQuizSelect";
	}
	
	@Secured("ROLE_STUDENT")
	@RequestMapping(value = "{subjectSeq}/takeQuizPage.do", method = RequestMethod.GET)
	public String takeQuizPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@RequestParam int quizSeq,
			Model model){
		QuizVO quiz = quizService.selectQuizProblem(quizSeq);
		model.addAttribute("quiz", quiz);
		return "lecture/lectureTakeQuiz";
	}
	
	@Secured("ROLE_STUDENT")
	@RequestMapping(value = "{subjectSeq}/insertQuizAnswer", method = RequestMethod.POST)
	public String quizDModify(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute QuizStudentVO quiz,
			Model model){
		quizService.insertQuizAnswer(quiz);
		return "redirect:quizSelectPage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/quizGradingPage", method = RequestMethod.GET)
	public String quizGradingPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute("quizSeq") int quizSeq,
			Model model){
		ArrayList<QuizStudentVO> quizStudentList = quizService.selectQuizStudentList(quizSeq);
		model.addAttribute("quizStudentList", quizStudentList);
		return "lecture/lectureQuizGrading";
	}
	
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/selectStudentAnswer", method = RequestMethod.POST)
	public @ResponseBody ArrayList<QuizStudentAnswerVO> selectStudentAnswer(
			@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@RequestBody QuizStudentVO quizStudentVO,
			Model model){
		System.out.println(quizStudentVO.getQuizStudentSeq());
		return (ArrayList<QuizStudentAnswerVO>) quizService.selectQuizStudentAnswerList(quizStudentVO.getQuizStudentSeq());

	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/insertGrading", method = RequestMethod.POST)
	public String quizGradingPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute QuizStudentVO quizStudent){
		quizService.insertGrading(quizStudent);
		return "redirect:quizGradingPage.do?quizSeq="+quizStudent.getQuizSeq();
	}
	
	
	
}
