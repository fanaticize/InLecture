package com.team3.inlecture.lecture.board;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.inlecture.authentication.UserAuth;
import com.team3.inlecture.lecture.quiz.QuizStudentAnswerVO;
import com.team3.inlecture.lecture.quiz.QuizStudentVO;
import com.team3.inlecture.lecture.quiz.QuizVO;

@Controller
@RequestMapping(value = "lecture/board")
public class BoardController {
	@Autowired 
	BoardService boardService;
	
	

	@Secured("ROLE_USER")
	@RequestMapping(value = "{subjectSeq}/{type}/boardListPage", method = RequestMethod.GET)
	public String boardListPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@PathVariable @ModelAttribute("type") String type,
			Model model){
		BoardVO boardVO = new BoardVO();
		boardVO.setSubjectSeq(subjectSeq);
		boardVO.setType(type);
		ArrayList<BoardVO> boardList = boardService.selectBoardList(boardVO);
		model.addAttribute("boardList", boardList);
		return "lecture/boardList";
	}
	
	@Secured("ROLE_USER")
	@RequestMapping(value = "{subjectSeq}/{type}/boardPage", method = RequestMethod.GET)
	public String quizProblems(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@PathVariable @ModelAttribute("type") String type,
			@ModelAttribute("idx") int idx,
			Model model){
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		BoardVO board = boardService.getBoardContents(idx);
		model.addAttribute("board", board);
		model.addAttribute("memseq", userinfo.getMemseq());
		return "lecture/board";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/{type}/boardInsertPage", method = RequestMethod.GET)
	public String boardInsertPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
		@PathVariable @ModelAttribute("type") String type,
		@ModelAttribute("board") BoardVO boardVO,
		Model model){
		return "lecture/boardInsert";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/{type}/boardInsert", method = RequestMethod.POST)
	public String boardInsert(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@PathVariable @ModelAttribute("type") String type,
			@ModelAttribute("boardVO") BoardVO boardVO,
			Model model){
		boardService.insertBoard(boardVO);
		return "redirect:boardListPage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/{type}/boardDelete", method = RequestMethod.GET)
	public String boardDelete(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute("boardVO") BoardVO boardVO,
			Model model){
		boardService.deleteBoard(boardVO.getIdx());
		return "redirect:boardListPage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/{type}/boardModifyPage", method = RequestMethod.GET)
	public String boardModifyPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@ModelAttribute("boardVO") BoardVO boardVO,
			Model model){
		BoardVO board = boardService.getBoardContents(boardVO.getIdx());
		model.addAttribute("board", board);
		return "lecture/boardModify";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/{type}/boardModify", method = RequestMethod.POST)
	public String boardModify(@ModelAttribute("boardVO") BoardVO boardVO,
			Model model){
		boardService.modifyBoard(boardVO);
		return "redirect:boardListPage.do";
	}
	
	
}
