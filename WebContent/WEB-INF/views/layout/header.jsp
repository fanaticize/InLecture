<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script>
	$(function () {
		  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  $(document).ajaxSend(function(e, xhr, options) {
		    xhr.setRequestHeader(header, token);
		  });
		  selectSubjectList();
	});
	function selectSubjectList(){
		var basicurl = "<c:url value="/" />";
		<sec:authorize access="hasRole('TEACHER')">
// 		var geturl = "<c:url value="/subject/selectTeacherSubjectList.do" />"
		var gourl = basicurl + 'subject/selectTeacherSubjectList.do';
        </sec:authorize>
        <sec:authorize access="hasRole('STUDENT')">
//         var geturl = "<c:url value="/subject/selectStudentSubjectList.do" />"
        var gourl = basicurl + 'subject/selectStudentSubjectList.do';
        </sec:authorize>
		var param = { };
		var _data = JSON.stringify(param);
		$.ajax({
		    url : gourl,
		    type : "post",
		    contentType : "application/json",
		    data : _data,
		    success: function(data) {
		    	var sethtml = '';
		    	$.each(data, function(key, val) {
		    		sethtml+='<li><a href="'+basicurl+'lecture/'+val.subjectSeq+'/lectureRoom">'+val.name+'('+val.code+')</a></li>';
		          });
		    	$('#subjectListDivider').before(sethtml);

		    },
		    error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"error:"+error);
		    }
		 
		});
	}
</script>
<div class="navbar navbar-default" role="navigation">
	<div class="navbar-inner">
<!--     	<div>header<p><a href="/InLecture/main.do">gomain</a></div> -->
        <button type="button" class="navbar-toggle pull-left animated flip">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        
        <div class="btn-group pull-right">
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i><span class="hidden-sm hidden-xs">
                <sec:authorize access="hasRole('TEACHER')">
                 Professor
                 </sec:authorize>
                 <sec:authorize access="hasRole('STUDENT')">
                 Student
                 </sec:authorize>
                 </span>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li id="subjectListDivider" class="divider"></li>
                <li><a href="<c:url value="/authentication/logout.do" />">Logout</a></li>
            </ul>
        </div>
    </div>
</div>