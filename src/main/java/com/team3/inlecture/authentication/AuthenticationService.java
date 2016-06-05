package com.team3.inlecture.authentication;

import java.util.ArrayList;
import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.team3.inlecture.member.MemberVO;


@Service("authenticationService")
public class AuthenticationService implements UserDetailsService {
	 private static final Logger logger = LoggerFactory.getLogger(AuthenticationService.class);
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
    private AuthenticationMapper authenticationMapper;
	 
	public String encoding(String str){
		return passwordEncoder.encode(str);
	}

	@Override
	public UserAuth loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO member = authenticationMapper.getMemberById(username);
		if (member == null) throw new UsernameNotFoundException("접속자 정보를 찾을 수 없습니다.");
		List<GrantedAuthority> rolelist=new ArrayList<GrantedAuthority>();
		rolelist.add(new SimpleGrantedAuthority("ROLE_USER"));
		if(member.getRole().equals("S"))
			rolelist.add(new SimpleGrantedAuthority("ROLE_STUDENT"));
		else if(member.getRole().equals("T"))
			rolelist.add(new SimpleGrantedAuthority("ROLE_TEACHER"));
		UserAuth user = new UserAuth(username, member.getPw(), rolelist);
		user.setMemseq(member.getMemseq());
		return user;
	}
}
