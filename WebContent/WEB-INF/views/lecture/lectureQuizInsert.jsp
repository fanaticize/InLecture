<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.2.4.min.js" />" ></script>
<script>
	var quizNum = 2;
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
<form action="quizInsert.do" name="form1" method="post">
퀴즈제목: <input type="text" name="name"/><p>
<div id="quizSet">

	<div id="quiz_1">
		<input class="idx" name="quizProblemList[0].idx" style="width: 30px;" readonly="readonly" value="1"/>번 
		<div class="glyphicon glyphicon-remove" title="삭제" onclick="deleteQuestion(1);"></div><p><p>
		<textarea name="quizProblemList[0].content" style="width: 500px;" class="form-control quiz_content" rows="3"></textarea>		
	</div>
</div>
<div>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</div>
<input type="button" class="btn btn-primary" style="margin-right:10px;" value="문제추가" onclick="addQuestion();">
<input type="submit" class="btn btn-primary" value="전송"/>
</form>
</body>
</html>