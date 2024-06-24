<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calendars</title>
</head>
<body>
<h1>Calendars</h1>
<table border="1">
    <tr>
        <th>Calendar ID</th>
        <th>Team Calendar Name</th>
        <th>Team Calendar ID</th>
        <th>Team Calendar Name</th>
        <th>User ID</th>
    </tr>
    <c:forEach var="calendar" items="${calendars}">
        <tr>
            <td>${calendar.getCalendarId()}</td>
            <td>${calendar.getCalendarName()}</td>
            <td>${calendar.gettCalendarId()}</td>
            <td>${calendar.gettCalendarName()}</td>
            <td>${calendar.userId}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>


