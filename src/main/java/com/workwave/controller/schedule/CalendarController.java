package com.workwave.controller.schedule;

import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.dto.schedule_dto.request.AllMyTeamCalendarEventDto;
import com.workwave.service.schedule.CalendarService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/calendar")
public class CalendarController {

    private final CalendarService calendarService;
//    @GetMapping("/list/{userId}")
//    public String getCalendars(@PathVariable("userId") String userId, Model model) {
//        log.info("GET : calendar/list/ {}", userId); // {}를 사용하여 userId를 로그에 추가
//        List<CalendarsDto> calendars = calendarService.getMyCalendars(userId);
//        log.info("calendar List index 확인 : {} ",calendars);
//        model.addAttribute("calendars", calendars);
//        log.info("model 확인 : {} ",model);
//        return "schedule/calendar/myAllCalendarList";
//    }

    //개인 달력 일정 목록
    @GetMapping("/myEvents/{userId}")
    public String getMyCalendarEvents(@PathVariable("userId") String userId,Model model) {
        log.info("GET : calendar/events/ {}   🎔   !!!!!!!!!!!    🎔   !!!!!!!!!!!!!   🎔   !!!!!!!!", userId);
        List<AllMyCalendarEventDto> calendarEvents = calendarService.getMyEvents(userId);
        log.info("calendar event 확인 : {}", calendarEvents);
        model.addAttribute("calendarEvents", calendarEvents);
        log.info("model 확인 : {}",model);
        return "schedule/calendar/myAllCalendarEvent";
    }

    // 팀 달력 일정 목록
    @GetMapping("/teamEvents/{userId}")
    public String getTeamCalendarEvents(@PathVariable("userId") String userId, Model model) {
        log.info("GET : TEAM calendar/events/ {}", userId);
        List<AllMyTeamCalendarEventDto> teamCalendarEvents = calendarService.getMyTeamEvents(userId);
        log.info("TEAM calendar event 확인 : {}", teamCalendarEvents);
        model.addAttribute("calendarEvents", teamCalendarEvents);
        log.info("TEAM model 확인 : {}",model);
        return "schedule/calendar/myAllTeamCalendarEvent"; // JSP 파일 이름
    }
}

//public String list( Model model, @ModelAttribute("s") Search page) { //상속으로 한번에 네개의 파라미터 받을 수 있음
