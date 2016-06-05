package com.team3.inlecture.lecture;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.MultipartFile;

import com.team3.inlecture.authentication.UserAuth;
import com.team3.inlecture.common.FileManager;
import com.team3.inlecture.common.FileVO;


@Controller
@RequestMapping(value = "lecture")
public class LectureController {
	@Autowired
    private LectureService lectureService;
	@Autowired
	private FileManager fileManager;
	
	@Secured("ROLE_USER")
	@RequestMapping(value = "{subjectSeq}/lectureRoom", method = RequestMethod.GET)
	public String lectureRoom(Model model,
			@PathVariable @ModelAttribute("subjectSeq") String subjectSeq) {
//		model.addAttribute("lectureRoom", true);
		
		return "lecture/lectureRoom";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/lectureMaterialPage", method = RequestMethod.GET)
	public String lectureMaterialPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			Model model
			){
		ArrayList<FileVO> fileList = lectureService.selectLectureFileList(subjectSeq);
		model.addAttribute("fileList", fileList);
		return "lecture/lectureMaterial";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/lectureMaterialInsert", method = RequestMethod.POST)
	public String lectureMaterialInsert(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq,
			@RequestParam("file") MultipartFile file){
		if (!file.isEmpty()) {
			lectureService.insertLectureFile(file, subjectSeq);
		}
		return "redirect:lectureMaterialPage.do";
	}
	
	@Secured("ROLE_TEACHER")
	@RequestMapping(value = "{subjectSeq}/lectureMaterialDelete", method = RequestMethod.POST)
	public @ResponseBody void lectureMaterialDelete(@PathVariable int subjectSeq,
			@RequestBody FileVO file ){
		lectureService.deleteLectureFile(subjectSeq, file.getFileSeq());
	}
	
	@RequestMapping(value = "{subjectSeq}/lectureBroadcastPage")
	public String lectureBroadcastPage(@PathVariable @ModelAttribute("subjectSeq") int subjectSeq
			, Model model){
		String file = fileManager.getFileBase64(10);
		model.addAttribute("file", file);
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		model.addAttribute("memSeq", userinfo.getMemseq());
		return "lecture/lectureBroadcast";
	}
	
}
