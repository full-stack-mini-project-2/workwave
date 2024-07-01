<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
  <title>길찾기 결과 지도에 표출하기</title>
  <link rel="stylesheet" href="assets/css/traffic/traffic.css">
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  
  <!-- fontawesome css: https://fontawesome.com -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">



  <script defer type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=nbpr5wd89w"></script>
  <script defer type="text/javascript" src="assets/js/traffic/traffic.js"></script>
  <script defer type="text/javascript" src="assets/js/traffic/weather.js"></script>
  <script defer type="text/javascript" src="assets/js/traffic/metro.js"></script>
</head>
<body>
  <form id="weather-from">
    <div id="weather"></div>
  </form>

  <div class="container">
    <div class="map-container" id="map"></div>
    <div class="form-container">
      <form action="/traffic-Info" method="POST">
        <h1 class="section-header">지하철</h1>
        <label for="departure-station">출발역</label>
        <select id="departure-station">
          <option disabled selected>출발역 선택</option>
          <c:forEach var="station" items="${stationInfo}">
            <option
              data-latitude="${station.latitude}"
              data-line="${station.line}"
              data-station="${station}"
              data-longitude="${station.longitude}"
              value="${station.stationName}"
            >
              ${station.stationName}
            </option>
          </c:forEach>
        </select>

        <label for="arrival-station">도착역</label>
        <select id="arrival-station">
          <option disabled selected>도착역 선택</option>
          <c:forEach var="station" items="${stationInfo}">
            <option
              data-latitude="${station.latitude}"
              data-line="${station.line}"
              data-longitude="${station.longitude}"
              value="${station.stationName}"
            >
              ${station.stationName}
            </option>
          </c:forEach>
        </select>

        <div>
          <label>총 역수: <span id="total-stations"></span>역</label>
        </div>
        <span>
          <label>총 소요시간: <span id="total-MetroTime"></span>분</label>
        </span>

        <h1 class="section-header">도착 예정 정보</h1>
        <div id="infomationMetro"></div>
        <a href="http://localhost:8383/traffic-myInfo"><h1>이전 조회 내역</h1></a>
      </form>
    </div>
  </div>


  <br>
  <a id="back-home" href="/"><h1>이전으로 돌아가기</h1></a>
</body>
</html>