package com.workwave.API;

import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
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
    public List<AllMyCalendarEventDto> getMyEvents(
            @PathVariable("userId") String userId,
            @RequestParam("year") int year,
            @RequestParam("month") int month) {
        try {
            return calendarService.getMyEventsForMonth(userId, year, month);
        } catch (Exception e) {
            log.error("Error fetching events for user: " + userId, e);
            throw new RuntimeException("Error fetching events");
        }
    }
        }
