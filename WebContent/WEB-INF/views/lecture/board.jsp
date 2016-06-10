<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<head>
<title>Insert title here</title>
</head>
<span style="font-weight:bold">제목</span>
<div class="well">
${board.title}
</div>
<span style="font-weight:bold">내용</span>
<div class="well">
${board.contents}
</div>

<c:if test="${board.memseq eq memseq }">
<input class="btn btn-primary" type="button" value="삭제" style="float: right" onclick="location.href = 'boardDelete.do?idx=${board.idx}'">
<a href= "boardModifyPage.do?idx=${board.idx}"><input class="btn btn-primary" type="button" value="수정" style="float: right" ></a>
</c:if>
<c:if test="${board.type eq 'Q' }">
<a href= "boardInsertPage.do?parent=${board.parent == 0 ? board.idx : board.parent}"><input class="btn btn-primary" type="button" value="답글" style="float: right" ></a>
</c:if>