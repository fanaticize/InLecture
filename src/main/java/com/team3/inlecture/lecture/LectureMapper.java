package com.team3.inlecture.lecture;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.team3.inlecture.common.FileVO;

@Repository(value="lectureMapper")
public interface LectureMapper {
	
    public Integer insertLectureFile(HashMap<String, Integer> fileAndSubjectSeq);
    public ArrayList<FileVO> selectLectureFileList(int subjectSeq);
    public Integer deleteLectureFile(HashMap<String, Integer> fileAndSubjectSeq);
}
