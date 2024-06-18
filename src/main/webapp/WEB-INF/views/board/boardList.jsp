<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <style>
      /* Pagination container */
      .pagination {
        display: flex;
        justify-content: center;
        padding: 0;
        list-style: none;
      }
      
      /* Pagination items */
      .pagination li {
        margin: 0 5px;
      }
      
      /* Pagination links */
      .pagination li a {
        color: #007bff;
        text-decoration: none;
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 4px;
        transition: background-color 0.3s, color 0.3s;
      }
      
      /* Hover state */
      .pagination li a:hover {
        background-color: #e9ecef;
        color: #0056b3;
      }
      
      /* Active state */
      .pagination li a.active {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
      }
      
      /* Disabled state (if needed) */
      .pagination li a.disabled {
        color: #6c757d;
        pointer-events: none;
        cursor: default;
      }
      
      /* Custom large pagination */
      .pagination-lg li a {
        padding: 12px 18px;
        font-size: 1.25rem;
      }
      
      /* Custom pagination style */
      .pagination-custom li a {
        background-color: #f8f9fa;
        color: #007bff;
      }
      
      .pagination-custom li a:hover {
        background-color: #007bff;
        color: #fff;
      }
      </style>
      
    <title>게시판</title>
  </head>
  <body>
    <h1>게시물 목록</h1>
    <table>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
      </tr>

      <c:forEach var="board" items="${boards}">
        <tr>
          <td>${board.boardId}</td>
          <td>
            <a href="/board/detail?bno=${board.boardId}">${board.boardTitle}</a>
          </td>
          <td>${board.userId}</td>
          <td>${board.formattedBoardCreatedAt}</td>
        </tr>
      </c:forEach>

      <c:if test="${totalPages > 1}">
        <nav>
          <ul>
            <c:forEach begin="1" end="${totalPages}" var="i">
              <li>
                <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}"
                  >${i}</a
                >
              </li>
            </c:forEach>
          </ul>
        </nav>
      </c:if>
    </table>
     <!-- 게시글 목록 하단 영역 -->
     <div class="bottom-section">
      <!-- 페이지 버튼 영역 -->
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
                class="page-link"
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
    <!-- end div.bottom-section -->
  </div>
    <a href="/board/write">새 글 쓰기</a>
  </body>
</html>
