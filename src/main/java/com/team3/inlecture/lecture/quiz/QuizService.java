package com.team3.inlecture.lecture.quiz;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.team3.inlecture.authentication.UserAuth;
import com.team3.inlecture.member.MemberVO;


@Service("quizService")
public class QuizService {
	@Autowired
    private QuizMapper quizMapper;
	
	public ArrayList<QuizVO> selectQuizList(int subjectSeq) {
		return quizMapper.selectQuizList(subjectSeq);
	}
	public QuizVO selectQuizProblem(int quizSeq) {
		ArrayList<QuizProblemVO> quizProb = quizMapper.selectQuizProblemList(quizSeq);
		QuizVO quizVO = quizMapper.selectQuiz(quizSeq);
		if(quizProb !=null)
			quizVO.setQuizProblemList(quizProb);
		return quizVO;
	}
	public void insertQuiz(QuizVO quiz, int subjectSeq) {
		quiz.setSubjectSeq(subjectSeq);
		quiz.setIsTested("N");
		
		quizMapper.insertQuiz(quiz);		
		quizMapper.insertQuizProblemList(quiz);
	}
	public void deleteQuiz(int quizSeq) {
		quizMapper.deleteQuizProblemList(quizSeq);
		quizMapper.deleteQuiz(quizSeq);
	}
	public void modifyQuiz(QuizVO quiz) {
		deleteQuiz(quiz.getQuizSeq());
		quizMapper.insertQuizWithSeq(quiz);
		
		quizMapper.insertQuizProblemList(quiz);
	}
	public ArrayList<QuizVO> selectAnswerList(int quizSeq){
		return quizMapper.selectAnswerList(quizSeq);
	}
	public void startQuiz(int quizSeq) {
		quizMapper.startQuiz(quizSeq);
	}
	public void endQuiz(int quizSeq) {
		quizMapper.endQuiz(quizSeq);
	}
	public ArrayList<QuizStudentVO> selectStartedQuizList(int subjectSeq) {
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		MemberVO memberVO = new MemberVO();
		memberVO.setMemseq(userinfo.getMemseq());
		QuizStudentVO searchQuiz = new QuizStudentVO();
		searchQuiz.setSubjectSeq(subjectSeq);
		searchQuiz.setMember(memberVO);
		return quizMapper.selectStartedQuizList(searchQuiz);
	}
	public void insertQuizAnswer(QuizStudentVO quiz) {
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		MemberVO memberVO = new MemberVO();
		memberVO.setMemseq(userinfo.getMemseq());
		quiz.setMember(memberVO);
		quizMapper.insertStudentQuiz(quiz);		
		quizMapper.insertStudentQuizAnswer(quiz);
	}
	public ArrayList<QuizStudentVO> selectQuizStudentList(int quizSeq) {
		return quizMapper.selectQuizStudentList(quizSeq);
	}
	public ArrayList<QuizStudentAnswerVO> selectQuizStudentAnswerList(int quizStudentSeq) {
		return quizMapper.selectQuizStudentAnswerList(quizStudentSeq);
	}
	public void insertGrading(QuizStudentVO quizStudent) {
		ArrayList<QuizStudentAnswerVO> answerArr = quizStudent.getAnswerList();
		double sum = 0;
		for(QuizStudentAnswerVO ans: answerArr){
			sum += ans.getScore();
			quizMapper.updateAnswer(ans);
		}
		quizStudent.setScore(sum);
		quizMapper.updateQuizStudentScore(quizStudent);
	}

}
