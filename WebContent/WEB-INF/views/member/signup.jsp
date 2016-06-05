<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
	<title>InLecture</title>	
</head>

<body>
<form:form commandName="member">
  <table>
     <tr>
        <td>아이디 :</td>
        <td>
        <form:input path="id" />
        <form:errors path="id" />
        </td>
     </tr>
     <tr>
        <td>패스워드 :</td> 
        <td>
        <form:password path="pw" />
        <form:errors path="pw" />
        </td>
     </tr>
     <tr>
        <td>유형 :</td>
        <td><form:radiobutton path="role" value="S" label="학생" /> 
            <form:radiobutton path="role" value="T" label="교수" />
            <form:errors path="role" /></td>
     </tr>
     <tr>
        <td>이름 :</td>
        <td><form:input path="name" /><form:errors path="name" /></td>
     </tr>
     <tr>
        <td>고유번호(학번) :</td>
        <td><form:input path="code" /><form:errors path="code" /></td>
     </tr>
     <tr>
        <td>닉네임 :</td>
        <td><form:input path="nick" /><form:errors path="nick" /></td>
     </tr>
     <tr>
        <td>학교 :</td>
        <td><form:input path="school" /><form:errors path="school" /></td>
     </tr>
     <tr>
        <td>이메일 :</td>
        <td><form:input path="email" /><form:errors path="email" /></td>
     </tr>
   </table>
   <input type="submit" value="submit"/>
</form:form>
</body>
</html>