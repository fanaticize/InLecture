package com.team3.inlecture.member;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

@Repository(value="memberMapper")
public interface MemberMapper {
	public Integer insertMember(MemberVO memberVO);

	public void insertMember(String id);

	public ArrayList<MemberVO> verifyID(String id);
}
