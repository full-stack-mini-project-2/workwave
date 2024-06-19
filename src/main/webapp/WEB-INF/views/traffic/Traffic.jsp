<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>길찾기 결과 지도에 표출하기</title>
</head>

<div id="map" style="width:50%;height:400px;"></div>
<form>
    <label>출발역</label>
    <select id="Departure-station" name="station1">
        <c:forEach var="station" items="${stationInfo}">
            <option data-latitude="${station.latitude}" data-longitude="${station.longitude}" value="${station.stationName}">${station.stationName}</option>
        </c:forEach>
    </select>

    <label>도착역</label>
    <select id="arrival-station" name="station2">
        <c:forEach var="station" items="${stationInfo}">
            <option data-latitude="${station.latitude}" data-longitude="${station.longitude}"value="${station.stationName}">${station.stationName}</option>
        </c:forEach>
    </select>
</form>




<!-- Naver Developers에서 발급받은 네이버지도 Application Key 입력  -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=nbpr5wd89w"></script>

<script type="text/javascript">


        const departureStaion = document.getElementById('Departure-station');
        departureStaion.addEventListener('change',e=>{
        const targetValue = e.target.value;
        const $option = departureStaion.querySelector(`option[value=\${targetValue}]`);

        console.log($option);
        sy=$option.dataset.longitude;
        sx=$option.dataset.latitude;

        console.log(sy);
        console.log(sx);
    });


    const arrivalStation = document.getElementById('arrival-station');
        arrivalStation.addEventListener('change',e=>{
        const targetValue = e.target.value;
        const $option = arrivalStation.querySelector(`option[value=\${targetValue}]`);

        console.log($option);
        ey=$option.dataset.longitude;
        ex=$option.dataset.latitude;

        console.log(ey);
        console.log(ex);
    });



    var mapOptions = {
        center: new naver.maps.LatLng(37.3595704, 127.105399),
        zoom: 10
    };

    var map = new naver.maps.Map('map', mapOptions);

    // 마커 추가 예제
    var markerOptions = {
        position: new naver.maps.LatLng(37.5665, 126.9780), // 마커의 위치 좌표 설정
        map: map // 마커가 표시될 지도 객체 설정
    };

    var marker = new naver.maps.Marker(markerOptions);

    var sx = 127.069231;
    var sy = 37.5404080;
    var ex = 127.094684;
    var ey = 37.5351610;

    function searchPubTransPathAJAX() {
        var xhr = new XMLHttpRequest();
        // ODsay apiKey 입력
        var url = "https://api.odsay.com/v1/api/searchPubTransPathT?SX="+sx+"&SY="+sy+"&EX="+ex+"&EY="+ey+"&apiKey=avqjby448YJDDqi4buwo5S69Uz5sf0nc3aEMdXWFzsQ";
        xhr.open("GET", url, true);
        xhr.send();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log( JSON.parse(xhr.responseText) ); // <- xhr.responseText 로 결과를 가져올 수 있음
                // 노선그래픽 데이터 호출
                callMapObjApiAJAX((JSON.parse(xhr.responseText))["result"]["path"][0].info.mapObj);
            }
        }
    }

    // 길찾기 API 호출
    searchPubTransPathAJAX();

    function callMapObjApiAJAX(mabObj){
        var xhr = new XMLHttpRequest();
        // ODsay apiKey 입력
        var url = "https://api.odsay.com/v1/api/loadLane?mapObject=0:0@"+mabObj+"&apiKey=avqjby448YJDDqi4buwo5S69Uz5sf0nc3aEMdXWFzsQ";
        xhr.open("GET", url, true);
        xhr.send();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var resultJsonData = JSON.parse(xhr.responseText);
                drawNaverMarker(sx, sy);  // 출발지 마커 표시
                drawNaverMarker(ex, ey);  // 도착지 마커 표시
                drawNaverPolyLine(resultJsonData);  // 노선그래픽데이터 지도위 표시
                // boundary 데이터가 있을경우, 해당 boundary로 지도이동
                if(resultJsonData.result.boundary){
                    var boundary = new naver.maps.LatLngBounds(
                        new naver.maps.LatLng(resultJsonData.result.boundary.top, resultJsonData.result.boundary.left),
                        new naver.maps.LatLng(resultJsonData.result.boundary.bottom, resultJsonData.result.boundary.right)
                    );
                    map.panToBounds(boundary);
                }
            }
        }
    }

    // 지도위 마커 표시해주는 함수
    function drawNaverMarker(x, y){
        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(y, x),
            map: map
        });
    }

    // 노선그래픽 데이터를 이용하여 지도위 폴리라인 그려주는 함수
    function drawNaverPolyLine(data){
        var lineArray;

        for(var i = 0 ; i < data.result.lane.length; i++){
            for(var j=0 ; j <data.result.lane[i].section.length; j++){
                lineArray = null;
                lineArray = new Array();
                for(var k=0 ; k < data.result.lane[i].section[j].graphPos.length; k++){
                    lineArray.push(new naver.maps.LatLng(data.result.lane[i].section[j].graphPos[k].y, data.result.lane[i].section[j].graphPos[k].x));
                }

                // 지하철결과의 경우 노선에 따른 라인색상 지정하는 부분 (1,2호선의 경우만 예로 들음)
                if(data.result.lane[i].type == 1){
                    var polyline = new naver.maps.Polyline({
                        map: map,
                        path: lineArray,
                        strokeWeight: 3,
                        strokeColor: '#003499'
                    });
                }else if(data.result.lane[i].type == 2){
                    var polyline = new naver.maps.Polyline({
                        map: map,
                        path: lineArray,
                        strokeWeight: 3,
                        strokeColor: '#37b42d'
                    });
                }else{
                    var polyline = new naver.maps.Polyline({
                        map: map,
                        path: lineArray,
                        strokeWeight: 3
                    });
                }
            }
        }
    }
</script>
</body>
</html>