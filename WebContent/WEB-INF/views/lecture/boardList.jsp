<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<head>
</head>
<div class="table-responsive">          
  <table class="table">
    <thead>
      <tr>
        <th>글번호</th>
        <th>제목</th>
        <th>글쓴이</th>        
      </tr>
    </thead>
    <tbody>
    	<c:forEach items="${boardList }" var="boardList">
    		<tr>
		        <td>
		        <c:if test="${boardList.parent != 0}">
		        	└
		        </c:if>
		        ${boardList.idx }</td>
		         <td><a href="boardPage.do?idx=${boardList.idx }">${boardList.title }</a></td>
		        <td>${boardList.writer }</td>
		      </tr>
    	</c:forEach>

    </tbody>
  </table>
  </div>
<c:if test="${type eq 'G'}">
<sec:authorize access="hasRole('TEACHER')">
<a href= "boardInsertPage.do"><input type="button" value="글쓰기" style="float: right" ></a>
</sec:authorize>
</c:if>
<c:if test="${type eq 'Q'}">
<sec:authorize access="hasRole('USER')">
<a href= "boardInsertPage.do"><input type="button" value="글쓰기" style="float: right" ></a>
</sec:authorize>
</c:if>