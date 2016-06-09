<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>main</title>
<script>
	function goLectureRoom(subjectSeq){
		location.href = 'lecture/'+subjectSeq+'/lectureRoom.do';
	}
</script>
</head>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well">
				<h2><i class="glyphicon glyphicon-info-sign"></i> 나의 과목</h2>
				
			</div>
			
			<div class="box-content row">
				<sec:authorize access="hasRole('TEACHER')">
					<c:forEach items="${teacherCourseList}" var="teacherCourseList" varStatus="status">
						<div class="col-md-3 col-sm-3 col-xs-6" >
							<a data-toggle="tooltip" style="cursor: pointer;" class="well top-block" onclick="goLectureRoom(${teacherCourseList.subjectSeq});">
								<div>${teacherCourseList.name }</div>
								<div>${teacherCourseList.code }</div>
								<div>${teacherCourseList.profName}</div>
							</a>
						</div>
					</c:forEach>
			    </sec:authorize>
			    <sec:authorize access="hasRole('STUDENT')">
					<c:forEach items="${studentCourseList}" var="studentCourseList" varStatus="status">
						<div class="col-md-3 col-sm-3 col-xs-6" >
							<a data-toggle="tooltip" style="cursor: pointer;" class="well top-block" onclick="goLectureRoom(${studentCourseList.subjectSeq});">
								<div>${studentCourseList.name }</div>
								<div>${studentCourseList.code }</div>
								<div>${studentCourseList.profName}</div>
							</a>
						</div>
					</c:forEach>
			    </sec:authorize>
			</div>
		</div>
	</div>
</div>


<!-- 	메인입니다 -->
	
<!-- <ul class="nav navbar-nav navbar-right"> -->
<!--     회원 권한이 없을 때 -->
<%--     <sec:authorize access="hasRole('ROLE_ANONYMOUS')"> --%>
<!--         <li><a href="member/signup.do">회원가입</a></li> -->
<!--         <li><a href="authentication/login.do">로그인</a></li> -->
<%--     </sec:authorize> --%>

<!--     회원 권한이 있을 때 -->
<%--     <sec:authorize access="hasRole('USER')"> --%>
<!--         <li><a href="authentication/logout.do">로그아웃</a></li> -->
<%--     </sec:authorize> --%>

<!--     여러 권한 체크 -->
<%--     <sec:authorize access="hasRole('STUDENT')"> --%>
<!-- 		<li>학생입니다.</li> -->
<!-- 		<table> -->
<!-- 			<tr> -->
<!-- 				<th>과목명</th> -->
<!-- 				<th>수업코드</th> -->
<!-- 				<th></th> -->
<!-- 			</tr> -->
<%-- 		<c:forEach items="${studentCourseList}" var="studentCourseList" varStatus="status"> --%>
<%-- 		<tr id="list_${status.count}"> --%>
<%-- 			<td>${studentCourseList.name }</td> --%>
<%-- 			<td>${studentCourseList.code }</td> --%>
<%-- 			<td>${studentCourseList.profName}</td> --%>
<%-- 			<td><input type="button" onclick="goLectureRoom(${studentCourseList.subjectSeq})"/></td> --%>
<!-- 		</tr> -->
<%-- 		</c:forEach> --%>
<!-- 		</table> -->
<%--     </sec:authorize> --%>
<%--      <sec:authorize access="hasRole('TEACHER')"> --%>
<!-- 		<li>교수입니다.</li> -->
<!-- 		<table> -->
<!-- 			<tr> -->
<!-- 				<th>과목명</th> -->
<!-- 				<th>수업코드</th> -->
<!-- 				<th></th> -->
<!-- 			</tr> -->
<%-- 		<c:forEach items="${teacherCourseList}" var="teacherCourseList" varStatus="status"> --%>
<%-- 		<tr id="list_${status.count}"> --%>
<%-- 			<td>${teacherCourseList.name }</td> --%>
<%-- 			<td>${teacherCourseList.code }</td> --%>
<%-- 			<td>${teacherCourseList.profName}</td> --%>
<%-- 			<td><input type="button" onclick="goLectureRoom(${teacherCourseList.subjectSeq})"/></td> --%>
<!-- 		</tr> -->
<%-- 		</c:forEach> --%>
<!-- 		</table> -->
<%--     </sec:authorize> --%>
    
<%--     <sec:authorize access="hasRole('TEACHER')"> --%>
			
<%-- 	</sec:authorize> --%>
<!-- </ul> -->