<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<head>
<script>
	var quizNum = 1;
	$(function () {
		var initNum = $("#quizSet div:last-child .idx").val();
		if(typeof initNum != "undefined")
			 quizNum +=  $("#quizSet div:last-child .idx").val();
		 console.log(quizNum);
	});
	function addQuestion(){
		 $("#quizSet").append(
				'<div id="quiz_'+quizNum+'">'
					+'<input class="idx" name="quizProblemList[0].idx" style="width: 30px;" readonly="readonly" value="1"/>번'
					+'<div class="glyphicon glyphicon-remove" title="삭제" onclick="deleteQuestion('+quizNum+');"></div><p><p>'
					+'<textarea name="quizProblemList[0].content" style="width: 500px;" class="form-control quiz_content" rows="3"></textarea>'
				+'</div>');
		 quizNum++;
		 resetIdx();
	}
	function deleteQuestion(quizNum){
		$('#quiz_'+quizNum).remove();
		resetIdx();
	}
	function resetIdx(){
		$('#quizSet > div').each(function(index) {
		   $(this).find('input.idx').val(index+1);
		   $(this).find('input.idx').attr("name", "quizProblemList[" + index + "].idx");
		   $(this).find('textarea.quiz_content').attr("name", "quizProblemList[" + index + "].content");
		  });
	}
</script>
<title>Insert title here</title>
</head>
<body>
<form action="quizModify.do" name="form1" method="post">
<input type="hidden" value="${quiz.quizSeq}" name="quizSeq">
<input type="hidden" value="${quiz.isTested}" name="isTested">
퀴즈제목: <input type="text" name="name" value="${quiz.name}"/><p>

<div id="quizSet">
	<c:forEach items="${quiz.quizProblemList}" var="problemList" varStatus="status">
	<div id="quiz_${problemList.idx}">
		<input class="idx" name="quizProblemList[${status.index}].idx" style="width: 30px;" readonly="readonly" value="${problemList.idx}"/>번
		<div class="glyphicon glyphicon-remove" title="삭제" onclick="deleteQuestion(${problemList.idx});"></div><p><p>
		<textarea name="quizProblemList[${status.index}].content" style="width: 500px;" class="form-control quiz_content" rows="3">${problemList.content}</textarea>
<%-- 		<input type="text"  name="quizProblemList[${status.index}].content" class="quiz_content" value="${problemList.content}"/> --%>
<%-- 		<input type="button" value="삭제" onclick="deleteQuestion(${problemList.idx});"> --%>
	</div>
	</c:forEach>
</div>

<div>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</div>
<input type="button" class="btn btn-primary" style="margin-right:10px;" value="문제추가" onclick="addQuestion();">
<input type="submit" class="btn btn-primary" value="전송"/>
</form>