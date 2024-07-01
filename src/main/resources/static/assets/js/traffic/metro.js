// // 6d6861446c6e796f34344c78697966 지하철역주변
// // 6d6861446c6e796f34344c78697966 지하철

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
  // console.log("targetStation: ", targetStation);
  const endpoint = `http://swopenapi.seoul.go.kr/api/subway/${apiKey}/json/realtimeStationArrival/0/5/${targetStation}`;

  fetch(endpoint)
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => { 
      filterdData = data.realtimeArrivalList.map(e => ({
        barvlDt: e.barvlDt, // 열차도착예정시간(초)
        statnNm: e.statnNm, // 기차역이름
        updnLine: e.updnLine, // 상하행선구분
        arvlMsg2: e.arvlMsg2, // 첫번째도착메세지(도착, 출발, 진입 등)
        arvlMsg3: e.arvlMsg3 // 현재 지하철 위치
      }));
      // console.log(filterdData);

      // Update the DOM with the filtered data
      const $info = document.getElementById('infomationMetro');
      const total = filterdData.length;
      $info.innerHTML = `<h2>도착예정수: `+ total + `건</h2>` 

      filterdData.forEach(e => {
        const $infoDiv = document.createElement('div');
        const departureTime = parseInt(e.barvlDt / 60);
        // <span>출발역: ${e.statnNm}</span> 
        // <span>열차도착예정시간: ${departureTime}분전</span>
        // <span>현재 지하철 위치: ${e.arvlMsg3}</span>
        $infoDiv.innerHTML = `
          <span>상/하행선: ${e.updnLine}</span>
          <span>현재 위치: ${e.arvlMsg2}</span>  
        `;
        $info.appendChild($infoDiv);
      });
      return filterdData;
    })
    .catch(error => {
      console.error('Error fetching data:', error);
    });
});





