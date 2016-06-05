package com.team3.inlecture.member;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


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
}
