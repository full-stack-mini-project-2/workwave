<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <%@ include file="../include/static-head.jsp" %>
    <link rel="icon" href="/assets/img/workwave_logo.png" />
    <link rel="stylesheet" href="/assets/css/boardList.css" />

    <title>게시판</title>

  </head>
  <body>

    <%@ include file="../include/header.jsp" %>

    <!-- 검색 폼 끝 -->

    <h1 class="board-list">게시물 목록</h1>

    <!-- 검색 폼 시작 -->
    <form class="searchBar" method="get" action="/board/list">
      <label for="searchType">검색 : </label>
      <select id="searchType" name="type">
        <option value="tc">제목+내용</option>
        <option value="id">내가 쓴 글</option>
      </select>
      <input type="text" name="keyword" placeholder="검색어 입력" />
      <button type="submit">검색</button>
    </form>

    <div class="container">
      <a href="/login">로그인</a>

      <table>
        <tr class="board-menu">
          <!-- <th>번호</th> -->
          <th>제목</th>
          <th>작성자</th>
          <th>작성일</th>
          <th>조회수</th>
          <th>추천</th>
          <th>비추천</th>
        </tr>

        <div class="board-box">
          <c:forEach var="board" items="${boards}">
            <tr>
              <!-- <td>${board.boardId}</td> -->
              <td>
                <a href="/board/detail?bno=${board.boardId}"
                  >${board.boardTitle}
                  <c:if
                    test="${board.replyCount != null && board.replyCount ne 0}"
                  >
                    <span>(${board.replyCount})</span>
                  </c:if>
                </a>
              </td>
              <td class="nickname">${board.boardNickname}</td>
              <td>${board.formattedBoardCreatedAt}</td>
              <td style="text-align: center">${board.viewCount}</td>
              <td style="text-align: center">${board.likes}</td>
              <td style="text-align: center">${board.dislikes}</td>
            </tr>
          </c:forEach>
        </div>

      </table>

      <div class="bottom-section">
        <nav aria-label="Page navigation example">
          <ul class="pagination pagination-lg pagination-custom">
            <c:if test="${maker.pageInfo.pageNo != 1}">
              <li class="page-item">
                <a
                  class="page-link"
                  href="/board/list?pageNo=1&type=${s.type}&keyword=${s.keyword}"
                  >&lt;&lt;</a
                >
              </li>
            </c:if>

            <c:if test="${maker.prev}">
              <li class="page-item">
                <a
                  class="page-link"
                  href="/board/list?pageNo=${maker.begin - 1}&type=${s.type}&keyword=${s.keyword}"
                  >prev</a
                >
              </li>
            </c:if>

            <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
              <li data-page-num="${i}" class="page-item">
                <a
                  class="page-link ${i == currentPage ? 'active' : ''}"
                  href="/board/list?pageNo=${i}&type=${s.type}&keyword=${s.keyword}"
                  >${i}</a
                >
              </li>
            </c:forEach>

            <c:if test="${maker.next}">
              <li class="page-item">
                <a
                  class="page-link"
                  href="/board/list?pageNo=${maker.end + 1}&type=${s.type}&keyword=${s.keyword}"
                  >next</a
                >
              </li>
            </c:if>

            <c:if test="${maker.pageInfo.pageNo != maker.finalPage}">
              <li class="page-item">
                <a
                  class="page-link"
                  href="/board/list?pageNo=${maker.finalPage}&type=${s.type}&keyword=${s.keyword}"
                  >&gt;&gt;</a
                >
              </li>
            </c:if>
          </ul>
        </nav>
      </div>

      <a href="/board/write">새 글 쓰기</a>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        let params = new URLSearchParams(window.location.search);
        let currentPage = params.get("pageNo") || 1;
        let pageLinks = document.querySelectorAll(".pagination a");
        pageLinks.forEach(function (link) {
          if (parseInt(link.textContent) == currentPage) {
            link.classList.add("active");
          }
        });
      });
    </script>
  </body>
</html>
