package com.team3.inlecture.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


@Service("memberService")
public class MemberService {
	@Autowired
    private MemberMapper memberMapper;
	public void insertMember(MemberVO memberVO){
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		memberVO.setPw(passwordEncoder.encode(memberVO.getPw()) );
		memberMapper.insertMember(memberVO);
	}
}
