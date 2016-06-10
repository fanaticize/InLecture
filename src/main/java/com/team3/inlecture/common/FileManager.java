package com.team3.inlecture.common;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

@Service("fileManegaer")
public class FileManager {
	@Autowired
    private FileMapper fileMapper;
	
	public FileVO insertFile(MultipartFile file, String type){
		FileVO fileVO = new FileVO();
		fileVO.setName(file.getOriginalFilename());
		fileVO.setFileType(file.getContentType());
		fileVO.setUseType(type);
		fileMapper.insertFile(fileVO);
		fileMapper.updateFileOrgName(fileVO);
		fileVO.setRealName(fileVO.getFileSeq()+"_"+fileVO.getName());
		writeFile(file, fileVO);
		return fileVO;
	}
	
	public void deleteFile(int fileSeq){
		FileVO fileVO = fileMapper.selectFile(fileSeq);
		deleteFile(fileVO);
		fileMapper.deleteFile(fileSeq);
	}
	
	private void deleteFile(FileVO fileVO){
		String fileName = fileVO.getRealName();
        try {
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            String path = request.getSession().getServletContext().getRealPath("WEB-INF/files/");
            System.out.println(path);
            File file = new File(path + fileName);
            file.delete();
            
        } catch (Exception e) {
        	System.out.println("You failed to upload " + fileName + ": " + e.getMessage());
        }
	}
	
	public String getFileBase64(int fileSeq){
		FileVO fileVO = fileMapper.selectFile(fileSeq);
		return fileToString(fileVO);
	}
	
	private void writeFile(MultipartFile file, FileVO fileVO){
		String fileName = fileVO.getRealName();
    	if (!file.isEmpty()) {
            try {
            	
                byte[] bytes = file.getBytes();
                HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
                String path = request.getSession().getServletContext().getRealPath("WEB-INF/files/");
                System.out.println(path);
                BufferedOutputStream buffStream = 
                        new BufferedOutputStream(new FileOutputStream(new File(path + fileName)));
                buffStream.write(bytes);
                buffStream.close();
                System.out.println("You have successfully uploaded " + fileName);
                
            } catch (Exception e) {
            	System.out.println("You failed to upload " + fileName + ": " + e.getMessage());
            }
        } else {
        	System.out.println("Unable to upload. File is empty.");
        }
    }
	
	public String fileToString(FileVO fileVO) {
		String fileName = fileVO.getRealName();
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String path = request.getSession().getServletContext().getRealPath("WEB-INF/files/");
        System.out.println(path);
		File file = new File(path + fileName);
		
		
	    String fileString = new String();
	    FileInputStream inputStream =  null;
	    ByteArrayOutputStream byteOutStream = null;

	    try {
	    inputStream = new FileInputStream(file);
		byteOutStream = new ByteArrayOutputStream();
	    
		int len = 0;
		byte[] buf = new byte[1024];
	        while ((len = inputStream.read(buf)) != -1) {
	             byteOutStream.write(buf, 0, len);
	        }

	        byte[] fileArray = byteOutStream.toByteArray();
	        fileString = new String(Base64.encodeBase64(fileArray));
	        inputStream.close();
	        byteOutStream.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    } finally {
	    	
	    }
	    return fileString;
	}
	
	
}
