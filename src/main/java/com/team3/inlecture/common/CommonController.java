   package com.team3.inlecture.common;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.team3.inlecture.authentication.UserAuth;
import com.team3.inlecture.subject.SubjectService;
import com.team3.inlecture.subject.SubjectVO;

@Controller
public class CommonController {
	@Autowired
    private SubjectService subjectService;
	
	@RequestMapping(value = "error", method = RequestMethod.GET)
	public String errorPage(@RequestParam(value="errorMsg", required=false) String error, Model model) {
		model.addAttribute("errorMsg", error);
		return "common/error";
	}
	
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main(Model model, Authentication authentication) {
		if(authentication != null){
		UserAuth user = (UserAuth) authentication.getPrincipal(); // Authentication 저장된 principal 객체를 User 객체로 Cast
			if(user!=null){
				ArrayList<SubjectVO> studentCourseList = subjectService.selectStudentCourseList(user.getMemseq());
				ArrayList<SubjectVO> teacherCourseList = subjectService.selectTeacherCourseList(user.getMemseq());
				model.addAttribute("studentCourseList", studentCourseList);
				model.addAttribute("teacherCourseList", teacherCourseList);
			}
		}
		return "common/main";
	}
	
}
