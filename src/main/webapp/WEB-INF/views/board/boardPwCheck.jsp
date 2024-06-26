<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>비밀번호 확인</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
      }

      .container {
        max-width: 400px;
        margin: 50px auto;
        background-color: #fff;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
      }

      h2 {
        font-size: 24px;
        margin-bottom: 20px;
        text-align: center;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-group label {
        display: block;
        font-size: 14px;
        margin-bottom: 5px;
      }

      .form-group input {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 4px;
      }

      .form-group button {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        color: #fff;
        background-color: #007bff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
      }

      .form-group button:hover {
        background-color: #0056b3;
      }

      .form-group .cancel-button {
        background-color: #f44336;
      }

      .form-group .cancel-button:hover {
        background-color: #da190b;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>비밀번호 확인</h2>

      <% String bno = request.getParameter("bno"); String action =
      request.getParameter("action"); %>

      <form action="pwcheck?bno=<%= bno %>&action=<%= action %>" method="post">
        <div class="form-group">
          <label for="boardPassword">비밀번호</label>
          <input
            type="password"
            id="boardPassword"
            name="boardPassword"
            placeholder="비밀번호를 입력하세요"
            required
          />
        </div>
        <div class="form-group">
          <button type="submit">확인</button>
          <button
          type="button"
          class="cancel-button"
          onclick="window.location.href='http://localhost:8383/board/detail?bno=<%= bno %>'"
      >
          취소
      </button>
        </div>
      </form>
    </div>

    <script type="text/javascript">
      window.onload = function () {
        let errorMessage = "${error}";
        if (errorMessage) {
          alert(errorMessage);
        }
      };
    </script>
  </body>
</html>
