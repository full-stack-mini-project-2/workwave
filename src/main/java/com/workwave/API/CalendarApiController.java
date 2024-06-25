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

    @GetMapping("/myEvents/{userId}")
    public List<AllMyCalendarEventDto> getCalendarEventsForPeriod(
            @PathVariable String userId,
            @RequestParam int year,
            @RequestParam int month) {
        return calendarService.getMyEventsForMonth(userId, year, month);
            }
        }
