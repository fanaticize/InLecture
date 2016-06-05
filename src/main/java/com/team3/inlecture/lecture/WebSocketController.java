package com.team3.inlecture.lecture;


import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class WebSocketController {
	@MessageMapping("/echo/{subjectSeq}")
    @SendTo("/subscribe/echo/{subjectSeq}")
    public Greeting greeting(@DestinationVariable String subjectSeq,
    		HelloMessage message) throws Exception {
        System.out.println(message.getName());
        return new Greeting("Hello, " + message.getName() + "!");
    }
	
	@MessageMapping("/echo/{subjectSeq}/isOpen")
    @SendTo("/subscribe/echo/{subjectSeq}/isOpen")
    public String isOpen(@DestinationVariable String subjectSeq,
    		String memSeq) throws Exception {
        System.out.println("participate: "+memSeq);
        return memSeq;
    }
	
	@MessageMapping("/echo/{subjectSeq}/isOpenOk/{memSeq}")
    @SendTo("/subscribe/echo/{subjectSeq}/isOpenOk/{memSeq}")
    public String isOpenOk(@DestinationVariable String subjectSeq,
    		@DestinationVariable String memSeq) throws Exception {
		System.out.println("assign participate: "+memSeq);
		return "";
    }
}