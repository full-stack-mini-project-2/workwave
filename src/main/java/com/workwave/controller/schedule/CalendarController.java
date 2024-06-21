package com.workwave.controller.schedule;

import com.workwave.dto.scheduleDto.DateData;
import com.workwave.dto.scheduleDto.request.CalendarDTO;
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
@RequestMapping("/calendars")
public class CalendarController {
    @Autowired
    private CalendarService calendarService;

    @GetMapping
    public String getAllCalendars(Model model) {
        List<CalendarDTO> calendars = calendarService.getAllCalendars();
        model.addAttribute("calendars", calendars);
        return "calendarList";
    }

    @GetMapping("/{id}")
    public String getCalendarById(@PathVariable int id, Model model) {
        CalendarDTO calendar = calendarService.getCalendarById(id);
        model.addAttribute("calendar", calendar);
        return "calendarDetail";
    }

    @PostMapping
    public String insertCalendar(CalendarDTO calendar) {
        calendarService.insertCalendar(calendar);
        return "redirect:/calendars";
    }

    @PutMapping("/{id}")
    public String updateCalendar(@PathVariable int id, CalendarDTO calendar) {
        calendar.setCalendar_id(id);
        calendarService.updateCalendar(calendar);
        return "redirect:/calendars";
    }

    @DeleteMapping("/{id}")
    public String deleteCalendar(@PathVariable int id) {
        calendarService.deleteCalendar(id);
        return "redirect:/calendars";
    }
    }
