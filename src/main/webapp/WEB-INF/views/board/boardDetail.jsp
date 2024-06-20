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
      .replies {
        margin-top: 40px;
      }
      .replies h2 {
        font-size: 20px;
        margin-bottom: 20px;
      }
      .reply {
        border-top: 1px solid #ddd;
        padding: 10px 0;
        margin-top: 10px;
      }
      .reply .meta {
        font-size: 12px;
        color: #555;
      }
      .reply .content {
        font-size: 14px;
        margin-top: 5px;
      }
      .reply-form {
        margin-top: 40px;
        padding: 20px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 4px;
      }
      .reply-form h2 {
        font-size: 18px;
        margin-bottom: 10px;
      }
      .reply-form input,
      .reply-form textarea {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 4px;
        margin-top: 10px;
        resize: vertical;
      }
      .reply-form button {
        margin-top: 10px;
        padding: 10px 20px;
        font-size: 14px;
        color: #fff;
        background-color: #007bff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
      }
      .reply-form button:hover {
        background-color: #0056b3;
      }
    </style>
  </head>
  <body>
    <div id="container" data-bno ="${board.boardId}">
      <h1>${board.boardTitle}</h1>
      <div class="meta">
        작성자: ${board.userId} | 작성일: ${board.formattedBoardCreatedAt}
        <c:if
          test="${board.formattedBoardCreatedAt != board.formattedBoardUpdateAt}"
          >| 수정일: ${board.formattedBoardUpdateAt}
        </c:if>
      </div>
      <div class="content">
        <p>${board.boardContent}</p>
      </div>
      <div class="actions">
        <a href="/board/update?bno=${board.boardId}">수정</a>
        <a href="/board/delete?bno=${board.boardId}">삭제</a>
        <a id="backLink" href="${sessionScope.referer}">목록으로 돌아가기</a>
      </div>

      <!-- 댓글 영역 -->
      <h2>댓글(${i})</h2>
      <div id="replyContainer">
        <!-- 댓글 요청 -->
      </div>

      <!-- 댓글 작성 영역 -->
      <div class="reply-form">
        <h2>댓글 작성</h2>
        <form action="/reply/add" method="post">
          <input type="hidden" name="boardId" value="${board.boardId}" />
          <input type="text" name="nickName" placeholder="닉네임" required />
          <input
            type="password"
            name="replyPassword"
            placeholder="댓글 비밀번호"
            required
          />
          <textarea
            name="replyContent"
            placeholder="댓글 내용"
            required
          ></textarea>
          <button type="submit">댓글 등록</button>
        </form>
      </div>

      <!-- 댓글 영역 end -->
    </div>
  </body>

  <!-- <script>
    document.addEventListener("DOMContentLoaded", function () {
      let referer = document.referrer;
      if (!referer) {
        referer = "/board/list";
      }
      document.getElementById("backLink").href = referer;
    });
  </script> -->
  <script type="module" src="/assets/js/reply.js"></script>
</html>
