package com.team3.inlecture.lecture.quiz;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

@Repository(value="quizMapper")
public interface QuizMapper {

	public ArrayList<QuizVO> selectQuizList(int subjectSeq);

	public QuizVO selectQuizProblem(int quizSeq);

	public Integer insertQuiz(QuizVO quiz);

	public Integer insertQuizProblemList(QuizVO quiz);

	public Integer deleteQuizProblemList(int quizSeq);

	public Integer deleteQuiz(int quizSeq);

	public Integer insertQuizProblemListWithSeq(QuizVO quiz);

	public ArrayList<QuizVO> selectAnswerList(int quizSeq);

}
