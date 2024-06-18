<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>게시물 상세보기</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f4;
      }
      .container {
        max-width: 800px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }
      h1 {
        font-size: 24px;
        margin-bottom: 10px;
      }
      .meta {
        font-size: 14px;
        color: #777;
        margin-bottom: 20px;
      }
      .content {
        font-size: 16px;
        line-height: 1.6;
      }
      .actions {
        margin-top: 20px;
      }
      .actions a {
        margin-right: 10px;
        color: #007bff;
        text-decoration: none;
      }
      .actions a:hover {
        text-decoration: underline;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>${board.boardTitle}</h1>
      <div class="meta">
        작성자: ${board.userId} | 작성일: ${board.formattedBoardCreatedAt}
      </div>
      <div class="content">
        <p>${board.boardContent}</p>
      </div>
      <div class="actions">
        <a href="#">수정</a>
        <a href="/board/delete?bno=${board.boardId}">삭제</a>
        <a id="backLink" href="#">목록으로 돌아가기</a>
      </div>
    </div>
  </body>
  
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      let referer = document.referrer;
      if (!referer) {
        referer = "/board/list";
      }
      document.getElementById("backLink").href = referer;
    });
  </script>
</html>
