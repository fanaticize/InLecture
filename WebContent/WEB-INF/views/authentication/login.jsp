<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- 	<title>Home</title>	 -->
<!-- </head> -->

<!-- <body> -->
<!-- <h2>로그인 </h2> -->
<!-- <form name="form1" method="post" action="loginProcess.do"> -->
<%-- <c:if test="${error == 'true'}"> --%>
<!-- <p>로그인에 실패하셨습니다.</p> -->
<%-- </c:if> --%>
<!-- <table> -->
<!--     <tr height="40px"> -->
<!--         <td>유저ID</td> -->
<!--         <td><input type="text" name="id"></td> -->
<!--     </tr> -->
<!--     <tr height="40px"> -->
<!--         <td>패스워드</td> -->
<!--         <td><input type="password" name="pw"></td> -->
<!--     </tr> -->
<!-- </table> -->
<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
<!-- <table> -->
<!--     <tr> -->
<!--         <td align="center"><input type="submit" value="로그인"></td> -->
<%--         <td align="center"><input type="button" onclick="location.href='<c:url value='/member/signup.do'/>'" value="회원가입"></td> --%>
<!--     </tr> -->
<!-- </table> -->
<!-- </form> -->
<div class="row">
        
    <div class="row">
        <div class="col-md-12 center login-header">
            <h2>In Lecture 시스템에 오신걸 환영합니다.</h2>
        </div>
        <!--/span-->
    </div><!--/row-->

    <div class="row">
        <div class="well col-md-5 center login-box" >
            <form class="form-horizontal" name="form1" method="post" action="loginProcess.do">
                <fieldset>
                    <div class="input-group input-group-lg">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user red"></i></span>
                        <input type="text" name="id" class="form-control" placeholder="User ID">
                    </div>
                    <div class="clearfix"></div><br>

                    <div class="input-group input-group-lg">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock red"></i></span>
                        <input type="password" name="pw" class="form-control" placeholder="Password">
                    </div>
                    <div class="clearfix"></div>

                    <p class="center col-md-5">
                        <button type="submit" class="btn btn-primary">로그인</a></button>
                        <button type="button" class="btn btn-primary" onclick="location.href='<c:url value='/member/signup.do'/>'">회원가입</button>
                    </p>
                </fieldset>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
        </div>
        <!--/span-->
    </div><!--/row-->
</div><!--/fluid-row-->
