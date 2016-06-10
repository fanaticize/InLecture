<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
<script>
	function takeQuiz(quizSeq){
		if(confirm('퀴즈에 응시하시겠습니까?')){
			location.href = 'takeQuizPage.do?quizSeq='+quizSeq;
		}
	}
	
</script>
<style>
	.quizTable{
		width: 600px;
	}
	.quizTable td{
		width: 200px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
<div class="table-responsive">
<table class="quizTable table table-striped">
<thead>
<tr>
<th>퀴즈명</th>
<th>완료여부</th>
<th></th>
</tr>
</thead>
<c:forEach items="${quizList }" var="quizList">
<tr>
<td>${quizList.name }</td>
<td>
	<c:if test="${quizList.isTested eq 'Y'}">
	퀴즈종료
	</c:if>
	<c:if test="${quizList.isTested eq 'N'}">
	미시행
	</c:if>
	<c:if test="${quizList.isTested eq 'W' and quizList.member.memseq eq 0 }">
	시행중
	</c:if>
	<c:if test="${quizList.isTested eq 'W' and quizList.member.memseq ne 0}">
	답변완료
	</c:if>
</td>
<td>
	<c:if test="${quizList.isTested eq 'W' and quizList.member.memseq eq 0}">
		<input type="button" value="시작" onclick="takeQuiz(${quizList.quizSeq})"/>
	</c:if>
</td>
</tr>
</c:forEach>
</table>
</div>