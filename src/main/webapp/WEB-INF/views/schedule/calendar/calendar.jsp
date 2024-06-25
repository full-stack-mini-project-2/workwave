<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 다음과 같이 userId와 formattedDate 변수를 선언하십시오 --%>
<%! private String userId; %>
<%! private String formattedDate; %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Calendar</title>
  <style>
    .calendar {
      width: 100%;
      border-collapse: collapse;
    }
    .calendar th, .calendar td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: center;
    }
    .event {
      margin-top: 5px;
      padding: 3px;
      background-color: lightblue;
      border-radius: 3px;
    }
  </style>
</head>
<body>
<h1>Calendar</h1>
<div id="calendar"></div>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const userId = '<%= userId %>'; // 스크립트릿 태그 안에서 userId 변수 사용

    let currentYear = new Date().getFullYear();
    let currentMonth = new Date().getMonth();

    function fetchEvents(year, month) {
      const xhr = new XMLHttpRequest();
      xhr.open('GET', `/api/calendar/myEvents/${userId}?year=${year}&month=${month + 1}`, true);
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

        const fullDateStr = `${yearStr}-${monthStr}-${dateStr}`;

        calendarHtml += `<td><div>${date}</div>`;

        events.forEach(event => {
          if (event.calEventDate.startsWith(fullDateStr)) {
            calendarHtml += `<div class="event">${event.calEventTitle}</div>`;
          }
        });

        calendarHtml += '</td>';
      }

      calendarHtml += '</tr></table>';

      document.getElementById('calendar').innerHTML = calendarHtml;
    }

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

    fetchEvents(currentYear, currentMonth);
  });
</script>

<div>Formatted Date: <span id="formattedDate"><%= formattedDate %></span></div>

<button id="prev-month">Prev</button>
<button id="next-month">Next</button>
</body>
</html>
