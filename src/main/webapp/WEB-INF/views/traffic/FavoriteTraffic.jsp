<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Favorite Traffic</title>
    <script defer type="text/javascript" src="assets/js/traffic/myTrafficInfo.js"></script>
    <link rel="stylesheet" href="assets/css/traffic/FavoriteTraffic.css">
</head>
<body>

    <h2>즐겨찾는 목록</h2>

    <c:forEach var="traffic" items="${favoriteView}">
        <div class="traffic-info">
            <span>출발역: ${traffic.departure}</span>
            <span>도착역: ${traffic.arrival}</span>
            <span>조회수: ${traffic.viewCount}</span>
        </div>
    </c:forEach>

    <a href="traffic-myInfo">이전으로 돌아가기</a>
</body>
</html>