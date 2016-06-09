<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<!-- <html> -->
<head>
	<meta charset="UTF-8">
	<meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
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
	 var objoff
	
	$(function () {
		var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  $(document).ajaxSend(function(e, xhr, options) {
		    xhr.setRequestHeader(header, token);
		  });
		  fileSelect();
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
// 		  PDFJS.getDocument({data: pdfData}).then(function (pdfDoc_) {
// 			  pdfDoc = pdfDoc_;
// 			  document.getElementById('page_count').textContent = pdfDoc.numPages;
// 			  // Initial/first page rendering
// 			  renderPage(pageNum);
// 		  });
		  disconnect(); init();
		  objoff= $("#can").offset();
	});
	function initPdf(pdffile){
		var pdfData = atob(pdffile);
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
		  $('#pdfCanvase').css('display', 'block');
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
			  	console.log('load complete');
			  	initCanvas();
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
//           if(connected){
//         	  $('#questionList').css('display', 'block');
//           }else{
//         	  $('#questionList').css('display', 'none');
//           }
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
    		
    		
    		$('#questionList').css('display', 'block');
    		
    		isOpenSubscribe();
    		
    		questionSubscribe();
    		
    	}else if(role =='S' ){
    		isOpenOkSubscribe();
    		isOpenSend();
    	}
      }
      
      var prefixSend = '/app/echo/${subjectSeq}';
      
      function doSend(url, data){
    	  stompClient.send(prefixSend+url, {}, JSON.stringify(data));
      }
      
    //학생이 교수에게 수업여부 확인 요청 보냄
      function isOpenSend(){
    	  console.log('sendIsOpen');
		  var data = {
			memSeq : '${memSeq}'			  
		  }
    	  doSend('/isOpen', data);
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
    		  $('#questionList').css('display', 'block');
    	  });
      }
      
    //질문 보냄
      function sendQuestion(){
    	  console.log('sendQuestion');
		  var data = {
			question: $('#question').val(),
			memSeq : '${memSeq}' 
		  }
    	  doSend('/sendQuestion', data);
      }
      
    //질문 받음
      function questionSubscribe(){
    	  doSubscribe('/sendQuestion', function(data){
    		  console.log('getQuestion: '+jsonToObject(data));
    		  console.log('getQuestion: '+jsonToObject(data).question);
    		  $('#response').append('<p>'+jsonToObject(data).question+'</p>');
    	  });
      }
    
      function fileSelect(fileSeq, idx){
  		var param = { };
  		var _data = JSON.stringify(param);
  		$.ajax({
  		    url : "selectFileList.do",
  		    type : "post",
  		    contentType : "application/json",
  		    data : _data,
  		    success: function(data) {
  		    	var sethtml = '<select id="fileSeq">';
		    	 $.each(data, function(key, val) {
					 sethtml += '<option value='+val.fileSeq+'>'+val.name+'</option>';
		          });
		    	 sethtml += '</select><input type="button" value="불러오기" onclick="getFile();">'
		    	 $('#fileSelct').html(sethtml);
  		    },
  		    error:function(request,status,error){
  		        alert("code:"+request.status+"\n"+"error:"+error);
  		    }
  		 
  		});
  		
  		
//   		<table>
//   		<tr>
//   			<th>파일명</th>
//   			<th></th>
//   		</tr>
//   		<c:forEach items="${fileList}" var="file" varStatus="status">
//   		<tr id="list_${status.count}">
//   			<td>${file.name }</td>
//   			<td><input type="button" value="삭제" onclick="fileDelete(${file.fileSeq}, ${status.count});"></td>
//   		</tr>
//   		</c:forEach>
//   		</table>
  	}
      
		function getFile(){
			var param = {
				fileSeq: $('#fileSeq').val()
			};
    		var _data = JSON.stringify(param);
    		$.ajax({
    		    url : "getFile.do",
    		    type : "post",
    		    contentType : "application/json",
    		    data : _data,
    		    success: function(data) {
    		    	initPdf(data);
    		    },
    		    error:function(request,status,error){
    		        alert("code:"+request.status+"\n"+"error:"+error);
    		    }
    		 
    		});  
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
<!-- <body onload="disconnect(); init();"> -->
<div id="fileSelct">
</div>
<div id="pdfCanvase" style="display: none;">
<div>
  <button id="prev">Previous</button>
  <button id="next">Next</button>
  &nbsp; &nbsp;
  <span>Page: <span id="page_num"></span> / <span id="page_count"></span></span>
</div>

<div id="lecCanvas">
  <canvas id="the-canvas" style="position: absolute; border:1px solid black; width:80%;"></canvas>
  <canvas id="can" style="position: absolute; border:2px solid; width:80%"></canvas>
</div>
</div>

<div>
    <div>
        <button id="connect" onclick="connect();">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button>
    </div>
    <div id="questionList" style="display: none;">
        <input type="text" id="question" />
        <button id="questionbButton" onclick="sendQuestion();">Send</button>
        <p id="response"></p>
    </div>
    
</div>
<div id="container">
<%--     <canvas id="chart" height="500" width="500" style='border:1px solid'  --%>
<%--         onmousemove='drawPath(event)' --%>
<%--   onmousedown='registerDrawingMode(event)' --%>
<%--   onmouseup='releaseDrawingMode()'></canvas> --%>
</div>


        <div style="position:absolute;top:12%;left:43%;">Choose Color</div>
        <div style="position:absolute;top:15%;left:45%;width:10px;height:10px;background:green;" id="green" onclick="color(this)"></div>
        <div style="position:absolute;top:15%;left:46%;width:10px;height:10px;background:blue;" id="blue" onclick="color(this)"></div>
        <div style="position:absolute;top:15%;left:47%;width:10px;height:10px;background:red;" id="red" onclick="color(this)"></div>
        <div style="position:absolute;top:17%;left:45%;width:10px;height:10px;background:yellow;" id="yellow" onclick="color(this)"></div>
        <div style="position:absolute;top:17%;left:46%;width:10px;height:10px;background:orange;" id="orange" onclick="color(this)"></div>
        <div style="position:absolute;top:17%;left:47%;width:10px;height:10px;background:black;" id="black" onclick="color(this)"></div>
        <div style="position:absolute;top:20%;left:43%;">Eraser</div>
        <div style="position:absolute;top:22%;left:45%;width:15px;height:15px;background:white;border:2px solid;" id="white" onclick="color(this)"></div>
        <img id="canvasimg" style="position:absolute;top:10%;left:52%;" style="display:none;">
        <input type="button" value="save" id="btn" size="30" onclick="save()" style="position:absolute;top:55%;left:10%;">
        <input type="button" value="clear" id="clr" size="23" onclick="erase()" style="position:absolute;top:55%;left:15%;">

<!-- </body> -->
<!-- </html> -->
<script type="text/javascript">
var canvas, ctx, flag = false,
prevX = 0,
currX = 0,
prevY = 0,
currY = 0,
dot_flag = false;

var x = "black",
y = 2;
function initCanvas(){
	var wid = $('#the-canvas').width();
	var hei = $('#the-canvas').height();
	$('#can').attr('width', wid);
	$('#can').attr('height', hei);
// 	$( "#the-canvas" ).position({
// 		  my: "left top",
// 		  at: "left top",
// 		  of: "#can"
// 	});
	objoff= $("#can").offset();
	init();
}
function init() {
	canvas = document.getElementById('can');
	ctx = canvas.getContext("2d");
	w = canvas.width;
	h = canvas.height;
	
	canvas.addEventListener("mousemove", function (e) {
	    findxy('move', e)
	}, false);
	canvas.addEventListener("mousedown", function (e) {
	    findxy('down', e)
	}, false);
	canvas.addEventListener("mouseup", function (e) {
	    findxy('up', e)
	}, false);
	canvas.addEventListener("mouseout", function (e) {
	    findxy('out', e)
	}, false);
}

function color(obj) {
switch (obj.id) {
    case "green":
        x = "green";
        break;
    case "blue":
        x = "blue";
        break;
    case "red":
        x = "red";
        break;
    case "yellow":
        x = "yellow";
        break;
    case "orange":
        x = "orange";
        break;
    case "black":
        x = "black";
        break;
    case "white":
        x = "white";
        break;
}
if (x == "white") y = 30;
else y = 2;

}

function draw() {
	ctx.beginPath();
	ctx.moveTo(prevX, prevY);
	ctx.lineTo(currX, currY);
	ctx.strokeStyle = x;
	ctx.lineWidth = y;
	ctx.stroke();
	ctx.closePath();
}

function erase() {
	var m = confirm("Want to clear");
	if (m) {
	    ctx.clearRect(0, 0, w, h);
	    document.getElementById("canvasimg").style.display = "none";
	}
}

function save() {
	document.getElementById("canvasimg").style.border = "2px solid";
	var dataURL = canvas.toDataURL();
	document.getElementById("canvasimg").src = dataURL;
	document.getElementById("canvasimg").style.display = "inline";
}

function findxy(res, e) {
	if (res == 'down') {
	    prevX = currX;
	    prevY = currY;
	    currX = e.pageX - objoff.left;
	    currY = e.pageY - objoff.top;
	
	    flag = true;
	    dot_flag = true;
	    if (dot_flag) {
	        ctx.beginPath();
	        ctx.fillStyle = x;
	        ctx.fillRect(currX, currY, 2, 2);
	        ctx.closePath();
	        dot_flag = false;
	    }
	}
	if (res == 'up' || res == "out") {
	    flag = false;
	}
	if (res == 'move') {
	    if (flag) {
	        prevX = currX;
	        prevY = currY;
	        currX = e.pageX - objoff.left;
	        currY = e.pageY - objoff.top;
	        draw();
	    }
	}
}
    </script>
