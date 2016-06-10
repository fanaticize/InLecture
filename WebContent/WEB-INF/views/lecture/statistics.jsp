<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
<title>Insert title here</title>
</head>

<div class="table-responsive">
<table class="quizTable table table-striped" style="max-width: 550px;">
<thead>
<tr>
<th>이름</th>
<th>고유번호</th>
<th>질문수</th>
<th>답변수</th>
<th>퀴즈점수합</th>
</tr>
</thead>
<c:forEach items="${statisticsList }" var="statisticsList">
<tr>
<td>${statisticsList.name }</td>
<td>${statisticsList.code }</td>
<td>${statisticsList.answerCnt }</td>
<td>${statisticsList.questionCnt }</td>
<td>${statisticsList.sumScore }</td>
</tr>
</c:forEach>
</table>
</div>