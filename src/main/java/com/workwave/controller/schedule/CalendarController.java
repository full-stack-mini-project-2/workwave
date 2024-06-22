package com.workwave.controller.schedule;

import com.workwave.dto.scheduleDTO.request.CalendarDTO;
import com.workwave.dto.scheduleDTO.request.CalendarEventDTO;
import com.workwave.dto.scheduleDTO.request.TeamCalendarEventDTO;
import com.workwave.service.UserService;
import com.workwave.service.schedule.CalendarService;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@Slf4j
@RequestMapping("/calendar")
public class CalendarController {

    @Autowired
    private CalendarService calendarService;
    @GetMapping("/list/{userId}")
    public String getCalendars(@PathVariable("userId") String userId, Model model) {
        log.info("GET : calendar/list/ {}", userId); // {}를 사용하여 userId를 로그에 추가
        List<CalendarDTO> calendars = calendarService.getCalendars(userId);
        model.addAttribute("calendars", calendars);
        return "schedule/calendar/calendarList"; // JSP 파일 이름
    }

    @GetMapping("/events/{userId}")
    public String getCalendarEvents(@PathVariable("userId") String userId, Model model) {
        log.info("GET : calendar/events/ {}", userId); // {}를 사용하여 userId를 로그에 추가
        List<CalendarEventDTO> calendarEvents = calendarService.getEvents(userId);
        model.addAttribute("calendarEvents", calendarEvents);
        return "schedule/calendar/calendarEvents"; // JSP 파일 이름
    }
}

