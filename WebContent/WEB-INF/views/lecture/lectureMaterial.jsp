<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
	<meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
	<script>
	$(function () {
		  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  $(document).ajaxSend(function(e, xhr, options) {
		    xhr.setRequestHeader(header, token);
		  });
		  
		  fileStyleInit();
	});
	
	function fileStyleInit(){
		var fileTarget = $('.filebox .upload-hidden');

		  fileTarget.on('change', function(){  // 값이 변경되면
		    if(window.FileReader){  // modern browser
		      var filename = $(this)[0].files[0].name;
		    } 
		    else {  // old IE
		      var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
		    }
		    
		    // 추출한 파일명 삽입
		    $(this).siblings('.upload-name').val(filename);
		  });
	}
	
	function fileDelete(fileSeq, idx, fileName){
		if(confirm(fileName+'\n해당 파일을 삭제하시겠습니까?')){
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
	}
	</script>
	<style>
	.filebox input[type="file"] {
		  position: absolute;
		  width: 1px;
		  height: 1px;
		  padding: 0;
		  margin: -1px;
		  overflow: hidden;
		  clip:rect(0,0,0,0);
		  border: 0;
		}
	</style>
</head>
	
	<form id="inserForm" action="lectureMaterialInsert.do?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data" method="POST">
<!-- 		<input type="file" id="file" name="file"> -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="filebox">
		 	<input class="upload-name" value="파일선택" disabled="disabled">
		
			<label for="ex_filename" class="btn btn-primary">파일선택</label> 
			<input type="file" name="file" id="ex_filename" class="btn btn-primary upload-hidden"> 
			<input type="submit" class="btn btn-primary" value="파일추가"/>
		</div>
		 
		
		
		
	</form>
	<div class="table-responsive">
		<table class="quizTable table table-striped" style="max-width: 550px;">
			<thead>
				<tr>
					<th>수업자료 목록</th>
					<th></th>
				</tr>
			</thead>
		<c:forEach items="${fileList}" var="file" varStatus="status">
		<tr id="list_${status.count}">
			<td>${file.name}</td>
			<td>
			<span class="glyphicon glyphicon-remove" style="cursor: pointer;" onclick="fileDelete(${file.fileSeq}, ${status.count}, '${file.name}');"></span>
<%-- 			<input type="button" value="삭제" onclick="fileDelete(${file.fileSeq}, ${status.count});"></td> --%>
		</tr>
		</c:forEach>
		</table>
	</div>
	