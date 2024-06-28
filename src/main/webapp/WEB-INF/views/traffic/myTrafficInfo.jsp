<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <script defer type="text/javascript" src="assets/js/traffic/myTrafficInfo.js"></script>
  </head>
  <body>
    <select class="form-select" name="year" id="year">년도별</select>
    <select class="form-select" name="month" id="month">월별</select>
    <select>
      <option value="date">날짜별</option>
      <option value="staion">역</option>
      <option value="date">등록일</option>
    </select>
    <c:set var="isFirst" value="true" />
    <c:forEach var="traffic" items="${totalTraffic}">
        <c:if test="${isFirst}">
            <h1>${traffic.userId} 조회했던 정보</h1>
            <c:set var="isFirst" value="false" />
        </c:if>
        <div>
            <p>출발역: ${traffic.departure}</p>
            <p>도착역: ${traffic.arrival}</p>
            <p>등록 일시: ${traffic.regDateTime}</p>
        </div>
        <hr>
    </c:forEach>
    <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
      <li data-page-num="${i}">
        <a  href="/traffic-myInfo?pageNo=${i}">${i}</a> 
      </li>
    </c:forEach>

  </body>
</html>
