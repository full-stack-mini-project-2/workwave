<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Calendar</title>
<%--  css--%>
<%--  <link rel="stylesheet" href="<c:url value='/assets/css/calendar.css' />">--%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
  <!-- JavaScript 파일 포함 -->
<%--  <script type="module" src="<c:url value='/assets/js/myCalendar.js' />' defer></script>--%>
<style>
  .calendar {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
  }
  .calendar th, .calendar td {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: center;
  }
  .event {
  margin-top: 5px;
  padding: 3px;
  border-radius: 3px;
  cursor: pointer; /* 마우스 커서를 포인터로 변경하여 클릭 가능한 상태로 만듦 */
  }

  .event-lightblue { background-color: lightblue; }
  .event-lightgreen { background-color: lightgreen; }
  .event-lightcoral { background-color: lightcoral; }
  .event-lightsalmon {background-color: lightsalmon; }
  .event-lightseagreen { background-color: lightseagreen; }
  .event-lightgray { background-color: lightgray; }

  /* 모달 스타일 */
  .modal {
  display: none; /* 초기에는 모달 숨김 */
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.4);
  }

  .modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  }

  .close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  }

  .close:hover,
  .close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
  }

  .color-picker {
  display: flex;
  justify-content: space-around;
  margin-top: 10px;
  }

  .color-picker div {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  cursor: pointer;
  }

  .color-red { background-color: red; }
  .color-green { background-color: green; }
  .color-blue { background-color: blue; }
  .color-yellow { background-color: yellow; }
  .color-magenta { background-color: magenta; }
  .calendar th, .calendar td {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: center;
  width: 14.28%; /* Ensure each day cell takes equal width */
  }

  .calendar-container {
  border: 1px solid #ddd;
  padding: 10px;
  max-width: 800px;
  margin: 0 auto;
  width: 500px;
  height: 400px;
  }
  .calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  }
  .calendar-header h3 {
  margin: 0;
  }
  .calendar-header i {
  cursor: pointer;
  font-size: 1.5em;
  }
</style>
</head>
<body>

<%-- 이벤트 상세 내용 --%>
<div id="eventModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <ul id="eventDetails">
      <!-- 여기에 이벤트 세부 정보가 추가-->
    </ul>
  </div>
</div>

<%-- 일정 추가 모달 --%>
<div id="addEventModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>일정 추가</h2>
    <form id="addEventForm">
      <label for="calEventTitle">제목:</label>
      <input type="text" id="calEventTitle" name="calEventTitle" placeholder="Event"><br>

      <label for="calEventDate">날짜:</label>


      <input type="date" id="calEventDate" name="calEventDate" value="\${fn:substring(new java.text.SimpleDateFormat('yyyy-MM-dd').format(new java.util.Date()), 0, 10)}}"><br>

      <label for="calEventDescription">내용:</label>
      <input type="text" id="calEventDescription" name="calEventDescription" placeholder="None"><br>

      <label for="calColorIndex">색상:</label>
      <div class="color-picker">
        <div class="color-red" data-color-index="1"></div>
        <div class="color-green" data-color-index="2"></div>
        <div class="color-blue" data-color-index="3"></div>
        <div class="color-yellow" data-color-index="4"></div>
        <div class="color-magenta" data-color-index="5"></div>
      </div>
      <input type="hidden" id="calColorIndex" name="calColorIndex" value=""><br>

      <button type="button" id="saveEventButton">추가</button>
    </form>
  </div>
</div>

<%--달력 화면--%>
<div class="calendar-container">
  <div class="calendar-header">
    <i id="prev-month" class="fa-solid fa-caret-left"></i>
    <h3 id="current-month"></h3>
    <i id="next-month" class="fa-solid fa-caret-right"></i>
    <i class="fa-regular fa-calendar-plus"></i>
  </div>
  <div id="calendar"></div>
</div>

<script>


  // JSON 형식의 문자열을 자바스크립트 객체로 반환하기
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

  // 원하는 형광 색상 선택
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
      if (event.target === modal) {
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

    // colorindex에 따라 색 부여하기
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

    // 이전 달로 넘어가기
    document.getElementById('prev-month').addEventListener('click', function () {
      if (currentMonth === 0) {
        currentYear--;
        currentMonth = 11;
      } else {
        currentMonth--;
      }
      fetchEvents(currentYear, currentMonth);
    });

    //다음달로 넘어가기
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

      //일정 저장 내용
      const newEvent = {
        calEventId: myCalEvents.length + 1,
        calEventDate: date,
        calEventTitle: title,
        calEventDescription: description,
        calEventCreateAt: new Date().toISOString(),
        colorIndexId: colorIndex,
        username: 'User'
      };

      //새로운 일정 추가
      myCalEvents.push(newEvent);
      renderCalendar(myCalEvents, new Date(date).getFullYear(), new Date(date).getMonth());

      document.getElementById('addEventModal').style.display = 'none';
    });

  });
</script>

<%--실제 일정--%>
<div>Formatted Date: <span id="formattedDate"><c:out value="${formattedDate}" /></span></div>
</body>
</html>