<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"
    />
    <title>길찾기 결과 지도에 표출하기</title>
    <script src="../../../../resources/static/assets/js/traffic/findTraffic.js"></script>
  </head>
  <body>
    <div id="map" style="width: 50%; height: 400px"></div>
    <form>
      <label>출발역</label>
      <select id="Departure-station" name="station1">
        <c:forEach var="station" items="${stationInfo}">
          <option
            data-latitude="${station.latitude}"
            data-longitude="${station.longitude}"
            value="${station.stationName}"
          >
            ${station.stationName}
          </option>
        </c:forEach>
      </select>

      <label>도착역</label>
      <select id="arrival-station" name="station2">
        <c:forEach var="station" items="${stationInfo}">
          <option
            data-latitude="${station.latitude}"
            data-longitude="${station.longitude}"
            value="${station.stationName}"
          >
            ${station.stationName}
          </option>
        </c:forEach>
      </select>
    </form>

    <!-- Naver Developers에서 발급받은 네이버지도 Application Key 입력 -->
    <script 
      type="text/javascript"
      src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=nbpr5wd89w"
    ></script>
   
    <script type="text/javascript">
      let mapOptions = {
        center: new naver.maps.LatLng(37.3595704, 127.105399),
        zoom: 10,
      };

      let map = new naver.maps.Map("map", mapOptions);

      function departureMakers() {
        const departureStation = document.getElementById("Departure-station");

        // 마커를 저장할 배열
        let departureMarkers = [];

        departureStation.addEventListener("change", (e) => {
          const targetValue = e.target.value;
          const option = departureStation.querySelector(
            `option[value="\${targetValue}"]`
          );

          // 기존 마커 삭제
          departureMarkers.forEach((marker) => marker.setMap(null));
          departureMarkers = [];

          // 새 마커 생성
          let newMarker = new naver.maps.Marker({
            position: new naver.maps.LatLng(
              option.dataset.latitude,
              option.dataset.longitude
            ),
            map: map,
          });

          // 배열에 새 마커 추가
          departureMarkers.push(newMarker);
        });
      }

      
      function arrivalMarkers() {
        const arrivalStation = document.getElementById("arrival-station");
        // 마커를 저장할 빈배열
        let arrivalMarkers = [];
        arrivalStation.addEventListener("change", (e) => {
          const targetValue = e.target.value;
          const option = arrivalStation.querySelector(
            `option[value="\${targetValue}"]`
          );

          // 마커 색 설정 , 기존 마커 삭제 
          
          arrivalMarkers.forEach((marker) => marker.setMap(null));
          arrivalMarkers = [];

          // 새 마커 생성
          let newMarker = new naver.maps.Marker({
            position: new naver.maps.LatLng(
              option.dataset.latitude,
              option.dataset.longitude
            ),
            map: map,
          });
          
          arrivalMarkers.push(newMarker);
        });
      }

      departureMakers(); // 출발 마커 함수 
      arrivalMarkers(); // 도착 마커 함수 
      // findLoadMap(); // 길찾기 함수
      hello();
    </script>
    
  </body>
</html>
