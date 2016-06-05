package com.team3.inlecture.subject;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.inlecture.authentication.UserAuth;


@Controller
@RequestMapping(value = "subject")
public class SubjectController {
	@Autowired
    private SubjectService subjectService;
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "/subjectInsert.do", method = RequestMethod.GET)
	public String subjectInsertPage(Model model) {
		model.addAttribute("subject", new SubjectVO());
		model.addAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
		return "subject/subjectInsert";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "/subjectInsert.do", method = RequestMethod.POST)
	public String subjectInsert(@ModelAttribute("subject") @Valid SubjectVO subject,
			BindingResult bindingResult, Model model) {
		if(bindingResult.hasErrors()){
			model.addAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
			return "subject/subjectInsert";
		}
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		subject.setMemseq(userinfo.getMemseq());
		
		subjectService.insertSubject(subject);
		
		return "subject/subjectInsertComplete";
	}
	
	@Secured("ROLE_STUDENT")
	@RequestMapping(value = "/subjectEnrolment.do", method = RequestMethod.GET)
	public String subjectEnrolmentPage(Model model) {
		model.addAttribute("subject", new SubjectVO());
		return "subject/subjectEnrolment";
	}

	@RequestMapping(value = "/subjectSearch.do", method = RequestMethod.POST)
	public @ResponseBody ArrayList<SubjectVO> subjectSearch(@RequestBody SubjectVO subject) {
		ArrayList<SubjectVO> subjectList = subjectService.searchSubjectList(subject);
	    return subjectList;
	}
	
	
	@RequestMapping(value = "/subjectEnrolmentInsert.do", method = RequestMethod.GET)
	public String subjectEnrolmentInsert(@RequestParam Integer subjectSeq) {
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		subjectService.insertSubjectEnrolment(subjectSeq, userinfo.getMemseq());
				
		return "subject/subjectEnrolmentComplete";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "/subjectEnrolmentCheck.do", method = RequestMethod.GET)
	public String subjectEnrolmentCheck(Model model) {
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		ArrayList<SubjectEnrolmentVO> enrolmentList = subjectService.selectSubjectEnrolmentList(userinfo.getMemseq());
		model.addAttribute("enrolmentList", enrolmentList);
		return "subject/subjectEnrolmentCheck";
	}
	
	@RequestMapping(value = "/updateEnrolment.do", method = RequestMethod.POST)
	public @ResponseBody void updateEnrolment(@RequestBody SubjectEnrolmentVO subjectEnrolment) {
		subjectService.updateEnrolmentAccept(subjectEnrolment);
	}
}
