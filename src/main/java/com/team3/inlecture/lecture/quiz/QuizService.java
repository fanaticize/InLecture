package com.team3.inlecture.lecture.quiz;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service("quizService")
public class QuizService {
	@Autowired
    private QuizMapper quizMapper;
	public ArrayList<QuizVO> selectQuizList(int subjectSeq) {
		return quizMapper.selectQuizList(subjectSeq);
	}
	public QuizVO selectQuizProblem(int quizSeq) {
		return quizMapper.selectQuizProblem(quizSeq);
	}
	public void insertQuiz(QuizVO quiz) {
		quizMapper.insertQuiz(quiz);
		quizMapper.insertQuizProblemList(quiz);
	}
	public void deleteQuiz(int quizSeq) {
		quizMapper.deleteQuizProblemList(quizSeq);
		quizMapper.deleteQuiz(quizSeq);
	}
	public void modifyQuiz(QuizVO quiz) {
		deleteQuiz(quiz.getQuizSeq());
		quizMapper.insertQuiz(quiz);
		quizMapper.insertQuizProblemListWithSeq(quiz);
	}
	public ArrayList<QuizVO> selectAnswerList(int quizSeq){
		return quizMapper.selectAnswerList(quizSeq);
	}

}
