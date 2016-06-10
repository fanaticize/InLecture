<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<head>
	<meta charset="UTF-8">
	<meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
	<script type="text/javascript" src="<c:url value="/resources/js/sockjs-1.1.1.min.js" />" ></script>
	<script type="text/javascript" src= "<c:url value="/resources/js/stomp.min.js" />"></script>
	<script id="script">
	var stompClient = null;
	$(function () {
		connect();
	});
	
	function initialConnect(subScribeFunc){
  	  var socket = new SockJS('/InLecture/echo');
  	  stompClient = Stomp.over(socket);
  	  stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            subScribeFunc();
        });
    }
	function objectToJson(data){
  	  return JSON.stringify(data);
    }
    
    function jsonToObject(data){
  	  return JSON.parse(data.body);
    }
    
    var prefixSubscribe = '/subscribe/echo/${subjectSeq}';
    
    function doSubscribe(url, callbackFunc){
  	  stompClient.subscribe(prefixSubscribe+url,callbackFunc);
    }
    
    function connect() {
			initialConnect(doSubscribeList);
 	  }
    
    function doSubscribeList(){
    	endQuizSubscribe();
    }
    
    var prefixSend = '/app/echo/${subjectSeq}';
    
    function doSend(url, data){
  	  stompClient.send(prefixSend+url, {}, JSON.stringify(data));
    }
    
    //퀴즈 종료신호 구독
    function endQuizSubscribe(){
    	  doSubscribe('/endQuiz/${quiz.quizSeq}', function(data){
    		  console.log('endQuiz');
    		  alert('퀴즈가 종료되었습니다. 자동으로 제출됩니다.');
    		  document.quizform.submit();
    	  });
     }
    
  //학생이 교수에게 수업여부 확인 요청 보냄
    function isOpenSend(){
  	  console.log('sendIsOpen');
		  var data = {
			memSeq : '${memSeq}'			  
		  }
  	  doSend('/isOpen', data);
    }
	</script>
<title>Insert title here</title>
</head>
<body>
<form action="insertQuizAnswer.do" name="quizform" method="post">
<input type="hidden" value="${quiz.quizSeq}" name="quizSeq">
<input type="hidden" value="${quiz.isTested}" name="isTested">
퀴즈제목: <input type="text" name="name" value="${quiz.name}"/><p>

<div id="quizSet">
	<c:forEach items="${quiz.quizProblemList}" var="problemList" varStatus="status">
	<div id="quiz_${problemList.idx}">
		<input class="" type="hidden"  name="quizProblemList[${status.index}].quizProblemSeq" value="${problemList.quizProblemSeq}"/>
		<input class="idx" name="quizProblemList[${status.index}].idx" style="width: 30px;" readonly="readonly" value="${problemList.idx}"/>번<p><p>
		<textarea  style="width: 500px;" readonly="readonly" name="quizProblemList[${status.index}].content" rows="3" class="quiz_content">${problemList.content}</textarea><p>
		<textarea  style="width: 500px;" name="quizProblemList[${status.index}].answer" rows="3"></textarea>
	</div>
	</c:forEach>
</div>

<div>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</div>
<input type="submit" class="btn btn-primary" value="전송"/>
</form>