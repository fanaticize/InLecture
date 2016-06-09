<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="col-sm-2 col-lg-2">
    <div class="sidebar-nav">
        <div class="nav-canvas">
            <div class="nav-sm nav nav-stacked">

            </div>
            <ul class="nav nav-pills nav-stacked main-menu">
                <li class="nav-header">Menu</li>
                <li>
	                <a class="ajax-link" href="/InLecture/main.do"><i class="glyphicon glyphicon-home"></i><span>메인</span></a>
	            </li>
                <sec:authorize access="hasRole('USER')">
	                <li>
	                <a class="ajax-link" href="/InLecture/lecture/lectureBroadcast/${subjectSeq}/lectureBroadcastPage.do"><i class="glyphicon glyphicon-edit"></i><span>강의</span></a>
	                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('TEACHER')">
	                <li>
	                <a class="ajax-link" href="/InLecture/lecture/${subjectSeq}/lectureMaterialPage.do"><i class="glyphicon glyphicon-save-file"></i><span>강의자료추가</span></a>
	                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('TEACHER')">
	                <li>
	                <a class="ajax-link" href="/InLecture/lecture/quiz/${subjectSeq}/quizManagePage.do"><i class="glyphicon glyphicon-check"></i><span>퀴즈관리</span></a>
	                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('STUDENT')">
	                <li>
	                <a class="ajax-link" href="/InLecture/lecture/quiz/${subjectSeq}/quizSelectPage.do"><i class="glyphicon glyphicon-pencil"></i><span>퀴즈</span></a>
	                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('TEACHER')">
                	<li>
	                <a class="ajax-link" href="/InLecture/lecture/schedule/${subjectSeq}/scheduleManagePage.do"><i class="glyphicon glyphicon-calendar"></i><span>일정관리</span></a>
	                </li>
				</sec:authorize>
<!--                 <li> -->
<!--                 <a class="ajax-link" href="professor_note_box.html"><i class="glyphicon glyphicon-envelope"></i><span> 쪽지함</span></a> -->
<!--                 </li> -->
            </ul>
       </div>
    </div>
</div>

<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <title>Insert title here</title> -->
<!-- </head> -->
<!-- <body> -->
<!-- 	<div> -->
<!-- 		<div>menu</div> -->
<%-- 		<sec:authorize access="hasRole('TEACHER')"> --%>
<%-- 			<a href="/InLecture/lecture/${subjectSeq}/lectureMaterialPage.do">강의자료추가</a><p> --%>
<%-- 		</sec:authorize> --%>
		
<%-- 		<sec:authorize access="hasRole('USER')"> --%>
<%-- 			<a href="/InLecture/lecture/lectureBroadcast/${subjectSeq}/lectureBroadcastPage.do">강의중계</a><p> --%>
<%-- 		</sec:authorize> --%>
		
<%-- 		<sec:authorize access="hasRole('TEACHER')"> --%>
<%-- 			<a href="/InLecture/lecture/quiz/${subjectSeq}/quizManagePage.do">퀴즈관리</a><p> --%>
<%-- 		</sec:authorize> --%>
		
<%-- 		<sec:authorize access="hasRole('STUDENT')"> --%>
<%-- 			<a href="/InLecture/lecture/quiz/${subjectSeq}/quizSelectPage.do">퀴즈</a><p> --%>
<%-- 		</sec:authorize> --%>
		
<%-- 		<sec:authorize access="hasRole('TEACHER')"> --%>
<%-- 			<a href="/InLecture/lecture/schedule/${subjectSeq}/scheduleManagePage.do">수업일정관리</a><p> --%>
<%-- 		</sec:authorize> --%>
<!-- 	</div> -->
	
<!-- </body> -->
<!-- </html> -->