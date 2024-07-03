<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <title>Work-Wave</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        body {
            font-family: "Noto Sans KR", sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 100vh;
            background-image: url('<c:url value="/assets/img/0.jpg" />');
            background-size: cover;
        }

        .clock-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 999; /* 화면에서 최상위로 표시 */
            text-align: center;
            margin-right: 80px; /* 시계 오른쪽 여백 */
        }

        .clock {
            font-size: 10rem;
            font-weight: bold;
            color: #F2EFEB;
            text-shadow: 2px 2px 4px rgba(255, 255, 255, 0.5);
        }

        .right-top {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
        }

        .right-bottom {
            position: absolute;
            bottom: 20px;
            left: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .right-box {
            width: 150px;
            height: 50px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.5rem;
            font-weight: bold;
            color: #fff;
            background-color: rgba(0, 0, 0, 0.7);
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        .right-box:hover {
            transform: translateY(-5px);
        }
        button {
            font: inherit;
            background-color: #f0f0f0;
            border: 0;
            color: #242424;
            border-radius: 0.5em;
            font-size: 1.35rem;
            padding: 0.375em 1em;
            font-weight: 600;
            text-shadow: 0 0.0625em 0 #fff;
            box-shadow: inset 0 0.0625em 0 0 #f4f4f4, 0 0.0625em 0 0 #efefef,
            0 0.125em 0 0 #ececec, 0 0.25em 0 0 #e0e0e0, 0 0.3125em 0 0 #dedede,
            0 0.375em 0 0 #dcdcdc, 0 0.425em 0 0 #cacaca, 0 0.425em 0.5em 0 #cecece;
            transition: 0.15s ease;
            cursor: pointer;
        }
        button:active {
            translate: 0 0.225em;
            box-shadow: inset 0 0.03em 0 0 #f4f4f4, 0 0.03em 0 0 #efefef,
            0 0.0625em 0 0 #ececec, 0 0.125em 0 0 #e0e0e0, 0 0.125em 0 0 #dedede,
            0 0.2em 0 0 #dcdcdc, 0 0.225em 0 0 #cacaca, 0 0.225em 0.375em 0 #cecece;
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

<div class="left-bottom">
    <a href="/viewTodo/personal" class="right-box">PERSONAL TODOLIST</a>
    <a href="/viewTodo/team" class="right-box">TEAM TODOLIST</a>
</div>

<div class="right-bottom">
    <a href="/traffic-map" class="right-box">TRAFFIC INFO</a>
    <a href="/board/list" class="right-box">ANONYMOUS BOARD</a>
    <a href="/lunchMateBoard" class="right-box">LUNCH MENU</a>
</div>

<div class="login">
    <button onclick="location.href='/login'">Login</button>
    <button onclick="location.href='/member/logout'" class="button-box">LOGOUT</button>
</div>
<script>
    function updateClock() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        document.getElementById('clock').textContent = `\${hours}:\${minutes}`;
    }

    setInterval(updateClock, 1000);
    updateClock(); // 페이지 로드 후 최초 시간 업데이트를 위해 호출
</script>

</body>
</html>