<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>workwave:로그인</title>
            <!-- reset -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
            <!-- 외부 스타일시트 링크 추가 -->
            <link rel="stylesheet" href="/assets/css/login.css" />
            <link rel="icon" href="/assets/img/workwave_logo.png" />
            <link href="https://fonts.google.com/specimen/Source+Sans+Pro" rel="stylesheet">
        </head>

        <body>
            <div class="login-container">
                <h1 class="cl-h1">로그인</h1>
                <form action="login" method="post" id="loginForm">
                    <div class="form-group">
                        <label for="username">아이디:</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">비밀번호:</label>
                        <input type="password" id="password" name="password" required>
                    </div>

                    <button type="submit" class="login-button">로그인</button>
                    <br /><br />
                    <a href="/join">
                        <button type="button" class="join-button">회원가입</button>
                    </a>
                </form>
                <div id="error-message" class="error-message"></div>
            </div>

        </body>

        </html>