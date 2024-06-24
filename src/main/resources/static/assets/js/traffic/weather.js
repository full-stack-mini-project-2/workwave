

function getWeather() {
    const apiKey = "a54f739fb74fe16024127bca11322fe5";
    const city = "Seoul";
    const urlString = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}`;

    fetch(urlString)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const weatherInfo = `
                <strong>도시:</strong> ${data.name}<br>
                <strong>기온:</strong> ${(data.main.temp - 273.15).toFixed(2)}°C<br>
                <strong>현재날씨:</strong> ${data.weather[0].main}<br>
                <strong>현재습도:</strong> ${data.main.humidity}%<br>
                <strong>풍속:</strong> ${data.wind.speed} m/s
            `;
            document.getElementById("weather").innerHTML = weatherInfo;
        })
        .catch(error => {
            document.getElementById("weather").innerHTML = `Error: ${error}`;
        });
}


// 날씨API 실행
getWeather();