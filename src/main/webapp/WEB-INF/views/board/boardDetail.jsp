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

      .replyModify {
        background: white;
        cursor: pointer;
      }

      .replyDelete {
        background: white;
        cursor: pointer;
      }

      .button-group {
        display: flex;
        justify-content: flex-end;
        gap: 5px;
        margin-top: 10px;
      }

      /* 좋아요/싫어요 버튼 스타일 */
      .like-dislike-buttons {
        margin-top: 20px;
        display: flex;
        gap: 10px;
      }

      .like-button,
      .dislike-button {
        padding: 10px 20px;
        font-size: 14px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s, color 0.3s;
      }

      .like-button {
        background-color: #4caf50;
        color: white;
      }

      .like-button:hover {
        background-color: #45a049;
      }

      .dislike-button {
        background-color: #f44336;
        color: white;
      }

      .dislike-button:hover {
        background-color: #da190b;
      }

      .subReply {
        background: white;
        cursor: pointer;
      }

      /* subRepliesContainer 스타일 추가 */
      #subRepliesContainer {
        margin-top: 20px;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f9f9f9;
      }

      .sub-reply {
        margin-bottom: 15px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #fff;
      }

      .sub-reply .meta {
        font-size: 0.9em;
        color: #777;
        margin-bottom: 5px;
      }

      .sub-reply .content {
        margin-bottom: 10px;
      }

      .sub-reply .button-group {
        display: flex;
      }

      .sub-reply .button-group button {
        padding: 5px 10px;
        border-radius: 3px;
        cursor: pointer;
      }

      .sub-reply .button-group .subReplyModify {
        background: white;
      }

      .sub-reply .button-group .subReplyDelete {
        background: white;
      }

      .reply-form {
        margin-top: 10px;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f1f1f1;
      }
      /* 페이지네이션 컨테이너 */
      .pagination {
        display: flex;
        justify-content: center;
        padding: 0;
        list-style: none;
      }

      /* 페이지네이션 아이템 */
      .pagination li {
        margin: 0 5px;
      }

      /* 페이지네이션 링크 */
      .pagination li a {
        color: #007bff;
        text-decoration: none;
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 4px;
        transition: background-color 0.3s, color 0.3s;
      }

      /* 호버 상태 */
      .pagination li a:hover {
        background-color: #e9ecef;
        color: #0056b3;
      }

      /* 활성 상태 */
      .pagination li a.active {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
      }

      /* 비활성 상태 (필요 시) */
      .pagination li a.disabled {
        color: #6c757d;
        pointer-events: none;
        cursor: default;
      }

      /* 큰 페이지네이션 */
      .pagination-lg li a {
        padding: 12px 18px;
        font-size: 1.25rem;
      }

      /* 커스텀 페이지네이션 스타일 */
      .pagination-custom li a {
        background-color: #f8f9fa;
        color: #007bff;
      }

      .pagination-custom li a:hover {
        background-color: #007bff;
        color: #fff;
      }
    </style>
  </head>
  <body>
    <div id="reply-container" data-bno="${board.boardId}">
      <h1>${board.boardTitle}</h1>
      <div class="meta">
        작성자: ${board.boardNickname} | 작성일:
        ${board.formattedBoardCreatedAt}
        <c:if
          test="${board.formattedBoardCreatedAt != board.formattedBoardUpdateAt}"
          >| 수정일: ${board.formattedBoardUpdateAt}
        </c:if>
        | 조회수: ${board.viewCount}
      </div>
      <div class="content">
        <p>${board.boardContent}</p>
      </div>
      <div class="actions">
        <a href="/board/pwcheck?bno=${board.boardId}&action=update">수정</a>
        <a href="/board/pwcheck?bno=${board.boardId}&action=delete">삭제</a>
        <a id="backLink" href="${sessionScope.referer}">목록으로 돌아가기</a>
      </div>

      <!-- 추천/비추천 버튼 영역 -->
      <div class="like-dislike-buttons">
        <button id="likeButton" class="like-button">
          좋아요 (<span id="likeCount">${board.likes}</span>)
        </button>
        <button id="dislikeButton" class="dislike-button">
          싫어요 (<span id="dislikeCount">${board.dislikes}</span>)
        </button>
      </div>

      <!-- 댓글 영역 -->

      <div id="replyContainer">
        <!-- 댓글 요청 -->
      </div>

      <ul class="pagination justify-content-center">
        <!--
            < JS로 댓글 페이징 DIV삽입 >
        -->
      </ul>

      <!-- 댓글 작성 영역 -->
      <div class="reply-form">
        <h2>댓글 작성</h2>
        <input type="hidden" id="boardId" value="${board.boardId}" />
        <input type="text" id="nickName" placeholder="닉네임" required />
        <input
          type="password"
          id="replyPassword"
          placeholder="댓글 비밀번호"
          required
        />
        <textarea id="replyContent" placeholder="댓글 내용" required></textarea>
        <button id="submitBtn" type="button">댓글 등록</button>
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
  <script type="module" src="/assets/js/board.js"></script>
</html>
