package com.team3.inlecture.common;

import org.springframework.stereotype.Repository;

@Repository(value="fileMapper")
public interface FileMapper {
	public Integer insertFile(FileVO fileVO);
	public Integer updateFileOrgName(FileVO fileVO);
	public FileVO selectFile(int fileSeq);
	public Integer deleteFile(int fileSeq);
}
