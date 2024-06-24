// // 6d6861446c6e796f34344c78697966 지하철역주변
// // 6d6861446c6e796f34344c78697966 지하철

let dataLine = 0;
let dataStation = '';

const $departureStation = document.getElementById('departure-station');
$departureStation.addEventListener('change', e => {
  const targetStation = e.target.value;
  const selectedOption = e.target.selectedOptions[0]; 
 
  dataStation = targetStation;
  dataLine = selectedOption.dataset.line;

  // API 키와 엔드포인트 설정
  const apiKey = "72554875536e796f313230734550786b"; 
  const lineNumber = `${dataLine}호선`; 
  const endpoint = `http://swopenapi.seoul.go.kr/api/subway/${apiKey}/json/realtimePosition/1/100/${lineNumber}`;

  fetch(endpoint)
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      const filteredData = data.realtimePositionList.filter(train => train.statnNm === dataStation);

      filteredData.forEach(train => {
        console.log(train);
      });
    })
    .catch(error => {
      console.error(`Fetch error: ${error.message}`);
    });
});