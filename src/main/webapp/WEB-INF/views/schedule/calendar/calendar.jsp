<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Calendar Events</title>
  <style>
    table.calendar {
      width: 100%;
      border-collapse: collapse;
    }
    table.calendar th, table.calendar td {
      border: 1px solid #ccc;
      width: 14%;
      height: 100px;
      vertical-align: top;
    }
    table.calendar th {
      background: #f4f4f4;
    }
    .event {
      background: #e3f2fd;
      padding: 5px;
      margin: 5px 0;
      border-radius: 3px;
    }
    .nav-button {
      margin: 10px;
      cursor: pointer;
      padding: 5px 10px;
      background-color: #ddd;
      border: 1px solid #ccc;
      border-radius: 3px;
    }
  </style>
</head>
<body>
<h1>My Calendar Events</h1>
<div>
  <span id="prev-month" class="nav-button">Previous Month</span>
  <span id="next-month" class="nav-button">Next Month</span>
</div>
<div id="calendar"></div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function () {
    const userId = '${userId}'; // Dynamic userId from model

    let currentYear = new Date().getFullYear();
    let currentMonth = new Date().getMonth();

    function fetchEvents(year, month) {
      $.ajax({
        url: `/api/calendar/myEvents/${userId}?year=${year}&month=${month + 1}`,
        method: 'GET',
        success: function (data) {
          renderCalendar(data, year, month);
        },
        error: function (xhr, status, error) {
          console.error('Failed to fetch calendar events:', status, error);
        }
      });
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

        const dateStr = `${year}-${String.format('%02d', month + 1)}-${String.format('%02d', date)}`;
        calendarHtml += `<td><div>${date}</div>`;

        events.forEach(event => {
          if (event.calEventDate.startsWith(dateStr)) {
            calendarHtml += `<div class="event">${event.calEventTitle}</div>`;
          }
        });

        calendarHtml += '</td>';
      }

      calendarHtml += '</tr></table>';

      $('#calendar').html(calendarHtml);
    }

    $('#prev-month').click(function () {
      if (currentMonth === 0) {
        currentYear--;
        currentMonth = 11;
      } else {
        currentMonth--;
      }
      fetchEvents(currentYear, currentMonth);
    });

    $('#next-month').click(function () {
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

</body>
</html>
