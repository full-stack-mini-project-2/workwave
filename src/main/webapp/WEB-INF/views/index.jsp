<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>



        <!DOCTYPE html>
        <html>

        <head>
            <title>Work-Wave</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
            <style>
                body {
                    font-family: "Noto Sans KR", sans-serif;
                    margin: 0;
                    padding: 0;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    height: 100vh;
                    background-color: #f5f5f5;
                }

                .clock {
                    font-size: 4rem;
                    font-weight: bold;
                    color: #333;
                    margin-left: 80px;
                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
                }

                .right-boxes {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    grid-gap: 20px;
                    margin-right: 80px;
                }

                .right-box {
                    width: 120px;
                    height: 120px;
                    background-color: #fff;
                    border-radius: 10px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-size: 1.4rem;
                    font-weight: bold;
                    color: #333;
                    transition: transform 0.3s ease;
                }

                .right-box:hover {
                    transform: translateY(-5px);
                }

                .login-box {
                    background-color: #fff;
                    border-radius: 10px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    padding: 30px;
                    text-align: center;
                    margin-left: 80px;
                    margin-right: 100px;
                    width: 300px;
                }

                .login-box h2 {
                    margin-top: 0;
                    font-size: 1.8rem;
                    color: #333;
                }

                .login-box input,
                .login-box button {
                    display: block;
                    width: 85%;
                    margin-bottom: 15px;
                    padding: 10px 15px;
                    font-size: 1rem;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    outline: none;
                    margin-right: 80px;
                }

                .login-box button {
                    background-color: #4caf50;
                    color: #fff;
                    border: none;
                    cursor: pointer;
                    transition: background-color 0.3s ease;
                    width: 96%;
                }

                .login-box button:hover {
                    background-color: #45a049;
                }
            </style>
            <link rel="icon" href="/assets/img/workwave_logo.png" />

        </head>


        <body>
            <div class="clock">00:00:00</div>

            <div class="right-boxes">
                <a href="/board/list">
                    <div class="right-box">우빈1</div>
                </a>
                <a href="#">
                    <div class="right-box">우빈2</div>
                </a>
                <a href="#">
                    <div class="right-box">윤종1</div>
                </a>
                <a href="#">
                    <div class="right-box">윤종2</div>
                </a>
                <a href="#">
                    <div class="right-box">윤종3</div>
                </a>
                <a href="#">
                    <div class="right-box">윤종4</div>
                </a>
                <a href="/login">
                    <div class="right-box">경곤1</div>
                </a>
                <a href="#">
                    <div class="right-box">준원1</div>
                </a>
                <a href="/lunchMateBoard">
                    <div class="right-box">승연1</div>
                </a>
                <a href="#">
                    <div class="right-box">승연2</div>
                </a>
                <a href="#">
                    <div class="right-box">Box 11</div>
                </a>
                <a href="#">
                    <div class="right-box">Box 12</div>
                </a>
                <a href="#">
                    <div class="right-box">Box 13</div>
                </a>
                <a href="#">
                    <div class="right-box">Box 14</div>
                </a>
                <a href="#">
                    <div class="right-box">Box 15</div>
                </a>
            </div>

            <div class="login-box">
                <h2>Login</h2>
                <input type="text" placeholder="Username" />
                <input type="password" placeholder="Password" />
                <button>Login</button>
            </div>
        </body>

        </html>



