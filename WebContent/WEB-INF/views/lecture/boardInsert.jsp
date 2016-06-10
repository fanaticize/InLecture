<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<form name="form1" method="post" action="boardInsert.do">
	<input type="hidden" name="subjectSeq" value="${subjectSeq }"/>
	<input type="hidden" name="type" value="${type }"/>
	<input type="hidden" name="parent" value="${board.parent}"/>
  <div class="form-group">
    <label for="exampleInputEmail1">제목</label>
    <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해 주세요.">
  </div>
  <div class="form-group">
  <label for="comment">내용</label>
  <textarea class="form-control" rows="5" id="comment" name="contents"></textarea>
    </div>
  <div class="form-group">
   </div>
   <button type="submit" class="btn btn-default" >등록</button>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>