package com.team3.inlecture.authentication;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class UserAuth extends User {
	private static final long serialVersionUID = 1L;
	private int memseq;

	public UserAuth(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public int getMemseq() {
		return memseq;
	}

	public void setMemseq(int memseq) {
		this.memseq = memseq;
	}

	
	
	

}
