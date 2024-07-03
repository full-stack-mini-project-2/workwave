<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <%@ include file="../include/static-head.jsp" %> <%@ include
    file="../include/header.jsp" %>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <script
      defer
      type="text/javascript"
      src="assets/js/traffic/myTrafficInfo.js"
    ></script>

    <link rel="stylesheet" href="assets/css/traffic/myTrafficInfo.css" />
  </head>
  <body>
    <div class="form-container">
      <c:set var="isFirst" value="true" />
      <c:forEach var="traffic" items="${totalTraffic}">
        <c:if test="${isFirst}">
          <h1>
            ${traffic.userId} 님의 이용내역
            <a href="/traffic-rank">조회 리스트 Best</a>
          </h1>
          <div class="sort-container">
            <select class="form-select" name="sort" id="sort">
              <option value="departure">출발역</option>
              <option value="arrival">도착역</option>
              <option value="regDate">등록일</option>
            </select>
            <button type="submit" form="sortForm">정렬</button>
          </div>
          <form id="sortForm" action="/traffic-myInfo" method="get"></form>
          <c:set var="isFirst" value="false" />
        </c:if>
        <div class="regDate" data-reg-date="${traffic.regDateTime}">
          ${traffic.regDateTime}
        </div>
        <div class="traffic-info">
          <div class="departure-location">
            <span>${traffic.departure}</span>
            <i class="fas fa-subway"></i>
          </div>
          <i class="fas fa-long-arrow-alt-right"></i>
          <div class="arrival-location">
            <span>${traffic.arrival}</span>
            <i class="fas fa-subway"></i>
          </div>
        </div>
      </c:forEach>
    </div>

    <ul class="pagination">
      <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
        <li data-page-num="${i}">
          <a href="/traffic-myInfo?pageNo=${i}">${i}</a>
        </li>
      </c:forEach>
    </ul>

    <br />
    <a href="traffic-map"><h1>이전으로 돌아가기</h1></a>
  </body>
</html>
