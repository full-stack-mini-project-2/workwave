package com.workwave.controller.schedule;

import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.dto.schedule_dto.request.AllMyTeamCalendarEventDto;
import com.workwave.service.schedule.CalendarService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Calendar;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class CalendarDateController {

    private final CalendarService calendarService;

    @GetMapping("/calendar")
    public String getCalendar(
            @RequestParam("userId") String userId,
            @RequestParam(value = "year", required = false) Integer year,
            @RequestParam(value = "month", required = false) Integer month,
            Model model) {

        Calendar cal = Calendar.getInstance();

        // 현재 년도와 월 설정
        if (year == null) {
            year = cal.get(Calendar.YEAR);
        }
        if (month == null) {
            month = cal.get(Calendar.MONTH) + 1; // Calendar.MONTH는 0부터 시작하므로 1을 더합니다.
        }

        // 해당 달의 첫 날과 마지막 날 계산
        cal.set(year, month - 1, 1);
        int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        // 해당 유저의 개인 일정과 팀 일정을 가져옴
        List<AllMyCalendarEventDto> myEvents = calendarService.getMyEvents(userId);
        List<AllMyTeamCalendarEventDto> myTeamEvents = calendarService.getMyTeamEvents(userId);

        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("firstDayOfWeek", firstDayOfWeek);
        model.addAttribute("lastDay", lastDay);
        model.addAttribute("myEvents", myEvents);
        model.addAttribute("myTeamEvents", myTeamEvents);

        return "schedule/calendar/calendar";  // JSP 파일명
    }
}
