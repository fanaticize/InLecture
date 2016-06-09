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
                <sec:authorize access="hasRole('TEACHER')">
	                <li>
	                <a class="ajax-link" href="/InLecture/subject/subjectInsert.do"><i class="glyphicon glyphicon-edit"></i><span>수업개설</span></a>
	                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('TEACHER')">
	                <li>
	                <a class="ajax-link" href="/InLecture/subject/subjectEnrolmentCheck.do"><i class="glyphicon glyphicon-check"></i><span>수강신청자확인</span></a>
	                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('STUDENT')">
	                <li>
	                <a class="ajax-link" href="/InLecture/subject/subjectEnrolment.do"><i class="glyphicon glyphicon-edit"></i><span>수업참여</span></a>
	                </li>
                </sec:authorize>
<!--                 <li> -->
<!--                 <a class="ajax-link" href="professor_note_box.html"><i class="glyphicon glyphicon-envelope"></i><span> 쪽지함</span></a> -->
<!--                 </li> -->
            </ul>
       </div>
    </div>
</div>