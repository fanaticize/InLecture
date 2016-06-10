package com.team3.inlecture.lecture.board;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository(value="boardMapper")
public interface BoardMapper {

	public Integer insertBoard(BoardVO boardVO);

	public ArrayList<BoardVO> selectBoardList(BoardVO boardVO);

	public BoardVO getBoardContents(int idx);

	public Integer deleteBoard(int idx);

	public Integer modifyBoard(BoardVO boardVO);
	
}
