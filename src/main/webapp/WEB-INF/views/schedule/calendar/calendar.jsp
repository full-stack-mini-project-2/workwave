<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calendar List</title>
</head>
<body>
<h1>Calendar List</h1>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Event Title</th>
        <th>Event Date</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="calendar" items="${calendars}">
        <tr>
            <td>${calendar.calendar_id}</td>
            <td>${calendar.event_title}</td>
            <td>${calendar.event_date}</td>
            <td>
                <a href="/calendars/${calendar.calendar_id}">Edit</a>
                <form action="/calendars/${calendar.calendar_id}" method="post" style="display:inline">
                    <input type="hidden" name="_method" value="delete">
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/calendars/new">Add New Event</a>
</body>
</html>