package com.team3.inlecture.member;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.hibernate.validator.constraints.Email;


@Alias("memberVO")
public class MemberVO{
	private int memseq;
	
	@Size(min=5, max=20, message="5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.")
	private String id;
	
	@Size(min=6, max=16, message="6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.")
	private String pw;
	
	@Size(min=1, message="필수항목")
	@NotNull(message="필수항목")
	private String name;
	
	@Size(min=1, message="필수항목")
	@NotNull(message="필수항목")
    private String nick;
	
	@Size(min=1, message="필수항목")
	@NotNull(message="필수항목")
	private String role;
	
	@Size(min=1, message="필수항목")
	@NotNull(message="필수항목")
	private String school;
	
	@Size(min=1, message="필수항목")
	@Email(message="올바른 형식이 아닙니다.")
	private String email;
	
	private String code;
	
	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getMemseq() {
		return memseq;
	}

	public void setMemseq(int memseq) {
		this.memseq = memseq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	
	

    
}