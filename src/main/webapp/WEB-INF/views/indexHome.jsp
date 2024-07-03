<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <title>Work-Wave</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/assets/css/indexHome.css">

    <style>
        /* 추가적인 스타일이 필요하다면 여기에 추가하세요 */
        .calendar-container {
            position: relative;
            width: 100%;
            height: 16.6%;
            overflow: hidden;
        }
        .calendar {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 1px solid #ccc;
            display: block; /* 초기에는 보이도록 설정 */
        }
        .calendar.minimized {
            display: none; /* 최소화 상태일 때는 숨김 */
        }
        .toggle-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            cursor: pointer;
        }
        .calendar-icon {
            position: fixed;
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
            cursor: pointer;
            z-index: 1000; /* 다른 요소 위에 표시될 수 있도록 높은 z-index 설정 */
            display: none; /* 초기에는 숨김 */
        }
    </style>

    <link rel="icon" href="/assets/img/workwave_logo.png" />
</head>
<body>

<div class="clock-container">
    <div class="clock" id="clock">00:00</div>
</div>

<div class="right-top">
    <a href="/myCalendar/viewTeamEvent" class="right-box">TEAM CALENDAR</a>
    <a href="/myCalendar/viewMyEvent" class="right-box">PERSONAL CALENDAR</a>
</div>

<div class="right-bottom">
    <a href="/viewTodo/personal" class="right-box">PERSONAL TODOLIST</a>
    <a href="/viewTodo/team" class="right-box">TEAM TODOLIST</a>
</div>

<div class="left-top">
    <a href="/traffic-map" class="right-box">TRAFFIC INFO</a>
</div>

<div class="left-bottom">
    <a href="/board/list" class="right-box">ANONYMOUS BOARD</a>
    <a href="/lunchMateBoard" class="right-box">LUNCH MENU</a>
</div>



<div class="login">
    <c:choose>
<%--        부서이름 어떻게 갖고오지?--%>
        <c:when test="${not empty dlist.departmentName}">
            <div class="user-info">TEAM_${login.departmentName}</div>
        </c:when>
        <c:when test="${not empty login.nickName}">
            <div class="user-info">${login.nickName}님 환영해요!</div>
            <button onclick="location.href='/member/logout'">LOGOUT</button>
        </c:when>
        <c:otherwise>
            <div class="user-info">로그인이 필요한 서비스입니다.</div>
            <button onclick="location.href='/login'">Login</button>
        </c:otherwise>
    </c:choose>
</div>

<!-- 달력 컨테이너 -->
<div class="calendar-container">
    <div class="calendar" id="personalCalendar">
        <iframe src="/myCalendar/viewMyEvent" style="width:100%; height:100%; border:none;"></iframe>
        <i class="fas fa-window-minimize toggle-btn" onclick="toggleCalendar('personalCalendar')"></i>
    </div>
    <div class="calendar" id="teamCalendar">
        <iframe src="/myCalendar/viewTeamEvent" style="width:100%; height:100%; border:none;"></iframe>
        <i class="fas fa-window-minimize toggle-btn" onclick="minimizeCalendar('teamCalendar')"></i>
    </div>
</div>

<!-- 최소화된 상태에서 복구할 달력 아이콘 -->
<i class="fas fa-calendar calendar-icon" onclick="restoreMinimizedCalendars()"></i>

<script>
    function updateClock() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        document.getElementById('clock').textContent = `\${hours}:\${minutes}`;
    }

    function toggleCalendar(calendarId) {
        // 모든 달력을 보이지 않는 상태로 설정
        const calendars = document.querySelectorAll('.calendar');
        calendars.forEach(calendar => {
            calendar.style.display = 'none';
        });

        // 선택한 달력만 보이도록 설정
        const selectedCalendar = document.getElementById(calendarId);
        selectedCalendar.style.display = 'block';

        // 최소화된 상태의 달력 아이콘 보이기
        const calendarIcon = document.querySelector('.calendar-icon');
        calendarIcon.style.display = 'block';
    }

    function minimizeCalendar(calendarId) {
        const calendar = document.getElementById(calendarId);
        calendar.classList.add('minimized');
    }

    function restoreMinimizedCalendars() {
        // 모든 최소화된 달력을 복구
        const minimizedCalendars = document.querySelectorAll('.calendar.minimized');
        minimizedCalendars.forEach(calendar => {
            calendar.classList.remove('minimized');
        });

        // 최소화된 상태의 달력 아이콘 숨기기
        const calendarIcon = document.querySelector('.calendar-icon');
        calendarIcon.style.display = 'none';
    }

    // 페이지 로드 후 실행되는 함수
    window.onload = function() {
        // 초기에 개인 캘린더를 보이도록 설정
        toggleCalendar('personalCalendar');

        // 시계 업데이트 함수를 1초마다 실행하여 시간을 표시
        setInterval(updateClock, 1000);
        updateClock(); // 페이지 로드 후 최초 시간 업데이트를 위해 호출
    };
</script>



</body>
</html>

