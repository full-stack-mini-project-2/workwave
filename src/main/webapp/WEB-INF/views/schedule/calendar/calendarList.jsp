<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Calendar</title>
</head>
<body>
<h1>Welcome, ${userName}</h1>

<h2>Your Calendars</h2>
<table border="1">
    <tr>
        <th>Personal Calendar</th>
        <th>Team Calendar</th>
    </tr>
    <c:forEach var="calendar" items="${calendars}">
        <tr>
            <td>${calendar.calendar_name}</td>
            <td>${calendar.t_calendar_name}</td>
        </tr>
    </c:forEach>
</table>

<h2>Your Calendar Events</h2>
<table border="1">
    <tr>
        <th>Title</th>
        <th>Description</th>
        <th>Date</th>
        <th>Type</th>
    </tr>
    <c:forEach var="event" items="${calendarEvents}">
        <tr>
            <td>${event.c_event_title}</td>
            <td>${event.c_event_description}</td>
            <td>${event.c_event_date}</td>
            <td>Personal</td>
        </tr>
    </c:forEach>
    <c:forEach var="event" items="${teamCalendarEvents}">
        <tr>
            <td>${event.c_event_title}</td>
            <td>${event.c_event_description}</td>
            <td>${event.c_event_date}</td>
            <td>Team</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
