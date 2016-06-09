package com.team3.inlecture.lecture.lectureBroadcast;

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
import org.springframework.web.multipart.MultipartFile;

import com.team3.inlecture.authentication.UserAuth;
import com.team3.inlecture.common.FileManager;
import com.team3.inlecture.common.FileVO;
import com.team3.inlecture.lecture.LectureService;

@Controller
@RequestMapping(value = "lecture/lectureBroadcast")
public class LectureBroadcastController {
	@Autowired
	private FileManager fileManager;
	@Autowired
    private LectureService lectureService;
	
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
	
	
	@RequestMapping(value = "{subjectSeq}/selectFileList")
	public @ResponseBody ArrayList<FileVO> selectFileList(@PathVariable int subjectSeq){
		return lectureService.selectLectureFileList(subjectSeq);
	}
	
	@RequestMapping(value = "{subjectSeq}/getFile" , method = RequestMethod.POST)
	public @ResponseBody String getFile(@PathVariable int subjectSeq, 
			@RequestBody FileVO file){
		return fileManager.getFileBase64(file.getFileSeq());
	}
}