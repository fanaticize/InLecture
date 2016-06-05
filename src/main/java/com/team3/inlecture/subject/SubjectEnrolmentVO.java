package com.team3.inlecture.subject;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("subjectEnrolmentVO")
public class SubjectEnrolmentVO {
	private int subjectSeq;
	private int memSeq;
	private String subjectName;
	private String subjectCode;
	private String year;
	private String semester;
	private String memName;
	private String memCode;
	private String accept;
	private Date date;
	public int getSubjectSeq() {
		return subjectSeq;
	}
	public void setSubjectSeq(int subjectSeq) {
		this.subjectSeq = subjectSeq;
	}
	public int getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(int memSeq) {
		this.memSeq = memSeq;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemCode() {
		return memCode;
	}
	public void setMemCode(String memCode) {
		this.memCode = memCode;
	}
	public String getAccept() {
		return accept;
	}
	public void setAccept(String accept) {
		this.accept = accept;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
}
