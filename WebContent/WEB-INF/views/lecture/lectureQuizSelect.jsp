<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.2.4.min.js" />" ></script>
<script>
	function takeQuiz(quizSeq){
		if(confirm('퀴즈에 응시하시겠습니까?')){
			location.href = 'takeQuizPage.do?quizSeq='+quizSeq;
		}
	}
	
</script>
<title>Insert title here</title>
</head>
<body>
<table>
<tr>
<th>퀴즈명</th>
<th>완료여부</th>
<th></th>
<th></th>
</tr>
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
</body>
</html>