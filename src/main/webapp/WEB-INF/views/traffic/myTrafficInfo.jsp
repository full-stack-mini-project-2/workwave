<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <script defer type="text/javascript" src="assets/js/traffic/myTrafficInfo.js"></script>

    <link rel="stylesheet" href="assets/css/traffic/myTrafficInfo.css">

  </head>
  <body>
    <div class="form-container">
      <form id="sortForm" action="/traffic-myInfo" method="get">
        <select class="form-select" name="sort" id="sort">
          <option value="departure">출발역</option>
          <option value="arrival">도착역</option>
          <option value="regDate">등록일</option>
        </select>
        <button type="submit">정렬</button>
      </form>
    </div>

    <c:set var="isFirst" value="true" />
    <c:forEach var="traffic" items="${totalTraffic}">
      <c:if test="${isFirst}">
        <h1>${traffic.userId} 조회했던 정보 <a href="/traffic-rank">조회 리스트 Best</a></h1>
        <c:set var="isFirst" value="false" />
      </c:if>
      <div class="traffic-info">
        <div class="regDate" data-reg-date="${traffic.regDateTime}">등록 일시: ${traffic.regDateTime}</div>
        <span>출발역: ${traffic.departure}</span>
        <span>도착역: ${traffic.arrival}</span>
      </div>
    </c:forEach>

    <ul class="pagination">
      <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
        <li data-page-num="${i}">
          <a href="/traffic-myInfo?pageNo=${i}">${i}</a>
        </li>
      </c:forEach>
    </ul>

    <br>
    <a href="traffic-map"><h1>이전으로 돌아가기</h1></a>
  </body>
</html>