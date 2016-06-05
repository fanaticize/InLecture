package com.team3.inlecture.subject;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.team3.inlecture.authentication.UserAuth;


@Service("subjectService")
public class SubjectService {
	@Autowired
    private SubjectMapper subjectMapper;
	public void insertSubject(SubjectVO subjectVO){
		subjectMapper.insertSubject(subjectVO);
	}
	
	public ArrayList<SubjectVO> searchSubjectList(SubjectVO subjectVO){
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		subjectVO.setMemseq(userinfo.getMemseq());
		return subjectMapper.searchSubjectList(subjectVO);
	}
	
	public void insertSubjectEnrolment(int subjectSeq, int memSeq){
		HashMap<String, Integer> param = new HashMap<String, Integer>();
		param.put("subjectSeq", subjectSeq);
		param.put("memSeq", memSeq);
		subjectMapper.insertSubjectEnrolment(param);
	}
	
	public ArrayList<SubjectEnrolmentVO> selectSubjectEnrolmentList(int memSeq){
		return subjectMapper.selectSubjectEnrolmentList(memSeq);
	}
	
	public void updateEnrolmentAccept(SubjectEnrolmentVO subjectEnrolmentVO){
		if(subjectEnrolmentVO.getAccept().equals("R") || subjectEnrolmentVO.getAccept().equals("Y"))
			subjectMapper.updateEnrolmentAccept(subjectEnrolmentVO);
	}
	
	public ArrayList<SubjectVO> selectStudentCourseList(int memSeq){
		return subjectMapper.selectStudentCourseList(memSeq);
	}
	
	public ArrayList<SubjectVO> selectTeacherCourseList(int memSeq){
		return subjectMapper.selectTeacherCourseList(memSeq);
	}
}
