package com.team3.inlecture.authentication;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Validator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value = "authentication")
public class AuthenticationController {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthenticationController.class);
	@Resource
	Validator validator;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@RequestParam(value="error", required=false) String error, Model model, HttpSession session) {
		logger.info("Welcome login! {}", session.getId());
		
		model.addAttribute("error", error);
		return "authentication/login";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		UserAuth user = (UserAuth)session.getAttribute("userLoginInfo");
		logger.info("Welcome logout! {}, {}", session.getId(), user.getUsername());
		session.invalidate();
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
	    return "redirect:/main.do";
	}
	
	@RequestMapping(value = "/loginSuccess", method = RequestMethod.GET)
	public String login_success(HttpSession session) {
		UserAuth userDetails = (UserAuth) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		 logger.info(userDetails.toString());
         auth.getName();
		logger.info("Welcome login_success! ");
		session.setAttribute("userLoginInfo", userDetails);
//		return "authentication/loginSuccess";
		return "redirect:/main.do";
	}
	
	
	@RequestMapping(value = "/loginDuplicate", method = RequestMethod.GET)
	public void login_duplicate() {		
		logger.info("Welcome login_duplicate!");
	}
	
}