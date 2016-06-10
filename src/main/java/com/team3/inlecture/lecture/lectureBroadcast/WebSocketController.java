package com.team3.inlecture.lecture.lectureBroadcast;


import java.util.HashMap;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class WebSocketController {

	@MessageMapping("/echo/{subjectSeq}/isOpen")
    @SendTo("/subscribe/echo/{subjectSeq}/isOpen")
    public HashMap<String, String> isOpen(@DestinationVariable String subjectSeq,
    		HashMap<String, String> memSeq) throws Exception {
        System.out.println("participate: "+memSeq.get("memSeq"));
        return memSeq;
    }
	
	@MessageMapping("/echo/{subjectSeq}/isOpenOk/{memSeq}")
    @SendTo("/subscribe/echo/{subjectSeq}/isOpenOk/{memSeq}")
    public String isOpenOk(@DestinationVariable String subjectSeq,
    		@DestinationVariable String memSeq) throws Exception {
		System.out.println("assign participate: "+memSeq);
		return "";
    }
	
	@MessageMapping("/echo/{subjectSeq}/sendQuestion")
    @SendTo("/subscribe/echo/{subjectSeq}/sendQuestion")
    public HashMap<String, String> sendQuestion(@DestinationVariable String subjectSeq,
    		HashMap<String, String> param) throws Exception {
//		System.out.println("getQuestion: "+param.get("question"));
		return param;
    }
	
	@MessageMapping("/echo/{subjectSeq}/endQuiz/{quizSeq}")
    @SendTo("/subscribe/echo/{subjectSeq}/endQuiz/{quizSeq}")
    public String endQuiz(@DestinationVariable String subjectSeq,
    		@DestinationVariable String quizSeq) throws Exception {
		System.out.println("endQuiz");
		return "";
    }
	
	
	
	
}