<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>InLecture</title>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.2.4.min.js" />" ></script>
	<script>
	$(function () {
		  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  $(document).ajaxSend(function(e, xhr, options) {
		    xhr.setRequestHeader(header, token);
		  });
	});
	
	function getStudentAnswer(quizStudentSeq){
		var param = {
				"quizStudentSeq": quizStudentSeq
		};
  		var _data = JSON.stringify(param);
  		$.ajax({
  		    url : "selectStudentAnswer.do",
  		    type : "post",
  		    contentType : "application/json",
  		    data : _data,
  		    success: function(data) {
  		    	$('#quizStudentSeq').val(quizStudentSeq)
  		    	var sethtml ='';
  		    	var tempScore;
  		    	var tempComment
		    	 $.each(data, function(key, val) {
		    		 tempScore = val.score;
		    		 tempComment = val.comment;
		    		 if(val.score == 0)
		    			 tempScore = '';
		    		 if(val.comment == null)
		    			 tempComment = '';
		    		 sethtml += '<div>';
		    		 sethtml += '문제'+val.idx+' : <span>'+val.content+'</span><p>';
		    		 sethtml += '답: <span>'+val.answer+ '<span><p>';
		    		 sethtml += '점수: <input class="quizScore" name="answerList['+key+'].score" value="'+tempScore+'" /><p>';
		    		 sethtml += '주석: <input name="answerList['+key+'].comment" value="'+tempComment+'" /><p>';
		    		 sethtml += '<input type="hidden" name="answerList['+key+'].quizAnswerSeq" value='+val.quizAnswerSeq+' /><p>';
		    		 sethtml += '</div>';
		          });
  		    	sethtml+='<input type="button" value="전송" onclick="submitAnswer();">';
		    	 $('#studentAnswer').html(sethtml);
  		    },
  		    error:function(request,status,error){
  		        alert("code:"+request.status+"\n"+"error:"+error);
  		    }
  		});
	}
	
	function submitAnswer(){
		var flag = true;
		$('#studentAnswer .quizScore').each(function(index) {
			if(!$.isNumeric($(this).val()))
				flag = false;
		});
		if(!flag)
			alert('점수는 반드시 숫자여야 합니다.');
		else
			document.quizAnswerList.submit();
	}
	</script>
</head>
<body>
<table>
<tr>
<th>이름</th>
<th>학번</th>
<th>채점여부</th>
<th>점수</th>
</tr>
</table>
<div style="width: 80%; height: 120px; overflow-y: scroll;;">
	<table>
		<c:forEach items="${quizStudentList }" var="quizStudentList">
			<tr>
			<td>${quizStudentList.member.name }</td>
			<td>${quizStudentList.member.code }</td>
			<td>${quizStudentList.isGrading}</td>
			<td>
				<c:if test="${quizStudentList.isGrading eq 'Y'}">
					${quizStudentList.score}
				</c:if>
			</td>
			<td>
				<input type="button" value="채점하기" onclick="getStudentAnswer(${quizStudentList.quizStudentSeq});"/>
			</td>
			</tr>
		</c:forEach>
		
	</table>
</div>
<form action="insertGrading.do" name="quizAnswerList" method="POST">
<input type="hidden" name="quizSeq" value="${quizSeq }" />
<input type="hidden" name="quizStudentSeq" id="quizStudentSeq" />

<div id="studentAnswer">

</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
</body>
</html>