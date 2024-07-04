

let dataLine = 0;
let dataStation = "";
let targetStation = "";
let filterdData = [];

const $departureStation = document.getElementById("departure-station");
$departureStation.addEventListener("change", (e) => {
  targetStation = e.target.value;
  const selectedOption = e.target.selectedOptions[0];

  dataStation = targetStation;
  dataLine = selectedOption.dataset.line;

  // API 키와 엔드포인트 설정
  const apiKey = "72554875536e796f313230734550786b";
  const endpoint = `http://swopenapi.seoul.go.kr/api/subway/${apiKey}/json/realtimeStationArrival/0/5/${targetStation}`;

  fetch(endpoint)
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then((data) => {
      filterdData = data.realtimeArrivalList.map((e) => ({
        barvlDt: e.barvlDt, // 열차도착예정시간(초)
        statnNm: e.statnNm, // 기차역이름
        updnLine: e.updnLine, // 상하행선구분
        arvlMsg2: e.arvlMsg2, // 첫번째도착메세지(도착, 출발, 진입 등)
        arvlMsg3: e.arvlMsg3, // 현재 지하철 위치
      }));

      // Update the DOM with the filtered data
      const $info = document.getElementById("arrival-info");
      const total = filterdData.length;
      $info.innerHTML = `<h2>도착예정수: ` + total + `건</h2>`;

      const trafficMap = [];

      const arrivalInfo = document.getElementById("informationMetro");
      const childElements = arrivalInfo.querySelectorAll(".station-name span");
      childElements.forEach((element) => {
        trafficMap.push(element.textContent);
      });

      let matchCount = 0;
    

      for (let i = 0; i < filterdData.length; i++) {
        const stationName = filterdData[i].arvlMsg3;

        for (let j = 0; j < trafficMap.length; j++) {
          if (
            stationName === trafficMap[j] ||
            trafficMap[j].includes(stationName)
          ) {
            matchCount++;

            const stationIcon = document.createElement("i");
            stationIcon.className = "fas fa-subway";
            stationIcon.style.position = "absolute";
            stationIcon.style.fontSize = "20px";
            stationIcon.style.color = "black";

            const stationSpans = document.querySelectorAll(".station-name span");
            const positionLeft = stationSpans[j].offsetLeft + stationSpans[j].offsetWidth / 2 - 5; 

            stationIcon.style.left = `${positionLeft}px`;
            stationIcon.style.top = "-20px"; // 아이콘을 역 이름 위에 배치

            stationSpans[j].parentNode.appendChild(stationIcon);

            break;
          }
        }
      }

      filterdData.forEach((e) => {
        const $infoDiv = document.createElement("div");
        const departureTime = parseInt(e.barvlDt / 60);
        $infoDiv.innerHTML = `
            <span>상/하행선: ${e.updnLine}</span>
            <span>현재 위치: ${e.arvlMsg2}</span>  
          `;
        $info.appendChild($infoDiv);
      });
      return filterdData;
    })
    .catch((error) => {
      console.error("Error fetching data:", error);
    });
});