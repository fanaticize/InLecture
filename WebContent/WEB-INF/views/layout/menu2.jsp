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
			<a href="/InLecture/lecture/${subjectSeq}/lectureMaterialPage.do">강의자료추가</a><p>
		</sec:authorize>
		
		<sec:authorize access="hasRole('USER')">
			<a href="/InLecture/lecture/${subjectSeq}/lectureBroadcastPage.do">강의중계</a><p>
		</sec:authorize>
		
	</div>
	
</body>
</html>