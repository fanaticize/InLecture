<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='<c:url value="/resources/css/calendar/fullcalendar.css" />' rel='stylesheet' />
<link href='<c:url value="/resources/css/calendar/fullcalendar.print.css" />' rel='stylesheet' media='print' />
<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.2.4.min.js" />" ></script>
<script type="text/javascript" src="<c:url value="/resources/js/calendar/moment.min.js" />" ></script>
<script type="text/javascript" src="<c:url value="/resources/js/calendar/fullcalendar.js" />" ></script>

<title>Insert title here</title>
<style>
	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}

</style>
<script>
$(document).ready(function() {  
	  
    // 현재 년,월,일 
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
  
    var calendar = $('#calendar').fullCalendar({

    header: {
		left: 'prev,next today',  // 왼쪽 버튼 순서
		center: 'title',  // 가운데 타이틀
		right: 'month,agendaWeek,agendaDay' // 오른쪽 버튼 순서
    },
    allDayText: '시간', // 주간,월간
    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
    dayNamesShort: ['일','월','화','수','목','금','토'],
    buttonText: {
		prev: '이전',
		next: '다음',
		prevYear: '이전',
		nextYear: '다음',
		today: '오늘',
		month: '월간',
		week: '주간',
		day: '일간'
    },
    selectable: true,
    selectHelper: true,
    select: function(start, end, allDay) {
		var title = prompt('일정을 입력하세요.');
		if (title) {
			calendar.fullCalendar('renderEvent',
			   {
					title: title,
					start: start,
					end: end,
					allDay: allDay
			   },
			   true // make the event "stick"
			);
		}
		console.log(start);
		console.log(end);
		console.log(allDay);
		calendar.fullCalendar('unselect');
    },
    editable: true,
	eventLimit: true, // allow "more" link when too many events
	events: [
		{
			title: 'All Day Event',
			start: '2016-05-01'
		},
		{
			title: 'Long Event',
			start: '2016-05-07',
			end: '2016-05-10'
		},
		{
			id: 999,
			title: 'Repeating Event',
			start: '2016-05-09T16:00:00'
		},
		{
			id: 999,
			title: 'Repeating Event',
			start: '2016-05-16T16:00:00'
		},
		{
			title: 'Conference',
			start: '2016-05-11',
			end: '2016-05-13'
		},
		{
			title: 'Meeting',
			start: '2016-05-12T10:30:00',
			end: '2016-05-12T12:30:00'
		},
		{
			title: 'Lunch',
			start: '2016-05-12T12:00:00'
		},
		{
			title: 'Meeting',
			start: '2016-05-12T14:30:00'
		},
		{
			title: 'Happy Hour',
			start: '2016-05-12T17:30:00'
		},
		{
			title: 'Dinner',
			start: '2016-05-12T20:00:00'
		},
		{
			title: 'Birthday Party',
			start: '2016-05-13T07:00:00'
		},
		{
			title: 'Click for Google',
			url: 'http://google.com/',
			start: '2016-05-28'
		}
	]
  });
  
});
</script>
</head>
<body>
<div id='calendar'></div>
</body>
</html>