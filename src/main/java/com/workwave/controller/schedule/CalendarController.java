package com.workwave.controller.schedule;

import com.workwave.dto.scheduleDTO.request.CalendarDto;
import com.workwave.dto.scheduleDTO.request.CalendarEventDto;
import com.workwave.service.schedule.CalendarService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/calendar")
public class CalendarController {

    private final CalendarService calendarService;
    @GetMapping("/list/{userId}")
    public String getCalendars(@PathVariable("userId") String userId, Model model) {
        log.info("GET : calendar/list/ {}", userId); // {}를 사용하여 userId를 로그에 추가
        List<CalendarDto> calendars = calendarService.getCalendars(userId);
        model.addAttribute("calendars", calendars);
        return "schedule/calendar/calendarList"; // JSP 파일 이름
    }

    @GetMapping("/events/{userId}")
    public String getCalendarEvents(@PathVariable("userId") String userId, Model model) {
        log.info("GET : calendar/events/ {}", userId); // {}를 사용하여 userId를 로그에 추가
        List<CalendarEventDto> calendarEvents = calendarService.getEvents(userId);
        model.addAttribute("calendarEvents", calendarEvents);
        return "schedule/calendar/calendarEvents"; // JSP 파일 이름
    }
}

