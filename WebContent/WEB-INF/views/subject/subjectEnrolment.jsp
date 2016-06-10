<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<head>
	<meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
	<title>InLecture</title>
	<script>
	$(function () {
		  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  $(document).ajaxSend(function(e, xhr, options) {
		    xhr.setRequestHeader(header, token);
		  });
		  
	});
	function search(){
		var param = { 
		    	"school" : $("#school").val(),
		    	"name" : $("#name").val(),
		    	"code" : $("#code").val(),
		    	"profName" : $("#profName").val()
		    	};
		var _data = JSON.stringify(param);
		$.ajax({
		    url : "subjectSearch.do",
		    type : "post",
		    contentType : "application/json",
		    data : _data,
		    success: function(data) {
		    	var sethtml = '<div class="table-responsive"><table class="table table-striped" style="max-width: 550px;">';
		    	sethtml += '<thead><tr><th>과목명</th><th>학교</th><th>수업코드</th><th>교수명</th><th></th></tr></thead>'
		    	 $.each(data, function(key, val) {
		    		 sethtml += '<tr>';
		    		 sethtml += '<td>'+val.name+'</td>';
					 sethtml += '<td>'+val.school+'</td>';
					 sethtml += '<td>'+val.code+'</td>';
					 sethtml += '<td>'+val.profName+'</td>';
					 sethtml += '<td><div class="glyphicon glyphicon glyphicon-ok" style="cursor:pointer; margin-right:15px;" title="신청" onclick="insertEnrolement('+val.subjectSeq+', \''+val.name+'\');"></div>';
					 sethtml += '</tr>';
		          });
		    	 sethtml += '</table></div>'
		    	 $('#searchTable').html(sethtml);
		    },
		    error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"error:"+error);
		    }
		 
		}); 
	}
	function insertEnrolement(subjectSeq, subjectName){
		if(confirm(subjectName+'을 수강신청하시겠습니까?'))
			location.href="subjectEnrolmentInsert.do?subjectSeq="+subjectSeq;
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
</head>

<!-- <body> -->
<div class="table-responsive">
<table class="quizTable table table-striped">
<tr>
<td>학교</td>
<td><input id="school" onchange="search();" /></td>
</tr>
<tr>
<td>과목명</td>
<td><input id="name" onchange="search();"/></td>
</tr>
<tr>
<td>수업고유번호</td>
<td><input id="code" onchange="search();"/></td>
</tr>
<tr>
<td>교수명</td>
<td><input id="profName" onchange="search();"/></td>
</tr>
</table>
<input type="button" class="btn btn-primary" onclick="search();" value="검색"/><p>
</div>
<div id="searchTable">

</div>