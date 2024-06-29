// JSON 형식의 문자열을 자바스크립트 객체로 반환
const myCalEvents = JSON.parse('<c:out value="${mycalEvents}" escapeXml="false" />'); // 전역변수로 놓고 렌더링
console.log("mycalevents",myCalEvents);


// 일정 추가 모달 열기
document.querySelector('.fa-calendar-plus').addEventListener('click', function () {
    const addEventModal = document.getElementById('addEventModal');
    addEventModal.style.display = 'block';

    // 모달 외부를 클릭하면 닫기
    window.onclick = function (event) {
        if (event.target == addEventModal) {
            addEventModal.style.display = 'none';
        }
    };

    // 닫기 버튼 클릭 시 모달 닫기
    const closeBtn = addEventModal.querySelector('.close');
    closeBtn.onclick = function () {
        addEventModal.style.display = 'none';
    };
});

// 색상 선택
document.querySelectorAll('.color-picker div').forEach(function (colorDiv) {
    colorDiv.addEventListener('click', function () {
        document.getElementById('calColorIndex').value = this.getAttribute('data-color-index');
    });
});





// 이벤트 상세보기
function openModal(eventIndex) {
    console.log('openModal called with eventIndex:', eventIndex);

    const selectedEvent = myCalEvents[eventIndex];
    console.log('Selected Event:', selectedEvent);

    const modal = document.getElementById('eventModal');
    const modalContent = modal.querySelector('.modal-content');
    const eventDetails = modal.querySelector('#eventDetails');

    // if(selectedEvent) {
    // 이벤트 세부 정보 구성
    eventDetails.innerHTML = `
    <li><strong>제목:</strong> \${selectedEvent.calEventTitle}</li>
    <li><strong>이벤트 내용:</strong> \${selectedEvent.calEventDescription}</li>
    <li><strong>이벤트 날짜:</strong> \${selectedEvent.calEventDate}</li>

    <li><strong>작성자:</strong> \${selectedEvent.userName}</li>
  `;
    // <li><strong>색상:</strong> \${getColorByIndex(selectedEvent.colorIndexId)}</li>
    // } else {
    //   eventDetails.innerHTML = '<li>이벤트 정보를 가져올 수 없습니다.</li>';
    // }

    // 모달 보이기
    modal.style.display = 'block';

    // 모달 외부를 클릭하면 닫기
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    };

    // 닫기 버튼 클릭 시 모달 닫기
    const closeBtn = modal.querySelector('.close');
    closeBtn.onclick = function () {
        modal.style.display = 'none';
    };
}

document.addEventListener('DOMContentLoaded', function () {


    // 첫 번째 이벤트에서 userId 속성을 가져옴
    const userId = myCalEvents.length > 0 ? myCalEvents[0].userId : "";

    const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    let currentYear = new Date().getFullYear();
    let currentMonth = new Date().getMonth();

    // 초기 데이터 로드
    fetchEvents(currentYear, currentMonth);

    function updateCurrentMonth(year, month) {
        document.getElementById('current-month').textContent = `\${monthNames[month]} \${year}`;
    }

    function fetchEvents(year, month) {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', `/api/calendar/myEvents/\${userId}?year=\${year}&month=\${month + 1}`, true);

        console.log(`/api/calendar/myEvents/\${userId}?year=\${year}&month=\${month + 1}`);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    const data = JSON.parse(xhr.responseText);
                    renderCalendar(data, year, month);
                } else {
                    console.error('Failed to fetch calendar events:', xhr.status, xhr.statusText);
                }
            }
        };

        xhr.onerror = function () {
            console.error('Failed to fetch calendar events: Network Error');
        };

        xhr.send();
    }

    function renderCalendar(events, year, month) {
        const firstDay = new Date(year, month, 1).getDay();
        const lastDate = new Date(year, month + 1, 0).getDate();

        let calendarHtml = '<table class="calendar">';
        calendarHtml += '<tr>';
        calendarHtml += '<th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th>';
        calendarHtml += '</tr><tr>';

        for (let i = 0; i < firstDay; i++) {
            calendarHtml += '<td></td>';
        }

        for (let date = 1; date <= lastDate; date++) {
            const day = (firstDay + date - 1) % 7;
            if (day === 0 && date > 1) {
                calendarHtml += '</tr><tr>';
            }

            const yearStr = year.toString();
            const monthStr = (month + 1 < 10 ? '0' + (month + 1) : month + 1).toString();
            const dateStr = (date < 10 ? '0' + date : date).toString();

            const fullDateStr = `\${yearStr}-\${monthStr}-\${dateStr}`;

            calendarHtml += `<td><div>\${date}</div>`;

            // 해당 날짜에 해당하는 이벤트 필터링
            const filteredEvents = events.filter(event => event.calEventDate.startsWith(fullDateStr));

            if (filteredEvents.length > 0) {
                filteredEvents.forEach(event => {
                    const colorClass = `event-\${getColorByIndex(event.colorIndexId)}`;
                    calendarHtml += `<div class="event \${colorClass}" onclick="openModal(\${events.indexOf(event)})">\${event.calEventTitle}</div>`;
                });
            }

            calendarHtml += '</td>';
        }

        calendarHtml += '</tr></table>';

        document.getElementById('calendar').innerHTML = calendarHtml;
        updateCurrentMonth(year, month);
    }

    // getColorByIndex 함수는 그대로 사용합니다.
    function getColorByIndex(index) {
        switch (index) {
            case 1:
                return 'lightblue';
            case 2:
                return 'lightgreen';
            case 3:
                return 'lightcoral';
            case 4:
                return 'lightsalmon';
            case 5:
                return 'lightseagreen';
            default:
                return 'lightgray';
        }
    }

    // 이전 달/다음 달 이동 버튼 처리
    document.getElementById('prev-month').addEventListener('click', function () {
        if (currentMonth === 0) {
            currentYear--;
            currentMonth = 11;
        } else {
            currentMonth--;
        }
        fetchEvents(currentYear, currentMonth);
    });

    document.getElementById('next-month').addEventListener('click', function () {
        if (currentMonth === 11) {
            currentYear++;
            currentMonth = 0;
        } else {
            currentMonth++;
        }
        fetchEvents(currentYear, currentMonth);
    });

    // 일정 저장
    document.getElementById('saveEventButton').addEventListener('click', function () {
        const title = document.getElementById('calEventTitle').value || 'Event';
        const date = document.getElementById('calEventDate').value || new Date().toISOString().split('T')[0];
        const description = document.getElementById('calEventDescription').value || 'None';
        const colorIndex = document.getElementById('calColorIndex').value || null;

        const newEvent = {
            calEventId: myCalEvents.length + 1,
            calEventDate: date,
            calEventTitle: title,
            calEventDescription: description,
            calEventCreateAt: new Date().toISOString(),
            colorIndexId: colorIndex,
            username: 'User'
        };

        myCalEvents.push(newEvent);
        renderCalendar(myCalEvents, new Date(date).getFullYear(), new Date(date).getMonth());

        document.getElementById('addEventModal').style.display = 'none';
    });

});