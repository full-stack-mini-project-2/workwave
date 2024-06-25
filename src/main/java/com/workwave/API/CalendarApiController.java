package com.workwave.API;

import com.workwave.dto.scheduleDTO.request.AllMyCalendarEventDto;
import com.workwave.dto.scheduleDTO.request.CalendarsDto;
import com.workwave.service.schedule.CalendarService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/calendar")
public class CalendarApiController {

    private final CalendarService calendarService;

    @GetMapping("/list/{userId}")
    public List<CalendarsDto> getCalendars(@PathVariable("userId") String userId) {
        log.info("GET: /api/calendar/list/{}", userId);
        return calendarService.getMyCalendars(userId);
    }


        @GetMapping("/myEvents/{userId}")
        public List<AllMyCalendarEventDto> getMyCalendarEvents(
                @PathVariable("userId") String userId,
                @RequestParam int year,
                @RequestParam int month) {
            log.info("GET : api/calendar/myEvents/ {} for year {} and month {}", userId, year, month);
            return calendarService.getMyEventsForMonth(userId, year, month);
        }
    }
