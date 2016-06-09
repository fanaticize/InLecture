package com.team3.inlecture.lecture.quiz;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

@Repository(value="quizMapper")
public interface QuizMapper {

	public ArrayList<QuizVO> selectQuizList(int subjectSeq);
	
	public QuizVO selectQuiz(int quizSeq);
	
	public ArrayList<QuizProblemVO> selectQuizProblemList(int quizSeq);
	
	public QuizVO selectQuizProblem(int quizSeq);

	public Integer insertQuiz(QuizVO quiz);

	public Integer insertQuizProblemList(QuizVO quiz);

	public Integer deleteQuizProblemList(int quizSeq);

	public Integer deleteQuiz(int quizSeq);
	
	public Integer insertQuizWithSeq(QuizVO quiz);

	public ArrayList<QuizVO> selectAnswerList(int quizSeq);

	public Integer startQuiz(int quizSeq);

	public Integer endQuiz(int quizSeq);

	public ArrayList<QuizStudentVO> selectStartedQuizList(QuizVO searchQuiz);

	public Integer insertStudentQuiz(QuizStudentVO quiz);

	public Integer insertStudentQuizAnswer(QuizStudentVO quiz);

	public ArrayList<QuizStudentVO> selectQuizStudentList(int quizSeq);

	public ArrayList<QuizStudentAnswerVO> selectQuizStudentAnswerList(int quizStudentSeq);

	public Integer updateQuizStudentScore(QuizStudentVO quizStudent);

	public Integer updateAnswer(QuizStudentAnswerVO ans);

}
