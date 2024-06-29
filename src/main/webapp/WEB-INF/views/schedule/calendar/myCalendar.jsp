<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Calendar</title>
<%--  css--%>
  <link rel="stylesheet" href="<c:url value='./assets/css/calendar.css' />">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
  <!-- JavaScript 파일 포함 -->
  <script type="module" src="<c:url value='./assets/js/myCalendar.js' />" defer></script>
</head>
<body>

<%-- 이벤트 상세 내용 --%>
<div id="eventModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <ul id="eventDetails">
      <!-- 여기에 이벤트 세부 정보가 추가될 것입니다 -->
    </ul>
  </div>
</div>

<%-- 일정 추가 모달 --%>
<div id="addEventModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>일정 추가</h2>
    <form id="addEventForm">
      <label for="calEventTitle">제목:</label>
      <input type="text" id="calEventTitle" name="calEventTitle" placeholder="Event"><br>

      <label for="calEventDate">날짜:</label>


      <input type="date" id="calEventDate" name="calEventDate" value="\${fn:substring(new java.text.SimpleDateFormat('yyyy-MM-dd').format(new java.util.Date()), 0, 10)}}"><br>

      <label for="calEventDescription">내용:</label>
      <input type="text" id="calEventDescription" name="calEventDescription" placeholder="None"><br>

      <label for="calColorIndex">색상:</label>
      <div class="color-picker">
        <div class="color-red" data-color-index="1"></div>
        <div class="color-green" data-color-index="2"></div>
        <div class="color-blue" data-color-index="3"></div>
        <div class="color-yellow" data-color-index="4"></div>
        <div class="color-magenta" data-color-index="5"></div>
      </div>
      <input type="hidden" id="calColorIndex" name="calColorIndex" value=""><br>

      <button type="button" id="saveEventButton">추가</button>
    </form>
  </div>
</div>

<%--달력 화면--%>
<div class="calendar-container">
  <div class="calendar-header">
    <i id="prev-month" class="fa-solid fa-caret-left"></i>
    <h3 id="current-month"></h3>
    <i id="next-month" class="fa-solid fa-caret-right"></i>
    <i class="fa-regular fa-calendar-plus"></i>
  </div>
  <div id="calendar"></div>
</div>

<%--실제 일정--%>
<div>Formatted Date: <span id="formattedDate"><c:out value="${formattedDate}" /></span></div>
</body>
</html>