package com.team3.inlecture.member;

import java.util.ArrayList;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.inlecture.lecture.quiz.QuizStudentAnswerVO;
import com.team3.inlecture.lecture.quiz.QuizStudentVO;


@Controller
@RequestMapping(value = "member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signUpPage(Model model) {
		model.addAttribute("member", new MemberVO());
		return "member/signup";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signUp(@ModelAttribute("member") @Valid MemberVO member,
			BindingResult bindingResult) {
		if(bindingResult.hasErrors()) return "member/signup";
		memberService.insertMember(member);
		
		return "member/signupComplete";
	}
	
	
	@RequestMapping(value = "/verifyID", method = RequestMethod.POST)
	public @ResponseBody String verifyID(@RequestBody MemberVO memberVO){
		ArrayList<MemberVO> memberList = memberService.verifyID(memberVO.getId());
		if(memberList.size() == 0)
			return "Y";
		else
			return "N";
	}
}
