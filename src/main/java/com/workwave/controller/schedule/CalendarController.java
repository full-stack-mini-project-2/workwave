package com.workwave.controller.schedule;

import com.workwave.dto.scheduleDTO.request.AllMyCalendarEventDto;
import com.workwave.dto.scheduleDTO.request.CalendarsDto;
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
        List<CalendarsDto> calendars = calendarService.getMyCalendars(userId);
        log.info("calendar List index 확인 : {} ",calendars);
        model.addAttribute("calendars", calendars);
        log.info("model 확인 : {} ",model);
        return "schedule/calendar/calendarList";
    }

    @GetMapping("/events/{userId}")
    public String getCalendarEvents(@PathVariable("userId") String userId, Model model) {
        log.info("GET : calendar/events/ {}", userId); // {}를 사용하여 userId를 로그에 추가
        List<AllMyCalendarEventDto> calendarEvents = calendarService.getEvents(userId);
        model.addAttribute("calendarEvents", calendarEvents);
        return "schedule/calendar/calendarEvents"; // JSP 파일 이름
    }
}

//public String list( Model model, @ModelAttribute("s") Search page) { //상속으로 한번에 네개의 파라미터 받을 수 있음
