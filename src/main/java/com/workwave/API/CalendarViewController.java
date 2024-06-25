package com.workwave.API;

import com.workwave.dto.scheduleDTO.request.AllMyCalendarEventDto;
import com.workwave.service.schedule.CalendarService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/calendar")
public class CalendarViewController {

    private final CalendarService calendarService;

    @GetMapping("/view/{userId}")
    public String viewCalendar(@PathVariable("userId") String userId,Model model) {
        List<AllMyCalendarEventDto> myCalendarEvents = calendarService.getMyEvents(userId);
        model.addAttribute("userId", userId);
        model.addAttribute("mycalEvents", myCalendarEvents);
        return "schedule/calendar/calendar";
    }
}
