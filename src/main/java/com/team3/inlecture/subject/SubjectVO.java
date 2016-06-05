package com.team3.inlecture.subject;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

@Alias("subjectVO")
public class SubjectVO {
	private int subjectSeq;
	@Size(min=1, message="필수항목")
	private String name;
	@Size(min=1, message="필수항목")
	private String semester;
	@NotNull(message="필수항목")
	private int year;
	@Size(min=1, message="필수항목")
	private String school;
	@Size(min=1, message="필수항목")
	private String code;
	private int memseq;
	private String profName;
	
	public int getSubjectSeq() {
		return subjectSeq;
	}
	public void setSubjectSeq(int subjectSeq) {
		this.subjectSeq = subjectSeq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public int getMemseq() {
		return memseq;
	}
	public void setMemseq(int memseq) {
		this.memseq = memseq;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getProfName() {
		return profName;
	}
	public void setProfName(String profName) {
		this.profName = profName;
	}
	
}
