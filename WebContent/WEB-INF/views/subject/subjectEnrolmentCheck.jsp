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
	function accept1(subjectSeq, memSeq, idx){
		handle(subjectSeq, memSeq, idx, 'Y');
	}
	function reject(subjectSeq, memSeq, idx){
		handle(subjectSeq, memSeq, idx, 'R');
	}
	function handle(subjectSeq, memSeq, idx, type){
		var param = { 
		    	"subjectSeq" : subjectSeq,
		    	"memSeq" : memSeq,
		    	"accept" : type
		    	};
		var _data = JSON.stringify(param);
		$.ajax({
		    url : "updateEnrolment.do",
		    type : "post",
		    contentType : "application/json",
		    data : _data,
		    success: function(data) {
		    	$("#list_"+idx).remove();
		    	alert('처리되었습니다.');
		    },
		    error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"error:"+error);
		    }
		 
		});
	}
	</script>
</head>
<body>
<table>
	<tr>
		<th>과목명</th>
		<th>수업코드</th>
		<th>연도</th>
		<th>학기</th>
		<th>이름</th>
		<th>학번</th>
	</tr>
	<c:forEach items="${enrolmentList}" var="enrolement" varStatus="status">
	<tr id="list_${status.count}">
		<td>${enrolement.subjectName }</td>
		<td>${enrolement.subjectCode }</td>
		<td>${enrolement.year }</td>
		<td>${enrolement.semester }</td>
		<td>${enrolement.memName}</td>
		<td>${enrolement.memCode}</td>
		<td><input class="acceptButton" type="button" value="승인" onclick="accept1(${enrolement.subjectSeq}, ${enrolement.memSeq}, ${status.count});"/></td>
		<td><input class="rejectButton" type="button" value="거절" onclick="reject(${enrolement.subjectSeq}, ${enrolement.memSeq}, ${status.count});"/></td>
	</tr>
	</c:forEach>
</table>
</body>
</html>