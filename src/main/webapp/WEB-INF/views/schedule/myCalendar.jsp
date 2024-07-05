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
  <%--  http://localhost:8181/assets/css/main.css--%>
<%--  <link rel="stylesheet" href="<c:url value='../assets/css/main.css' />">--%>
  <!-- JavaScript 파일 포함 -->
  <%--  <script type="module" src="<c:url value='/assets/js/myCalendar.js' />' defer></script>--%>
<%--  <%@ include file="../include/header.jsp" %>--%>
  <style>
    .calendar {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    #calendar {
      height: 500px;
      width: 800px;
      border-radius: 7px;
      overflow: auto;
      -ms-overflow-style: none;
      scrollbar-width: none;
    }

    .calendar-container {
      border-radius: 10px;
      height: 560px; /* Set the desired height */
      border: 1px solid black; /* Optional: Border for visualization */
      padding: 10px;
      max-width: 800px; /* Ensure the calendar is responsive up to a maximum width */
      background: rgba(242, 239, 245, 0.92);
    }

    #current-month {
      width: 270px;
      display: inline-block;
      margin-left: 100px;
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

    .calendar th, .calendar td {
      width: 14.28%;
      overflow: hidden;
      vertical-align: top;
      position: relative;
    }

    .calendar th {
      text-align: center;
      height: 10px;
      border-top: none;
      border-left: none;
      border-right: none;
      border-bottom: black 1px double;
    }

    .calendar td {
      padding: 10px;
      /*border: 1px solid #ddd;*/
      text-align: justify;
      width: 90px;
      height: 60px;
      overflow-y: auto;
    }

    .calendar-add-btn {
      display: block;
      width: 20px;
    }

    .calendar-month {
      margin-left: 140px;
    }

    .event-container {
      height: 50px;
      overflow-y: auto;
      width: 70px;
      padding-left: 20px;
      -ms-overflow-style: none;
      scrollbar-width: none;
    }

    .event-container::-webkit-scrollbar, #calendar::-webkit-scrollbar {
      display: none;
    }

    .event {
      margin-top: 5px;
      padding: 3px;
      border-radius: 3px;
      cursor: pointer;
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
      width: 49px;
      font-size: 14px;
    }

    .event-lightsteelblue { background-color: lightsteelblue; }
    .event-darkslateblue { background-color: darkslateblue; }
    .event-steelblue { background-color: steelblue; }
    .event-lightyellow { background-color: lightyellow; }
    .event-lightpink { background-color: lightpink; }
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
      background-color: rgba(254, 254, 254, 0.9);
      margin: 15% auto;
      padding: 20px;
      border: 1.5px solid #888;
      border-radius: 7px; /* Border radius for modal content */
      width: 300px;
      box-shadow: 0 6px 10px rgba(0,0,0,0.2); /* Optional: shadow for better visibility */
    }

    .close {
      color: #aaa;
      float: right; /* Change float to right for better alignment */
      font-size: 13px;
      font-weight: bold;
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

    .color-lightsteelblue { background-color: lightsteelblue; }
    .color-darkslateblue { background-color: darkslateblue; }
    .color-steelblue { background-color: steelblue; }
    .color-lightyellow { background-color: lightyellow; }
    .color-lightpink { background-color: lightpink; }

    .fa-add {
      float: right;
      margin-top: 200px;
      margin-right: -10px;
      border: none;
      background: #beb9b9;
      border-radius: 3px;
    }

    .fa-pencil {
      margin-right: 250px;
      margin-top: 5px;
    }

    .fa-caret-right, .fa-caret-left {
      font-weight: 900;
      width: 100px;
    }

    .modal-content input[type="text"],
    .modal-content input[type="date"] {
      margin-top: 5px;
      border: none;
      background-color: rgba(255, 255, 255, 0.9);
      padding: 5px;
      border-radius: 3px;
    }

    #saveChangesButton {
      display: none; /* 초기에는 숨김 */
      float: right;
      margin-top: -10px;
      margin-right: -5px;
      border: none;
      background: #beb9b9;
      border-radius: 3px;
    }

  </style>
</head>
<body>



<!-- 이벤트 상세 및 일정 수정 모달 -->
<div id="eventModal" class="modal">
  <div class="modal-content">
    <span class="close"><i class="fa-solid fa-x"></i></span>
    <i class="fa-regular fa-trash-can" style="color: #929292;" id="deleteEvent"></i>
    <i class="fa-solid fa-pencil" style="color: #444444;" id="editEvent"></i>
    <ul id="eventDetails">
    </ul>
<%--    수정버튼을 눌러야 버튼이 보여짐--%>
    <button id="saveChangesButton" style="display:none;">Save Changes</button>
  </div>
</div>

<%-- 일정 추가 모달 --%>
<div id="addEventModal" class="modal">
  <div class="modal-content">
    <span class="close"><i class="fa-solid fa-x"></i></span>
    <button class="fa-add" type="button" id="saveEventButton">Add</button>
    <h2>New Event</h2>
    <form id="addEventForm">
      <label for="calEventTitle">Title</label>
      <input type="text" id="calEventTitle" name="calEventTitle" placeholder="Event"><br>

      <label for="calEventDate">Event Date</label>


      <input type="date" id="calEventDate" name="calEventDate" value="\${fn:substring(new java.text.SimpleDateFormat('yyyy-MM-dd').format(new java.util.Date()), 0, 10)}}"><br>

      <label for="calEventDescription">Description</label>
      <input type="text" id="calEventDescription" name="calEventDescription" placeholder="None"><br>

      <label for="calColorIndex"></label>
      <div class="color-picker">
        <div class="color-lightsteelblue" data-color-index="1"></div>
        <div class="color-darkslateblue" data-color-index="2"></div>
        <div class="color-steelblue" data-color-index="3"></div>
        <div class="color-lightyellow" data-color-index="4"></div>
        <div class="color-lightpink" data-color-index="5"></div>
      </div>
      <input type="hidden" id="calColorIndex" name="calColorIndex" value=""><br>

    </form>
  </div>
</div>

<%--달력 화면--%>
<div class="calendar-container">
  <div class="calendar-header">
    <div class="calendar-month">
    <i id="prev-month" class="fa-solid fa-caret-left"></i>
    <h3 id="current-month"></h3>
    <i id="next-month" class="fa-solid fa-caret-right"></i>
    </div>
    <div class="calendar-add-btn">
    <i class="fa-regular fa-calendar-plus"></i>
    </div>
  </div>
  <div id="calendar"></div>
</div>

<script>
  // JSON 형식의 문자열을 자바스크립트 객체로 반환하기
  <%--const myCalEvents = JSON.parse(`<c:out value="\${data}" escapeXml="false"/>`);--%>
  <%--console.log("mycalevents", myCalEvents);--%>
  // const userId = myCalEvents.length > 0 ? myCalEvents[0].userId : "";

  let myCalEvents = [];
  // let userId = "";
  // let userName = "";

  const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  let currentYear = new Date().getFullYear();
  let currentMonth = new Date().getMonth();

  // 초기 데이터 로드, 콜백함수로 비동기 렌더링
  fetchEvents(currentYear, currentMonth, function () {
    const userId = "${userId}";
    console.log("userId가 나오나요",userId);
    const userName = "${userName}";
    console.log("userName이 나오나요",userName);
    renderCalendar(myCalEvents, currentYear, currentMonth);
  });

  function fetchEvents(year, month, callback) {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', `/api/calendar/myEvents?year=\${year}&month=\${month + 1}`, true);

    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          const data = JSON.parse(xhr.responseText);

          console.log("맨처음 불러오는 json 달력 data:", data)

          myCalEvents = data;

          callback();

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

  renderCalendar();


  //화면에 달력 데이터 렌더링
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

      calendarHtml += `<td><div>\${date}</div><div class="event-container">`;

      // 해당 날짜에 해당하는 이벤트 필터링
      const filteredEvents = events.filter(event => event.calEventDate.startsWith(fullDateStr));

      if (filteredEvents.length > 0) {
        filteredEvents.forEach(event => {
          const colorClass = `event-\${getColorByIndex(event.colorIndexId)}`;
          calendarHtml += `<div class="event \${colorClass}" onclick="openModal(\${event.calEventId})">\${event.calEventTitle}</div>`;
        });
      }

      calendarHtml += '</div></td>';
    }

    calendarHtml += '</tr></table>';
    document.getElementById('calendar').innerHTML = calendarHtml;
    updateCurrentMonth(year, month);
  }

  // Current date update function
  function updateCurrentMonth(year, month) {
    document.getElementById('current-month').textContent = `\${monthNames[month]} \${year}`;
  }

  // Color index to class name mapping
  function getColorByIndex(index) {
    switch (index) {
      case 1:
        return 'lightsteelblue';
      case 2:
        return 'darkslateblue';
      case 3:
        return 'steelblue';
      case 4:
        return 'lightyellow';
      case 5:
        return 'lightpink';
      default:
        return 'lightgray';
    }
  }

  // Event Modal 닫기
  document.addEventListener('click', function (event) {
    const modal = document.getElementById('eventModal');
    const closeButton = modal.querySelector('.close');
    if (event.target === modal || event.target === closeButton) {
      modal.style.display = 'none';
    }
  });

  // 일정 추가 모달 열기
  document.querySelector('.fa-calendar-plus').addEventListener('click', function () {
    const addEventModal = document.getElementById('addEventModal');
    addEventModal.style.display = 'block';

    // 초기화 로직 추가 (모달이 열릴 때 입력 필드 초기화)
    document.getElementById('calEventTitle').value = '';
    document.getElementById('calEventDate').value = '';
    document.getElementById('calEventDescription').value = '';
    document.getElementById('calColorIndex').value = '';

    // 색상 선택 기능
    document.querySelectorAll('.color-picker div').forEach(function (colorDiv) {
      colorDiv.addEventListener('click', function () {
        document.getElementById('calColorIndex').value = this.getAttribute('data-color-index');
      });
    });

    // 닫기 버튼 클릭 시 모달 닫기
    const closeBtn = addEventModal.querySelector('.close');
    closeBtn.onclick = function () {
      addEventModal.style.display = 'none';
    };

    // 모달 바깥을 클릭하여도 닫히도록 설정
    addEventModal.addEventListener('click', function (event) {
      if (event.target === addEventModal || event.target.closest('.close')) {
        addEventModal.style.display = 'none';
      }
    });
  });

  // 색상 미리보기 업데이트 함수
  function updateColorPreview(index) {
    const colorDivs = document.querySelectorAll('.color-picker div');
    colorDivs.forEach(function (colorDiv) {
      colorDiv.classList.remove('selected');
      if (colorDiv.getAttribute('data-color-index') === index) {
        colorDiv.classList.add('selected');
      }
    });
  }


  // 이벤트 상세보기
  function openModal(eventId) {
    console.log('openModal called with eventId:', eventId);

    const selectedEvent = myCalEvents.find(event => event.calEventId === eventId);
    console.log('Selected Event:', selectedEvent);

    const modal = document.getElementById('eventModal');
    const modalContent = modal.querySelector('.modal-content');
    const eventDetails = modal.querySelector('#eventDetails');


    eventDetails.innerHTML = `
        <li><strong>Title :</strong> \${selectedEvent.calEventTitle}</li>
        <li><strong>Event description :</strong> \${selectedEvent.calEventDescription}</li>
        <li><strong>Event Date :</strong> \${selectedEvent.calEventDate}</li>
        <li><strong>Write By :</strong> \${selectedEvent.userName}</li>
      `;

    const editButton = modal.querySelector('#editEvent');
    const saveChangesButton = modal.querySelector('#saveChangesButton');

    editButton.onclick = function () {
      const titleSpan = eventDetails.querySelector('#eventDetails li:nth-child(1)');
      const descriptionSpan = eventDetails.querySelector('#eventDetails li:nth-child(2)');
      const dateSpan = eventDetails.querySelector('#eventDetails li:nth-child(3)');

      titleSpan.innerHTML = `<input type="text" id="edit-title" value="\${selectedEvent.calEventTitle}">`;
      descriptionSpan.innerHTML = `<input type="text" id="edit-description" value="\${selectedEvent.calEventDescription}">`;
      dateSpan.innerHTML = `<input type="date" id="edit-date" value="\${selectedEvent.calEventDate}">`;

      // 수정 버튼 클릭 시 Save Changes 버튼 보이기
      saveChangesButton.style.display = 'block';
    };

    // 수정된 일정 저장하기
    saveChangesButton.onclick = function () {
      const updatedTitle = document.getElementById('edit-title').value;
      const updatedDate = document.getElementById('edit-date').value;
      const updatedDescription = document.getElementById('edit-description').value;

      // 입력값 받기, 수정 없어도 저장 됨
      if (updatedTitle && updatedDate) {
        const updateEvent = {
          calEventId: selectedEvent.calEventId,
          calEventTitle: updatedTitle || selectedEvent.calEventTitle,
          calEventDate: updatedDate || selectedEvent.calEventDate,
          calEventDescription: updatedDescription || selectedEvent.description,
          calColorIndex: selectedEvent.calColorIndex
        };

        //색상 바로 렌더링
        updateColorPreview();


        //일정 수정
        fetch('/api/calendar/updateEvent', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(updateEvent),
        })
                .then(response => response.json())
                .then(data => {
                  if (data.success) {
                    // Update local data
                    selectedEvent.calEventTitle = updatedTitle;
                    selectedEvent.calEventDate = updatedDate;
                    selectedEvent.calEventDescription = updatedDescription;

                    // Close modal and re-render calendar
                    modal.style.display = 'none';
                    //입력한 일정으로 달력화면 보여주기
                    renderCalendar(myCalEvents, new Date(updatedDate).getFullYear(), new Date(updatedDate).getMonth());
                  } else {
                    alert('Error saving event: ' + data.message);
                  }
                })
                .catch(error => {
                  console.error('Error:', error);
                  alert('Error saving event');
                });
      }
      else {
        alert('제목과 날짜를 입력하세요.');
      }
    };
    // 모달 보이기
    modal.style.display = 'block';

    // 저장 후 Save Changes 버튼 다시 숨기기
    saveChangesButton.style.display = 'none';

    // 모달 외부를 클릭하면 닫기
    window.onclick = function (event) {
      if (event.target === modal) {
        modal.style.display = 'none';
        saveChangesButton.style.display = 'none';
      }
    };

    const deleteButton = modal.querySelector('#deleteEvent');
    deleteButton.onclick = function () {
      console.log(selectedEvent.calEventId); // 이벤트 아이디 잘 나옴
      if (confirm('정말 이 이벤트를 삭제하시겠습니까?')) {
        fetch(`/api/calendar/deleteEvent/\${selectedEvent.calEventId}`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({calEventId: selectedEvent.calEventId}),
        })
                .then(response => response.json())
                .then(data => {
                  if (data.success) {
                    // 성공적으로 삭제된 경우
                    const index = myCalEvents.findIndex(event => event.calEventId === selectedEvent.calEventId);
                    if (index !== -1) {
                      myCalEvents.splice(index, 1);
                    }
                    modal.style.display = 'none';
                    renderCalendar(myCalEvents, new Date(selectedEvent.calEventDate).getFullYear(), new Date(selectedEvent.calEventDate).getMonth());
                  } else {
                    // 삭제 실패한 경우
                    alert('Error deleting event: ' + data.message);
                  }
                })
                .catch(error => {
                  console.error('Error:', error);
                  alert('Error deleting event');
                });
        }
    };
  }

  // 일정 추가 모달 열기
  document.querySelector('.fa-calendar-plus').addEventListener('click', function () {
    const addEventModal = document.getElementById('addEventModal');
    addEventModal.style.display = 'block';

    document.getElementById('calEventTitle').value = '';
    document.getElementById('calEventDate').value = '';
    document.getElementById('calEventDescription').value = '';
    document.getElementById('calColorIndex').value = '';

    document.querySelectorAll('.color-picker div').forEach(function (colorDiv) {
      colorDiv.addEventListener('click', function () {
        document.getElementById('calColorIndex').value = this.getAttribute('data-color-index');
        updateColorPreview(this.getAttribute('data-color-index')); // Update color preview
      });
    });

    const closeBtn = addEventModal.querySelector('.close');
    closeBtn.onclick = function () {
      addEventModal.style.display = 'none';
    };
  });

  // 일정 저장
  document.getElementById('saveEventButton').addEventListener('click', function () {
    const title = document.getElementById('calEventTitle').value || 'Event';
    const date = document.getElementById('calEventDate').value || new Date().toISOString().split('T')[0]; // 날짜만 가져오기
    const description = document.getElementById('calEventDescription').value || 'None';
    const colorIndex = document.getElementById('calColorIndex').value || null;

    // 일정 저장 내용
    const newEvent = {
      calEventId: myCalEvents.length + 1,
      calEventDate: date,
      calEventTitle: title,
      calEventDescription: description,
      calEventCreateAt: new Date().toISOString(),
      colorIndexId: colorIndex,
      userName: myCalEvents.userName,
    };

    // AJAX 요청으로 이벤트 저장
    fetch('/api/calendar/addEvent', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(newEvent),
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                myCalEvents.push(newEvent);
                renderCalendar(myCalEvents, new Date(date).getFullYear(), new Date(date).getMonth());
                document.getElementById('addEventModal').style.display = 'none';
              } else {
                alert('Error saving event: ' + data.message);
              }
            })
            .catch(error => {
              console.error('Error:', error);
              alert('Error saving event');
            });
  });


  // DOMContentLoaded 이벤트 발생 시 실행
  document.addEventListener('DOMContentLoaded', function () {

    // 이전 달로 넘어가기
    document.getElementById('prev-month').addEventListener('click', function () {
      if (currentMonth === 0) {
        currentYear--;
        currentMonth = 11;
      } else {
        currentMonth--;
      }
      fetchEvents(currentYear, currentMonth, () => renderCalendar(myCalEvents, currentYear, currentMonth));
    });

    //다음달로 넘어가기
    document.getElementById('next-month').addEventListener('click', function () {
      if (currentMonth === 11) {
        currentYear++;
        currentMonth = 0;
      } else {
        currentMonth++;
      }
      fetchEvents(currentYear, currentMonth, () => renderCalendar(myCalEvents, currentYear, currentMonth));
    });
    fetchEvents(currentYear, currentMonth, () => renderCalendar(myCalEvents, currentYear, currentMonth));
  });

</script>

<%--현재 날짜 --%>
<div>Formatted Date: <span id="formattedDate"><c:out value="${formattedDate}" /></span></div>
</body>
</html>2