<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>게시판</title>
    <style>
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
      .table {
      }
    </style>
  </head>
  <body>
    <h1>게시물 목록</h1>
    <table>
      <tr class="table">
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
        <th>추천</th>
        <th>비추천</th>
      </tr>

      <!-- 검색 폼 시작 -->
      <form method="get" action="/board/list">
        <label for="searchType">검색 : </label>
        <select id="searchType" name="type">
          <option value="tc">제목+내용</option>
        </select>
        <input type="text" name="keyword" placeholder="검색어 입력" />
        <button type="submit">검색</button>
      </form>
      <!-- 검색 폼 끝 -->

      <c:forEach var="board" items="${boards}">
        <tr>
          <td>${board.boardId}</td>
          <td>
            <a href="/board/detail?bno=${board.boardId}"
              >${board.boardTitle}
              <c:if test="${board.replyCount != null && board.replyCount ne 0}">
                <span>(${board.replyCount})</span>
              </c:if>
            </a>
          </td>
          <td>${board.userId}</td>
          <td>${board.formattedBoardCreatedAt}</td>
          <td style="text-align: center">${board.viewCount}</td>
          <td style="text-align: center">${board.likes}</td>
          <td style="text-align: center">${board.dislikes}</td>
        </tr>
      </c:forEach>
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
