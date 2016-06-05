package com.team3.inlecture.lecture;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.team3.inlecture.common.FileManager;
import com.team3.inlecture.common.FileVO;

@Service("lectureService")
public class LectureService {
	
	@Autowired
    private LectureMapper lectureMapper;
	
	@Autowired
    private FileManager fileManager;
	
	public void insertLectureFile(MultipartFile file, int subjectSeq){
		FileVO fileVO = fileManager.insertFile(file, "material");
		HashMap<String, Integer> fileAndSubjectSeq = new HashMap<String, Integer>();
		
		fileAndSubjectSeq.put("subjectSeq", subjectSeq);
		fileAndSubjectSeq.put("fileSeq", fileVO.getFileSeq());
		lectureMapper.insertLectureFile(fileAndSubjectSeq);
		
	}
	
	public ArrayList<FileVO> selectLectureFileList(int subjectSeq){
		return lectureMapper.selectLectureFileList(subjectSeq);
	}

	public void deleteLectureFile(int subjectSeq, int fileSeq) {
		fileManager.deleteFile(fileSeq);
		
		HashMap<String, Integer> fileAndSubjectSeq = new HashMap<String, Integer>();
		fileAndSubjectSeq.put("subjectSeq", subjectSeq);
		fileAndSubjectSeq.put("fileSeq", fileSeq);
		
		lectureMapper.deleteLectureFile(fileAndSubjectSeq);
	}
	
	
}
