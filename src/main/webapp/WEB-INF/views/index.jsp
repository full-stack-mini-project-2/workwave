<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <title>Index Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* 중앙 시계 */
        .clock {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 3rem;
            font-weight: bold;
            color: #333;
        }

        /* 오른쪽 div 박스 */
        .right-boxes {
            position: absolute;
            top: 50%;
            right: 20px;
            transform: translateY(-50%);
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-gap: 10px;
        }

        .right-box {
            width: 100px;
            height: 100px;
            background-color: #f1f1f1;
            border: 1px solid #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
        }

        /* 상단 로그인 박스 */
        .login-box {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #f1f1f1;
            border: 1px solid #ddd;
            padding: 20px;
            text-align: center;
        }

        .login-box h2 {
            margin-top: 0;
        }

        .login-box input,
        .login-box button {
            display: block;
            margin-bottom: 10px;
            padding: 5px 10px;
        }
    </style>
</head>

<body>
    <div class="clock">00:00:00</div>

    <div class="right-boxes">
        <div class="right-box">우빈1</div>
        <div class="right-box">우빈2</div>
        <div class="right-box">윤종1</div>
        <div class="right-box">윤종2</div>
        <div class="right-box">윤종3</div>
        <div class="right-box">윤종4</div>
        <div class="right-box">경곤1</div>
        <div class="right-box">준원1</div>
        <div class="right-box">승연1</div>
        <div class="right-box">승연2</div>
        <div class="right-box">Box 11</div>
        <div class="right-box">Box 12</div>
        <div class="right-box">Box 13</div>
        <div class="right-box">Box 14</div>
        <div class="right-box">Box 15</div>
    </div>

    <div class="login-box">
        <h2>Login</h2>
        <input type="text" placeholder="Username">
        <input type="password" placeholder="Password">
        <button>Login</button>
    </div>
</body>

</html>