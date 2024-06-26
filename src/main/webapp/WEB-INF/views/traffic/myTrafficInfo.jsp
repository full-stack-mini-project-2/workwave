<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <h1>내가 조회했던 정보</h1>
    <c:forEach var="traffic" items="${totalTraffic}">
        <div>
            <p>출발역: ${traffic.departure}</p>
            <p>도착역: ${traffic.arrival}</p>
            <p>등록 일시: ${traffic.regDateTime}</p>
        </div>
        <hr>
    </c:forEach>
    <c:forEach var="i" begin="1" end="${maker.end}">
      <li data-page-num="${i}" class="page-item">
        <a class="page-link" href="/traffic-myInfo?pageNo=${i}">${i}</a> 
      </li>
    </c:forEach>

  </body>
</html>
