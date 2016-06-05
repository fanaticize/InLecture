package com.team3.inlecture.subject;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository(value="subjectMapper")
public interface SubjectMapper {
	public Integer insertSubject(SubjectVO subjectVO);
	
	public ArrayList<SubjectVO> searchSubjectList(SubjectVO subjectVO);
	
	public Integer insertSubjectEnrolment(HashMap<String, Integer> param);
	
	public ArrayList<SubjectEnrolmentVO> selectSubjectEnrolmentList(int memSeq);
		
	public void updateEnrolmentAccept(SubjectEnrolmentVO subjectEnrolmentVO);
	
	public ArrayList<SubjectVO> selectStudentCourseList(int memSeq);
	
	public ArrayList<SubjectVO> selectTeacherCourseList(int memSeq);
	
}
