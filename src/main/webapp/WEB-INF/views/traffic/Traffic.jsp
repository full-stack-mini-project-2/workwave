<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"
    />
    <title>길찾기 결과 지도에 표출하기</title>
    <script
      defer
      type="text/javascript"
      src="../../../../resources/static/assets/js/traffic/traffic.js"
    ></script>
    <script
      defer
      type="text/javascript"
      src="../../../../resources/static/assets/js/traffic/weather.js"
    ></script>
    <script
      defer
      type="text/javascript"
      src="../../../../resources/static/assets/js/traffic/metro.js"
    ></script>

    <script
      type="text/javascript"
      src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=nbpr5wd89w"
    ></script>
  </head>
  <body>
    <div id="map" style="width: 100%; height: 400px"></div>
    <form action="/traffic-Info" method="POST">
      <h1>지하철</h1>
      <label>출발역</label>
      <select id="departure-station">
        <option disabled selected>출발역</option>
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

      <label>도착역</label>
      <select id="arrival-station">
        <option disabled selected>도착역</option>
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

      <label>총 역수: <span id="total-stations"></span>역</label>
      <label>총 소요시간: <span id="total-MetroTime"></span>분</label>

      <h1>도착 예정 정보</h1>
      <div id="infomationMetro"></div>

    </form>

    <form>
      <h1>서울 현재 날씨 정보</h1>
      <div id="weather"></div>
    </form>
  </body>
</html>
