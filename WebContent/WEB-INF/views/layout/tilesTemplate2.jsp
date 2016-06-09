<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>


<html>

 <head>
   <title>InLecture</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- The styles -->
    <link id="bs-css" href="<c:url value="/resources/css/bootstrap-cerulean.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/charisma-app.css" />" rel="stylesheet">
    <link href='<c:url value="/resources/bower_components/fullcalendar/dist/fullcalendar.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/bower_components/fullcalendar/dist/fullcalendar.print.css" />' rel='stylesheet' media='print'>
    <link href='<c:url value="/resources/bower_components/chosen/chosen.min.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/bower_components/colorbox/example3/colorbox.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/bower_components/responsive-tables/responsive-tables.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/css/jquery.noty.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/css/noty_theme_default.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/css/elfinder.min.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/css/elfinder.theme.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/css/jquery.iphone.toggle.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/css/uploadify.css" />' rel='stylesheet'>
    <link href='<c:url value="/resources/css/animate.min.css" />' rel='stylesheet'>
    <!-- jQuery -->
    <script src="<c:url value="/resources/bower_components/jquery/jquery.min.js" />"></script>
   
<%-- 	<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.2.4.min.js" />" ></script> --%>
    <!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- The fav icon -->
    <link rel="shortcut icon" href="img/favicon.ico">
	<script src="<c:url value="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js" />"></script>
	<!-- library for cookie management -->
	<script src="<c:url value="/resources/js/jquery.cookie.js" />"></script>
	<!-- calender plugin -->
	<script src='<c:url value="/resources/bower_components/moment/min/moment.min.js" />'></script>
	<script src='<c:url value="/resources/bower_components/fullcalendar/dist/fullcalendar.min.js" />'></script>
	<!-- data table plugin -->
	<script src='<c:url value="/resources/js/jquery.dataTables.min.js" />'></script>
	<!-- select or dropdown enhancer -->
	<script src="<c:url value="/resources/bower_components/chosen/chosen.jquery.min.js" />"></script>
	<!-- plugin for gallery image view -->
	<script src="<c:url value="/resources/bower_components/colorbox/jquery.colorbox-min.js" />"></script>
	<!-- notification plugin -->
	<script src="<c:url value="/resources/js/jquery.noty.js" />"></script>
	<!-- library for making tables responsive -->
	<script src="<c:url value="/resources/bower_components/responsive-tables/responsive-tables.js" />"></script>
	<!-- tour plugin -->
	<script src="<c:url value="/resources/bower_components/bootstrap-tour/build/js/bootstrap-tour.min.js" />"></script>
	<!-- star rating plugin -->
	<script src="<c:url value="/resources/js/jquery.raty.min.js" />"></script>
	<!-- for iOS style toggle switch -->
	<script src="<c:url value="/resources/js/jquery.iphone.toggle.js" />"></script>
	<!-- autogrowing textarea plugin -->
	<script src="<c:url value="/resources/js/jquery.autogrow-textarea.js" />"></script>
	<!-- multiple file upload plugin -->
	<script src="<c:url value="/resources/js/jquery.uploadify-3.1.min.js" />"></script>
	<!-- history.js for cross-browser state change on ajax -->
	<script src="<c:url value="/resources/js/jquery.history.js" />"></script>
	<!-- application script for Charisma demo -->
	<script src="<c:url value="/resources/js/charisma.js" />"></script>
 </head>
	<body>	
		<tiles:insertAttribute name="body" />
	</body>
</html>