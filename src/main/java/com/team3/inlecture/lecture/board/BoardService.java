package com.team3.inlecture.lecture.board;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.team3.inlecture.authentication.UserAuth;

@Service("boardService")
public class BoardService {
	@Autowired
	BoardMapper boardMapper;

	public ArrayList<BoardVO> selectBoardList(BoardVO boardVO) {
		return boardMapper.selectBoardList(boardVO);
	}

	public BoardVO getBoardContents(int idx) {
		return boardMapper.getBoardContents(idx);
	}

	public void insertBoard(BoardVO boardVO) {
		SecurityContext context = SecurityContextHolder.getContext();
		UserAuth userinfo =(UserAuth) context.getAuthentication().getPrincipal();
		boardVO.setMemseq(userinfo.getMemseq());
		boardMapper.insertBoard(boardVO);
	}

	public void deleteBoard(int idx) {
		boardMapper.deleteBoard(idx);
	}

	public void modifyBoard(BoardVO boardVO) {
		boardMapper.modifyBoard(boardVO);
	}
}
