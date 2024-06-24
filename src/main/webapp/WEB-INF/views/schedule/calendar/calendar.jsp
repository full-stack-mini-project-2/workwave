<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
  <title>Calendar</title>
  <style>
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid black;
      text-align: center;
      padding: 10px;
    }
  </style>
</head>
<body>
<h1>${year}년 ${month}월의 일정</h1>
<table>
  <thead>
  <tr>
    <th>일</th>
    <th>월</th>
    <th>화</th>
    <th>수</th>
    <th>목</th>
    <th>금</th>
    <th>토</th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <c:forEach var="i" begin="1" end="${firstDayOfWeek - 1}">
    <td></td>
    </c:forEach>
    <c:forEach var="day" begin="1" end="${lastDay}">
    <c:if test="${(day + firstDayOfWeek - 2) % 7 == 0}">
  <tr>
    </c:if>
    <td>
        ${day}
      <c:forEach var="event" items="${myEvents}">
        <c:if test="${event.calEventDate.time >= pageContext.request.time && event.calEventDate.time < (pageContext.request.time + 86400000)}">
          <div>${event.calEventTitle}</div>
        </c:if>
      </c:forEach>
      <c:forEach var="event" items="${myTeamEvents}">
        <c:if test="${event.calEventDate.time >= pageContext.request.time && event.calEventDate.time < (pageContext.request.time + 86400000)}">
          <div>${event.calEventTitle}</div>
        </c:if>
      </c:forEach>
    </td>
    <c:if test="${(day + firstDayOfWeek - 1) % 7 == 0}">
  </tr>
  </c:if>
  </c:forEach>
  <c:forEach var="i" begin="${lastDay + firstDayOfWeek}" end="${(7 - (lastDay + firstDayOfWeek - 1) % 7) % 7 + lastDay + firstDayOfWeek - 1}">
    <td></td>
  </c:forEach>
  </tr>
  </tbody>
</table>
</body>
</html>