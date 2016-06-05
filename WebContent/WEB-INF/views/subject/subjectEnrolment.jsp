<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
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
		    	var sethtml = '<table>';
		    	sethtml += '<tr><td>과목명</td><td>학교</td><td>수업코드</td><td>교수명</td><td></td></tr>'
		    	 $.each(data, function(key, val) {
		    		 sethtml += '<tr>';
		    		 sethtml += '<td>'+val.name+'</td>';
					 sethtml += '<td>'+val.school+'</td>';
					 sethtml += '<td>'+val.code+'</td>';
					 sethtml += '<td>'+val.profName+'</td>';
					 sethtml += '<td><input value="신청" type="button" onclick="insertEnrolement(\''+val.subjectSeq+'\');"</td>';
					 sethtml += '</tr>';
		          });
		    	 sethtml += '</table>'
		    	 $('#searchTable').html(sethtml);
		    },
		    error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"error:"+error);
		    }
		 
		}); 
	}
	function insertEnrolement(subjectSeq){
		location.href="subjectEnrolmentInsert.do?subjectSeq="+subjectSeq;
	}
	</script>
</head>

<body>
<table>
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
<input type="button" onclick="search();" value="검색"/>

<div id="searchTable">

</div>
</body>
</html>