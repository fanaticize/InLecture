<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<head>
	<meta charset="UTF-8">
	<meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
	<script type="text/javascript" src="<c:url value="/resources/js/sockjs-1.1.1.min.js" />" ></script>
	<script type="text/javascript" src= "<c:url value="/resources/js/stomp.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/pdfjs/compatibility.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/pdfjs/pdf.js" />"></script>
	<script id="script">
	var pdfDoc,	pageNum, pageRendering, pageNumPending, scale, canvas, ctx, isLoadRender, notyIdx = 0,
	imgArr = new Array(), imgArrIdx = 0;
	
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

		  disconnect(); init();
		  objoff= $("#can").offset();
		  


		  $(window).resize(function(){
			initCanvas();
		  }).resize();
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
		  
		  //첫 로딩인지 확인
		  isLoadRender = true;
		 
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
		if(!isLoadRender)
			erase();
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
// 			  	console.log('load complete');
				
				//첫번째 로딩이면 그림판 초기화
				if(isLoadRender){
 					initCanvas();
 					isLoadRender = false;
				}
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

//       function setConnected(connected) {
//           document.getElementById('connect').disabled = connected;
//           document.getElementById('disconnect').disabled = !connected;
// //           if(connected){
// //         	  $('#questionList').css('display', 'block');
// //           }else{
// //         	  $('#questionList').css('display', 'none');
// //           }
// //           document.getElementById('conversationDiv').style.visibility = connected ? 'visible' : 'hidden';
//           document.getElementById('response').innerHTML = '';
//       }
      
      var timeflag = true;
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
//     	  doSubscribe('', function(data){
//     		  showGreeting(JSON.parse(data.body).content);
//     	  });

    	if(role=='T'){
    		
    		$('#connector').css('display', 'none');
    		$('#viewer').css('display','block');
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
    	  setTimeout("if(timeflag)alert('아직 강의가 시작된 상태가 아닙니다. 강의 시작 후에 접속해 주세요.');", 3000);
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
    		  getOKSign = true;
    		  timeflag = false;
    		  $('#questionList').css('display', 'block');
    		  $('#connector').css('display', 'none');
      		  $('#viewer').css('display','block');
      			
    	  });
      }
      
    //질문 보냄
      function sendQuestion(qidx){
    	var isSendImg =  $('input:checkbox[id="isSendImg'+qidx+'"]').is(":checked") == true;
    
    	var imgd = '';
    	if(isSendImg)
    		imgd = sendBase64Img();
    	  console.log('sendQuestion');
		  var data = {
			question: $('#question'+qidx).val(),
			memSeq : '${memSeq}' ,
			imgdata: imgd,
			isImg: isSendImg,
			page: $('#page_num').text()
		  }
    	  doSend('/sendQuestion', data);
      }
      
    //질문 받음
      function questionSubscribe(){
    	  doSubscribe('/sendQuestion', function(data){
    		  var objdata = jsonToObject(data);
//     		  console.log('getQuestion: '+jsonToObject(data));
//     		  console.log('getQuestion: '+jsonToObject(data).question);
//     		  $('#response').append('<p>'+jsonToObject(data).question+'</p>');
// $('#canvasimg').attr('src', data.imgdata);
// generate2(isImg, text, page, img
			generate2(objdata.isImg, objdata.question, objdata.page, objdata.imgdata)
			if(data.isImg){
// 				erase();
// 				queueRenderPage(data.page);
// 				var wid = $('#the-canvas').width();
// 				var hei = $('#the-canvas').height();
// 				$('#canvasimg').attr('width', wid);
// 				$('#canvasimg').attr('height', hei);
// 				document.getElementById("canvasimg").src= objdata.imgdata;
// 				$('#canvasimg').css('display', 'block');
			}
    	  });
      }
    
    	function goQPage(page, imgIdx){
    		erase();
    		 pageNum = page;
    		 queueRenderPage(page);
// 			queueRenderPage(data.page);
			var wid = $('#the-canvas').width();
			var hei = $('#the-canvas').height();
			$('#canvasimg').attr('width', wid);
			$('#canvasimg').attr('height', hei);
			document.getElementById("canvasimg").src= imgArr[imgIdx];
			$('#canvasimg').css('display', 'block');
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
  		    	var sethtml = '<select id="fileSeq" class="form-control" style="max-width: 400px; display: inline-block; margin-right:10px;">';
		    	 $.each(data, function(key, val) {
					 sethtml += '<option value='+val.fileSeq+'>'+val.name+'</option>';
		          });
		    	 sethtml += '</select><input type="button" class="btn btn-primary" value="불러오기" onclick="getFile();">'
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
	<script type="text/javascript">
var drawcanvas, ctx2, flag = false, w, h,
prevX = 0,
currX = 0,
prevY = 0,
currY = 0,
dot_flag = false;

var x = "black",
y = 2;
var wid;
var hei;
function initCanvas(){
	console.log('그림판 초기화');
	var wid = $('#the-canvas').width();
	var hei = $('#the-canvas').height();
	$('#can').attr('width', wid);
	$('#can').attr('height', hei);
	objoff= $("#can").offset();
	init();
}
function init() {
	drawcanvas = document.getElementById('can');
	ctx2 = drawcanvas.getContext("2d");
	w = drawcanvas.width;
	h = drawcanvas.height;
	
	drawcanvas.addEventListener("mousemove", function (e) {
	    findxy('move', e)
	}, false);
	drawcanvas.addEventListener("mousedown", function (e) {
	    findxy('down', e)
	}, false);
	drawcanvas.addEventListener("mouseup", function (e) {
	    findxy('up', e)
	}, false);
	drawcanvas.addEventListener("mouseout", function (e) {
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
	ctx2.beginPath();
	ctx2.moveTo(prevX, prevY);
	ctx2.lineTo(currX, currY);
	ctx2.strokeStyle = x;
	ctx2.lineWidth = y;
	ctx2.stroke();
	ctx2.closePath();
}

function erase() {
	ctx2.clearRect(0, 0, w, h);
	document.getElementById("canvasimg").style.display = "none";
}

function save() {
// 	document.getElementById("canvasimg").style.border = "2px solid";
// 	var dataURL = drawcanvas.toDataURL();
// 	document.getElementById("canvasimg").src = dataURL;
// 	document.getElementById("canvasimg").style.display = "inline";
sendBase64Img();
}

function sendBase64Img() {
	var canvas2 = document.getElementById('can');
	var dataURL = canvas2.toDataURL();//이미지 데이터가 base64 문자열로 인코딩된 데이터
// 	console.log(dataURL);
	return dataURL;
	// base64문자열의 첫 부분에 위치한 'http://cfile9.uf.tistory.com/image/24343B4956E6601629B332"");*/
// 	$.ajax({
// 	  type: "POST",
// 	  url: "saveBase64.jsp",
// 	  contentType: "application/x-www-form-urlencoded; charset=utf-8",
// 	  data: { "imgBase64": dataURL }
// 	}).success(function(o) {
// 	  alert('선택영역을 서버의 이미지 파일에 저장했습니다'); 
// 	});
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
	        ctx2.beginPath();
	        ctx2.fillStyle = x;
	        ctx2.fillRect(currX, currY, 2, 2);
	        ctx2.closePath();
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

function generate() {
	var layout = 'bottomRight';
	notyIdx++;
	var n = noty({
        text        : '<div><input type="checkbox" id="isSendImg'+notyIdx+'">필기와 함께보내기</div><textarea id="question'+notyIdx+'" style="width: 288px;"></textarea>',
        type        : 'alert',
        dismissQueue: true,
        layout      : layout,
        theme       : 'defaultTheme',
        buttons     : [
            {addClass: 'btn btn-primary', text: 'Ok', onClick: function ($noty) {
                $noty.close();
                sendQuestion(notyIdx);
                noty({dismissQueue: true, force: true, layout: layout, theme: 'defaultTheme', text: '질문이 전송되었습니다.', type: 'success'});
            }
            },
            {addClass: 'btn btn-danger', text: 'Cancel', onClick: function ($noty) {
                $noty.close();
                noty({dismissQueue: true, force: true, layout: layout, theme: 'defaultTheme', text: '취소되었습니다.', type: 'error'});
            }
            }
        ]
    });
    console.log('html: ' + n.options.id);
}

function generate2(isImg, text, page, img) {
	var layout = 'bottomRight';
	notyIdx++;
	var sethtml ='';
	if(isImg){
		imgArr[imgArrIdx] = img;
		sethtml += '<input type="button" onclick="goQPage('+page+', '+imgArrIdx+');" class="btn btn-danger" value="필기조회">';
		imgArrIdx++;
	}
	var n = noty({
        text        : sethtml+text,
        type        : 'alert',
        dismissQueue: true,
        layout      : layout,
        theme       : 'defaultTheme'
    });
    console.log('html: ' + n.options.id);
}
    </script>

<script>

</script>
</head>
<div id="connector">
    <button id="connect" class="btn btn-primary" onclick="connect();">수업 시작하기</button>
<!--     <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button> -->
</div>
<div id="viewer" style="display:none;">
<div id="fileSelct" style="width: 500px; float: left;">
</div>
<div class="color1">
	<div style="float: left; margin-right: 10px; margin-left: 40px;">color:</div> 
	<div class="color1-1" style="background:green;" id="green" onclick="color(this)"></div>
	<div class="color1-1" style="background:blue;" id="blue" onclick="color(this)"></div>
	<div class="color1-1" style="background:red;" id="red" onclick="color(this)"></div>
	
	<div class="color1-1" style="background:yellow;" id="yellow" onclick="color(this)"></div>
	<div class="color1-1" style="background:orange;" id="orange" onclick="color(this)"></div>
	<div class="color1-1" style="background:black;" id="black" onclick="color(this)"></div>
	<div class="color1-1" style="background:white;border:1px solid;" id="white" onclick="color(this)"></div>
	<span style="float: left; margin-right: 10px;">/</span>
	<div class="glyphicon glyphicon-remove-sign" id="clr" size="23" onclick="erase();" style="float: left;     margin-top: 3px; cursor: pointer"></div>
	<span style="float: left; margin-right: 10px; margin-left: 10px;">/</span>
	<div style="float: left; margin-left:10px;">
	  <div id="prev" class="glyphicon glyphicon-arrow-left" style="cursor: pointer;"></div>
	  <div id="next" class="glyphicon glyphicon-arrow-right" style="cursor: pointer; margin-left:10px; margin-right:10px;"></div>
	  <span>Page: <span id="page_num"></span> / <span id="page_count"></span></span>
	</div>
	<sec:authorize access="hasRole('STUDENT')">
		<span style="float: left; margin-right: 10px; margin-left: 10px;">/</span>
		<div class="glyphicon glyphicon-question-sign" onclick="generate();" style="float: left;     margin-top: 3px; cursor: pointer"></div>
	</sec:authorize>
</div>
<div id="pdfCanvase" style="display: none;">
<div id="lecCanvas">
  <canvas id="the-canvas" style="position: absolute; left: 1%; top: 130%; border:1px solid black; width:80%;"></canvas>
   <img id="canvasimg" style="position: absolute; left: 1%; top: 130%;width:80%; z-index: 1;" style="display:none;">
  <canvas id="can" style="position: absolute; left: 1%; top: 130%; border:1px solid; width:80%; z-index: 2;"></canvas>
 
</div>
</div>

<div>
    <div  style="display: none;">
        <input type="text" id="question" />
        <button id="questionbButton" onclick="sendQuestion();">Send</button>
        <p id="response"></p>
    </div>
</div>
<div>
<div class="container"></div>
</div>
</div>
		<style>
			.color1{
				margin-top:9px;
			}
			.color2{
			
			}
			.color1-1{
				width:10px;height:10px;
			    float: left;
  				margin-right: 10px;
  				margin-top: 6px;
  				cursor: pointer;
  				
			}
		</style>
