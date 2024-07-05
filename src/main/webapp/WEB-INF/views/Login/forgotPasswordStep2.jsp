<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>WORKWAVE: 비밀번호 찾기2</title>
        <style>
            body {
                font-family: 'NEXON Lv1 Gothic OTF', 'Roboto', sans-serif;
                background-color: #181A33;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .container {
                background-color: #3E489F;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
                width: 300px;
            }

            h2 {
                color: #FFFFFF;
                text-align: center;
                margin-bottom: 20px;
                font-size: 24px;
            }

            .input-group {
                position: relative;
                margin-bottom: 15px;
            }

            .input-group i {
                position: absolute;
                left: 10px;
                top: 50%;
                transform: translateY(-50%);
                color: #FFFFFF;
            }

            input[type="text"],
            input[type="email"] {
                width: 255px;
                padding: 10px 10px 10px 35px;
                border: none;
                border-radius: 5px;
                background-color: rgba(255, 255, 255, 0.2);
                color: #FFFFFF;
                font-size: 14px;
            }

            input[type="text"]::placeholder,
            input[type="email"]::placeholder {
                color: rgba(255, 255, 255, 0.7);
            }

            input[type="submit"] {
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 5px;
                background-color: #7B317C;
                color: #FFFFFF;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover {
                background-color: #973554;
            }

            .back-link {
                text-align: center;
                margin-top: 15px;
            }

            .back-link a {
                color: #FFFFFF;
                text-decoration: none;
                font-size: 14px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h2>${resultUser}</h2>
            <form action="verifyUser.jsp" method="post">
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" name="userName" placeholder="이름" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" name="employeeId" placeholder="사번" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" placeholder="이메일" required>
                </div>
                <input type="submit" value="확인">
            </form>
            <div class="back-link">
                <a href="login.jsp">로그인으로 돌아가기</a>
            </div>
        </div>
    </body>

    </html>