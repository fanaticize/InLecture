<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
	<title>InLecture</title>	
</head>

<body>
<form:form commandName="subject">
  <table>
  	 <tr>
        <td>학교:</td>
        <td><form:input path="school" /><form:errors path="school" /></td>
     </tr>
     <tr>
        <td>과목이름 :</td>
        <td>
        <form:input path="name" />
        <form:errors path="name" />
        </td>
     </tr>
     <tr>
        <td>수업코드 :</td>
        <td>
        <form:input path="code" />
        <form:errors path="code" />
        </td>
     </tr>
     <tr>
        <td>연도</td>
        <td><form:input path="year" value="${year}"/><form:errors path="year" /></td>
     </tr>
     <tr>
        <td>학기 :</td>
        <td>
        <form:radiobutton path="semester" value="1H" label="1학기"/>
		<form:radiobutton path="semester" value="2H" label="2학기"/>
        <form:errors path="semester" />
        </td>
     </tr>
   </table>
   <input type="submit" value="submit"/>
</form:form>
</body>
</html>