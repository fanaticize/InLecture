package com.team3.inlecture.lecture.quiz;

import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

import com.team3.inlecture.member.MemberVO;

@Alias("quizStudentVO")
public class QuizStudentVO extends QuizVO{
	private int quizStudentSeq;
	private String isGrading;
	private double score;
	private MemberVO member;
	private ArrayList<QuizStudentAnswerVO> answerList;
	
	public int getQuizStudentSeq() {
		return quizStudentSeq;
	}
	public void setQuizStudentSeq(int quizStudentSeq) {
		this.quizStudentSeq = quizStudentSeq;
	}
	public String getIsGrading() {
		return isGrading;
	}
	public void setIsGrading(String isGrading) {
		this.isGrading = isGrading;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}
	public ArrayList<QuizStudentAnswerVO> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(ArrayList<QuizStudentAnswerVO> answerList) {
		this.answerList = answerList;
	}
	
	
}
