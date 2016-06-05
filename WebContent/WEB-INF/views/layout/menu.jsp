<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<div>
		<div>menu</div>
		<sec:authorize access="hasRole('TEACHER')">
			<a href="/InLecture/subject/subjectInsert.do">수업개설</a><p>
		</sec:authorize>
		<sec:authorize access="hasRole('TEACHER')">
			<a href="/InLecture/subject/subjectEnrolmentCheck.do">수강신청자확인</a><p>
		</sec:authorize>
		
		<sec:authorize access="hasRole('STUDENT')">
			<a href="/InLecture/subject/subjectEnrolment.do">수업참여</a><p>
		</sec:authorize>
		
	</div>
	
</body>
</html>