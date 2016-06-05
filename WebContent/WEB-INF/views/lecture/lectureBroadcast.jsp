<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.2.4.min.js" />" ></script>
	<script type="text/javascript" src="<c:url value="/resources/js/sockjs-1.1.1.min.js" />" ></script>
	<script type="text/javascript" src= "<c:url value="/resources/js/stomp.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/pdfjs/compatibility.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/pdfjs/pdf.js" />"></script>
	<script id="script">
	var pdfDoc,	pageNum, pageRendering, pageNumPending, scale, canvas, ctx;
	
	<sec:authorize access="hasRole('TEACHER')">
	var role = 'T';
	</sec:authorize>
	<sec:authorize access="hasRole('STUDENT')">
	var role = 'S';
	</sec:authorize>
	
	
	$(function () {
// 		  var pdfData = atob('');
		  pdfDoc = null,
				pageNum = 1,
			    pageRendering = false,
			    pageNumPending = null,
			    scale = 1,
			    canvas = document.getElementById('the-canvas'),
			    ctx = canvas.getContext('2d');
		 
		  document.getElementById('prev').addEventListener('click', onPrevPage);
		  document.getElementById('next').addEventListener('click', onNextPage);

		  /**
		  * Asynchronously downloads PDF.
		  */
		  PDFJS.getDocument({data: pdfData}).then(function (pdfDoc_) {
			  pdfDoc = pdfDoc_;
			  document.getElementById('page_count').textContent = pdfDoc.numPages;
			  // Initial/first page rendering
			  renderPage(pageNum);
		  });
	});
	function initPdf(){
		var pdfData = atob('');
		  pdfDoc = null,
				pageNum = 1,
			    pageRendering = false,
			    pageNumPending = null,
			    scale = 1,
			    canvas = document.getElementById('the-canvas'),
			    ctx = canvas.getContext('2d');
		 
		  document.getElementById('prev').addEventListener('click', onPrevPage);
		  document.getElementById('next').addEventListener('click', onNextPage);

		  /**
		  * Asynchronously downloads PDF.
		  */
		  PDFJS.getDocument({data: pdfData}).then(function (pdfDoc_) {
			  pdfDoc = pdfDoc_;
			  document.getElementById('page_count').textContent = pdfDoc.numPages;
			  // Initial/first page rendering
			  renderPage(pageNum);
		  });
	}
	function renderPage(num) {
		pageRendering = true;
		// Using promise to fetch the page
		pdfDoc.getPage(num).then(function(page) {
		    var viewport = page.getViewport(scale);
		    canvas.height = viewport.height;
		    canvas.width = viewport.width;

		    // Render PDF page into canvas context
		    var renderContext = {
			  	canvasContext: ctx,
			  	viewport: viewport
		    };
		    var renderTask = page.render(renderContext);

		    // Wait for rendering to finish
		    renderTask.promise.then(function () {
			  	pageRendering = false;
			  	if (pageNumPending !== null) {
			  	  // New page rendering is pending
			  	  renderPage(pageNumPending);
			  	  pageNumPending = null;
			  	}
		  	});
	  	});

	  	// Update page counters
	  	document.getElementById('page_num').textContent = pageNum;
	  }

	  function queueRenderPage(num) {
		  if (pageRendering) {
		    pageNumPending = num;
		  } else {
		    renderPage(num);
		  }
	  }
	  function onPrevPage() {
		  if (pageNum <= 1) {
		    return;
		  }
		  pageNum--;
		  queueRenderPage(pageNum);
	  }
	  function onNextPage() {
		  if (pageNum >= pdfDoc.numPages) {
		    return;
		  }
		  pageNum++;
		  queueRenderPage(pageNum);
	  }
	  
	  var stompClient = null;

      function setConnected(connected) {
          document.getElementById('connect').disabled = connected;
          document.getElementById('disconnect').disabled = !connected;
          if(connected){
        	  $('#questionList').css('display', 'block');
          }else{
        	  $('#questionList').css('display', 'none');
          }
//           document.getElementById('conversationDiv').style.visibility = connected ? 'visible' : 'hidden';
          document.getElementById('response').innerHTML = '';
      }

//       function connect() {
//        var socket = new SockJS('/InLecture/echo');
//        stompClient = Stomp.over(socket);
//        stompClient.connect({}, function(frame) {
//            setConnected(true);
//            console.log('Connected: ' + frame);
//            stompClient.subscribe('/subscribe/echo/${subjectSeq}', function(greeting){
//          	  //요청헤더 포함
// //             	  console.log(greeting);
//          	  //요청의 내용부분
// //             	  console.log(greeting.body);
//          	  //JSON을 Object로 변환
// //             	  console.log(JSON.parse(greeting.body));
//                showGreeting(JSON.parse(greeting.body).content);
//            });
//        });
//    }
      
      
      function initialConnect(subScribeFunc){
    	  var socket = new SockJS('/InLecture/echo');
    	  stompClient = Stomp.over(socket);
    	  stompClient.connect({}, function(frame) {
              setConnected(true);
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
//     	  doSubscribe('', function(data){
//     		  showGreeting(JSON.parse(data.body).content);
//     	  });

    	if(role=='T'){
    		isOpenSubscribe();
    	}else if(role =='S' ){
    		isOpenOkSubscribe();
    		isOpenSend();
    	}
      }
      
      var prefixSend = '/app/echo/${subjectSeq}';
      
      function doSend(url, data){
    	  stompClient.send(prefixSend+url, {}, JSON.stringify(data));
      }
      
      
      //교수가 수업이 열렸는지 여부 요청 구독받고 응답보냄
      function isOpenSubscribe(){
    	  doSubscribe('/isOpen', function(data){
    		  console.log('getIsOpen: '+jsonToObject(data).memSeq);
    		  var sendData = '';
    		  doSend('/isOpenOk/'+jsonToObject(data).memSeq, sendData);
    	  });
      }
      
      //학생이 수업이 열렸는지 여부 요청에 대한 응답 구독
      function isOpenOkSubscribe(){
    	  doSubscribe('/isOpenOk/${memSeq}', function(data){
    		  console.log('OKSign');
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
      
      
      

      function disconnect() {
          if (stompClient != null) {
              stompClient.disconnect();
          }
          setConnected(false);
          console.log("Disconnected");
      }

      function sendName() {
          var name = document.getElementById('name').value;
          stompClient.send("/app/echo/${subjectSeq}", {}, JSON.stringify({ 'name': name }));
      }

      function showGreeting(message) {
          var response = document.getElementById('response');
          var p = document.createElement('p');
          p.style.wordWrap = 'break-word';
          p.appendChild(document.createTextNode(message));
          response.appendChild(p);
      }
	</script>
</head>
<body onload="disconnect()">

<div id="pdfCanvase" style="display: none;">
<h1>'Previous/Next' example</h1>

<div>
  <button id="prev">Previous</button>
  <button id="next">Next</button>
  &nbsp; &nbsp;
  <span>Page: <span id="page_num"></span> / <span id="page_count"></span></span>
</div>

<div>
  <canvas id="the-canvas" style="border:1px solid black"></canvas>
</div>
</div>

<div>
    <div>
        <button id="connect" onclick="connect();">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button>
    </div>
    <div id="questionList" style="display: none;">
        <input type="text" id="name" />
        <button id="sendName" onclick="sendName();">Send</button>
        <p id="response"></p>
    </div>
    
</div>

</body>
</html>

