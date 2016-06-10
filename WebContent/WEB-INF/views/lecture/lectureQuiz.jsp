<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
	<meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>InLecture</title>
	<script type="text/javascript" src="<c:url value="/resources/js/sockjs-1.1.1.min.js" />" ></script>
	<script type="text/javascript" src= "<c:url value="/resources/js/stomp.min.js" />"></script>
	<script>
	$(function () {
		  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  $(document).ajaxSend(function(e, xhr, options) {
		    xhr.setRequestHeader(header, token);
		  });
		  connect();
	});
	
	function quizInsert(){
		location.href = 'quizInsertPage.do';
	}
	
	function quizModify(quizSeq){
		location.href = 'quizModifyPage.do?quizSeq='+quizSeq;
	}
	
	function quizDelete(quizSeq){
		if(confirm('정말로 삭제하시겠습니까?')){
			location.href = 'quizDelete.do?quizSeq='+quizSeq;
		}
	}
	function quizStart(quizSeq){
		if(confirm('정말로 시작하시게습니까?')){
			location.href = 'quizStart.do?quizSeq='+quizSeq;
		}
	}
	function quizEnd(quizSeq){
		if(confirm('종료하시겠습니까?')){
			quizEndSend(quizSeq);
			location.href = 'quizEnd.do?quizSeq='+quizSeq;
		}
	}
	function quizGrading(quizSeq){
		location.href = 'quizGradingPage.do?quizSeq='+quizSeq;
	}
	
	var stompClient = null;
	$(function () {
		
		
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
    	
    }
    
    var prefixSend = '/app/echo/${subjectSeq}';
    
    function doSend(url, data){
  	  stompClient.send(prefixSend+url, {}, JSON.stringify(data));
    }
    
  	//퀴즈 종료 신호 보냄
    function quizEndSend(quizSeq){
  	  console.log('quizEnd');
	  var data = '';
  	  doSend('/endQuiz/'+quizSeq, data);
    }
	
	</script>
	
</head>
<body>
<div class="table-responsive">
<table class="quizTable table table-striped" style="max-width: 550px;">
<thead>
<tr>
<th>퀴즈명</th>
<th>완료여부</th>
<th></th>
<th></th>
</tr>
</thead>
<c:forEach items="${quizList }" var="quizList">
<tr>
<td>${quizList.name }</td>
<td>
<c:if test="${quizList.isTested eq 'Y'}">
시행완료
</c:if>
<c:if test="${quizList.isTested eq 'N'}">
미시행
</c:if>
<c:if test="${quizList.isTested eq 'W'}">
시행중
</c:if>
</td>
<td>
	<c:if test="${quizList.isTested ne 'Y'}">
		<div class="glyphicon glyphicon-pencil" style="cursor:pointer; margin-right:15px;" title="수정" onclick="quizModify(${quizList.quizSeq})"></div>
	</c:if>
	<c:if test="${quizList.isTested ne 'W'}">
		<div class="glyphicon glyphicon-remove" style="cursor:pointer; margin-right:15px;" title="삭제" onclick="quizDelete(${quizList.quizSeq})"></div>
<%-- 		<input type="button" value="삭제" onclick="quizDelete(${quizList.quizSeq})"/> --%>
	</c:if>
	<c:if test="${quizList.isTested eq 'N'}">
		<div class="glyphicon glyphicon-play" style="cursor:pointer; margin-right:15px;"title="시작" onclick="quizStart(${quizList.quizSeq})"></div>
<%-- 		<input type="button" value="시작" onclick="quizStart(${quizList.quizSeq})"/> --%>
	</c:if>
	<c:if test="${quizList.isTested eq 'W'}">
		<div class="glyphicon glyphicon-stop" style="cursor:pointer; margin-right:15px;" title="끝" onclick="quizEnd(${quizList.quizSeq})"></div>
<%-- 		<input type="button" value="끝" onclick="quizEnd(${quizList.quizSeq})"/> --%>
	</c:if>
	<c:if test="${quizList.isTested eq 'Y'}">
<%-- 		<input type="button" value="채점" onclick="quizGrading(${quizList.quizSeq})"/> --%>
		<div class="glyphicon glyphicon glyphicon-ok" style="cursor:pointer; margin-right:15px;" title="채점" onclick="quizGrading(${quizList.quizSeq})"></div>
	</c:if>
</td>
</tr>
</c:forEach>
</table>
</div>
<input type="button" class="btn btn-primary" value="퀴즈추가" onclick="quizInsert();"/>