package com.team3.inlecture.lecture.quiz;

import org.apache.ibatis.type.Alias;

@Alias("quizStudentAnswerVO")
public class QuizStudentAnswerVO extends QuizProblemVO {
	private int quizAnswerSeq;
	private int quizStudentSeq;
	private String answer;
	private double score;
	private String comment;
	public int getQuizAnswerSeq() {
		return quizAnswerSeq;
	}
	public void setQuizAnswerSeq(int quizAnswerSeq) {
		this.quizAnswerSeq = quizAnswerSeq;
	}
	public int getQuizStudentSeq() {
		return quizStudentSeq;
	}
	public void setQuizStudentSeq(int quizStudentSeq) {
		this.quizStudentSeq = quizStudentSeq;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
}
