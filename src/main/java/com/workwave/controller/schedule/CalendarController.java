package com.workwave.controller.schedule;

import com.workwave.dto.scheduleDto.DateData;
import com.workwave.dto.scheduleDto.request.CalendarDTO;
import com.workwave.dto.scheduleDto.request.CalendarEventDTO;
import com.workwave.dto.scheduleDto.request.TeamCalendarEventDTO;
import com.workwave.service.UserService;
import com.workwave.service.schedule.CalendarService;
import lombok.extern.slf4j.Slf4j;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
    @Autowired
    private UserService userService;


    @GetMapping("/{userId}")
    public String getCalendar(@PathVariable String userId, Model model) {
        List<CalendarDTO> calendars = calendarService.getCalendars(userId);
        List<CalendarEventDTO> calendarEvents = calendarService.getEvents(userId);
        List<TeamCalendarEventDTO> teamCalendarEvents = calendarService.getTeamEvents(userId);

        String userName = userService.getUserName(userId);

        model.addAttribute("userName", userName);
        model.addAttribute("calendars", calendars);
        model.addAttribute("calendarEvents", calendarEvents);
        model.addAttribute("teamCalendarEvents", teamCalendarEvents);

        return "schedule/calendar/calendarList";
    }
}
