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
	
	function fileDelete(fileSeq, idx){
		var param = { 
		    	"fileSeq" : fileSeq
		    	};
		var _data = JSON.stringify(param);
		$.ajax({
		    url : "lectureMaterialDelete.do",
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
	강의자료삽입
	<form id="inserForm" action="lectureMaterialInsert.do?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data" method="POST">
		<input type="file" id="file" name="file">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="submit" value="파일추가"/>
	</form>
	<table>
	<tr>
		<th>파일명</th>
		<th></th>
	</tr>
	<c:forEach items="${fileList}" var="file" varStatus="status">
	<tr id="list_${status.count}">
		<td>${file.name }</td>
		<td><input type="button" value="삭제" onclick="fileDelete(${file.fileSeq}, ${status.count});"></td>
	</tr>
	</c:forEach>
</table>
	
</body>
</html>