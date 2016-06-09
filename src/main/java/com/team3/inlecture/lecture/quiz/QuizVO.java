package com.team3.inlecture.lecture.quiz;

import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

import com.team3.inlecture.member.MemberVO;

@Alias("quizVO")
public class QuizVO {
	private int quizSeq;
	private int subjectSeq;
	private String name;
	private String isTested;
	private ArrayList<QuizProblemVO> quizProblemList;
	
	public int getQuizSeq() {
		return quizSeq;
	}
	public void setQuizSeq(int quizSeq) {
		this.quizSeq = quizSeq;
	}
	public int getSubjectSeq() {
		return subjectSeq;
	}
	public void setSubjectSeq(int subjectSeq) {
		this.subjectSeq = subjectSeq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIsTested() {
		return isTested;
	}
	public void setIsTested(String isTested) {
		this.isTested = isTested;
	}
	public ArrayList<QuizProblemVO> getQuizProblemList() {
		return quizProblemList;
	}
	public void setQuizProblemList(ArrayList<QuizProblemVO> quizProblemList) {
		this.quizProblemList = quizProblemList;
	}
	
}
