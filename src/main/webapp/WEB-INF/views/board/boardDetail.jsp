<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>게시물 상세보기</title>
    <style>

    </style>
    <link rel="stylesheet" href="/assets/css/main.css" />
    <link rel="icon" href="/assets/img/workwave_logo.png" />
    <link rel="stylesheet" href="/assets/css/boardDetail.css" />
  </head>
  <script type="module" src="/assets/js/reply.js"></script>
  <script type="module" src="/assets/js/board.js"></script>
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
          좋아요 (<span id="likeCount" data-id="${id}">${board.likes}</span>)
        </button>
        <button id="dislikeButton" class="dislike-button">
          싫어요 (<span id="dislikeCount" data-id="${id}"
            >${board.dislikes}</span
          >)
        </button>
      </div>

      <!-- 댓글 영역 -->

      <div id="replyContainer" data-id="${board.userId}">
        <!-- 댓글 요청 -->
      </div>

      <div class="pagination-container">
        <ul class="pagination">
          <!-- 페이지네이션 항목들 -->
        </ul>
      </div>

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
</html>
