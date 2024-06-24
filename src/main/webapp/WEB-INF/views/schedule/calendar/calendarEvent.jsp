<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Calendar Events</title>
</head>
<body>
<h1>Calendar Events</h1>
<table border="1">
  <tr>
    <th>Event ID</th>
    <th>Event Date</th>
    <th>Event Title</th>
    <th>Event Description</th>
    <th>User ID</th>
    <th>Department ID</th>
    <th>Calendar ID</th>
    <th>Team Calendar ID</th>
    <th>Color Index ID</th>
    <th>Notice ID</th>
  </tr>
  <c:forEach var="event" items="${calendarEvents}">
    <tr>
      <td>${event.calEventId}</td>
      <td>${event.calEventDate}</td>
      <td>${event.cconalEventTitle}</td>
      <td>${event.calEventDescription}</td>
      <td>${event.userId}</td>
      <td>${event.departmentId}</td>
      <td>${event.calendarId}</td>
      <td>${event.teamCalendarId}</td>
      <td>${event.colorIndexId}</td>
      <td>${event.noticeId}</td>
    </tr>
  </c:forEach>
</table>
</body>
</html>
