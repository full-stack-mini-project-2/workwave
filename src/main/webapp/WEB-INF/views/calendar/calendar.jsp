<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
  <title>Calendar Page</title>>
    <style>
      body {
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #f5f5f5;
      }

      .calendar-container {
        width: 80%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }

      h1 {
        text-align: center;
        color: #333;
      }

      .calendar {
        display: grid;
        grid-template-columns: repeat(7, 1fr);
        border-collapse: collapse;
        margin-top: 20px;
      }

      .calendar-header {
        background-color: #f0f0f0;
        text-align: center;
        padding: 10px;
        font-weight: bold;
        border-bottom: 1px solid #ccc;
      }

      .calendar-cell {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: center;
      }

      .calendar-cell.today {
        background-color: #e0f7fa;
      }

      .calendar-cell:hover {
        background-color: #f5f5f5;
      }
    </style>
  </head>
<body>
<div class="calendar-container">
  <h1>Calendar</h1>
  <div class="calendar">
    <c:forEach var="event" items="${calendarData}">
      <div class="calendar-header">${event.date}</div>
      <div class="calendar-cell">${event.event}</div>
    </c:forEach>
  </div>
</div>
</body>
</html>