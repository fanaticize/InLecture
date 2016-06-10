<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div class="row">
    <div class="well col-md-9 center login-box" style="max-width: 800px;">
    	<form:form commandName="subject" class="form-horizontal" style="max-width: 800px;">
         <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">학교</label>
            <div class="col-sm-10">
              <form:input path="school" class="form-control" id="inputEmail3" placeholder=""/><form:errors path="school" />
            </div>
          </div>
          <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">과목이름</label>
            <div class="col-sm-10">
            	<form:input path="name" class="form-control" id="inputEmail3" placeholder=""/><form:errors path="name" />
            </div>
          </div>
          <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">수업코드</label>
            <div class="col-sm-10">
              <form:input path="code" class="form-control" id="inputEmail3" />
        <form:errors path="code" />
            </div>
          </div>
          <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">연도</label>
            <div class="col-sm-10">
              <form:input path="year" value="${year}" class="form-control" id="inputEmail3"/><form:errors path="year" />
            </div>
          </div>
           <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">학기</label>
            <div class="col-sm-10" style="padding-top: 9px;">
              <form:radiobutton class="radio-inline" path="semester" value="1H" label="1학기"/>&nbsp;&nbsp;&nbsp;
				<form:radiobutton class="radio-inline" path="semester" value="2H" label="2학기"/>
		        <form:errors path="semester" />
            </div>
          </div>
           <input type="submit" class="btn btn-primary" style="width:70px; text-align: center" value="제출" > 
        </form:form>
       </div>
</div>
